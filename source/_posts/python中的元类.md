---
title: python中的元类
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: python
abbrlink: 25874
date: 2022-10-23 20:10:58
tags:
	- python基础
img:
coverImg:
summary:
---

### 元类的定义

 [案例：元类实现单例模式_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1uA411V7dW?p=4) 

1. 在python中，一切皆是对象，类本身也是对象，当使用关键字class时，解释器会在内存中创建一个对象（这个对象是指类本身，而不是类的实例）

   ````python
   class Student:  # 这句解释器执行了type("Student", (), {})
       pass
   
   ````

2. 元类是类的类，是类的模板， 是用来控制如何创建类的，元类的实例对象为类，正如类的实例为对象

3. type是python内建的一个元类，用来直接控制类的生成，python中任何直接定义的类，都是type类实例化的对象

### 创建类的两种方法

·```

````
class Student:pass

Student = type('Student', (), {})
````

### 自定义一个元类

```python
class Mytype(type):
  
    def __init__(self, a, b, c):
        print("执行构造类方法")
        print("执行元类的第一个参数{}".format(self))
        print("执行元类的第一个参数{}".format(a))
        print("执行元类的第二个参数{}".format(b))
        print("执行元类的第三个参数{}".format(c))

    def __call__(self, *args, **kwargs):
        print("执行元类的__call__方法")
        obj = object.__new__(self)
        self.__init__(obj, *args, **kwargs)
        return obj

class Student(metaclass=Mytype):  ### 这句相当于执行 Student = Mytype(Student, "Student", (), {})

    def __init__(self, name):
        self.name = name

s = Student("李四")

```

