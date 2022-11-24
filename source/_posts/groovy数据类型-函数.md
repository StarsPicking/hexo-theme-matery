---
title: groovy数据类型-函数
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: groovy
tags:
  - groovy
abbrlink: 29915
date: 2022-10-28 23:54:04
img:
coverImg:
summary:
---

#### groovy 函数

*  def 定义函数
*  语法
```
def PrintMes(value){
    println(value)
    return value
    }

```
* 调用 PrintMes()
* 实践
```
groovy:000> def PrintMes(value){
groovy:001>     println(value)
groovy:002>     return value
groovy:003>     }
===> true
groovy:000> PrintMes("devops")
devops
===> devops
groovy:000> resposne = PrintMes("devope")
devope
===> devope
groovy:000> println(response)
Unknown property: response
groovy:000> println(resposne)

```