---
title: 保留字指令
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: docker
tags:
  - docker
  - dockerfile
abbrlink: 11266
date: 2022-10-28 17:34:11
img:
coverImg:
summary:
---



# 保留字指令



FROM 基于哪个镜像编写

MAINTAINER 镜像维护者的姓名和邮箱地址

RUN 容器构建时需要给运行的命令

EXPOSE 实例启动时的端口号

WORKDIR 工作目录ENV 在构建过程中使用环境变量

ADD 将宿主机目录下的文件拷贝进镜像且add命令会自动处理url和解压tar压缩包

COPY 拷贝文件目录到镜像中

VOLUME 容器数据卷，保持数据和持久化

CMD 指定容器启动时需要运行的命令

 dockerfile中可以有多个CMD命令，但只有最后一个生效，CMD会被docker run 之后的参数替换

ENTRYPOINT 指定一个容器启动时的命令 entrypoint的目的和cmd一样，都是在指定容器启动程序以及参数 , entrypoint 追加组合命令

ONBUILD 触发器，当构建一个被继承的dockerfile时运行命令， 父镜像在被子继承后父镜像的onbuild 被触发