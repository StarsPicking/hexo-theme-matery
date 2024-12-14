---
title: 构建工具npm集成
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - CICD
abbrlink: 26166
date: 2022-10-21 18:56:05
img:
coverImg:
summary:
---

#### jenkins 集成npm
[官网](https://nodejs.org/en/download/)
##### npm安装
1. cd /data/devops/devops-tools-install-pkg/
2. wget https://nodejs.org/dist/v16.16.0/node-v16.16.0-linux-x64.tar.xz
3. tar -xvf node-v16.16.0-linux-x64.tar.xz -C /usr/local/
4. cd /usr/local/node-v16.16.0-linux-x64/
5. pwd 获取安装路径
6. vi /etc/profile
```
 export `NPM_HOME=/usr/local/node-v16.16.0-linux-x64
export PATH=$GROOVY_HOME/bin:$PATH:M2_HOME/bin:$ANT_HOME/bin:$GRADLE_HOME/bin:$NPM_HOME/bin
```
7. source /etc/profile
8. npm install -g npm
9. jenkins-->全局工具配置--->node   name: NPM    PATH usr/local/node-v16.16.0-linux-x64

##### 运行脚本
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
                    // sh "${mvnHome}/bin/mvn ${buildShell}" //学习使用参数的方式进行构建
                }
            }
        }
        stage("ant"){
          steps{
                script{
                    try{
                        antHome = tool "ANT"
                        //sh "${antHome}/bin/ant -v"
                        sh "${antHome}/bin/ant ${buildShell}" //学习使用参数的方式进行构建
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
                    //sh "${gradleHome}/bin/gradle ${buildShell}" //学习使用参数的方式进行构建
                }
            }
        } 
        stage("npmbuild"){
          steps{
                script{
                    npmHome = tool "NPM"
                    //sh "${npmHome}/bin/npm -v"
                    sh "${npmHome}/bin/npm ${buildShell}" //学习使用参数的方式进行构建
                }
            }
        }
    }
}
// 该jenkins 脚本执行到ant会报错，所以加入try{}catch(e){}语句
```