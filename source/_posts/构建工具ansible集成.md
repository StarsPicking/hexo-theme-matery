---
title: 构建工具ansible集成
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - CICD
  
abbrlink: 47333
date: 2022-10-21 18:59:43
img:
coverImg:
summary:
---

##### CD-ansible

## 安装

1. yum install epel-release -y
2.  yum install ansible -y
3.  vi /etc/ansible/hosts 添加
```
[servers]
server1 192.168.72.131
```
**注意如果是集成到jenkins里，由于jenlins的默认启动用户是jenkins， 所以需要和免密的用户保持一致，要么添加jenkisn免密，要么修改启动用户，此处做如下修改**

1. chmod 777 /etc/sudoers
2. vi /etc/sudoers
```
root    ALL=(ALL)       ALL
jenkins ALL=(ALL)       ALL

```
3. chmod 440 /etc/sudoers
4. vim /etc/passwd 打开jenkins的bash
5. su jenkins
6. ssh-keygen
7. ssh-copy-id -i /var/lib/jenkins/.ssh/id_rsa.pub root@192.168.72.132
8. vi /etc/ansible/ansible.cfg
```
[defaults]
remote_user = root
```
```
#!groovy
@Library('jenkinslib') _
def build = new org.devops.build()
def deploy = new org.devops.deploy()
String buildShell = "${env.buildShell}" //jenkins项目中配置的参数名称
String buildType = "${env.buildType}"
pipeline{
    agent any
    stages{
        stage("build"){
            steps{
                script{
                    build.Build(buildType, buildShell)
                    deploy.SaltDeploy("salt-minion", "test.ping")
                    deploy.AnsibleDeploy("server1", "ping")
                }
            }
        }
    }
}
// 该jenkins 脚本执行到ant会报错，所以加入try{}catch(e){}语句

```