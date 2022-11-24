---
title: 在流水线中使用docker容器
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
summary: 在流水线中使用单个或者多个dokcer容器进行编译
categories: Devops
tags:
  - jenkins
  - CICD

op: false
abbrlink: 41684
date: 2022-08-02 20:13:32
img:
coverImg:
---






## jenkins 中使用docker进行流水线编译

### jenkins 中挂载docker命令

```
docker run --name jenkins -itd  -p 8081:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock  -v /usr/bin/docker:/usr/bin/docker  jenkins/jenkins
```

### 解决启动权限问题

```
docker exec -it -u root jenkins bash
usermod -aG root jenkins
chmod 777 /var/run/docker.sock
```

### 测试流水线

1. 安装docker pipeline、 docker插件
2. 新建流水线项目

```
pipeline {
    agent {
        docker { image 'node:14-alpine' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
    }
}
```



3. 运行流水线，成功截图如下

![1659504549940](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1659504549940.png)



4. 改进流水线

   ```
   pipeline {
       agent {
           docker {
               image 'maven:3-alpine'
               args '-v $HOME/.m2:/root/.m2'
           }
       }
       stages {
           stage('Build') {
               steps {
                   sh 'mvn -v'
               }
           }
       }
   }
   
   许多构建工具将下载外部依赖项并将其本地缓存以供将来重用。由于容器最初是使用“干净”文件系统创建的，因此这可能会导致管道运行速度变慢，因为它们可能无法利用后续管道运行之间的磁盘缓存。
   
   管道支持添加传递给Docker的自定义参数，允许用户指定要安装的自定义Docker卷，该卷可用于在两次管道运行之间在代理上缓存数据。以下示例将~/.m2目录利用maven容器在两次管道运行之间进行缓存，从而避免为管道的后续运行重新下载依赖项。
   ```

5.  流水线中使用多个docker 

   ```
   pipeline {
       agent none
       stages {
           stage('Back-end') {
               agent {
                   docker { image 'maven:3-alpine' 
                   args '-v $HOME/.m2:/root/.m2'}
               }
               steps {
                   sh 'mvn --version'
               }
           }
           stage('Front-end') {
               agent {
                   docker { image 'node:14-alpine' 
                   args '-v $HOME/.npm:/root/.npm '}
               }
               steps {
                   sh 'node --version'
               }
           }
       }
   }
   ```

   

   

6.  查看运行信息

   ```
   Started by user unknown or anonymous
   [Pipeline] Start of Pipeline
   [Pipeline] stage
   [Pipeline] { (Back-end)
   [Pipeline] node
   Running on Jenkins in /var/jenkins_home/workspace/demo-dokcer-service-test
   [Pipeline] {
   [Pipeline] isUnix
   [Pipeline] withEnv
   [Pipeline] {
   [Pipeline] sh
   + docker inspect -f . maven:3-alpine
   .
   [Pipeline] }
   [Pipeline] // withEnv
   [Pipeline] withDockerContainer
   Jenkins seems to be running inside container 9f0fa912ea7a6a8b94c7d02d7aedf2429aa2f12d8841f67976f7efc79a2e03e0
   $ docker run -t -d -u 1000:1000 -v $HOME/.m2:/root/.m2 -w /var/jenkins_home/workspace/demo-dokcer-service-test --volumes-from 9f0fa912ea7a6a8b94c7d02d7aedf2429aa2f12d8841f67976f7efc79a2e03e0 -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** maven:3-alpine cat
   $ docker top b8f8f8c418ad25cc550a1e35e6c9b632fe6c1251dd4ed62dabbf7c23a38a7c2b -eo pid,comm
   [Pipeline] {
   [Pipeline] sh
   + mvn --version
   Apache Maven 3.5.0 (ff8f5e7444045639af65f6095c62210b5713f426; 2017-04-03T19:39:06Z)
   Maven home: /usr/share/maven
   Java version: 1.8.0_131, vendor: Oracle Corporation
   Java home: /usr/lib/jvm/java-1.8-openjdk/jre
   Default locale: en_US, platform encoding: UTF-8
   OS name: "linux", version: "4.18.0-394.el8.x86_64", arch: "amd64", family: "unix"
   [Pipeline] }
   $ docker stop --time=1 b8f8f8c418ad25cc550a1e35e6c9b632fe6c1251dd4ed62dabbf7c23a38a7c2b
   $ docker rm -f b8f8f8c418ad25cc550a1e35e6c9b632fe6c1251dd4ed62dabbf7c23a38a7c2b
   [Pipeline] // withDockerContainer
   [Pipeline] }
   [Pipeline] // node
   [Pipeline] }
   [Pipeline] // stage
   [Pipeline] stage
   [Pipeline] { (Front-end)
   [Pipeline] node
   Running on Jenkins in /var/jenkins_home/workspace/demo-dokcer-service-test
   [Pipeline] {
   [Pipeline] isUnix
   [Pipeline] withEnv
   [Pipeline] {
   [Pipeline] sh
   + docker inspect -f . node:14-alpine
   .
   [Pipeline] }
   [Pipeline] // withEnv
   [Pipeline] withDockerContainer
   Jenkins seems to be running inside container 9f0fa912ea7a6a8b94c7d02d7aedf2429aa2f12d8841f67976f7efc79a2e03e0
   $ docker run -t -d -u 1000:1000 -v $HOME/.npm:/root/.npm -w /var/jenkins_home/workspace/demo-dokcer-service-test --volumes-from 9f0fa912ea7a6a8b94c7d02d7aedf2429aa2f12d8841f67976f7efc79a2e03e0 -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** node:14-alpine cat
   $ docker top 03a7311f1a63225f31a83f4cdcc1ff3480b1a92608fac48c199e8afe43c12334 -eo pid,comm
   [Pipeline] {
   [Pipeline] sh
   + node --version
   v14.18.2
   [Pipeline] }
   $ docker stop --time=1 03a7311f1a63225f31a83f4cdcc1ff3480b1a92608fac48c199e8afe43c12334
   $ docker rm -f 03a7311f1a63225f31a83f4cdcc1ff3480b1a92608fac48c199e8afe43c12334
   [Pipeline] // withDockerContainer
   [Pipeline] }
   [Pipeline] // node
   [Pipeline] }
   [Pipeline] // stage
   [Pipeline] End of Pipeline
   Finished: SUCCESS
   ```

   

   

