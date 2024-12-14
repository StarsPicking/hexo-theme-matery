---
title: pipeline模板
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - jenkins
  - pipeline
op: false
abbrlink: 61292
date: 2022-07-26 19:21:29
img:
coverImg:
summary:
---



# pipeline简单的流程模板



- 本实例通过流水线的方式，在jenkisn里配置全局变量（npm, ant, maven, gradle）,通过项目里配置参数buildShell来控制实际的构建工具，实现用户可以选择构建工具来打包的功能

- 项目准备：

  1. 安装 npm ant maven gradle
  1. 配置项目参数
  1. 配置系统管理----> 全局变量配置

  

```
#!groovy
String buildShell = "${env.buildShell}" //jenkins项目中配置的参数名称
pipeline{
    agent any
    stages{
        stage("build"){
            steps{
                script{
                    mvnHome = tool "M2"
                    sh "${mvnHome}/bin/mvn -v"
                    // sh "${mvnHome}/bin/mvn ${buildShell}" //使用参数的方式进行构建
                }
            }
        }
        stage("ant"){
          steps{
                script{
                    try{
                        antHome = tool "ANT"
                        //sh "${antHome}/bin/ant -v"
                        sh "${antHome}/bin/ant ${buildShell}" //使用参数的方式进行构建
                    }catch(e){
                        println(e)
                    }
                }
            }
        }
        stage("gradlebuild"){
          steps{
                script{
                    gradleHome = tool "GRADLE"
                    println("${gradleHome}")
                    sh "${gradleHome}/bin/gradle -v"
                    //sh "${gradleHome}/bin/gradle ${buildShell}" //使用参数的方式进行构建
                }
            }
        } 
        stage("npmbuild"){
          steps{
                script{
                    npmHome = tool "NPM"
                    //sh "${npmHome}/bin/npm -v"
                    sh "${npmHome}/bin/npm ${buildShell}" //使用参数的方式进行构建
                }
            }
        }
    }
}

```

jenkins 中参数配置如下

![1658835056291](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1658835056291.png)

jenkinsz中配置全局工具（M2 ANT GRADLE NPM）

![1658835277618](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1658835277618.png)

