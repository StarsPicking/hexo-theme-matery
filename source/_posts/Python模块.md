---
title: Python模块
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: python
tags:
  - python
abbrlink: 58477
date: 2023-06-24 22:36:24
img:
coverImg:
summary:
---



# time

## time模块



### time模块的三种模式



| 模块                        | 结果                           | 说明         |
| --------------------------- | ------------------------------ | ------------ |
| `time.time()`               | 1613221384.608557              | 1.时间戳     |
| `time.strftime('%Y-%m-%d')` | 2021-02-13                     | 2.格式化时间 |
| `time.localtime()`          | time.struct_time(tm_year=2021… | 3.时间元祖   |



### time时间转换



```python
import time
print(time.time()) # 时间戳
print(time.strftime("%Y-%m-%d")) # 年-月-日时间格式
print(time.localtime()) # 获取系统时区
print(time.gmtime())  # 将时间转换为UTC格式的时间

# 1. 将格式化时间转化为时间戳
print(time.mktime(time.localtime()))

#2. 将字符串时间转化为时间格式
print(time.strptime("2023-09-21"， "%Y-%m-%d"))

# 时间对象转为字符串
print(time.strftime("%Y-%m-%d", "2023-01-09"))

#4. 将结构化时间(元组) 转换成英文字符串时间 : Mon Nov 20 16:51:28 2017
print(time.asctime(time.localtime()))

#5. 将时间戳转成 英文字符串时间 : Mon Nov 20 16:51:28 2017
print(time.ctime(time.time()))
```



## datetime



### datetime获取时间

```python
import datetime

# 1. 获取当前时间
print(datetime.datetime.now())

# 2. 获取三天后的时间
print(datetime.datetime.now()+datetime.timedelta(day=3))

# 3. 获取三天前的时间
print(datetime.datetime.now()+datetime.timedelta(day=-3))

# 4. 获取三个小时后的时间
print(datetime.datetime.now()+datetime.timedelta(hours=3))
# 5. 获取三分钟以前的时间
print(datetime.datetime.now()+datetime.timedelta(minutes = -3))

# 6. 获取当前的年月日时间
print(datetime.datetime.now().date())                              #2017-08-18

# 7. 当前时间格式化输出
print(datetime.datetime.now().strftime("%Y-%m-%d %H-%M-%S"))   

```

### datetime时间转换

```python
import datetime

# 1. 时间格式转化为字符串

print(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))

# 2. 字符串转时间
print(datetime.datetime.strptime('2016-02-22',"%Y-%m-%d"))

# 3. datetime对象转时间元组
print(datetime.datetime.now().timetuple())


# 4. 时间戳转换成datetime对象
print(datetime.datetime.fromtimestamp(1520561646.8906238))

```



# os

## os模块常用方法

```python
import os
#1 当前工作目录，即当前python脚本工作的目录路径
print(os.getcwd())    # C:\Users\admin\PycharmProjects\s14\Day5\test4

#2 当前脚本工作目录；相当于shell下cd
os.chdir("C:\\Users\\admin\\PycharmProjects\\s14")
os.chdir(r"C:\Users\admin\PycharmProjects\s14")
print(os.getcwd())    # C:\Users\admin\PycharmProjects\s14

#3 返回当前目录: ('.')
print(os.curdir)        # ('.')

#4 获取当前目录的父目录字符串名：('..')
print(os.pardir)        # ('..')

#5 可生成多层递归目录
os.makedirs(r'C:\aaa\bbb')         # 可以发现在C盘创建了文件夹/aaa/bbb

#6 若目录为空，则删除，并递归到上一级目录，如若也为空，则删除，依此类推
os.removedirs(r'C:\aaa\bbb')    # 删除所有空目录

#7 生成单级目录；相当于shell中mkdir dirname
os.mkdir(r'C:\bbb')        # 仅能创建单个目录

#8 删除单级空目录，若目录不为空则无法删除，报错；相当于shell中rmdir dirname
os.rmdir(r'C:\aaa')        # 仅删除指定的一个空目录

#9 列出指定目录下的所有文件和子目录，包括隐藏文件，并以列表方式打印
print(os.listdir(r"C:\Users\admin\PycharmProjects\s14"))

#10 删除一个文件
os.remove(r'C:\bbb\test.txt')        # 指定删除test.txt文件

#11 重命名文件/目录
os.rename(r'C:\bbb\test.txt',r'C:\bbb\test00.bak')

#12 获取文件/目录信息
print(os.stat(r'C:\bbb\test.txt'))

#13 输出操作系统特定的路径分隔符，win下为"\\",Linux下为"/"
print(os.sep)                # \

#14 输出当前平台使用的行终止符，win下为"\r\n",Linux下为"\n"
print(os.linesep)

#15 输出用于分割文件路径的字符串
print(os.pathsep)                # ;  （分号）

#16 输出字符串指示当前使用平台。win->'nt'; Linux->'posix'
print(os.name)                # nt

#17 运行shell命令，直接显示
os.system("bash command")

#18 获取系统环境变量
print(os.environ)                # environ({'OS': 'Windows_NT', 'PUBLIC': ………….

#19 返回path规范化的绝对路径
print(os.path.abspath(r'C:/bbb/test.txt'))    # C:\bbb\test.txt

#20 将path分割成目录和文件名二元组返回
print(os.path.split(r'C:/bbb/ccc'))    # ('C:/bbb', 'ccc')

#21 返回path的目录。其实就是os.path.split(path)的第一个元素
print(os.path.dirname(r'C:/bbb/ccc'))    # C:/bbb

#22 返回path最后的文件名。如何path以／或\结尾，那么就会返回空值。即os.path.split(path)的第二个元素
print(os.path.basename(r'C:/bbb/ccc/ddd'))    # ddd

#23 如果path存在，返回True；如果path不存在，返回False
print(os.path.exists(r'C:/bbb/ccc/'))    # True

#24 如果path是绝对路径，返回True        # True
print(os.path.isabs(r"C:\Users\admin\PycharmProjects\s14\Day5\test4"))

#25 如果path是一个存在的文件，返回True。否则返回False
print(os.path.isfile(r'C:/bbb/ccc/test2.txt'))        # True

#26 如果path是一个存在的目录，则返回True。否则返回False
print(os.path.isdir(r'C:/bbb/ccc'))            # True

#28 返回path所指向的文件或者目录的最后存取时间
print(os.path.getatime(r'C:/bbb/ccc/test2.txt'))        # 1483509254.9647143

#29 返回path所指向的文件或者目录的最后修改时间
print(os.path.getmtime(r'C:/bbb/ccc/test2.txt'))        # 1483510068.746478

#30 无论linux还是windows，拼接出文件路径
put_filename = '%s%s%s'%(self.home,os. path.sep, filename)
#C:\Users\admin\PycharmProjects\s14\day10select版FTP\home
```



## os模块使用场景

### 添加文件夹到环境变量

```python
import os,sys
print(os.path.dirname( os.path.dirname( os.path.abspath(__file__) ) ))
BASE_DIR = os.path.dirname( os.path.dirname( os.path.abspath(__file__) ) )
sys.path.append(BASE_DIR)

# 代码解释：
# 要想导入其他目录中的函数，其实就是将其他目录的绝对路径动态的添加到pyhton的环境变量中，这样python解释器就能够在运行时找到导入的模块而不报错：
# 然后调用sys模块sys.path.append(BASE_DIR)就可以将这条路径添加到python环境变量中
```







### os.popen获取脚本执行结果

- data.py

```python
data = {'name':'aaa'}
import json
print json.dumps(data)
```

- get_data.py

```python
#! /usr/bin/env python
# -*- coding: utf-8 -*-
import os,json

ret = os.popen('python data.py')
data = ret.read().strip()
ret.close()
data = json.loads(data)
print data  # {'name':'aaa'}
```



# sys



## sys基本方法

sys.argv　　　　　　　　　　返回执行脚本传入的参数

sys.exit(n) 　　　　 退出程序，正常退出时exit(0)

sys.version 　　 获取Python解释程序的版本信息

sys.maxint 　 最大的Int值

sys.path 　　 返回模块的搜索路径，初始化时使用PYTHONPATH环境变量的值

sys.platform 　 返回操作系统平台名称

sys.stdout.write('please:')

val = sys.stdin.readline()[:-1]

## 使用sys返回运行脚本参数



```python
import sys
# C:\Users\tom\PycharmProjects\s14Review\day01>  python test01.py 1 2 3
print(sys.argv)         # 打印所有参数            ['test01.py', '1', '2', '3']
print(sys.argv[1:])     # 获取索引 1 往后的所有参数    ['1', '2', '3']
```



# json与pickle

## json

- 1.序列化 (json.dumps) ：是将内存中的对象存储到硬盘，变成字符串
- 2.反序列化(json.loads) ： 将刚刚保存在硬盘中的内存对象从新加载到内存中
- json.dumps( data,ensure_ascii=False, indent=4)

```python
#json序列化代码
import json
info = {
    'name':"tom",
    "age" :"100"
}
f = open("test.txt",'w')
# print(json.dumps(info))
f.write(json.dumps(info))
f.close()
```



```python
#json反序列化代码
import json
f = open("test.txt","r")
data = json.loads(f.read())
f.close()
print(data["age"])
```



## pickle序列化

- python的pickle模块实现了python的所有数据序列和反序列化。
- 基本上功能使用和JSON模块没有太大区别，方法也同样是dumps/dump和loads/load
- 与JSON不同的是pickle不是用于多种语言间的数据传输，它仅作为python对象的持久化或者python程序间进行互相传输对象的方法，因此它支持了python所有的数据类型。
- `pickle序列化代码`

```python
#pickle序列化代码
import pickle
info = {
    'name':"tom",
    "age" :"100"
}
f = open("test.txt",'wb')
f.write(pickle.dumps(info))
f.close()
```



- `pickle反序列化代码`

```text
#pickle反序列化代码
import pickle
f = open("test.txt","rb")
data = pickle.loads(f.read())
f.close()
print(data["age"])
```



## 解决序列化datetime类型

```python
import json,datetime

class JsonCustomEncoder(json.JSONEncoder):
    def default(self, field):
        if isinstance(field, datetime.datetime):
            return field.strftime('%Y-%m-%d %H:%M:%S')
        elif isinstance(field, datetime.date):
            return field.strftime('%Y-%m-%d')
        else:
            return json.JSONEncoder.default(self, field)

t = datetime.datetime.now()

print(type(t),t)
f = open('ttt','w')                              #指定将内容写入到ttt文件中
f.write(json.dumps(t,cls=JsonCustomEncoder))      #使用时候只要在json.dumps增加个cls参数即可
```



- `JSON和pickle模块的区别`

  

  - 1.JSON只能处理基本数据类型。pickle能处理所有Python的数据类型。
  - 2.JSON用于各种语言之间的字符转换。
  - pickle用于Python程序对象的持久化或者Python程序间对象网络传输，但不同版本的Python序列化可能还有差异



# re

## re模块常用方法

### re.compile()

- 该方法用来生成正则表达式对象，其语法格式如下：

```
regex=re.compile(pattern,flags=0)
```

- 参数说明：

  - pattern：正则表达式对象。

  - flags：代表功能标志位，扩展正则表达式的匹配。

### re.findall()

- 根据正则表达式匹配目标字符串内容。

```
re.findall(pattern,string,flags=0)
```

- 该函数的返回值是匹配到的内容列表，如果正则表达式有子组，则只能获取到子组对应的内容。参数说明如下：

  - pattern：正则表达式对象。

  - string：目标字符串

  - flags：代表功能标志位，扩展正则表达式的匹配。

根据正则表达式匹配目标字符串内容。

```
re.findall(pattern,string,flags=0)
```

该函数的返回值是匹配到的内容列表，如果正则表达式有子组，则只能获取到子组对应的内容。参数说明如下：

- pattern：正则表达式对象。
- string：目标字符串
- flags：代表功能标志位，扩展正则表达式的匹配。

#### re.split()

- 该函数使用正则表达式匹配内容，切割目标字符串。返回值是切割后的内容列表。参数说明：

```
re.split(pattern,string,flags = 0)
```

- 参数说明：

  - pattern：正则表达式。

  - string：目标字符串。

  - flags：功能标志位,扩展正则表达式的匹配。

### re.sub

- 该函数使用一个字符串替换正则表达式匹配到的内容。返回值是替换后的字符串。其语法格式如下：

```
re.sub(pattern,replace,string,max,flags = 0)
```

- 其参数说明：

  - pattern：正则表达式。

  - replace：替换的字符串。

  - string：目标字符串。

  - max：最多替换几处，默认替换全部，

  - flags：功能标志位,扩展正则表达式的匹配。

### re.search()

- 匹配目标字符串第一个符合的内容，返回值为匹配的对象。语法格式如下：

```
re.search(pattern,string,flags=0)
```

- 参数说明：

  - pattern：正则表达式

  - string：目标字符串

## flags功能标志位

功能标志位的作用是扩展正则表达的匹配功能。常用的 flag 如下所示：



| 缩写元字符 | 说明                                    |
| ---------- | --------------------------------------- |
| A          | 元字符只能匹配 ASCII码。                |
| I          | 匹配忽略字母大小写。                    |
| S          | 使得`.`元字符可以匹配换行符。           |
| M          | 使 ^ $ 可以匹配每一行的开头和结尾位置。 |

注意：可以同时使用福多个功能标志位，比如 flags=re.I|re.S。

下面使用贪婪和非贪婪两种模式来匹配 HTML 元素，分别，如下所示：

 ```python
 import re
 
 html="""
 <div><p>www.biancheng.net</p></div>
 <div><p>编程帮</p></div>
 """
 #贪婪匹配，re.S可以匹配换行符
 #创建正则表达式对象
 pattern=re.compile('<div><p>.*</p></div>',re.S)
 #匹配HTMLX元素，提取信息
 re_list=pattern.findall(html)
 print(re_list)
 
 #非贪婪模式匹配，re.S可以匹配换行符
 pattern=re.compile('<div><p>.*?</p></div>',re.S)
 re_list=pattern.findall(html)
 print(re_list)
 ```



输出结果：

```shell
['<div><p>www.biancheng.net</p></div>\n<div><p>编程帮</p></div>']
['<div><p>www.biancheng.net</p></div>', '<div><p>编程帮</p></div>']
```



## 正则表达式分组



- 通过正则表达式分组可以从匹配的信息中提取出想要的信息。示例- 演示：

```python
#正则表达式分组
website="编程帮 www.biancheng.net"

#提取所有信息
#注意此时正则表达式的 "." 需要转义因此使用 \.
pattern_1=re.compile('\w+\s+\w+\.\w+\.\w+')
print(pattern_1.findall(website))

#提取匹配信息的第一项
pattern_2=re.compile('(\w+)\s+\w+\.\w+\.\w+')
print(pattern_2.findall(website))

#有两个及以上的()则以元组形式显示
pattern_3=re.compile('(\w+)\s+(\w+\.\w+\.\w+)')
print(pattern_3.findall(website))
```

输出结果：

```shell
['编程帮 www.biancheng.net']
['编程帮']
[('编程帮', 'www.biancheng.net')]
```



- 正则表达式分组是提取信息的常用方式。当需要哪个特定信息的时候，就可以通过分组(也就是加括号)的方式获得。
