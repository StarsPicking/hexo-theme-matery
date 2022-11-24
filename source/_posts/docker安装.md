---
title: docker安装
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
summary:
categories: docker
tags:
  - docker
  - docker
  - CICD
abbrlink: 8175
date: 2022-07-25 01:31:48
img:
coverImg:
---

## 安装与卸载

### 卸载老版本

  ```shell
sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
  ```



### 安装新版本

```shell
sudo yum install -y yum-utils

sudo yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
# 如果上面的太慢，更换国内的源
# yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

sudo yum install docker-ce docker-ce-cli containerd.io

sudo systemctl start docker

docker version   确定是否安装成功

注意只能在centos6.5版本以上版本中使用docker
```

#### 解决centos8中podman问题

```shell
yum erase podman buildah
```



