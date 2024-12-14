---
title: jenkins中集成jmeter
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
summary: 在jenkins 中通过ant 和jemter整合实现自动化测试
categories: Devops
tags:
  - jenkins
  - CICD
op: false
abbrlink: 1800
date: 2022-08-04 17:19:53
img:
coverImg:
---




### jemter 参数

-n: 非gui模式下执行jmeter

-t: 执行测试文件坐在位置

-l: 指定测试报告结果保存的文件， jtl格式文件

-o: 指定测试报告保存的位置

### 流程

1. 将jmeter extra目录中的ant-jmeter-1.1.1.jar拷贝至ant安装目录的lib中

2. 创建demo文件存放jmeter脚本文件，创建demo-report文件夹存放测试报告

3. demo 文件下新建build.xml文件（可以将jmeter extra中的build.xml拷贝过来）

4. 配置build.xml文件

   ```
   <?xml version="1.0" encoding="UTF-8"?>
   <project name="ant-jmeter-test" default="run" basedir=".">
     <tstamp>
       <format property="time" pattern="yyyyMMddhhmm" />
     </tstamp>
     <!-- 需要改成自己本地的 Jmeter 目录-->
     <property name="jmeter.home" value="D:\work_software\jmeter\apache-jmeter-3.2" />
     <!-- Jmeter生成 jtl 格式的结果报告的路径-->
     <property name="jmeter.result.jtl.dir" value="D:\work_software\jmeter\apache-jmeter-3.2\testcases\report\jtl" />
     <!-- Jmeter生成 html 格式的结果报告的路径-->
     <property name="jmeter.result.html.dir" value="D:\work_software\jmeter\apache-jmeter-3.2\testcases\report\html" />
     <!-- 生成的报告的前缀-->
     <property name="ReportName" value="TestReport" />
     <property name="jmeter.result.jtlName" value="${jmeter.result.jtl.dir}/${ReportName}${time}.jtl" />
     <property name="jmeter.result.htmlName" value="${jmeter.result.html.dir}/${ReportName}${time}.html" />
    
     <target name="run">
    
       <antcall target="test" />
    
       <antcall target="report" />
    
     </target>
    
     <target name="test">
    
       <taskdef name="jmeter" classname="org.programmerplanet.ant.taskdefs.jmeter.JMeterTask" />
    
       <jmeter jmeterhome="${jmeter.home}" resultlog="${jmeter.result.jtlName}">
    
         <!-- 声明要运行的脚本。"*.jmx"指包含此目录下的所有Jmeter脚本-->
    
         <testplans dir="D:\work_software\jmeter\apache-jmeter-3.2\testcases" includes="*.jmx" />
    
           <property name="jmeter.save.saveservice.output_format" value="xml"/>
    
       </jmeter>
    
     </target>
    
      <path id="xslt.classpath">
    
       <fileset dir="${jmeter.home}/lib" includes="xalan*.jar"/>
       <fileset dir="${jmeter.home}/lib" includes="serializer*.jar"/>
     </path>
     <target name="report"><tstamp> <format property="report.datestamp" pattern="yyyy/MM/dd HH:mm" /></tstamp>
    
       <xslt
    
          classpathref="xslt.classpath" rel="external nofollow"
          force="true"
          in="${jmeter.result.jtlName}"
          out="${jmeter.result.htmlName}"
          style="${jmeter.home}/extras/jmeter-results-detail-report_21.xsl">
          <param name="dateReport" expression="${report.datestamp}"/>
       </xslt>
       <copy todir="${jmeter.result.html.dir}">
         <fileset dir="${jmeter.home}/extras">
           <include name="collapse.png" />
           <include name="expand.png" />
         </fileset>
       </copy>
     </target>
   </project>
   ```

   

5.  配置ant环境变量

6. 运行ant 查看报告

   1. 安装publishhtml插件

   2. 查看片段生成器

   3. 生成展示报告代码放入jenkinsfile中

      ```jenkinsfile
      #!groovy
      
      @Library('jenkinslibrary@master') _
      
      //func from shareibrary
      def build = new org.devops.build()
      def tools = new org.devops.tools()
      def toemail = new org.devops.toemail()
      
      
      //env
      String buildType = "${env.buildType}"
      String buildShell = "${env.buildShell}"
      String srcUrl = "${env.srcUrl}"
      String branchName = "${env.branchName}"
      
      userEmail = "1028354023@qq.com"
      
      
      //pipeline
      pipeline{
          agent { node { label "build"}}
          
          
          stages{
      
              stage("CheckOut"){
                  steps{
                      script{
                         
                          
                          println("${branchName}")
                      
                          tools.PrintMes("获取代码","green")
                          checkout([$class: 'GitSCM', branches: [[name: "${branchName}"]], 
                                            doGenerateSubmoduleConfigurations: false, 
                                            extensions: [], 
                                            submoduleCfg: [], 
                                            userRemoteConfigs: [[credentialsId: 'gitlab-admin-user', url: "${srcUrl}"]]])
      
                      }
                  }
              }
              stage("Build"){
                  steps{
                      script{
                      
                          tools.PrintMes("执行打包","green")
                          build.Build(buildType,buildShell)
                          
                          
                          
                          //展示测试报告
                          publishHTML([allowMissing: false, 
                                       alwaysLinkToLastBuild: false, 
                                       keepAll: false, 
                                       reportDir: 'result/htmlfile', 
                                       reportFiles: 'SummaryReport.html,DetailReport.html', 
                                       reportName: 'InterfaceTestReport', 
                                       reportTitles: ''])
                      }
                  }
             }
          }
          post {
              always{
                  script{
                      println("always")
                  }
              }
              
              success{
                  script{
                      println("success")
                      toemail.Email("流水线成功",userEmail)
                  
                  }
              
              }
              failure{
                  script{
                      println("failure")
                      toemail.Email("流水线失败了！",userEmail)
                  }
              }
              
              aborted{
                  script{
                      println("aborted")
                      toemail.Email("流水线被取消了！",userEmail)
                  }
              
              }
          
          }
          
          
      }
      
      ```

      
