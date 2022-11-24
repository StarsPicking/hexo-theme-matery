---
title: jenkins使用共享库
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - jenkins
abbrlink: 26356
date: 2022-10-21 18:14:21
img:
coverImg:
summary:
---



# 共享库定义

**存在这样的场景**：
 在 jenkins 中存在多个 pipeline jobs,
 pipeline jobs 之间有相同逻辑功能（有重复相同代码），
 为了 dry (don't repeat yourself) 去除重复代码，jenkins 可以提供了一特性： 可以把重复的代码做成通用的共享库（shared libraries)

好处： 一方面精简代码（去重），另一方面减少后续新添 pipeline job 时的重复造轮子。

# 共享库的使用

## 1. 使用流程

分以下几步：

- 1. 创建共享库
- 1. jenkins 配置 Global Shared Libraries
- 1. jenkinsfile 引用共享库

## 2. 创建共享库

定义共享库(Defining Shared Libraries)

1. 在gitlab 新建共享库仓库jenkinslib



![1666348541590](1666348541590.png)

2. 创建目录结构

```
(root)
+- src                     # Groovy source files
|   +- org
|       +- foo
|           +- Bar.groovy  # for org.foo.Bar class
+- vars
|   +- foo.groovy          # for global 'foo' variable
|   +- foo.txt             # help for 'foo' variable
+- resources               # resource files (external libraries only)
|   +- org
|       +- foo
|           +- bar.json    # static helper data for org.foo.Bar

```



3. 创建src/org/devops/xxx.groovy 文件

![1666348578043](1666348578043.png)

4. 在jenkins 客户端引用该共享库文件
   - jenkins 配置 Global Shared Libraries 
   - Manage Jenkins » Configure System » Global Pipeline Libraries

5. 在jenkinsfiile中通过@Library('jenkins') _ 引入

```
@Library('my-shared-library') _
/* Using a version specifier, such as branch, tag, etc */
@Library('my-shared-library@1.0') _
/* Accessing multiple libraries with one statement */
@Library(['my-shared-library', 'otherlib@abc1234']) _
```

6. jenkinsfile中使用

```
#!groovy

@Library('jenkinslibrary@master') _

//func from shareibrary
def build = new org.devops.build()
def deploy = new org.devops.deploy()
def tools = new org.devops.tools()
def gitlab = new org.devops.gitlab()
def toemail = new org.devops.toemail()
def sonar = new org.devops.sonarqube()
def sonarapi = new org.devops.sonarapi()
def nexus = new org.devops.nexus()
def artifactory = new org.devops.artifactory() 


def runOpts
//env
String buildType = "${env.buildType}"
String buildShell = "${env.buildShell}"
String deployHosts = "${env.deployHosts}"
String srcUrl = "${env.srcUrl}"
String branchName = "${env.branchName}"
String artifactUrl = "${env.artifactUrl}"


if ("${runOpts}" == "GitlabPush"){
    branchName = branch - "refs/heads/"
    
    currentBuild.description = "Trigger by ${userName} ${branch}"
    gitlab.ChangeCommitStatus(projectId,commitSha,"running")
    env.runOpts = "GitlabPush"

    
} else {
   userEmail = "2560350642@qq.com"
}


//pipeline
pipeline{
    agent { node { label "build"}}
    
    
    stages{

        stage("CheckOut"){
            steps{
                script{
                   
                    
                    println("${branchName}")
                
                    tools.PrintMes("获取代码","green")
                    checkout([$class: 'GitSCM', branches: [[name: "${branchName}"]], 
                                      doGenerateSubmoduleConfigurations: false, 
                                      extensions: [], 
                                      submoduleCfg: [], 
                                      userRemoteConfigs: [[credentialsId: 'gitlab-admin-user', url: "${srcUrl}"]]])

                }
            }
        }
        stage("Build"){
            steps{
                script{
                
                    tools.PrintMes("执行打包","green")
                    //build.Build(buildType,buildShell)
                    artifactory.main(buildType,buildShell)
                    artifactory.PushArtifact()
                    
                    //上传制品
                    //nexus.main("nexus")
                    
                    //发布制品
                    //sh " wget ${artifactUrl} && ls "
                    
                    
                    


                    //deploy.SaltDeploy("${deployHosts}","test.ping")
                    //deploy.AnsibleDeploy("${deployHosts}","-m ping ")
                }
            }
       }
       
       
        stage("QA"){
            steps {
                script{
                    tools.PrintMes("搜索项目","green")
                    result = sonarapi.SerarchProject("${JOB_NAME}")
                    println(result)
                    
                    if (result == "false"){
                        println("${JOB_NAME}---项目不存在,准备创建项目---> ${JOB_NAME}！")
                        sonarapi.CreateProject("${JOB_NAME}")
                    } else {
                        println("${JOB_NAME}---项目已存在！")
                    }
                    
                    tools.PrintMes("配置项目质量规则","green")
                    qpName="${JOB_NAME}".split("-")[0]   //Sonar%20way
                    sonarapi.ConfigQualityProfiles("${JOB_NAME}","java",qpName)
                
                    tools.PrintMes("配置质量阈","green")
                    sonarapi.ConfigQualityGates("${JOB_NAME}",qpName)
                
                    tools.PrintMes("代码扫描","green")
                    sonar.SonarScan("test","${JOB_NAME}","${JOB_NAME}","src")
                    

                    sleep 30
                    tools.PrintMes("获取扫描结果","green")
                    result = sonarapi.GetProjectStatus("${JOB_NAME}")
                    
                    
                    println(result)
                    if (result.toString() == "ERROR"){
                        toemail.Email("代码质量阈错误！请及时修复！",userEmail)
                        error " 代码质量阈错误！请及时修复！"
                        
                        
                    } else {
                        println(result)
                    }
                
                

                }
           }
       }
    }
    post {
        always{
            script{
                println("always")
            }
        }
        
        success{
            script{
                println("success")
                if ("${runOpts}" == "GitlabPush"){
                    gitlab.ChangeCommitStatus(projectId,commitSha,"success")
                }
                toemail.Email("流水线成功",userEmail)
            
            }
        
        }
        failure{
            script{
                println("failure")
                if ("${runOpts}" == "GitlabPush"){
                    gitlab.ChangeCommitStatus(projectId,commitSha,"failed")
                }
                toemail.Email("流水线失败了！",userEmail)
            }
        }
        
        aborted{
            script{
                println("aborted")
                if ("${runOpts}" == "GitlabPush"){
                    gitlab.ChangeCommitStatus(projectId,commitSha,"canceled")
                }
               toemail.Email("流水线被取消了！",userEmail)
            }
        
        }
    
    }
    
    
}

```

