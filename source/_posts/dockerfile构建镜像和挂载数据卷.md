---
title: 通过dockerfile构建镜像和挂载数据卷
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: docker
tags:
  - docker
  - dockerfile
abbrlink: 50637
date: 2022-10-28 16:23:33
img:
coverImg:
summary:
---

# docker镜像的定义

> 轻量级可执行的独立软件保，用来打包软件运行环境和基于运行环境开发的软件unionfs 联合文件系统， 右一层一层的文件系统组成, 他支持对文件系统的修改作为一次提交来一层层的叠加特性：一次同时加载多个文件系统，但从外面看起来，只能看到一个文件系统，联合加载会把文件系统叠加起来，这样最终的文件系统会包含所有的底层文件和目录主要包含boosfs rootfs 这种结构可以通过一个base共享资源

#  从容器构建一个docker 镜像

> 命令： docker commit
>
> 参数： -a : 作者
>
> ​			-m: 构建时添加的信息

```shell
docker commit -m  提交副本实质成为一个新的镜像

docker commit -a "zhangtq" -m "no doc" bba8e1b9632c aiguigu/mytomcat:1.2


```



# 运行docker镜像生成容器

```shell
docker run -it -p 对外暴露的端口8888:8080 tomcatdocker run -it -p 8888:8080 tomcat
docker run -it -P tomcat 随机分配暴露端口docker exec -it bba8e1b9632c /bin/bash
docker run -d -p 6666:8080 tomcat 后台启动
```



#  docker 数据卷

> 将docker 容器产生的数据持久化（类似移动硬盘）和数据共享

数据卷的特点： 

1. 数据卷可以在容器之间共享或重用数据

2. 卷中的更改可以直接生效

3. 数据卷中的更改不会包含在镜像的更新中

4. 数据卷的生命周期一致持续到没有容器使用他为止

   

   

   容器内添加： 1.直接命令添加 docker run -it -v /mydatavolume:/mydatavolumecontainer centos
   docker run -it -v /mydatavolume:/mydatavolumecontainer:ro centos  只读挂载 主机可以写，容器内只读
   查看数据是否挂载成功docker inspect centos
   docker start 56dd279c7699\2.dockerfile 添加# volume testFROM centosVOLUME ["/dataVolumeContainer1", "/dataVolumeContainere2"]CMD echo "finished, -------success1"CMD /bin/bash
   docker build -f /mydocker/DockerFile -t test/centos . 创建镜像

数据卷的添加

1. 容器内添加

   docker run -it -v /mydatavolume:/mydatavolumecontainer centos
   docker run -it -v /mydatavolume:/mydatavolumecontainer:ro centos  只读挂载 主机可以写，容器内只读

   docker inspect centos   查看数据是否挂载成功
   docker start 56dd279c7699\  启动容器

2. dockerfile中添加

   ```shell
   # 创建一个dockerfile文件，名字可以随机，建议Dockerfile
   # 文件中的内容 指令（大写） 参数
   FROM centos
   
   VOLUME ["volume01","volume02"]
   
   CMD echo "-----end------"
   
   CMD /bin/bash
   
   # 这里的每个命令，就是镜像的一层！
   ```

   

# docker 编写

```
FROM centos:7.9.2009
MAINTAINER 15652533044@163.com
# 将宿主机当前的上下文c.txt 拷贝到容器/usr/local/路径下
COPY c.txt /user/local/cincontainer.txt
# 将java tomcat 加入到容器中
ADD apache-tomcat-9.0.64.tar.gz /usr/local/
ADD jdk-18_linux-aarch64_bin.tar.gz /usr/local/
# 安装vim编辑器
RUN yum -y install vim
# 设置工作访问路径
ENV MYPATH /usr/local
WORKDIR $MYPATH
# 配置java 和tomcat 的环境变量
ENV JAVA_HOME /usr/local/jdk-18.0.1.1
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV CATALINA_HOME /usr/local/jdk-18.0.1.1
ENV CATALINA_BASE /usr/local/jdk-18.0.1.1
ENV PAHT $PATH;$JAVA_HOME/bin;$CATALINA_HOME/lib;$CATALINA_HOME/bin

# 容器运行时监听的端口
EXPOSE 8080
# 运行时启动tomcat
# ENTRYPOINT ["/usr/local/apache-tomcat-9.0.64/bin/startup.sh"]
# CMD ["/usr/local/apache-tomcat-9.0.64/catalina.sh", "run"]
CMD /usr/local/apache-tomcat-9.0.64/bin/startup.sh && tail -F /usr/local/apache-tomcat-9.0.64/bin/logs/catalina.out

```



LABEL \
org.label-schema.schema-version="1.0" \
org.label-schema.name="CentOS Base Image" \
org.label-schema.vendor="CentOS" \
org.label-schema.license="GPLv2" \
org.label-schema.build-date="20201113" \
org.opencontainers.image.title="CentOS Base Image" \
org.opencontainers.image.vendor="CentOS" \
org.opencontainers.image.licenses="GPL-2.0-only" \
org.opencontainers.image.created="2020-11-13 00:00:00+00:00"


CMD ["/bin/bash"]

1docker 从基础镜像运行一个容器2执行一天指令并对容器做出修改3.执行类似docker commit 的操作提交一个新的镜像层4.docker基于刚提交的镜像运行一个新的容器5执行dockerfile中的下一条指令直到所有的指令都执行完成
dokcer保留字指令FROM 基于哪个镜像编写MAINTAINER 镜像维护者的姓名和邮箱地址RUN 容器构建时需要给运行的命令EXPOSE 实例启动时的端口号WORKDIR 工作目录ENV 在构建过程中使用环境变量ADD 将宿主机目录下的文件拷贝进镜像且add命令会自动处理url和解压tar压缩包COPY 拷贝文件目录到镜像中VOLUME 容器数据卷，保持数据和持久化CMD 指定容器启动时需要运行的命令 dockerfile中可以有多个CMD命令，但只有最后一个生效，CMD会被docker run 之后的参数替换ENTRYPOINT 指定一个容器启动时的命令 entrypoint的目的和cmd一样，都是在指定容器启动程序以及参数 , entrypoint 追加组合命令ONBUILD 触发器，当构建一个被继承的dockerfile时运行命令， 父镜像在被子继承后父镜像的onbuild 被触发
自定义centos的dockersfileFROM centosENV mypath /tmpWORKDIR $mypathRUN yum -y install vimRUN yun -y install net-toolsEXPOSE 80CMD /bin/bash




docker build
docker run