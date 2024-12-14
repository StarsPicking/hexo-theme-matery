---
title: java项目发布流水线
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - 流水线
  - CICD
op: false
abbrlink: 63297
date: 2022-08-10 16:11:37
img:
coverImg:
summary:
---


## java 项目发布流水线

![1660119219391](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1660119219391.png)

- 使用maven编译打包

- 使用Sonar扫描

- 编写Dockerfile构建镜像

- 自动生成K8s部署文件，替换镜像
- 使用Kubernetes API发布部署.（Jenkins Slave要挂载docker）