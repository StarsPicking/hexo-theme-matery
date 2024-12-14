---
title: 基于docker配置前端流水线
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - CICD
op: false
abbrlink: 29748
date: 2022-08-03 19:03:43
img:
coverImg:
summary:
---




## 基于docker配置web项目实例

```
pipeline {
    agent {
        docker {
            image 'node:10.20.1-alpine3.11'
            args '-v $HOME/.m2:/root/.m2'
        }
    }
    stages {
        stage('checkout') {
            steps {
                git 'https://github.com/jenkins-docs/simple-node-js-react-npm-app'
            }
        }
        stage('build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }        
    }
}
```



![1659524779824](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1659524779824.png)

