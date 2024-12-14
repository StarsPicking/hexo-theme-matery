---
title: 构建工具grandle集成
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - CICD
abbrlink: 37880
date: 2022-10-21 18:55:38
img:
coverImg:
summary:
---

##### jenkins 集成grandle
[gradle官网](https://gradle.org/)
##### 安装grandle

1. cd /data/devops/devops-tools-install-pkg/

2. wget https://downloads.gradle-dn.com/distributions/gradle-7.5-bin.zip

3. cd /usr/local/gradle-7.5/

4. pwd

  > /usr/local/gradle-7.5

```

5.vi /etc/profile
````
export GRADLE_HOME=/usr/local/gradle-7.5
export PATH=$GROOVY_HOME/bin:$PATH:M2_HOME/bin:$ANT_HOME/bin:GRADLE_HOME/bin

```

6. source /etc/profile
7. jenkins---->系统设置--->系统工具设置--->gradle  name:GRADLE PATH /usr/local/gradle-7.5
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
        stage("gradle"){
          steps{
                script{
                    gradleHome = tool "GRADLE"
                    println("${gradleHome}")
                    sh "${gradleHome}/bin/gradle -v"
                    //sh "${gradleHome}/bin/gradle ${buildShell}" //学习使用参数的方式进行构建
                }
            }
        } 
    }
}
// 该jenkins 脚本执行到ant会报错，所以加入try{}catch(e){}语句