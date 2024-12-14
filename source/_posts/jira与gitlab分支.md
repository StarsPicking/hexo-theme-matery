---
title: jira与gitlab分支
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - CICD

op: false
abbrlink: 53151
date: 2022-08-01 23:15:48
img:
coverImg:
summary:
---




## jenkins中集成需求管理工具jira



## jira中问题发布与gitlabMR(marge request)

* 效果
  * 能够实现在jara系统对应的任务下面创建分支
  * 或者开发人员在创建分支的时候包含jiraID子关联

* 不足
  * 插件不稳定，资源消耗大
  * 手动创建分支，增加人员成本
* 改进
  * 创建故事胡总和任务自动在对应的代码库创建分支
  * 故事或者任务在关联到帆布之后自动创建release分支
* 实现
  * 配置jira webhook 出发jenkisn 操作gitlab系统



jira分析

![1659600508967](1659600508967.png)

webhookevent分析

![1659600564592](1659600564592.png)

gitlab接口分析

![1659600616097](1659600616097.png)

jenkins分析

![1659600726233](1659600726233.png)



```
package org.devops

//封装HTTP请求
def HttpReq(reqType,reqUrl,reqBody){
    def apiServer = "http://192.168.1.200:8050/rest/api/2"
   
   result = httpRequest authentication: 'jira-admin-user',
            httpMode: reqType, 
            contentType: "APPLICATION_JSON",
            consoleLogResponseBody: true,
            ignoreSslErrors: true, 
            requestBody: reqBody,
            url: "${apiServer}/${reqUrl}"
            //quiet: true
    return result
}





//执行JQL
def RunJql(jqlContent){
    apiUrl = "search?jql=${jqlContent}"
    response = HttpReq("GET",apiUrl,'')
    return response
}
```



```
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

### 自动创建分支

![1659601319880](1659601319880.png)

![1659601365441](1659601365441.png)



![1659601383774](1659601383774.png)

![1659601399747](1659601399747.png)



### 自动创建合并请求

![1659601485742](1659601485742.png)



![1659601518681](1659601518681.png)



![1659601550683](1659601550683.png)



![1659601569263](1659601569263.png)



### 自动清理分支

- jiararelease 发布后自动清理分支
- release发布--->jenkina--->清理gitlab分支（已合并的特性分支）

![1659601736934](1659601736934.png)



![1659601758471](1659601758471.png)



