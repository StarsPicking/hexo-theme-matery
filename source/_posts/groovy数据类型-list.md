---
title: groovy数据类型-list
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: groovy
tags:
  - groovy
abbrlink: 42286
date: 2022-10-28 23:53:55
img:
coverImg:
summary:
---

#### groovy数据类型-list

* 列表符号[]
* 常用方法
    *  + - += -= 元素增加或者减少
    * << 、 add() 添加元素
    *  isEmpty() 是否为空
    *  intersect([2, 3]) disjoint([1]) 取交集、判断是否有交集
    *  flatten() 合并嵌套的列表
    *  unique()去重
    *  reverse() sort() 反转 升序
    *  count() 元素个数
    *  join() 将元素按照参数链接
    *  sum() min() max() 
    *  contains() 包含特定元素
    *  remove(2) removeA11()
    *  each{} 遍历 
* 实践
```
  groovy:000> []
===> []
groovy:000> [1, 2, 3, 4, 5] + 6
===> [1, 2, 3, 4, 5, 6]
groovy:000> [1, 2, 3, 4, 5]  << 14
===> [1, 2, 3, 4, 5, 14]
groovy:000> [1, 2, 3, 4, 5].add(14)
===> true
groovy:000> result = [1, 2, 3, 4, 5].add(14)
===> true
groovy:000> println(result)
true
===> null
groovy:000> [2, 3, 4, 4, 6, 7].unique()
===> [2, 3, 4, 6, 7]
groovy:000> [2, 3, 4, 5, 6, 6].each{println(it)}
2
3
4
5
6
6
===> [2, 3, 4, 5, 6, 6]
```