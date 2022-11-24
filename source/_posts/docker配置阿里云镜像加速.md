---
title: docker配置阿里云镜像加速
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
summary: 使用阿里云镜像加速，解决docker下载镜像慢的问题
categories: docker
tags:
  - docker
  - CICD
abbrlink: 20211
date: 2022-07-25 01:40:54
img:
coverImg:
---

### 为什么需要配置镜像加速

从docker hub 下载镜像太慢，使用阿里云镜像加速器

### 配置

1. 登录[阿里云]( https://www.aliyun.com/ )

2. 个人中心--->控制台---->搜索容器镜像服务--->镜像加速

3. 开始配置

   ```shell
   sudo mkdir -p /etc/docker
     
   sudo tee /etc/docker/daemon.json <<-'EOF'
   {
     "registry-mirrors": ["https://xxxxx.mirror.aliyuncs.com"]
   }
   EOF
     
   sudo systemctl daemon-reload
     
   sudo systemctl restart docker
   ```

   

