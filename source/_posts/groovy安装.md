---
title: groovy安装
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: groovy
tags:
  - groovy
abbrlink: 20877
date: 2022-10-28 23:53:12
img:
coverImg:
summary:
---

#### groovy安装

1. wget https://groovy.jfrog.io/artifactory/dist-release-local/groovy-zips/apache-groovy-binary-4.0.2.zip
2. unzip apache-groovy-binary-4.0.2.zip -d /usr/local/
3. ln -sv /usr/local/groovy-4.0.2 /usr/local/groovy
4. vi /etc/profile
```
export GROOVY_HOME="/usr/local/groovy"
export PATH=$GROOVY_HOME/bin:$PATH
```
5. source /etc/profile
6. groovy -version