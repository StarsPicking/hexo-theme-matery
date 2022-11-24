---
title: docker+harbor+jenkins安装命令汇总
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - docker
  - harbor
  - jenkins
  - CICD

abbrlink: 19046
date: 2022-07-26 03:21:16
img:
coverImg:
summary:
---

# 1. 安装docker 
1.1 sudo yum install -y yum-utils
1.2 yum-config-manager     --add-repo     https://download.docker.com/linux/centos/docker-ce.repo
1.3  yum install docker-ce docker-ce-cli containerd.io
1.4 systemctl start docker
1.5 yum erase podman buildah (centos解决podman的错误)

# 2. docker-compose
2.1 curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
2.2 chmod +x /usr/local/bin/docker-compose

# 3. 安装docker-harbor
3.1 wget  https://storage.googleapis.com/harbor-releases/release-1.8.0/harbor-online-installer-v1.8.4.tgz
3.2 tar -xf harbor-offline-installer-v2.0.0.tgz
3.3 mv harbor-offline-installer-v2.0.0 /usr/local/harbor
3.4 vim /usr/local/harbor/harbor.yml
3.5 hostname: 10.168.4.44:5000  #本机IP+端口
3.6 port: 5000
3.7 ./install
3.8. 新建用户
3.9. 新建项目
3.10. 将用户加入项目

# 4. docker 机器连接测试
4.1 vi /etc/docker/daemon.json

```
{ "registry-mirrors": ["https://rzugk9e7.mirror.aliyuncs.com"],
"insecure-registries": ["192.168.72.130:5000"] }
```
​	4.2 systemctl daemon-reload
​	4.3 systemctl restart docker
​	4.4 docker login
​	4.5 docker tag nginx 192.168.72.130:5000/jenkins/nginx:v1.0  ip:port/project/tag
​	4.6 docker push 192.168.72.130:5000/jenkins/nginx:v1.0
​	4.7 查看docker 服务其上是否有该镜像

# 5. jenkins 服务器安装jenkins

  5.1 先安装docker
  5.2 wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
  5.3 rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
  5.4 yum install epel-release
  5.5 yum install java-11-openjdk-devel
  5.6 yum install jenkins
  5.7 yum install git
  5.8 systemctl start jenkins
  5.9 firewall-cmd --permanent --zone=public --add-port=8080/tcp
  5.10 firewall-cmd --reload
  5.11 vi /var/lib/jenkins/secrets/initialAdminPassword
  5.22 ip+port 访问
  5.13 下载插件
  5.14 rpm -ql jenkins 查看jenkins 目录
  5.15 点击系统管理–>管理用户–>新建用户

  5.17 点击系统管理–>插件管理–>可选插件–>搜索 Role-based Authorization Strategy 并安装
  5.18 点击系统管理–>Configure Global Security(全局安全配置)–>授权策略：修改为 Role-Base Strategy
  5.19 添加用户

