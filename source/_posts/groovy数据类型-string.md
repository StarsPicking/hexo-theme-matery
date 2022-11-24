---
title: groovy数据类型-string
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: groovy
tags:
  - groovy
abbrlink: 50895
date: 2022-10-28 23:53:39
img:
coverImg:
summary:
---

#### groovy数据类型-String

* 字符串表示：单双引号，三引号
* 常用方法：
    * contain() 是否包含特定的内容，返回trur or false
    * size() length 大小、长度
    * toString() 转换成string类型
    * indexOf() 元素的索引
    * endsWith() 是否指定字符串的结尾
    * minus() plus() 去除、增加字符串
    * reverse() 反转字符串
    * substring(1, 2) 指定索引开始的子字符串
    * toUpperCase()、 toLowerCase() 大小写转换
    * split()字符串分割， 默认空格分割，返回列表
 * 实践
 ```
 groovy:000> name = "zhangsan"
===> zhangsan
groovy:000> "my name is ${zhangsan}"
Unknown property: zhangsan
groovy:000> "my name is ${name}"
===> my name is zhangsan
groovy:000> 'my name is ${name}'
===> my name is ${name}
 单引号打变量名， 双引号获取变量的值
 
 groovy:000> "devopsteststops".contains("ops")
===> true
groovy:000> "devopsteststops".contains("users")
===> false
groovy:000> "devopsteststops".endsWith("ops")
===> true
groovy:000> "devopsteststops".endsWith("abs")
===> false
groovy:000> "devopsteststops".size()
===> 15
groovy:000> "devopsteststops".length()
===> 15
groovy:000> "dev" + "ops"
===> devops
groovy:000> "dev" - "ops"
===> dev
groovy:000> "devops".toUpperCase()
===> DEVOPS
groovy:000> "devops".toUpperCase().toLowerCase()
===> devops
groovy:000> 
groovy:000> "host01, host02, host03".split(",")
===> [host01,  host02,  host03]
groovy:000> hosts = "host01, host02, host03".split(",")
===> [host01,  host02,  host03]
groovy:000> for (i in hosts){}
===> null
groovy:000> for (i in hosts){
groovy:001> println(i)}
host01
 host02
 host03
===> null

 ```