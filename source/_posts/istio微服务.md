---
title: istio微服务
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: 微服务
tags:
  - istio
abbrlink: 50921
date: 2022-11-15 23:19:42
img:
coverImg:
summary:
---

# istio能做什么

-  连接： 智能控制服务之间的调用流量， 实现灰度升级，ab测试和蓝绿部署等
-  安全加固： 自动为服务之间的调用提供认认证、授权和加密
-  控制：应用用户定义的policy,保证资源在消费者中公平分配
-  观察：查看服务运行期间的各种数据，比如日志，监控，了解服务的运行情况

istios是servicemesh 的产品化落地，可以通过现有的服务器新增部署边车代理（sidecar proxy）,应用程序不用改代码，就能实现以下基本功能：

- 帮助微服务之间建立连接

- 帮助微服务分层解耦，解耦后的proxy 代理层能专注于提供基础架构能力

  - 服务发现

    - >服务注册 将服务注册到服务中心上
      >
      >服务发现 从注册中心获取服务信息

  - 负载均衡

    - > 流量分流。 常见的负载均衡（nginx, haproxy, lvs）

  - 故障恢复

    - > 具备出现故障自动恢复的功能

  - 服务度量

    - > http:
      >
      > 请求个数
      >
      > 请求持续时间
      >
      > 请求大小
      >
      > 响应大小
      >
      > tcp:
      >
      > tcp 发送字节数
      >
      > tcp 接收字节数
      >
      > tcp 打开连接数
      >
      > tcp 关闭连接数

      

  - 服务监控

  - A/B测试

  - 灰度发布

    - > 通过负载均衡等策略，先将少量的流量导入新版本，然后通过监控等确认金丝雀没有问题后，进行服务扩容，最终将老版本全部下线，将所有流量打入新版本

  - 限流限速

  - 访问控制

  - 身份认证

  

# istio 核心特性



- **流控（断路器 超时， 重试，多路由规则，ab测试， 灰度发布）**
- 安全（加密，身份认证等）
- **可观察（追踪，监控数据收集，）**
- 平台无关性
- 集成与定制

## 服务熔断和降级- 断路器

- 下游的服务因为某种原因突然变得不可用或响应过慢，上游服务为了保证自己整体服务的可用性
- 不再继续调用目标服务，直接返回，快速释放资源。如果目标服务情况好转则恢复调用

## 服务熔断的原理



- 当远程服务被调用时，断路器将监视这个调用，如调用时间太长，断路器将会介入并中断调用。
- 此外，断路器将监视所有对远程资源的调用，如对某一个远程资源的调用失败次数足够多
- 那么断路器会出现并采取快速失败，阻止将来调用此远程资源的请求.
- 断路器模式的状态图

![1667998383076]( 1667998383076.png)

- 最开始处于closed状态，一旦检测到错误到达一定阈值，便转为open状态；
- 这时候会有个 reset timeout，到了这个时间了，会转移到half open状态，尝试放行一部分请求到后端
- 一旦检测成功便回归到closed状态，即恢复服务

## 服务降级

**服务熔断是服务降级的一种方式**

- 当下游的服务因为某种原因响应过慢，下游服务主动停掉一些不太重要的业务，释放出服务器资源，增加响应速度！
- 二、当下游的服务因为某种原因不可用，上游主动调用本地的一些降级逻辑，避免卡顿，迅速返回给用户！

**在实际工作中，采用以下的方式来完成降级工作**

- 梳理出核心业务和非核心业务流程
- 在非核心业务上增加开关， 一旦发现系统扛不住，关掉开关，结束这些次要流程
- 一个微服务架构下有很多功能，需要区分核心功能和非核心功能
- 然后次要功能加上开关，需要降级的时候，把次要功能关了吧 
- 降低一致性了，即将核心业务流程的同步改异步，将强一致性改最终一致性 



## 服务超时



## 重试



## 多路由规则

1. http重定向
2. http重写
3. http重试
4. http故障注入
5. http 跨域资源共享



# istio 架构



## 流量治理

- 在控制平面会经过如下流程

  - 管理员通过命令行或者api创建流量规则
  - pilot将规则转化为envoy的标准格式
  - polit 将规则下发给envoy

- 在数据平面会有如下流程：

  - envoy拦截pod上本地容器的inbound和outbound流量
  - 在流量经过envoy时对流量进行治理

  

![1668052000960](1668052000960.png)

## 数据平面和控制平面

- 数据平面
  - 数据平面时有一组sidecar方式部署的只能代理（envoy+sidecar）组成
  - sidecar控制微服务之间的所有网络通信，管理入口和出口流量
  - sidecar一般和业务容器绑定在一起（在k8s中以自动注入的方式注入到企业pod中）来劫持业务 容器的流量，并且接受控制平面的的控制，同时向控制面输出日志，追踪以及监控数据等
  - envoy 和pilot打包在同一个镜像中，即sidecar proxy
- 控制平面
  - 负责管理和管理和配置代理
  - 控制平面的核心，管理istio的所有功能，主要包括istod (pilot,mixer,ciadel等服务组件的集成)

## 基础架构

### 架构图

 ![img](image-20220909112116832.a1bd212f.png) 

### 特性描述

1. 自动注入

   - 在创建应用程序时自动注入sidecar代理envoy程序
   - 在kubernetes中创建pod的时候，kube-apiserver 调用控制面组件sidecar-injector服务，自动修改程序的描述信息并注入sidecar
   - 真正创建pod时，在创建业务容器pod中同时创建sidecar容器

2. 流量拦截

   - 在pod初始化时设置iptable流量规则，基于配置的iptable规则拦截业务容器的进出口流量到sidecar上
   - 应用程序无感知
   - 上图中，流出 frontend 服务的流量会被 frontend 服务侧的 Envoy 拦截，而当流量到达 forecast容器时，Inbound 流量被 forecast 服务侧的 Envoy 拦截 

3. 服务发现

   -  务发起方的 Envoy 调用控制面组件 Pilot 的服务发现接口获取目标服务的实例列表 
   -  上图中，frontend 服务侧的 Envoy 通过 Pilot 的服务发现接口得到 forecast 服务各个实例的地址 

4. 负载均衡

   - 服务发起方的 Envoy 根据配置的负载均衡策略选择服务实例，并连接对应的实例地址。
   - 上图中，数据面的各个 Envoy 从 Pilot 中获取 forecast 服务的负载均衡配置，并执行负载均衡动作。

5. 流量治理

   - envoy 从 Pilot 中获取配置的流量规则，在拦截到 Inbound 流量和 Outbound 流量时执行治理逻辑。
   - 上图中， frontend 服务侧的 Envoy 从 Pilot 中获取流量治理规则，并根据该流量治理规则将不同特征的流量分发到 forecast 服务的 v1 或 v2 版本。

6. 访问安全

   - 在服务间访问时通过双方的 Envoy 进行双向认证和通道加密，并基于服务的身份进行授权管理。
   - 上图中，Pilot 下发安全相关配置，在 frontend 服务和 forecast 服务的 Envoy 上自动加载证书和密钥来实现双向认证
   - 其中的证书和密钥由另一个管理面组件 Citadel 维护。

7. 服务监测

   - 在服务间通信时，通信双方的 Envoy 都会连接管理面组件 Mixer 上报访问数据，并通过Mixer 将数据转发给对应的监控后端。
   - 上图中，frontend 服务对 forecast 服务的访问监控指标、日志和调用链都可以通过这种方式收集到对应的监控后端。

8. 策略执行

   - 在进行服务访问时，通过 Mixer 连接后端服务来控制服务间的访问，判断对访问是放行还是拒绝。
   - 上图中，Mixer 后端可以对接一个限流服务对从 frontend 服务到 forecast 服务的访问进行速率控制等操作。

   

9. 外部访问

   - 在网格的入口处有一个 Envoy 扮演入口网关的角 色。

   - 上图中，外部服务通过 Gateway 访问入口服务 frontend，对 frontend 服务的负载均衡和一些流量治理策略都在这个 Gateway 上执行

### istio 组件作用

#### pilot组件

- pilot是主要的控制组件，下发指令控制客户但，在整个系统中，pilot完成以下任务
  - 从kubernetes或者其他平台的注册中心或者服务信息，完成服务发现过程
  - 读取istio的各项控制配置，在进行转换之后  ，将其发送给数据面执行
- pilot 将配置内容发送给数据面的envoy，envoy更具pilot指令，将路由，服务，监听，集群等定义信息转换为本地配置，完成控制行为的落地
  - pilot为envoy提供服务发现
  - 提供流量管理功能（a/b测试，金丝雀发布）以及弹性功能（超时，重试，熔断等）
  - 生成envoy配置
  - 启动envoy
  - 监控并且管理envoy的运行状况, 比如envoy出错时， pilot-agent负责重启，或者envoy配置变更后，pilot 负责重启



- pilot-agent是什么
  - Envoy 不直接跟 k8s 交互，通过 pilot-agent 管理的
  - Pilot-agent 进程根据 K8S APIserver 中的配置信息生成 Envoy 的配置文件，并负责启动 Envoy 进程。
  - Envoy 由 Pilot-agent 进程启动，启动后，Envoy 读取 Pilot-agent 为它生成的配置文件
  - 然后根据该文件的配置获取到Pilot 的地址，通过数据面从 pilot 拉取动态配置信息
  - 包括路由(route），监听器(1istener），服务集群(cluster）和服务端点 (endpoint)

#### envoy组件



1. envoy是什么 
   - envoy是c++开发的高性能代理，用于协调网络中所有服务的入口和出口流量
   - envoy有许多强大的功能：动态服务发现、负载均衡、tls终端、http\grpc代理、
   - 断路器、健康检查、流量拆分灰度发布、故障注入
2. istio 与envoy的关系
   - envoy 和serviceA同属于一个pod， 共享网络和命名空间，代理podA的流量
   - 将流量按照请求规则作用在serviceA中

![1668054370581](1668054370581.png)





#### Citadel

- 负责处理系统上不同服务之间的 TLS 通信。
- Citadel 充当证书颁发机构(CA)，并生成证书以允许在数据平面中进行安全的 mTLS 通信。
- Citadel 是 Istio 的核心安全组件，提供了自动生 成、分发、轮换与撤销密钥和证书功能。
- Citadel 一直监听 Kube- apiserver，以 Secret 的形式为每个服务都生成证书密钥，并在 Pod 创建时挂载到 Pod 上
- 代理容器使用这些文件来做服务身份认证，进而代 理两端服务实现双向 TLS 认证、通道加密、访问授权等安全功能
- 如图 所示，frontend 服 务对 forecast 服务的访问用到了HTTP 方式，通过配置即可对服务增加认证功能
- 双方的 Envoy 会建立双向认证的 TLS 通道，从而在服务间启用双向认证的 HTTPS

![img](image-20220909142205117.2d6c0e8a.png)

#### Galley

- Galley 是 istio 的配置验证、提取、处理和分发的组件。
- Galley 是提供配置管理的服务。实现原理是通过 k8s 提供的 ValidatingWebhook 对配置进行验证。
- Galley 使 Istio 可以与 Kubernetes 之外的其他环境一起工作，因为它可以将不同的配置数据转换为Istio 可以理解的通用格式。

#### Ingressgateway



- ingressgateway就是入口处的gateway， 从网格外部访问网格内的服务就是通过这个gateway进行的
- istio-ingressgateway是一个loadblance类型的service， 不同于其他的服务组件只有一两个端口
- istio-ingressgateway 开放了一组端口，这些就是网格内服务的外部访问端口
- 如图所示，网格入口网关的负载和网格内的sidecar是同样的执行流程
- 也和内部的其他sidecar一样，通过pilot处接受流量规则
- **网关配置应用于在网格边缘运行的独立 Envoy 代理`，`而不是与服务工作负载一起运行的 Sidecar Envoy 代理` **

![1668055016859](1668055016859.png)

#### Sidecar-injector

- Sidecar-injector 是负责自动注入的组件，只要开启了自动注 入，在 Pod 创建时就会自动调用istio-sidecar-injector 向 Pod 中注入 Sidecar 容器。
- 在 Kubernetes 环境下，根据自动注入配置，Kube-apiserver 在拦截到 Pod 创建的请求时
- 会调用自动注入服务 istio-sidecar-injector 生成 Sidecar 容器的描述并将其插入原 Pod 的定义中
- 这样，在创建的 Pod 内除了包括业务容器，还包括 Sidecar 容器，这个注入过程对用户透明。

# # ingress部署nginx

## 入口网关

- 入口网关（ingress geteway）时istis的重要资源之一，时用于管理网格边缘入站的流量
- 通过入口网关可以很轻松的将网格内部的服务暴漏到外部提供访问
- **网关配置应用在网格边缘独立运行的envoy代理，而不是与服务工作负载一起运行的sidecar envoy代理*
- 所以我们配置的gateway资源指代的时下图中的2istio-ingressgateway

![1668222997922](1668222997922.png)

## nginx-gateway.yaml

> 通过命令访问 curl -H "Host: nginx.gateway.com" http://ingressgateway:nodeport/ 

-  istio-ingressgateway 就是小区的大门（唯一的大门），所有进入的流量都需要经过 
-  ingressgateway 相当于路标引导去到A B C D的一栋建筑里面，分开域名去导流，
-  virtualservice 就像到建筑里的电梯一样，按照不同的楼层进行管理路由的作用
-  destinationrule 到达具体的楼层后按照不同的门房号 1 2 3 4 进入到真正的屋里去 

> istio安装后会有下面三个服务
>
> `istio-egressgateway` : 管理进入的流量
>
> `istio-ingressgateway` : 管理出去的流量
>
> istiod

```yaml
piVersion: networking.istio.io/v1alpha3
kind: Gateway  # ② nginx-gw 是 ingressgateway
metadata: 
  name: nginx-gw 
spec:
  selector:
    app: istio-ingressgateway  # ① istio-ingressgateway 是默认已经创建好的istio网关控制器
                               # 将 ingressgateway（nginx-gw）关联到 网关 istio-ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - nginx.test.com
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService  # ③ virtualservice 
metadata:
  name: nginx-vs
spec:
  hosts:
  - nginx.test.com
  gateways:
  - nginx-gw
  http:
  - route:
    - destination:
        host: nginx-svc
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-svc
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx
  type: ClusterIP
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - image: 'nginx:latest'
          name: nginx-deployment
```

