---
title: docker镜像仓库管理规范
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: docker
tags:
  - harbor
  - CICD
  - docker
op: false
abbrlink: 40755
date: 2022-08-03 19:12:51
img:
coverImg:
summary:
---


##  镜像管理规范

### 命名规范

#### 仓库类型：

1. snapshot: 开发仓库
2. release： 生产正式版本仓库

####  仓库命名

1. snapshot： 业务/项目名称 demo-snapshot
2. release:  业务/项目名称 demo-release

#### 镜像命名

应用名称/标签

1. DEV: demo-snapshot/demo-devops-service:branch_commitid
2. PRD: demo-release/demo-devops-srvice:version_commitid

#### 标签命名

1. 分支名_提交ID
2. 版本号_提交ID

提交id 减少重复构建

### 镜像清理策略

随着镜像越来越多，频繁更新导致harbor镜像仓库的容量很快爆满，release 发布后，一周后可以清除，snapshot在合并到release 后可以清理(具体时间按照需求)

