---
title: 基于jira的流水线实践
author: 张大哥
top: true
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - 流水线
  - CICD
op: false
abbrlink: 64396
date: 2022-08-05 19:13:37
img:
coverImg:
summary:
---


## 整体架构设计图

![1659698071406]( 1659698071406.png)



### jira端规划

- 创建任务、故事（对应gitlab分支）
  - 创建jira 问题 -->自动创建给gitlab分支
- 创建发布(对应版本文件)

### gitlab端规划

- 提交代码 -->出发jenkins提交六线

- 合并分支 --> 当流水线成功后可以合并

- 创建版本库（存放发布版本）

  ![1659698514188]( 1659698514188.png)



jenkins 端规划

- 提交流水线

- uat测试流水线

  - 代码-->编译-->单侧-->打包-->扫描-->自动化测试-->生成镜像-->发布-->生成版本-->邮件通知

    

- 制品晋级/版本更新流水线

  -  选择晋级策略--> 根据版本文件晋级-->生成新版本文件

- stag/prod发布流水线

  - 选择版本号-->获取版本文件-->发布应用

- jira 集成流水线

  - jira 版本发布-->分支合并-->清理分支
  - 创建任务、故事(对应gitlab分支）
    - 创建jira问题 -->自动创建gitlab分支
  - 创建版本（对应版本文件）
    - 创建release-->获取应用部署yml文件 -->上传到git
  - 版本发布（清理分支）
    - 版本发布-->出发release分支到master分支合并-->清理特性分支

  ### 开始实践

  - 创建Gitlab版本库，用于存放k8s应用部署文件。
  - 新建demo-k8s-service项目，存放k8s的版本控制文件包含以下三个文件
    
    - prod
  - stag
  
  - uat
  
  - Jira webhook中配置 新建版本触发事件。

    ![1659700922280]( 1659700922280.png)

  - Kubernetes中创建三个NS，用于模拟不同的集群。
  
    ```shell
    cd k8s
    kubectl create -f ns.yaml
    ```
  ```
  
  获取k8s的token
  
  ​```shell
    kubectl describe secrets -n kube-system $ (kubectl -n kube-system get secret | awk '/dashboard-admin/(print $1｝，)
  
    验证
  curl -heade "Authorization：Bearer	$TOKEN"	--insecure -X GET https：//192.168.1.200：6443/api/v1/nodes
  ```
  
    
  
    ![1659710480228]( 1659710480228.png)
  
  - jira中新建一个版本验证jenkins触发器
  
    
  
    ![1659700940166]( 1659700940166.png)
  
  - 共享库分装k8s
  
    - 新建文件kubernetes.groovy
  - 分装http请求（token、accept、content-type为yaml）
    
    - 创建获取deploymets的方法
  - jenkinsfile中调用
    
  - 新建gitlabapi文件分装gitlab 对应的api方法
    
  - 获取k8s文件上传到gitlab
  
  - 上线完成触发分支合并测试
  
  - 提交流水线测试
  
    - gitlab配置webhook
  
    - jenkins中配置
  
    - 新建gitlab.jenkinsfile
  
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
      def artifactory = new org.devops.artifactory() 
      
      
      def runOpts
      //env
      String buildType = "${env.buildType}"
      String buildShell = "${env.buildShell}"
      String deployHosts = "${env.deployHosts}"
      
      String srcUrl = "${env.srcUrl}"
      String branchName = "${env.branchName}"
      
      
      
      branchName = branch - "refs/heads/"
      
      currentBuild.description = "Trigger by ${userName} ${branch}"
      gitlab.ChangeCommitStatus(projectId,commitSha,"running")
      
      
          
      
      
      
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
              
              stage("Build&Test"){
                  steps{
                      script{
                          tools.PrintMes("执行打包","green")
                          artifactory.main(buildType,buildShell)
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
                      
                      gitlab.ChangeCommitStatus(projectId,commitSha,"success")
                      
                      toemail.Email("流水线成功",userEmail)
                  
                  }
              
              }
              failure{
                  script{
                      println("failure")
                      
                      gitlab.ChangeCommitStatus(projectId,commitSha,"failed")
                      
                      toemail.Email("流水线失败了！",userEmail)
                  }
              }
              
              aborted{
                  script{
                      println("aborted")
                      gitlab.ChangeCommitStatus(projectId,commitSha,"canceled")
                     toemail.Email("流水线被取消了！",userEmail)
                  }
              
              }
          
          }
          
          
      }
      
      ```
  
      
  
  - jekninsfile中调用
  
    - 新建jira.jenkinsfile
  
    ```jenkinsfile
    #!groovy
    
    @Library('jenkinslibrary') _
    
    def gitlab = new org.devops.gitlab()
    def jira = new org.devops.jira()
    def k8s = new org.devops.kubernetes()
    
    pipeline {
        agent { node { label "master"}}
    
        triggers {
            GenericTrigger( causeString: 'Trigger By Jira Server -->>>>> Generic Cause', 
                            genericRequestVariables: [[key: 'projectKey', regexpFilter: '']], 
                            genericVariables: [[defaultValue: '', key: 'webHookData', regexpFilter: '', value: '$']], 
                            printContributedVariables: true, 
                            printPostContent: true, 
                            regexpFilterExpression: '', 
                            regexpFilterText: '', 
                            silentResponse: true, 
                            token: "${JOB_NAME}"
            )
        }
    
    
        stages{
    
            stage("FileterData"){
                steps{
                    script{
                        response = readJSON text: """${webHookData}"""
    
                        println(response)
    
                        env.eventType = response["webhookEvent"]
    
                        switch(eventType) {
                            case "jira:version_created":
                                env.versionName = response["version"]["name"]
                                currentBuild.description = " Trigger by  ${eventType} ${versionName} "
                                break
    
                            case ["jira:issue_created" , "jira:issue_updated" ]:
                                env.issueName = response['issue']['key']
                                env.userName = response['user']['name']
                                env.moduleNames = response['issue']['fields']['components']
                                env.fixVersion = response['issue']['fields']['fixVersions']
                                currentBuild.description = " Trigger by ${userName} ${eventType} ${issueName} "
                                break
    
                            /*case "jira:issue_updated":
                                env.issueName = response['issue']['key']
                                env.userName = response['user']['name']
                                env.moduleNames = response['issue']['fields']['components']
                                env.fixVersion = response['issue']['fields']['fixVersions']
                                currentBuild.description = " Trigger by ${userName} ${eventType} ${issueName} "
                                break*/
                                
                            case "jira:version_released":
                                env.versionName = response["version"]["name"]
                                currentBuild.description = " Trigger by  ${eventType} ${versionName} "
                                break
    
                            default:
                                println("hello")
                        }
                    }
                }
            }
            
            /*stage("CreateVersionFile"){
                when {
                    environment name: 'eventType', value: 'jira:version_created' 
                }
                
                steps{
                    script{
                        //获取K8s文件
                        response = k8s.GetDeployment("demo-uat","demoapp")
                        response = response.content
                        //文件转换
                        base64Content = response.bytes.encodeBase64().toString()
                       //上传文件
                       gitlab.CreateRepoFile(7,"demo-uat%2f${versionName}-uat.yaml",base64Content)
                    }
                
                }
            }
            
            stage("DeleteBranch"){
                when {
                    environment name: 'eventType', value: 'jira:version_released'   
                }
                
                steps{
                    script{
                        //获取issuesName
                        println("project%20%3D%20${projectKey}%20AND%20fixVersion%20%3D%20${versionName}%20AND%20issuetype%20%3D%20Task")
                        response = jira.RunJql("project%20%3D%20${projectKey}%20AND%20fixVersion%20%3D%20${versionName}%20AND%20issuetype%20%3D%20Task")
                        
                        response = readJSON text: """${response.content}"""
                        println(response)
                        issues = [:]
                        for ( issue in response['issues']){
                            println(issue["key"])
                            println(issue["fields"]["components"])
                            issues[issue["key"]] = []
                            
                            //获取issue关联的模块
                            for (component in issue["fields"]["components"] ){
                                issues[issue["key"]].add(component["name"])
                            }
                        
                        }
                        
                        println(issues)
                        
                        
                        //搜索gitlab分支是否已合并然后删除
                        
                        
                        for (issue in issues.keySet()){
                            for (projectName in issues[issue]){
                                repoName = projectName.split("-")[0]
                                projectId = gitlab.GetProjectID(repoName, projectName)
                                
                                try {
                                    println("创建合并请求  RELEASE-${versionName}  ---> master")
                                    result = gitlab.CreateMr(projectId,"RELEASE-${versionName}","master","RELEASE-${versionName}--->master")
                                    result = readJSON text: """${result}"""
                                    mergeId = result["iid"]
                                    gitlab.AcceptMr(projectId,mergeId)
                                    
                                    sleep 15
                                } catch(e){
                                    println(e)
                                }
                                response = gitlab.SearchProjectBranches(projectId,issue)
                                
                                println(response[projectId][0]['merged'])
                                
                                if (response[projectId][0]['merged'] == false){
                                    println("${projectName} --> ${issue} -->此分支未合并暂时忽略！")
                                } else {
                                    println("${projectName} --> ${issue} -->此分支已合并准备清理！")
                                    gitlab.DeleteBranch(projectId,issue)
                                }
                            
                            }
    
                        }
                    }
                }
            }*/
    
            stage("CreateBranchOrMR"){
    
                when {
                    anyOf {
                        environment name: 'eventType', value: 'jira:issue_created'   //issue 创建 /更新
                        environment name: 'eventType', value: 'jira:issue_updated' 
                    }
                }
    
                steps{
                    script{
                        def projectIds = []
                        println(issueName)
                        fixVersion = readJSON text: """${fixVersion}"""
                        println(fixVersion.size())
    
                        //获取项目Id
                        def projects = readJSON text: """${moduleNames}"""
                        for ( project in projects){
                            println(project["name"])
                            projectName = project["name"]
                            currentBuild.description += "\n project: ${projectName}"
                            groupName = projectName.split("-")[0]
                            
                            try {
                                projectId = gitlab.GetProjectID(groupName, projectName)
                                println(projectId)
                                projectIds.add(projectId)   
                            } catch(e){
                                println(e)
                                println("未获取到项目ID，请检查模块名称！")
                            }
                        } 
    
                        println(projectIds)  
    
    
                        if (fixVersion.size() == 0) {
                            for (id in projectIds){
                                println("新建特性分支--> ${id} --> ${issueName}")
                                currentBuild.description += "\n 新建特性分支--> ${id} --> ${issueName}"
                                gitlab.CreateBranch(id,"master","${issueName}")
                            }
                                
                            
    
                        } else {
                            fixVersion = fixVersion[0]['name']
                            println("Issue关联release操作,Jenkins创建合并请求")
                            currentBuild.description += "\n Issue关联release操作,Jenkins创建合并请求 \n ${issueName} --> RELEASE-${fixVersion}" 
                            
                            for (id in projectIds){
    
                                println("创建RELEASE-->${id} -->${fixVersion}分支")
                                gitlab.CreateBranch(id,"master","RELEASE-${fixVersion}")
    
    
                                
                                println("创建合并请求 ${issueName} ---> RELEASE-${fixVersion}")
                                gitlab.CreateMr(id,"${issueName}","RELEASE-${fixVersion}","${issueName}--->RELEASE-${fixVersion}")
                                
                            }
                        } 
                    }
                }
            }
        }
    }
    
    ```
  
    



### UAT测试流水线

代码-->编译-->单测-->打包-->扫描-->镜像-->发布-->接口测试-->生成版本文件-->邮件通知

两种方式使用docker：

1. 配置专属slave， 新建一个pod 里面起一个docker
2. docker in docker 配置， 使用物理机的dokcer 进行挂载，但是可能会影响整个docker的性能

![1660032386054]( 1660032386054.png)

### 获取k8s文件上传至k8s集群

1. 分装的函数详见gitlab.groovy 和kubernete.groovy文件

2. jave.jenkinsfile

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
   def k8s = new org.devops.kubernetes()
   
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
   
          stage("GetCode"){
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
           stage("Build&Test"){
               steps{
                   script{
                       tools.PrintMes("执行打包","green")
                       artifactory.main(buildType,buildShell)
                       artifactory.PushArtifact()
                       
               
   
                       //deploy.SaltDeploy("${deployHosts}","test.ping")
                       //deploy.AnsibleDeploy("${deployHosts}","-m ping ")
                   }
               }
          }
          
          
           //并行
           stage('parallel01') {
          
            
             parallel {
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
                           sonar.SonarScan("test","${JOB_NAME}","${JOB_NAME}","src","${branchName}")
                           
       
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
              
              //构建镜像
              stage("BuildImages"){
                   steps{
                       script{
                           tools.PrintMes("构建上传镜像","green")
                           env.serviceName = "${JOB_NAME}".split("_")[0]
                          
                           withCredentials([usernamePassword(credentialsId: 'aliyun-registry-admin', passwordVariable: 'password', usernameVariable: 'username')]) {
                              
                              env.dockerImage = "registry.cn-beijing.aliyuncs.com/devopstest/${serviceName}:${branchName}"
                              sh """
                                  docker login -u ${username} -p ${password}  registry.cn-beijing.aliyuncs.com
                                  docker build -t registry.cn-beijing.aliyuncs.com/devopstest/${serviceName}:${branchName} .
                                  sleep 1
                                  docker push registry.cn-beijing.aliyuncs.com/devopstest/${serviceName}:${branchName}
                                  sleep 1
                                  #docker rmi registry.cn-beijing.aliyuncs.com/devopstest/${serviceName}:${branchName}
                               """
                           }
                       }
                   }
               }
           }
       }
          
          //发布
          stage("Deploy"){
               steps{
                   script{
                       tools.PrintMes("发布应用","green")
                       
                       //下载版本库文件 
                       
                       releaseVersion = "${branchName}".split("-")[-1]
                       response = gitlab.GetRepoFile(7,"demo-uat%2f${releaseVersion}-uat.yaml")
                       //println(response)
                       
                       //替换文件中内容（镜像）
                       fileData = readYaml text: """${response}"""
                       println(fileData["spec"]["template"]["spec"]["containers"][0]["image"])
                       println(fileData["metadata"]["resourceVersion"])
                       oldImage = fileData["spec"]["template"]["spec"]["containers"][0]["image"] 
                       oldVersion = fileData["metadata"]["resourceVersion"]
                       response = response.replace(oldImage,dockerImage)
                       response = response.replace(oldVersion,"")
                       println(response)
                       
                       //更新gitlab文件内容
                       base64Content = response.bytes.encodeBase64().toString()
                       gitlab.UpdateRepoFile(7,"demo-uat%2f${releaseVersion}-uat.yaml",base64Content)
                       
                       //发布kubernetes
                       k8s.UpdateDeployment("demo-uat","demoapp",response)
                       
   
                   }
               }
           }
          
           //接口自动化测试
           stage("InterfaceTest"){
               steps{
                   script{
                       tools.PrintMes("接口测试","green")
   
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

   

