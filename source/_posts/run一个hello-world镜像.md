---
title: run一个hello-world镜像
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - docker
abbrlink: 4585
summary: 在centos上运行一个hello-world 镜像
date: 2022-07-25 02:05:55
img:
coverImg:
---

## 运行一个hello-world容器

```shell
docker run hello-world
```

### 日志如下

```
[root@localhost log]# docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
0e03bdcc26d7: Pull complete 
Digest: sha256:8e3114318a995a1ee497790535e7b88365222a21771ae7e53687ad76563e8e76
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an centos container with:
 $ docker run -it centos bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

### 运行过程分析：

1. 执行run hello-world后，docker首先会从本地的镜像仓库中查找hello-world这个镜像如果找到了，就会用本地的镜像闯将容器，如果没有找到对应的镜像，就会前往已经配置好的远端仓库查找，找到后下载到本地仓库，创建容器并启动

2. 从 **Unable to find image 'hello-world:latest' locally** 可以看到本地没有找到对应的镜像
3. 从 **latest: Pulling from library/hello-world** 可以看到，docker 到远端开去镜像
4. 从**Status: Downloaded newer image for hello-world:latest** 可以看到镜像拉取成功，此时本地仓库已经添加了hello-world镜像
5. 从**hello docker**可以看到镜像已经成功运行了

