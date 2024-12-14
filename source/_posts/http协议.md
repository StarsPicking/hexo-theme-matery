---
title: http协议
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: 网络通信
tags:
  - http协议
abbrlink: 20687
date: 2022-11-15 23:42:11
img: https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover8.jpg
coverImg: https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover8.jpg
summary:
---

# http必知必会

#  http 请求方式

- get: 请求服务器的某些资源

- post: 向服务器提交某些资源

- put; 用于新增资源

- patch: 对资源进行部分修改

- delete: 删除资源

- head: 请求资源的头部信息， 获取于post或者get相同的头信息，  该请求方法的一个使用场景是在下载一个大文件前先获取其大小再决定是否要下载, 以此可以节约带宽资源 

- opstions:  检测资源支持的通信选项， 比如：‘／user’路由支持哪些方法：get、post、delete

- trace: 回显服务器收到的请求，一般用作测试或者网络诊断



# GET 和POST有什么区别

- 数据传输方式不同， get使用url传输数据，而post的数据一般通过请求体传输
- 安全性不同：post数据在请求体内，有一定的安全性保障，而get在url， 很容易查到数据信息
- 数据类型不同：get只是永续ascii码，post没有限制
- get请求无害： 刷新，后退等操作，post可能会重复提交表单
- get传参是，参数的数据量小于post

# 什么是无状态协议， http是无状态协议吗，怎么解决

- 无状态协议是指对会话没有记忆功能。缺少状态意味着后面处理需要前面请求到的状态信息。解决办法：cookie, session 和jwt



# udp和tcp的区别

- udp 是什么

  > udp是用户数据报协议。他不需要握手操作，从而加快了通信速度，允许网络上的其他主机在同意之前传输数据

- udp的特点

  - 能够支持容忍数据包丢失的带宽密集型应用程序
  - 具有低延迟的特点
  - 能够发送大量的数据包
  - 能够允许dns查找，dns是建立在udp上的应用层协议

- tcp 是什么

  > tco传输控制协议，能够帮助你确定计算机连接到internet以及他们之间进行数据传输，通过三次握手来启动和确认tcp的连接过程

- tcp 的主要特点

  - 能够确保连接的确立和数据包的发送
  - 支持错误重传
  - 提供错误校验

- tcp 和udp的区别

  - tcp 是面向连接的协议，udp是无连接的协议
  - tcp在发送数据前建立连接，然后再发送数据，udp 无序建立连接就可以直接发送数据
  - tcp会按照特定顺序重新排列数据包。udp数据包没有固定顺序，所有的数据包都是相互独立的
  - tcp的传输速度比较慢，udp传输会更快
  - tcp的头部有20字节, udp只有8字节
  - tcp是重量级的，在发送任何用户数据前，tcp都需要三次握手确认连接，udp是轻量级的，没有跟踪连接，消息排序等功能
  - tcp 能够进行错误校验，并且能进行错误恢复， udp 也会进行错误检查，但是会丢弃错误的数据包
  - tcp 有发送确认，udp没有发送确认
  - tcp是可靠的，能确保数据发送到目标地址， udp不能保证

# http中的302状体

- 302表示重定向，这种情况下，返回的头部信息中会包含location字段，内容是重定向的url

# http 协议由什么组成

- 起始行（start line）、头部（header）和主体（body）三部分组成，起始行是对报文进行的描述，头部包含报文的一些属性，主体包含报文的数据 



![1668574410255](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1668574410255.png)

# cookie 和session的区别

> cookie 保存在浏览器上，session保存在浏览器上
>
> session 中保存的是对象，cookie保存的是字符串
>
> cookie的安全性一般，在安全性第一的原则下，优先选择session
>
> 单个cookie保存的数据不能超过4k
>
> session可以放在文件内存或者数据库中
>
> session中运行时依赖sessionId, 而sessionId时存在cookie中，也就是说，如果浏览器禁用了cookie，session也会失效（但是可以通过其他方式实现，比如在url中传递sessionId）

# http协议有什么特点

- 无状态
- c/s模型
- 简单快速
- 灵活：可以传输任何类型的数据

# http和https有什么区别

- https有ca证书，http一般没有
- http时超文本传输协议，信息时明文传输的，http则是具有安全性的ssl加密传输
- http默认端口时80， https默认端口时443

# http中的keep-alive是用来干什么的

- 在早期的http1.0中，每次http请求都是需要创建一个连接，而创建连接的过程需要消耗资源和时间，为了减少资源消耗，缩短响应时间，就需要重用连接，在后来，引入了重用连接机制，就是在http请求头中加入了connection：keep-alive告诉对方这个请求响应完成后不要关闭，下一次继续使用
- keep-alive的优点：
  - 减少cpu和内存的使用
  - 请求和应答之间管线化
  - 降低拥塞控制（tcp连接减少了）
  - 减少了后续的请求延迟（无序在进行握手）

# http 三次握手和四次挥手

- 三次握手过程

  > 1. 客户端向服务端发送syn报文， 同时发送自己的初始化序列号isn，此时客户端处于syn_send
  > 2. 服务端收到后然会syn报文，发送自己的初始化序列号，同时返回ack，ack的值为isn +1, syn-revd
  > 3. 客户端收到服务端返回的syn报文后，会返回ack，值为服务端色isn+1,此时客户端处于established状态
  > 4. 服务端收到后后也处于established状态

- 四次挥手过程

  > 1. 第一次挥手：客户端发送一个fin报文，报文会指定一个序列号，此时客户端处于fin_wait状态
  > 2. 第二次挥手：服务端收到fin之后，会发送ack报文，值为isn+1，表明收到客户端的报文，此时客户端处于close_waiting状态
  > 3. 第三次挥手：服务端此时也想断开了，和客户端一样，发送fin报文，并且指定序列号，此时服务端处于last-ack状态
  > 4. 第四次挥手：客户端收到fin之后，一样会发送一个ack报文作为应答，且把服务端的序列号（isn） +1作文自己的ack，此时客户端处于time_wait状态，需要过一阵等服务端收到自己的ack报文后进入close状态
  > 5. 服务端收到ack报文后，处于close状态

# 请求转发和重定向的区别

> 转发过程：
>
> 客户端浏览器发出请求---> 服务端接收请求--->调用内部方法在容器内部完成请求处理和转发过程---> 将目标资源发送给客户端 转发的路径必须是同一web容器下的url，不能转向到其他web路径上，中间传递的是自己的容器内request, 在客户端浏览器路径依然显示的是自己第一次访问的路径，也就是说客户无感知。转发行为浏览器只是做了一次请求
>
> 重定向过程：
>
> 客户但浏览器发送http请求--->服务端接受请求---> 返回302状态码以及在头部添加location字段，表明重定向的url---> 浏览器发现响应式302状态，则自动发送一个新的http请求，请求url是location地址--->服务端依据请求返回数据。这里的location可以重定向到任何地址，在浏览器的地址栏可以看到请求地址发生了变化，重定向行为浏览器至少发生了两次请求

