---
title: istio实现金丝雀发布
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: 微服务
tags:
  - istio
abbrlink: 51490
date: 2022-11-12 16:23:34
img:
coverImg:
summary:
---



#  1 istio实现灰度发布

## 1.1 什么是灰度发布

- 灰度发布也叫金丝雀部署 ，是指通过控制流量的比例，实现新老版本的逐步更替。 
  比如对于服务 A 有 version1、 version2 两个版本 ， 当前两个版本同时部署，但是 version1 比例
  90% ，version2 比例 10% ，看运行效果，如果效果好逐步调整流量占比 80～20 ，70～
  30 ·····10～90 ，0，100 ，最终 version1 版本下线。



## 1.2 灰度发布的特点

- 新老版本共存

- 可以实时根据反馈动态调整占比

- 理论上不存在服务完全宕机的情况

- 适合于服务的平滑升级与动态更新

## 1.3 使用istio 实现金丝雀发布

```
 docker load -i canary-v2.tar.gz
 docker load -i canary-v1.tar.gz
```



- 创建金丝雀服务 

- ```
  cat deployment.yaml，内容如下： 
  ```

- 

```yaml
apiVersion: apps/v1 
kind: Deployment 
metadata: 
 name: appv1 
 labels: 
 app: v1 
spec: 
 replicas: 1 
 selector: 
 matchLabels: 
 app: v1 
 apply: canary 
 template: 
 metadata: 
 labels: 
 app: v1 
 apply: canary 
 spec: 
 containers: 
 - name: nginx 
 image: xianchao/canary:v1 
 ports: 
 - containerPort: 80 
--- 
apiVersion: apps/v1 
kind: Deployment 
metadata: 
 name: appv2 
 labels: 
 app: v2 
spec: 
 replicas: 1 
 selector: 
 matchLabels: 
 app: v2 
 apply: canary 
 template: 
 metadata: 
 labels: 
 app: v2 
 apply: canary 
 spec: 
 containers: 
 - name: nginx 
 image: xianchao/canary:v2 
 ports: 
 - containerPort: 80 
 
 

 

```

- 更新： 

- ```sh
  kubectl apply -f deployment.yaml 
  ```



- ```sh
  # 创建 service 
  cat service.yaml 文件，内容如下： 
  ```

  

- ```yaml
  apiVersion: v1 
  kind: Service 
  metadata: 
   name: canary 
   labels: 
   apply: canary 
  spec: 
   selector: 
   apply: canary 
   ports: 
   - protocol: TCP 
   port: 80 
   targetPort: 80 
   
  ```

- ```sh
  # 更新 service.yaml 文件 
  kubectl apply -f service.yaml 
  ```

- ```sh
  # 创建 gateway 
  cat gateway.yaml 文件，内容如下： 
  ```

  

- ```yaml
  apiVersion: networking.istio.io/v1beta1 
  kind: Gateway 
  metadata: 
   name: canary-gateway 
  spec: 
   selector: 
   istio: ingressgateway 
   servers: 
   - port: 
   number: 80 
   name: http 
   protocol: HTTP 
   hosts: 
  - "*" 
  ```



- ```sh
  # 更新 gateway.yaml 
  kubectl apply -f gateway.yaml 
  
  ```

- ```sh
  # 创建 virtualservice 
  cat virtual.yaml，内容如下： 
  ```

  

- ```yaml
  apiVersion: networking.istio.io/v1beta1 
  kind: VirtualService 
  metadata: 
   name: canary 
  spec: 
   hosts: 
   - "*" 
   gateways: 
   - canary-gateway 
   http: 
   - route: 
   - destination: 
   host: canary.default.svc.cluster.local 
   subset: v1 
   weight: 90 
   - destination: 
   host: canary.default.svc.cluster.local 
   subset: v2 
   weight: 10 
  --- 
  apiVersion: networking.istio.io/v1beta1 
  kind: DestinationRule 
  metadata: 
   name: canary 
  spec: 
   host: canary.default.svc.cluster.local 
   subsets: 
   - name: v1 
   labels: 
   app: v1 
   - name: v2 
   labels: 
   app: v2 
  ```

- ```sh
  # 更新 virtual.yaml 文件 
  kubectl apply -f virtual.yaml 
   
  
  ```

- ```sh
  # 获取 Ingress_port: 
  kubectl -n istio-system get service istio-ingressgateway -o 
  jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}' 
   
  ```

- 显示结果是 30871 
  验证金丝雀发布效果： 
  for i in `seq 1 100`; do curl 192.168.40.180:30871;done > 1.txt 
  打开 1.txt 可以看到结果有 90 次出现 v1，10 次出现 canary-v2,符合我们预先设计的流量走向。

  