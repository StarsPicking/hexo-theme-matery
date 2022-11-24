---
title: 基于dokcer安装jenkins
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - jenkins
  - CICD
op: false
abbrlink: 27011
date: 2022-08-02 15:51:38
img:
coverImg:
summary:
---

# docker 安装jenkins

## 安装

```
docker pull jenkins/jenkins
mkdir -p /var/jenkins_home
chmod 777 /var/jenkins_home
docker run -d -p 10240:8080 -p 10241:50000 -v /var/jenkins_home:/var/jenkins_home -v /etc/localtime:/etc/localtime --name myjenkins jenkins/jenkins
docker ps
docker logs -f d49d8bf74571

可以看到启动正常
>	at jenkins.install.InstallState$3.initializeState(InstallState.java:105)<br>	at jenkins.model.Jenkins.setInstallState(Jenkins.java:1062)<br>	at jenkins.install.InstallUtil.proceedToNextStateFrom(InstallUtil.java:96)<br>	at jenkins.model.Jenkins.&lt;init&gt;(Jenkins.java:952)<br>	at hudson.model.Hudson.&lt;init&gt;(Hudson.java:86)<br>	at hudson.model.Hudson.&lt;init&gt;(Hudson.java:82)<br>	at hudson.WebAppMain$3.run(WebAppMain.java:235)<br></pre>
Aug 02, 2022 7:47:40 AM hudson.WebAppMain$3 run
INFO: Jenkins is fully up and running

```

## 配置国内镜像源

```
vi /var/jenkins_home/hudson.model.UpdateCenter.xml 将里面的url修改为清华源

<?xml version='1.0' encoding='UTF-8'?>
<sites>
  <site>
    <id>default</id>
    <url>http://mirror.esuni.jp/jenkins/updates/update-center.json</url>
  </site>
</sites>

cd /var/jenkins_home/war/WEB-INF/update-center-rootCAs
rm -rf *
vi  mirror-adapter.crt 添加如下内容
-----BEGIN CERTIFICATE-----
MIICcTCCAdoCCQD/jZ7AgrzJKTANBgkqhkiG9w0BAQsFADB9MQswCQYDVQQGEwJD
TjELMAkGA1UECAwCR0QxCzAJBgNVBAcMAlNaMQ4wDAYDVQQKDAV2aWhvbzEMMAoG
A1UECwwDZGV2MREwDwYDVQQDDAhkZW1vLmNvbTEjMCEGCSqGSIb3DQEJARYUYWRt
aW5AamVua2lucy16aC5jb20wHhcNMTkxMTA5MTA0MDA5WhcNMjIxMTA4MTA0MDA5
WjB9MQswCQYDVQQGEwJDTjELMAkGA1UECAwCR0QxCzAJBgNVBAcMAlNaMQ4wDAYD
VQQKDAV2aWhvbzEMMAoGA1UECwwDZGV2MREwDwYDVQQDDAhkZW1vLmNvbTEjMCEG
CSqGSIb3DQEJARYUYWRtaW5AamVua2lucy16aC5jb20wgZ8wDQYJKoZIhvcNAQEB
BQADgY0AMIGJAoGBAN+6jN8rCIjVkQ0Q7ZbJLk4IdcHor2WdskOQMhlbR0gOyb4g
RX+CorjDRjDm6mj2OohqlrtRxLGYxBnXFeQGU7wWjQHyfKDghtP51G/672lXFtzB
KXukHByHjtzrDxAutKTdolyBCuIDDGJmRk+LavIBY3/Lxh6f0ZQSeCSJYiyxAgMB
AAEwDQYJKoZIhvcNAQELBQADgYEAD92l26PoJcbl9GojK2L3pyOQjeeDm/vV9e3R
EgwGmoIQzlubM0mjxpCz1J73nesoAcuplTEps/46L7yoMjptCA3TU9FZAHNQ8dbz
a0vm4CF9841/FIk8tsLtwCT6ivkAi0lXGwhX0FK7FaAyU0nNeo/EPvDwzTim4XDK
9j1WGpE=
-----END CERTIFICATE-----

重启jenkins
docker restart myjenkins

```

# 访问jenkins

浏览器登录http://ip:10240/

vi  /var/jenkins_home/secrets/initialAdminPassword  获取密码

# 下载插件



