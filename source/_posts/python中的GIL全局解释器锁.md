---
title: python中的GIL全局解释器锁
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: python
abbrlink: 38350
date: 2022-10-23 10:31:55
tags:
	- python基础
img:
coverImg:
summary:
---

# GIL



在cpython中使用引用计数来管理内存，举个例子

```
import sys
a = []
b = a
sys.getrecount(a)
```

在这个例子中，引用计数时3，这样一来，如果有两个线程同时引用了a，会出现竞争条件漏洞，引用计数可能只增加1, 这样会造成内存污染，因为当第一个线程结束时,引用计数-1,会使对象销毁，达到内存回收的标准，第二个线程再去访问的时候，找不到有效内存。

cpython中引GIL主要有两个原因：

1. 设计者为了规避内存管理这样复杂的竞争风险
2. cpython中大量使用了c语言库，而c语言库大多不是原生线程安全的（线程安全会降低复杂度）

# GIL工作原理



 下面这张图，就是一个 GIL 在 Python 程序的工作示例。其中，Thread 1、2、3 轮流执行，每一个线程在开始执行时，都会锁住 GIL，以阻止别的线程执行；同样的，每一个线程执行完一段后，会释放 GIL，以允许别的线程开始利用资源。 ![1666493857159](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1666493857159.png)





但是如果死锁了怎么办呢，如果仅仅是要求 Python 线程在开始执行时锁住 GIL，而永远不去释放 GIL，那别的线程就都没有了运行的机会。 

没错cpython还有另外一个机制，check_interval机制，在一个合理的时间段内python 解释器都会强制释放锁

# python的线程安全问题

有了GIL,并不意味着python 编程就不考虑线程安全问题了，因为存在check_interval抢占机制，所以某些操作可能会被打断，所以我们需要使用threading.lock()来确保线程安全

# 如何绕过GIL



绕过 CPython，使用 JPython（Java 实现的 Python 解释器）等别的实现 

把关键性能代码，放到别的语言（一般是 C++）中实现。