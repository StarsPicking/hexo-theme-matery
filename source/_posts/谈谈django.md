---
title: 谈谈django
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: python
tags:
  - django
abbrlink: 35098
date: 2022-10-23 14:47:18
img:
coverImg:
summary:
---

### Django

django是一个有python编写的web应用框架，使用django可以很轻易的完成一个网站的大部分内容，在这个基础上可以进一步开发出全功能的web服务。django本身基于mvc模式（model, view, controller）的设计模式，使后续对程序的修改变得简单易行。

mvc的优势：

低耦合

开发快捷

部署方便

可重用性高

维护成本低



特点：

强大的数据库功能

自带强大的后台

### MTV和mvc模式

MTV模式是指：

m: 模型，负责数据库的映射（orm）

v: 视图， 图形界面，负责与用户的交互(页面) 

c: 控制器， 负责转发请求

MTV模式是指：

m: 模型， 负责业务对象和数据库的映射

t: 模板，将数据通过html的形式展示给用户

v: 视图，负责处理业务逻辑，在适当的时候调用view 和model

除此之外，mtv模式还需要一个url分发器来分发请求，将不同的url分发给不同的url进行处理