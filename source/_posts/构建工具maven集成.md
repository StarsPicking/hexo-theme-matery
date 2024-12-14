---
title: 构建工具maven集成
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - CICD
abbrlink: 24379
date: 2022-10-21 18:54:19
img:
coverImg:
summary:
---

#### jenkins中maven安装

##### 采用手动安装的方式

1. cd cd /data/devops/devops-tools-install-pkg/
2. wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
3. tar -xvf apache-maven-3.8.6-bin.tar.gz -C /usr/local/
4. cd /usr/local/apache-maven-3.8.6/
5. pwd
    1. /usr/local/apache-maven-3.8.6/
6. vi /etc/profile
7. 添加环境变量如下内容，注意export 后面是追加，不影响之前的环境变量
 ```
export M2_HOME=/usr/local/apache-maven-3.8.6
export PATH=$GROOVY_HOME/bin:$PATH:M2_HOME/bin
 ```

8. jenkins --->系统设置--->全局工具配置--->maven
    1. name: M2
    2. MAVEN_HOME: /usr/local/apache-maven-3.8.6
9. 点击保存
10. 新建流水线,脚本如下
```
#!groovy
pipeline{
    agent any
    stages{
        stage("build"){
            steps{
                script{
                    mvnHome = tool "M2"
                    sh "${mvnHome}/bin/mvn -v"
                }
            }
        }
    }
}

```

11.  maven常用命令
    1. clean 清理构建目录
    2. clean package 打包
    3. clean install 打包部署
    4. clean test 单元测试
    

