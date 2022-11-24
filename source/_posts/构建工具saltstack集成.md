---
title: 构建工具saltstack集成
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - CICD

abbrlink: 52139
date: 2022-10-21 18:59:32
img:
coverImg:
summary:
---

#### CD-saltstack
[官网](https://repo.saltproject.io/#rhel)
##### saltstack安装

1. sudo rpm --import https://repo.saltproject.io/py3/redhat/8/x86_64/latest/SALTSTACK-GPG-KEY.pub

2. curl -fsSL https://repo.saltproject.io/py3/redhat/8/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo

3. yum install salt-master

4. yum install salt-minion

5. systemctl start salt-master

6. systemctl start salt-minion

7. cd /etc/salt

8. vi minion 添加master: 182.168.72.132   重启

9. salt-key -L   # master上操作可以看到未接受的key

10. salt-key -a 172.17.0.1

11.  设置开机自启动
    1.  systemctl enable --now salt-master
    2.  systemctl enable --now salt-minion
    
12. firewall-cmd --zone=public --add-port=4505/tcp --permanent

13. firewall-cmd --zone=public --add-port=4506/tcp --permanent

14. systemctl restart firewalld.service

    ---

    

##### 常用命令



sudo systemctl enable salt-master && sudo systemctl start salt-master

sudo systemctl enable salt-minion && sudo systemctl start salt-minion

sudo systemctl enable salt-syndic && sudo systemctl start salt-syndic

sudo systemctl enable salt-api && sudo systemctl start salt-api

##### 修改id或者标识
1. hostnamectl 查看当前
2. hostnamectl set-hostname k8s-slave
3. minion 端执行
    1. rm -rf/etc/salt/minion_id
    2. rm -rf /etc/salt/pki/*
    3. service salt-minion restart
4. master端执
    1. rm -rf /etc/salt/pki/* 
    2. service salt-master restart