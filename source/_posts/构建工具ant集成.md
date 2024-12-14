---
title: 构建工具ant集成
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - CICD
abbrlink: 55167
date: 2022-10-21 18:55:10
img:
coverImg:
summary:
---

#### jenkins 中ant构建工具
[ant官网](https://ant.apache.org/bindownload.cgi)

##### ant安装

1. cd /data/devops/devops-tools-install-pkg/
2. wget https://dlcdn.apache.org//ant/binaries/apache-ant-1.10.12-bin.tar.gz
3. tar -xvf apache-ant-1.10.12-bin.tar.gz -C /usr/local/
4. cd /usr/local/apache-ant-1.10.12/
5. pwd
```
/usr/local/apache-ant-1.10.12/
```
6. vi /etc/profile
```
export ANT_HOME=/usr/local/apache-ant-1.10.12
export PATH=$GROOVY_HOME/bin:$PATH:M2_HOME/bin:$ANT_HOME/bin
```

7. source /etc/profile

##### 脚本
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
                    antHome = tool "ANT"
                    //sh "${antHome}/bin/ant -v"
                    sh "${mvnHome}/bin/ant ${buildShell}" //学习使用参数的方式进行构建
                }
            }
        }
    }
}
// 该jenkins 脚本使用会报错是因为没有项目，执行参数中的clean 会报错
```