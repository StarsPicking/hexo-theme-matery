---
title: jenkins中集成artifactory
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Devops
tags:
  - CICD
  -	 制品库
op: false
abbrlink: 62927
date: 2022-08-01 21:45:38
img:
coverImg:
summary:
---

# jenkins中集成artifactory

## artifactory 和nexus的区别

参考 [制品仓库的artifactory的介绍和部署 - 走看看 (zoukankan.com)](http://t.zoukankan.com/qingbaizhinian-p-13272346.html) 

>Artifactory是目前国内唯一提供原厂技术支持的企业级全语言制品管理解决方案，具有原生高可用以及热容灾备份功能，专门针对大型企业设计。而Nexus不具备相应功能，会大大提高技术人员的学习成本，以及企业的用人成本；
>
>b. Artifactory提供元数据功能，可以真正意义上将开发运维通过制品端到端的联系起来，需求、代码提交、各项测试结果、审批流程、构建过程以及部署过程都能一目了然的显示，彻底打破了信息烟囱化的问题，而Nexus不具备此项功能；
>
>c. Artifactory所有功能都提供Rest API，全接口方便封装，能结合用户的不同需求进行二次开发，从而打造最贴合用户行为习惯的制品管理工具，而Nexus接口不全面；
>
>d. Artifactory包含Xray组件，能够扫描第三方组件安全漏洞，并且能够从影响范围和影响深度两个维度快速定位安全风险，大大提高企业软件开发安全性，而Nexus不具备此功能。
>
>e. Artifactory能够管理任何形式的二进制文件，以及相关联的非二进制文件，并提供完备的访问方式和本地仓库，而Nexus此项功能不全面。
>
>此外 nexus常用来做私服和代理仓具， artifactory常用来做制品库
>

## 安装

```
docker run -id \
--privileged=true --name=nexus3 \
-p 8081:8081 \
-v ${LOCALDIR}/nexus3/nexus-data:/nexus-data \
sonatype/nexus3:3.20.1
```

访问： http://localhost:8081/artifactory/webapp/home.html  用户名密码： admin/password 

登录系统显示如下

![1666965452765]( 1666965452765.png)

登录系统后修改密码

可以选择构建编译仓库

Artifactory 仓库主要有四种类型：远程仓库、本地仓库、虚拟仓库及分发仓库，分别应用在如下不同的场景。

远程仓库：Artifactory 仓库支持代理公网或内网二进制软件制品仓库(Artifactory, Nexus，Harbor等)，按需获取后在本地进行缓存，可大幅度提升构建效率

本地仓库：Artifactory 本地仓库用来存储本地构建产出的软件制品。本地仓库中的软件制品通常都带有丰富的元数据，并且通过基于角色的访问控制(RBAC)实现资源隔离

虚拟仓库：为满足制品管理的多团队协作需求，虚拟仓库通过打包任意数量的远程仓库和本地仓库，暴露唯一的访问入口的方式，将制品提供者和消费者之间的耦合度降到最低，提升协作效率

分发仓库：分发仓库通过JFrog Bintray SaaS服务满足软件制品公网分发的需求，提供默认的全球CDN加速服务


![1666965556299](1666965556299.png)



![1666965612827](1666965612827.png)





## jenkins中集成artficatory

-  jenkins中artifactory插件

- 配置artifactory仓库信息

  ![1666965796320](1666965796320.png)

  ![1666965829033](1666965829033.png)



# 使用artifactory插件收集构建数据

```
package org.devops


//Maven打包构建,上传构建信息
def MavenBuild(buildShell){
    def server = Artifactory.newServer url: "http://192.168.1.200:30082/artifactory"
    def rtMaven = Artifactory.newMavenBuild()
    def buildInfo
    server.connection.timeout = 300
    server.credentialsId = 'artifactory-admin-user' 
    //maven打包
    rtMaven.tool = 'M2' 
    buildInfo = Artifactory.newBuildInfo()

    String newBuildShell = "${buildShell}".toString()
    println(newBuildShell)
    rtMaven.run pom: 'pom.xml', goals: newBuildShell, buildInfo: buildInfo
    //上传build信息
    server.publishBuildInfo buildInfo
}

def main(buildType,buildShell){
    if(buildType == "mvn"){
        MavenBuild(buildShell)
    }
}

```



![1666967385494](1666967385494.png)



# 命令规范

![1666967508528](1666967508528.png)



# 使用rtUpload插件上传制品到artifactory



```
//上传制品
def PushArtifact(){
    
    
    //重命名制品
    def jarName = sh returnStdout: true, script: "cd target;ls *.jar"
    jarName = jarName - "\n"
    def pom = readMavenPom file: 'pom.xml'
    env.pomVersion = "${pom.version}"
    env.serviceName = "${JOB_NAME}".split("_")[0]
    env.buildTag = "${BUILD_ID}"
    def newJarName = "${serviceName}-${pomVersion}-${buildTag}.jar"
    println("${jarName}  ------->>> ${newJarName}")
    sh " mv target/${jarName}  target/${newJarName}"
    
    //上传制品
    env.businessName = "${env.JOB_NAME}".split("-")[0]
    env.repoName = "${businessName}-${JOB_NAME.split("_")[-1].toLowerCase()}"
    println("本次制品将要上传到${repoName}仓库中!")   
    env.uploadDir = "${repoName}/${businessName}/${serviceName}/${pomVersion}"
    
    println('上传制品')
    rtUpload (
        serverId: "artifactory",
        spec:
            """{
            "files": [
                {
                "pattern": "target/${newJarName}",
                "target": "${uploadDir}/"
                }
            ]
            }"""
    )
}
```



# artifactory和nexus对比

最近经常被问到一个问题："我已经在用 Nexus 管理 Maven 仓库，用 Artifactory 替换它有什么好处？"

 

其实这个问题在社区里早已有官方的答案：https://binary-repositories-comparison.github.io/

 

这个 wiki 是 Artifactory，Nexus 等各自的开发团队维护的产品功能列表，目的是保证所列出的功能是公平，公正，公开的。来看看具体的对比。

 

语言&工具支持

Artifactory

> Maven、Docker、Bower（html&js）、Chef、Puppet、CocoaPods（IOS）、Conan（C/C++）、Debian、Ruby Gems、Git LFS、Gradle、Ivy、Npm、Nuget、Opkg、Php composer、Pypi、SBT、Vagrant（box）、Rpm、Generic（通用）

Nexus

> Bower、Java、Npm、Docker、Nuget、Pypi

 多 Docker 镜像注册中心

Artifactory

> 支持多 Docker 镜像注册中心，用户可以做 Docker 镜像的流水线 Promotion。
> 删除 Docker 镜像时不需要停服。

Nexus 3.0

> 支持 Docker 镜像注册中心。
>
> 删除 Docker 镜像时需要停服。



 

是否支持 REST API

Artifactory

> 全面覆盖的 REST API。与 UI 松耦合，可以基于 REST API 实现自己的 UI。

Nexus 3.0

> 部分支持。

 

元数据

Artifactory

> 支持自定义属性以及属性集到任何 Layout 的二进制文件上;可以基于这些属性进行过滤搜索，并且支持Restful 方式搜索；
>
> 跨地域远程代理仓库之间可以同步属性，管理异地协同开发。

Nexus 

> Nexus2 支持 Custom metadata plugin。
>
> Nexus3 不支持。

 

CI 集成

Artifactory

> 收集所有构建相关环境信息。
>
> 收集发布以及依赖的模块信息。
>
> 支持构建 Promotion 升级。
>
> 建立二进制文件和构建的关系，多维度管理二进制文件生命周期。
>
> 支持可视化的正-反向依赖关系展示。

Nexus

> 不支持。

 

Checksum 检查

Artifactory

> 在上传时检查 Checksum，若发现该文件已经被上传过，则不重复上传。
> 若文件丢失 Checksum，会重新计算并记录。

Nexus 3.0

> 不支持。

 

主动并发下载依赖

Artifactory

> 支持主动并发下载相关的依赖。例如 A依赖 B，B 依赖 C，Artifactory 在下载 A 的同时，会并发的下载 B 和 C。

Nexus 3.0

> 不支持。

 

任意全局查询

Artifactory

> 提供 AQL（Artifactory Query Language）支持任何条件的查询，包括排序，过滤，返回字段等等。

Nexus 3.0

> 支持有限的查询，例如通过名字查询。

 

深度文件查询

Artifactory

> 支持在任意可解压文件里搜索类文件，并提供地址。例如：在任意 Jar 包里找到 .Class 文件。

Nexus 3.0

> 不支持。

 

仓库数据统计

Artifactory

> 提供仓库大小，实际存储大小，文件数量，下载量，上传者等统计

Nexus 3.0

> 不支持

 

查看 Jar 文件

Artifactory

> 能够查看 Jar文件里的任何内容，包括 Jar 文件里的源代码。

Nexus 3.0

> 不支持。

 

仓库复制

Artifactory

> 支持文件夹级别的文件实时复制。支持并发多地复制（Multi-Push）保证多地仓库的一致性。

Nexus 3.0

> 不支持。

 

支持高可用

Artifactory

> 支持0宕机时间的高可用集群，并且可以自由水平扩展。支持 Active-Active 高可用。

Nexus 3.0

> 支持Master-Slave。

 

数据库存储

Artifactory

> 安装包默认绑定 Apache Derby。支持MySQL，PostgreSQL，Oracle，MS SQL Server。

Nexus

> 安装包默认绑定 H2。

 

商业支持

Artifactory

> 不限制用户数量，不限制服务器硬件配置。30天免费试用，并可以适当延期。24/7 support，4小时响应时间。

Nexus

> 按用户数量收费，不限制服务器数量。
>
> 14天免费试用，并可以适当延期。
>
> 24/7 support。

 

> 谷歌云平台, 亚马逊, 苹果，Twitter, Linkedin, Netflix, Mesosphere, 甲骨文，思科，华为，腾讯，滴滴等3000+企业，都已经使用 Artifactory 管理 Maven，Docker，Yum，NPM，C/C++等仓库。

 

JFrog 开发了专门的工具支持从 Nexus 导出数据到 Artifactory，欢迎试用！

 

下载JFrog Artifactory 开源版（代替 Nexus）：

http://www.jfrogchina.com/open-source/

 

下载JFrog Artifactory 企业版(免费试用)：

https://www.jfrog.com/artifactory/free-trial/?lang=zh-hans#High-Availability

 

关于JFrog

世界领先DevOps平台

公司成立于2008年，在美国、以色列、法国、西班牙，以及中国北京市拥有超过200名员工。JFrog 拥有3000多个付费客户，其中知名公司包括如腾讯、谷歌、思科、Netflix、亚马逊、苹果等。连续两年，JFrog 被德勤评选为50家发展最快的技术公司之一，并被评为硅谷增长最快的私营企业之一。