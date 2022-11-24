---
title: python的垃圾回收机制
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: python
tags:
  - python基础
abbrlink: 41514
date: 2022-10-21 23:09:19
img:
coverImg:
summary:
---





# 引用计数c源码

![1666365135262](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1666365135262.png)



# 引用计数在python中的实现



![1666365721785](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1666365721785.png)









![1666366202112](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1666366202112.png)



# 标记清楚解决循环引用

只用引用计数的话，会出现循环引用的问题，在python中用了标记清除的方式来解决





![1666366643482](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1666366643482.png)







![1666366986121](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1666366986121.png)





![1666367253217](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1666367253217.png)







![1666367810310](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1666367810310.png)



总结：

在python中维护了一个refchain的双向循环列表，这个链表中维护了程序运行需要的所有对象，每种对象中都有obj_re cent的属性，首次创建次数为一，通过+1 -1来维护该对象被引用的次数，当object_refcnt为0时，说明需要进行垃圾回收。

但是在python中，多个元素组成的对象可能存在相互引用的问题，为了解决这个问题，python又引入了标记清除的方式，

在解释器内部额外再维护三个列表（0代，1代，2代），

0代：当0代到达700个扫描一次，

1代： 当1代扫描10次扫描一次

2代： 当2代扫描10此扫描一次

在这个基础上，python内部又做缓存优化

缓存优化有两种：

1. 池（int）避免重复创建和销毁常用的对象

2. free_list 当引用计数为0时，按理说应该回收，但内部不会直接回收，会加入到free_list中，以后不会直接创建，而是先从free_list中获取

   

