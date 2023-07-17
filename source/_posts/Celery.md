---
title: Celery
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: python
tags:
  - celery
abbrlink: 63146
date: 2023-06-25 22:40:29
img:
coverImg:
summary:
---

# celery组件与原理

##  celery原理与组件

###   celery应用举例

- Celery 是一个 基于python开发的`分布式异步消息任务队列`，通过它可以轻松的实现任务的异步处理，如果你的业务场景中需要用到异步任务，就可以考虑使用celery
- 你想对100台机器执行一条批量命令，可能会花很长时间 ，但你不想让你的程序等着结果返回，而是给你返回 一个任务ID,你过一段时间只需要拿着这个任务id就可以拿到任务执行结果， 在任务执行ing进行时，你可以继续做其它的事情
- Celery 在执行任务时需要通过一个消息中间件来接收和发送任务消息，以及存储任务结果， 一般使用rabbitMQ or Redis

###  Celery有以下优点

- 简单：一单熟悉了celery的工作流程后，配置和使用还是比较简单的
- 高可用：当任务执行失败或执行过程中发生连接中断，celery 会自动尝试重新执行任务
- 快速：一个单进程的celery每分钟可处理上百万个任务
- 灵活： 几乎celery的各个组件都可以被扩展及自定制

###  Celery 特性

- 方便查看定时任务的执行情况, 如 是否成功, 当前状态, 执行任务花费的时间等.
- 可选 多进程, Eventlet 和 Gevent 三种模型并发执行.
- `Celery 是语言无关的.它提供了python 等常见语言的接口支持.`

# celery 组件

https://www.cnblogs.com/xiaonq/p/11166235.html#i2

###  Celery组件说明

- **Celery Beat :** 任务调度器. Beat 进程会读取配置文件的内容, 周期性的将配置中到期需要执行的任务发送给任务队列.
- **Celery Worker :** 执行任务的消费者, 通常会在多台服务器运行多个消费者, 提高运行效率.
- **Broker :** 消息代理, 队列本身. 也称为消息中间件. 接受任务生产者发送过来的任务消息, 存进队列再按序分发给任务消费方(通常是消息队列或者数据库).
- **Producer :** 任务生产者. 调用 Celery API , 函数或者装饰器, 而产生任务并交给任务队列处理的都是任务生产者.
- **Result Backend :** 任务处理完成之后保存状态信息和结果, 以供查询.

###  celery架构图

- `生产者消费者模型`

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210429152428805.d6301703.png)

- 调度方法

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210429152806829.23ccab52.png)

### 产生任务的方式

- 发布者发布任务(WEB 应用)
- 任务调度按期发布任务(定时任务)

### celery 依赖三个库

- 这三个库, 都由 Celery 的开发者开发和维护
- `billiard :` 基于 Python2.7 的 multisuprocessing 而改进的库, 主要用来提高性能和稳定性.
- `librabbitmp :`C 语言实现的 Python 客户端
- `kombu :` Celery 自带的用来收发消息的库, 提供了符合 Python 语言习惯的, 使用 AMQP 协议的高级借口.



# celery简单使用

## celery简单使用

### 安装celery

```python
pip3 install celery==4.4.7
```

1

###  新建`celery/main.py`配置celery

```python
# celery_task/main.py
import os
from celery import Celery

# 定义celery实例, 需要的参数, 1, 实例名, 2, 任务发布位置, 3, 结果保存位置
app = Celery('mycelery',
             broker='redis://127.0.0.1:6379/14',  # 任务存放的地方 
             backend='redis://127.0.0.1:6379/15')  # 结果存放的地方

# @app.task 指定将这个函数的执行交给celery异步执行
@app.task
def add(x, y):
    return x + y
```



## 测试celery

###  启动celery

```python
'''1.启动celery'''
#1.1 单进程启动celery
celery -A main worker -l INFO
#1.2 celery管理
celery  multi start celery_test -A celery_test -l debug --autoscale=50,5        # celery并发数：最多50个，最少5个
ps auxww|grep "celery worker"|grep -v grep|awk '{print $2}'|xargs kill -9       # 关闭所有celery进程
```



###  测试执行

```python
(syl) root@dev:celery_task# python
>>> t = main.add.delay(2,3)
>>> t.get()
5
```



###  celery其他命令

```python
t.ready()                   #返回true证明可以执行，不必等待
t.get(timeout=1)              #如果1秒不返回结果就超时,避免一直等待
t.get(propagate=False)          #如果执行的代码错误只会打印错误信息
t.traceback                  #打印异常详细结果
```



# 项目中使用celery





## 在普通项目中使用

```text
pip3 install Django==2.2
pip3 install celery==4.4.7
pip3 install redis==3.5.3
```



###  celery_task/main.py

```python
# -*- coding: utf-8 -*-
from celery import Celery


# 1.celery基本配置
app = Celery('proj',
             broker='redis://localhost:6379/14',
             backend='redis://localhost:6379/15',
             include=['celery_task.tasks',
                      'celery_task.tasks2',
                      ])

# 2.实例化时可以添加下面这个属性
app.conf.update(
   result_expires=3600,        #执行结果放到redis里，一个小时没人取就丢弃
)

# 3.配置定时任务：每5秒钟执行 调用一次celery_pro下tasks.py文件中的add函数
app.conf.beat_schedule = {
    'add-every-5-seconds': {
        'task': 'celery_task.tasks.test_task_crontab',
        'schedule': 1,
        'args': (16, 16)
    },
}

# 4.添加时区配置
app.conf.timezone = 'UTC'

if __name__ == '__main__':
   app.start()
```



###  celery_task/tasks.py

```python
# -*- coding:utf8 -*-
from .main import app       #从当前目录导入app

# 1.test_task_crontab测试定时任务
@app.task
def test_task_crontab(x, y):
    print('执行定时任务')
    return x + y


# 2.测试异步发送邮件
@app.task(bind=True)
def send_sms_code(self, mobile, datas):
    return '异步发送邮件'
```



###  celery_task/tasks2.py

```python
# -*- coding:utf8 -*-
from .main import app
import time,random

@app.task
def randnum(start,end):
    time.sleep(3)
    return random.randint(start,end)
```



###  启动项目

```python
'''1.启动celery-worker'''
(syl) root@dev:opwf_project# celery -A celery_task.main worker -l INFO

'''2.启动celery-beat'''
(syl) root@dev:opwf_project# celery -A celery_task.main beat -l info
```



###  celery并发方式

- Celery支持不同的并发和序列化的手段

  - 并发：Prefork, Eventlet, gevent, threads/single threaded
  - 序列化：pickle, json, yaml, msgpack. zlib, bzip2 compression， Cryptographic message signing 等等

- ```
  方法1：使用进程池并发
  ```

  - 默认是进程池方式，进程数以当前机器的CPU核数为参考，每个CPU开四个进程

```shell
(syl) root@dev:opwf_project# celery worker -A celery_task.main --concurrency=4
```



- `方法2：使用协程方式并发`

```python
# 安装eventlet模块
$ pip install eventlet

# 启用 Eventlet 池
$ celery -A celery_task.main worker -l info -P eventlet -c 1000
```



## 在django项目中使用

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210429202604867.841e2467.png)

###  celery_task/main.py

```python
# -*- coding: utf-8 -*-
from celery import Celery
import os,sys
import django

# # 1.添加django项目根路径
CELERY_BASE_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(CELERY_BASE_DIR, '../opwf'))

# 2.添加django环境
os.environ.setdefault("DJANGO_SETTINGS_MODULE","opwf.settings")
django.setup() # 读取配置


# 3.celery基本配置
app = Celery('proj',
             broker='redis://localhost:6379/14',
             backend='redis://localhost:6379/15',
             include=['celery_task.tasks',
                      'celery_task.tasks2',
                      ])

# 4.实例化时可以添加下面这个属性
app.conf.update(
   result_expires=3600,        #执行结果放到redis里，一个小时没人取就丢弃
)

# 5.配置定时任务：每5秒钟执行 调用一次celery_pro下tasks.py文件中的add函数
app.conf.beat_schedule = {
    'add-every-5-seconds': {
        'task': 'celery_task.tasks.test_task_crontab',
        'schedule': 5.0,
        'args': (16, 16)
    },
}

# 6.添加时区配置
app.conf.timezone = 'UTC'

if __name__ == '__main__':
   app.start()
```

###  celery_task/tasks.py

```python
# -*- coding:utf8 -*-
from .main import app       #从当前目录导入app
import os,sys
from .main import CELERY_BASE_DIR

# 1.test_task_crontab测试定时任务
@app.task
def test_task_crontab(x, y):
    # 添加django项目路径
    sys.path.insert(0, os.path.join(CELERY_BASE_DIR, '../opwf'))

    from utils.rl_sms import test_crontab

    res = test_crontab(x, y)
    return x + y


# 2.测试异步发送邮件
@app.task(bind=True)
def send_sms_code(self, mobile, datas):
    sys.path.insert(0, os.path.join(CELERY_BASE_DIR, '../opwf'))
    # 在方法中导包
    from utils.rl_sms import send_message
    # time.sleep(5)
    try:
        # 用 res 接收发送结果, 成功是:０，　失败是：－１
        res = send_message(mobile, datas)
    except Exception as e:
        res = '-1'

    if res == '-1':
        # 如果发送结果是 -1  就重试.
        self.retry(countdown=5, max_retries=3, exc=Exception('短信发送失败'))
```

### celery_task/tasks2.py

```python
# -*- coding:utf8 -*-
from .main import app
import time,random

@app.task
def randnum(start,end):
    time.sleep(3)
    return random.randint(start,end)
```



# 04.django中使用

## django中使用



###  安装包

```python
pip3 install Django==2.2
pip3 install celery==4.4.7
pip3 install redis==3.5.3
pip3 install django-celery==3.1.17
```



###  celery管理

```python
celery -A celery_task worker -l INFO               # 单线程
celery multi start w1 w2 -A celery_pro -l info     #一次性启动w1,w2两个worker
celery -A celery_pro status                        #查看当前有哪些worker在运行
celery multi stop w1 w2 -A celery_pro              #停止w1,w2两个worker

# 1.项目中启动celery worker
celery  multi start celery_task -A celery_task -l debug --autoscale=50,10      # celery并发数：最多50个，最少5个
# 2.在项目中关闭celery worker
ps auxww|grep "celery worker"|grep -v grep|awk '{print $2}'|xargs kill -9      # 关闭所有celery进程
```



###  django_celery_beat管理

```python
# 1.普通测试启动celery beat
celery -A celery_task beat -l info
# 2.在项目中后台启动celery beat
celery -A celery_task beat -l debug >> /aaa/Scheduler.log 2>&1 & 
# 3.停止celery beat
ps -ef | grep -E "celery -A celery_test beat" | grep -v grep| awk '{print $2}' | xargs kill -TERM &> /dev/null  # 杀死心跳所有进程
```



## 安装相关包 与 管理命令

###  在与项目同名的目录下创建celery.py

```python
import os
from celery import Celery

# 只要是想在自己的脚本中访问Django的数据库等文件就必须配置Django的环境变量
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'opwf.settings')

# app名字
app = Celery('celery_test')

# 配置celery
class Config:
    BROKER_URL = 'redis://127.0.0.1:6379'
    CELERY_RESULT_BACKEND = 'redis://127.0.0.1:6379'


app.config_from_object(Config)
# 到各个APP里自动发现tasks.py文件
app.autodiscover_tasks()
```



### [#](http://v5blog.cn/pages/b92306/#_2-2-在与项目同名的目录下的-init-py-文件中添加下面内容)2.2 在与项目同名的目录下的 init.py 文件中添加下面内容

```python
# -*- coding:utf8 -*-

# 告诉Django在启动时别忘了检测我的celery文件
from .celery import app as celery_app
__all__ = ['celery_app']
```



###  创建workorder/tasks.py文件

```python
# -*- coding:utf8 -*-
from celery import shared_task
import time

# 这里不再使用@app.task,而是用@shared_task，是指定可以在其他APP中也可以调用这个任务
@shared_task
def add(x,y):
    print('########## running add #####################')
    return x + y

@shared_task
def minus(x,y):
    time.sleep(30)
    print('########## running minus #####################')
    return x - y
```



### 启动

- 保证启动了redis-server
- 启动一个celery的worker

```python
celery -A opwf worker -l INFO
celery multi start w1 w2 -A celery_pro -l info     #一次性启动w1,w2两个worker
celery -A celery_pro status                        #查看当前有哪些worker在运行
celery multi stop w1 w2 -A celery_pro              #停止w1,w2两个worker

celery  multi start celery_test -A celery_test -l debug --autoscale=50,5        # celery并发数：最多50个，最少5个
ps auxww|grep "celery worker"|grep -v grep|awk '{print $2}'|xargs kill -9       # 关闭所有celery进程
```



##  测试celery

```shell
./manage.py shell
import tasks
t1 = tasks.minus.delay(5,3)
t2 = tasks.add.delay(3,4)
t1.get()
t2.get()
```







# celery分布式部署

## 分布式集群部署

###  celery集群说明

- celery作为分布式的任务队列框架，worker是可以执行在不同的服务器上的。
- 部署过程和单机上启动是一样，只要把项目代码copy到其他服务器，使用相同命令就可以了。
- 就是通过共享Broker队列，使用合适的队列
- 如redis，单进程单线程的方式可以有效地避免同个任务被不同worker同时执行的情况。

###  分布式集群架构图

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210430112847099.d059c43e.png)

# supervisor管理celery





## 实时Celery监控-Flower

### flower介绍

- Flower是一个基于实时Web服务的Celery监控和管理工具。
- 它正在积极开发中，但已经是一个必不可少的工具。
- 作为Celery推荐的监视器，它淘汰了Django-Admin监视器、celerymon监视器和基于ncurses的监视器。

###  Celery事件来实时监控

- 任务的进度和历史信息
- 可以查看任务的详情（参数，开始时间，运行时间等）
- 提供图表和统计信息

###  远程控制

- 查看worker的状态和统计信息
- 关闭和重启worker实例
- 控制worker的缓冲池大小和自动优化设置
- 查看并修改一个worker实例所指向的任务队列
- 查看目前正在运行的任务
- 查看定时或间隔性调度的任务
- 查看已保留和已撤销的任务
- 时间和速度限制
- 配置监视器
- 撤销或终止任务

###  HTTP API

- 列出worker
- 关闭一个worker
- 重启worker的缓冲池
- 增加/减少/自动定量 worker的缓冲池
- 从任务队列消费（取出任务执行）
- 停止从任务队列消费
- 列出任务列表/任务类型
- 获取任务信息
- 执行一个任务
- 按名称执行任务
- 获得任务结果
- 改变工作的软硬时间限制
- 更改任务的速率限制
- 撤销一个任务

###  OpenID 身份验证

## 截图

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210502225509126.281d50e1.png)

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210502225547257.65800c4b.png)

## 使用方法

###  安装 Flower

```python
[root@k8s-node2 ~]#  pip install flower
```



- 运行下面的 flower 命令你将得到一个可以访问的 web 服务器。

```python
[root@k8s-node2 ~]# celery -A myCeleryProj.app flower
[I 180907 22:34:43 command:139] Visit me at http://localhost:5555
[I 180907 22:34:43 command:144] Broker: redis://127.0.0.1:6379/0
[I 180907 22:34:43 command:147] Registered tasks: 
    ['celery.accumulate',
     'celery.backend_cleanup',
     'celery.chain',
     'celery.chord',
     'celery.chord_unlock',
     'celery.chunks',
     'celery.group',
     'celery.map',
     'celery.starmap',
     'myCeleryProj.tasks.add',
     'myCeleryProj.tasks.taskA',
     'myCeleryProj.tasks.taskB']
[I 180907 22:34:43 mixins:224] Connected to redis://127.0.0.1:6379/0
```



### [#](http://v5blog.cn/pages/1281a5/#_3-2-在页面中访问)3.2 在页面中访问

- 从输出的信息可以看出，默认的端口为 http://localhost:5555，但你也可以手工指定端口，命令如下所示 ：

```python
[root@k8s-node2 ~]#  celery -A myCeleryProj.app flower --port=5555
```

1

- 中间人的url也可以通过参数 --broker参数来指定

```python
[root@k8s-node2 ~]# celery -A myCeleryProj.app flower --port=5555 --broker=redis://127.0.0.1:6379/0
```



- 打开浏览器 [http://localhost:5555 (opens new window)](http://localhost:5555/)可以看到flower的web界面

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210502225837199.49579fb9.png)





# redis和rabbitmq区别

## celery工作流程

### 工作流程

- 消息中间件（message broker）：
  - Celery本身不提供消息服务，但是可以方便的和第三方提供的消息中间件集成。
  - 包括，RabbitMQ, Redis, MongoDB ，SQLAlchemy等
  - 其中rabbitm与redis比较稳定，其他处于测试阶段。
- 任务执行单元（worker）：
  - Worker是Celery提供的任务执行的单元，worker并发的运行在分布式的系统节点中。
- 任务结果存储（result store）：
  - result store用来存储Worker执行的任务的结果，支持AMQP，redis，mongodb，mysql等主流数据库。

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210429152428805.d6301703.png)

### 并发、序列化、压缩

- celery任务并发执行支持prefork、eventlet、gevent、threads的方式；
- 序列化支持pickle,json,yaml,msgpack等；
- 压缩支持zlib, bzip2 。

### 使用中的一些建议和优化

- （1）如果你的broker使用的是rabbitmq
  - 可安装一个C语言版的客户端librabbitmq来提升性能
  - pip install librabbitmq；
- （2）通过 BROKER_POOL_LIMIT 参数配置消息中间件的连接池；
- （3）通过CELERYD_PREFETCH_MULTIPLIER 参数配置消息预取的数量
  - 如果消息队列中有很多消息，这个值建议设为1，以达到各个worker的最大化利用；
- （4）指定worker消费的队列
  - 如果你根据业务配置了多个不同的消息队列，各个队列的任务量大小不同
  - 可以在worker启动时指定消费队列 celery -A app_name -l INFO -Q queue1,queue2
- （5）worke（prefork）默认启动cpu核数个子进程
  - 进程管理可以使用supervisor，supervisor是用Python开发的一套通用的进程管理程序
  - 能将一个普通的命令行进程变为后台daemon，并监控进程状态，异常退出时能自动重启

## rabbitMQ和redis区别

### 可靠性

- redis ：
  - 没有相应的机制保证消息的可靠消费，如果发布者发布一条消息
  - 而没有对应的订阅者的话，这条消息将丢失，不会存在内存中
- rabbitMQ：
  - 具有消息消费确认机制，如果发布一条消息，还没有消费者消费该队列，那么这条消息将一直存放在队列中
  - 直到有消费者消费了该条消息，以此可以保证消息的可靠消费

### 实时性

- redis:实时性高，redis作为高效的缓存服务器，所有数据都存在在服务器中，所以它具有更高的实时性

###  消费者负载均衡

- redis发布订阅模式
  - 一个队列可以被多个消费者同时订阅，当有消息到达时，会将该消息依次发送给每个订阅者；
- rabbitMQ队列可以被多个消费者同时监控消费
  - 但是每一条消息只能被消费一次，由于rabbitMQ的消费确认机制
  - 因此它能够根据消费者的消费能力而调整它的负载；

###  持久性

- redis：redis的持久化是针对于整个redis缓存的内容，它有RDB和AOF两种持久化方式（redis持久化方式，后续更新），可以将整个redis实例持久化到磁盘，以此来做数据备份，防止异常情况下导致数据丢失。
- rabbitMQ：队列，消息都可以选择性持久化，持久化粒度更小，更灵活；

###  队列监控

- rabbitMQ实现了后台监控平台，可以在该平台上看到所有创建的队列的详细情况，良好的后台管理平台可以方便我们更好的使用；
- redis没有所谓的监控平台。

###  总结

- redis： 轻量级，低延迟，高并发，低可靠性；
- rabbitMQ：重量级，高可靠，异步，不保证实时；
- rabbitMQ是一个专门的AMQP协议队列，他的优势就在于提供可靠的队列服务，并且可做到异步，而redis主要是用于缓存的，redis的发布订阅模块，可用于实现及时性，且可靠性低的功能。





# celery踩过的坑

## 队列集群内存爆了

###  场景描述

- 有一个项目须要处理大量的异步任务，并须要能够快速水平扩展，增长系统吞吐量。
- 最终基于Celery来开发这个系统
- Celery是用Python编写的一个分布式任务队列，经过消息队列来在Client与Worker之间传递任务
- 但Celery自己并不提供消息队列服务，须要使用第三方的消息服务做为Broker
- 官方推荐RabbitMQ和Redis，我一开始使用了Redis。
- 使用Celery开发很容易，只须要编写任务逻辑，调度的事情Celery就帮你完成了。
- 而后部署到3台机器，一切都运行得很好，Worker会把执行的events发送到Broker
- 经过events能够知道任务执行的状况，成功仍是失败等等。
- Celery Flower提供一个web界面来查看这些监控数据。
- 后来项目须要增长系统吞吐量，OK，把程序发布到新机器，启动Celery Worker，就完成扩展了。
- 随着开的Worker愈来愈多，问题也出来了。

###  Redis机器的内网带宽跑满

- 系统使用单机Redis来作Broker，当链接到Redis的Worker增长的时候，内网流量也迅速增长
- 最后达到1G，把千兆网卡跑满了，生产者和消费者的性能立刻降了下来
- 经过查看Redis的操做记录，发现大量的发布订阅操做，消息是json格式
- 除了对传入任务参数的封装，还有Celery自己附带的一些信息
- Redis不停地把这些消息发布给各个Worker，而Redis性能真的好，因而产生了每秒1G的流量
- 查看了Celery的文档，发现json

```python
CELERY_TASK_SERIALIZER = 'pickle'
CELERY_MESSAGE_COMPRESSION = 'gzip'
```

- 把json改为Python内置的pickle，并压缩，能够减小一点点消息的大小，但仍是跑满了。
- 想到单机的消息队列可能会成为系统的瓶颈，因而把单机Broker改为集群
- 可是Redis集群用在这里不太好用，看了看RabbitMQ，自己支持集群，镜像模式还能够作HA，性能也能够
- 果断把Broker改为RabbitMQ集群。
- 拿了两台机器（16G内存）来组成集群，使用HAProxy来作负载均衡，Celery配置加上服务器

```text
CELERY_QUEUE_HA_POLICY = 'all'
```

1

- 而后单机内网流量降了下来，单机峰值在500M/s,可是运行几个小时以后，问题又来了。

###  RabbitMQ集群内存爆了

- RabbitMQ集群出现OOM了，一番搜索以后异步
- RabbitMQ自带的监控插件有可能会占用大量的内存，不看web界面的时候，把插件关闭。

```shell
[root@k8s-node2 ~]#  rabbitmq-plugins disable rabbitmq_management
```



- celery默认会发送服务器的心跳信息，这些我是不须要的，能够经过zabbix等监控，关闭发送，能够在celery启动命令中加上 --without-heartbeat
- celery默认会发送大量的任务处理状态事件，这些事件默认是不设置过时时间的
- 由RabbitMQ的过时时间来处理，因此会有大量的事件数据在RabbitMQ中堆积但又不会被消费。
- 能够在celery配置中加上过时时间，如设置过时时间5s

```python
CELERY_EVENT_QUEUE_TTL = 5
```



- 作完这几步以后，RabbitMQ单机内存占用稳定在1~2G，并且内网流量也大幅降了下来，峰值100M/s

###  RabbitMQ流控机制

- 这个系统生产消息有明显的高峰和低谷，观察高峰时生产者的日志
- 发现当生产者刚启动时，队列尚未消息的时候，消息入队很快，大概2k/s
- 而后几十秒以后，发现消息入队愈来愈慢，入队2k逐渐须要4s、8s、10s
- 一番搜索以后，发现RabbitMQ有流量控制机制，当生产者过快，消费者来不及消费消息，消息在队列中堆积
- RabbitMQ就会阻塞发布消息过快的连击，也就表现为入队逐渐变慢
- 这时须要注意调整生产和消费的速率，注意RabbitMQ内存占用和内存阀值配置，以及磁盘空间。

###  其余一些问题

#### 不启用RabbitMQ的confirm机制

- RabbitMQ处理confirm消息占用了大量cpu资源。
- confrim的做用在于当消息真正落地写到磁盘时，给生产者发送ack确认
- 若生产者在收到该ack后才丢弃该消息，就能够保证消息必定不丢，这是一种很是高强度的可靠性保证。
- 但若没有这么高的要求则能够不启用confirm机制，增长RabbitMQ的吞吐量。

#### 慎用CELERY_ACKS_LATE

- Celery的CELERY_ACKS_LATE=True，表示Worker在任务执行完后才向Broker发送acks
- 告诉队列这个任务已经处理了，而不是在接收任务后执行前发送
- 这样能够在Worker处理任务过程当中异常退出，这个任务还会被发送给别的Worker处理。
- 可是可能的状况是，一个任务会被屡次执行，因此必定要慎用。

#### Celery 任务分队列

- 耗时和不耗时的任务分开，避免耗时任务阻塞队列；
- 重要和不重要的任务分开，避免重要的任务得不到及时处理。

#### 让Celery忽略处理结果

- 多数状况下并不须要关注Celery处理的结果，况且在Worker里面咱们会记录其结果
- 设置CELERY_IGNORE_RESULT = True可让Celery不要把结果发送到Broker，也能够下降内网流量和Broker内存占用。

#### Celery内存泄露

- 长时间运行Celery有可能发生内存泄露，能够配置CELERYD_MAX_TASKS_PER_CHILD
- 让Worker在执行n个任务杀掉子进程再启动新的子进程，能够防止内存泄露。
- 另外Worker执行大量任务后有僵死的状况，启动了一个crontab定时重启Worker。

#### ip_conntrack: table full, dropping packet

- 系统执行时会创建大量的链接，形成iptables跟踪表满了，socket拒绝链接，性能提不上去。
- 解决方法：加大 ip_conntrack_max 值。

#### Inodes满了没法写文件

- 因为创建了太多的临时文件，发现磁盘没有满，但仍是没法写入文件
- 由于Inodes被用完了，启动一个crontab定时清理临时文件

## celery丢失任务

- 修改配置如下：

```python
task_reject_on_worker_lost = True    # 作用是当worker进程意外退出时，task会被放回到队列中
task_acks_late = True            # 作用是只有当worker完成了这个task时，任务才被标记为ack状态
```



- 该配置可以保证task不丢失，中断的task在下次启动时将会重新执行。
- 需要说明的是，backend最好使用rabbitmq等支持ACK状态的消息中间件。

## celery重复执行

### 情况描述

- celery 在执行task时有个机制,就是任务时长超过了 visibility_timeout 时还没执行完
- 就会指定其他worker重新开始task,默认的时长是一小时.

```python
app.conf.broker_transport_options = {‘visibility_timeout’: 3600}
```



###  celery once

- Celery Once 也是利用 Redis 加锁来实现, Celery Once 在 Task 类基础上实现了 QueueOnce 类
- 该类提供了任务去重的功能，所以在使用时，我们自己实现的方法需要将 QueueOnce 设置为 base

```python
@task(base=QueueOnce, once={'graceful': True})
```



- 后面的 once 参数表示，在遇到重复方法时的处理方式，默认 graceful 为 False
- 那样 Celery 会抛出 AlreadyQueued 异常，手动设置为 True，则静默处理。
- 另外如果要手动设置任务的 key，可以指定 keys 参数

```python
@celery.task(base=QueueOnce, once={'keys': ['a']})
def slow_add(a, b):
    sleep(30)
    return a + b
```



### celery once使用步骤

####  第一步，安装

```python
pip install -U celery_once
```



3.3.2 第二步，增加配置

```python
from celery import Celery
from celery_once import QueueOnce
from time import sleep

celery = Celery('tasks', broker='amqp://guest@localhost//')
celery.conf.ONCE = {
  'backend': 'celery_once.backends.Redis',
  'settings': {
    'url': 'redis://localhost:6379/0',
    'default_timeout': 60 * 60
  }
}
```



####  第三步，修改 delay 方法

```python
example.delay(10)
# 修改为
result = example.apply_async(args=(10))
```



####  第四步，修改 task 参数

```python
@celery.task(base=QueueOnce, once={'graceful': True, keys': ['a']})
def slow_add(a, b):
    sleep(30)
    return a + b
```
