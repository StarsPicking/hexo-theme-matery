---
title: 使用docker安装mysql和redis
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - docker
  - mysql
  - reids
abbrlink: 47352
date: 2022-07-25 22:19:17
img:
coverImg:
summary:
---

## 安装mysql 

1.  到docker hub中找自己需要的mysql 镜像版本 或者执行docker search mysql

![1658759001622](1658759001622.png)

2.  docker pull mysql  --- 不指定版本默认下载最新的mysql

   ![屏幕截图 2022-07-25 223100](223100.png)

3. docker pull mysql:5.7 下载5.7版本的镜像

4.  运行mysql 镜像

   ```
   sudo docker run \
    -p 3306:3306 --name mysql \
    -v /mydata/mysql/log:/var/log/mysql \ 
    -v /mydata/mysql/data:/var/lib/mysql \ 
    -v /mydata/mysql/conf:/etc/mysql \ 
    -e MYSQL_ROOT_PASSWORD=root \ 
    -d mysql:5.7
    
    配置端口映射：
   -p 3306:3306 --name mysql
   将容器的3306端口映射到主机的3306端口
   配置mysql数据卷挂载
   1.-v /mydata/mysql/log:/var/log/mysql(日志文件挂载)
   将容器中的日志文件夹挂载到主机对应的/var/log/mysql文件夹中
   2.-v /mydata/mysql/data:/var/lib/mysql(数据文件挂载)
   将容器中的数据文件夹挂载到主机对应的/var/lib/mysql文件夹中
   3.-v /mydata/mysql/conf:/etc/mysql(配置文件挂载)
   将容器的配置文件夹挂载到主机对应的/etc/mysql文件夹中
   注(这里所提的主机指的是当前的linux主机)
   配置用户
   -e MYSQL_ROOT_PASSWORD=root
   设置初始化root用户的密码
   指定镜像资源
   -d mysql:5.7
   -d：以后台方式运行实例
   mysql:5.7：指定用这个镜像来创建运行实例
   ```

   

5. 查看mysql 容器

   ```
   docker ps -a
   ```

## 安装redis

1. docker pull redis

2. 挂载配置文件

   ```
   mkdir -p  /home/redis/myredis/data
   vim /home/redis/myredis/redis.conf   # 写入redis 配置文件内容
   # 执行docker命令
   docker run --restart=always --log-opt max-size=100m --log-opt max-file=2 -p 6379:6379 --name myredis -v /home/redis/myredis/myredis.conf:/etc/redis/redis.conf -v /home/redis/myredis/data:/data -d redis redis-server /etc/redis/redis.conf  --appendonly yes  --requirepass 000415
   
   
   ```

   说明

   ```
   –restart=always 总是开机启动
   –log是日志方面的
   -p 6379:6379 将6379端口挂载出去
   –name 给这个容器取一个名字
   -v 数据卷挂载
   /home/redis/myredis/myredis.conf:/etc/redis/redis.conf 这里是将 liunx 路径下的myredis.conf 和redis下的redis.conf 挂载在一起。
   /home/redis/myredis/data:/data 这个同上
   -d redis 表示后台启动redis
   redis-server /etc/redis/redis.conf 以配置文件启动redis，加载容器内的conf文件，最终找到的是挂载的目录 /etc/redis/redis.conf 也就是liunx下的/home/redis/myredis/myredis.conf
   –appendonly yes 开启redis 持久化
   –requirepass 000415 设置密码
   ```

   

   