---
title: docker命令
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: docker
tags:
  - docker
  - CICD
summary: docker 容器、docker镜像的基本操作
abbrlink: 12799
date: 2022-07-25 02:29:00
img:
coverImg:
---

## docker 命令

### 镜像操作命令

1.  docker run hello-word
2.  docker search tomcatdocker images  ---查看docker镜像
3.  docker pull tomcat --- docker pull tomcat:latestdocker pull 镜像:tag
4. docker rmi 镜像:tag ---删除镜像
5. docker rmi -f hello-world nginx ---删除多个镜像
6. docker rmi -f $(docker images -qa) 删除docker中所有的镜像

### 容器操作

1. docker pull centos  --- 先获取一个docker镜像

2. docker run centos  --- 运行一个centos镜像，生成centos 实例

3. docker build   --- 打包封装一个容器为镜像
4. docker run -it --env-file ./run/hrms.env -v /opt/hrms/hrms/hrms:/opt/hrms/hrms -p 10.142.8.12:8083:8080 55ad68601db
   1. -i : 以交互式模式运行容器， 通常与t同时使用
   2. -t:为容器重新分配一个伪终端，通常与i同时使用
   3. -v:  表示将宿主机上的文件挂载到镜像中，冒号前面表示宿主机文件路径，后面表示镜像文件路径，都要用绝对路径 
5. docker ps  --- 查看docker中运行的容器
6. docker ps -l  --- 上次运行的
7. docker ps -n 5    --- 上5次运行的容器
8. docker ps -qa   --- 所有运行的容器
9. exit 退出 (结束退出)
10. ctrl + q+p 守护退出
11. docker stop/ start ed3e7ce4801b --- 停止或者启动容器
12. docker kill ed3e7ce4801b  --- 强制停止
13. docker rm id1 id2 ---删除多个容器
14. docker rm -f $(docker ps -aq) 删除所有容器

### 补充命令

1. docker logs -f -t --tail 
2. docker logs 3441313e8552
3. docker top 3441313e8552 查看容器的进程
4. docker inspect 3441313e8552 查看容器内的结构细节
5. docker attach 12004edc9cdd 进入容器，然后执行命令
6. docker exec -t 12004edc9cdd ls -l /tmp 直接的得到某个容器的执行结果
7. docker cp 宿主机中要拷贝的文件名及其路径 容器名：要拷贝到容器里面对应的路径 
8.  docker cp 容器名:要拷贝的文件在容器里面的路径 要拷贝到宿主机的相应路径 





   

