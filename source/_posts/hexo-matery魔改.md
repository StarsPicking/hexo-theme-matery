---
title: hexo-matery魔改
author: 张大哥
top: Ttrue
cover: true
toc: true
mathjax: false
categories: hexo
tags:
  - hexo-theme-matery
abbrlink: 27595
date: 2022-11-26 01:13:25
img: https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover1.jpg
coverImg: https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover1.jpg
summary: Hexo官方站点上有非常多的主题，可以选择一套自己喜欢的，并且这些主题都是开源的，基本参考readme文档就可以完成更换，如果你懂点前端知识的话，还可以进行修改，贡献代码。这里我使用的 Matery 主题，是由blinkfox大佬开发的一款的响应式主题, 页面简介功能强大，基础的不谈，直接上干货
---





# 魔改



## 修改网站整体配色

- vi themes/hexo-theme-matery/source/css/matery.css 修改bg-color 的background-image属性来设置颜色，修改opacity设置透明度

```css
.bg-color {
    background-image: linear-gradient(to right, #ee9ca7 0%, #ffdde1 100%);
    opacity: 0.8;
}

```





## 取消banner蒙层

- vi themes/hexo-theme-matery/source/css/matery.css 将bg-cover:after 注释

```css
/*.bg-cover:after {
    -webkit-animation: rainbow 60s infinite;
    animation: rainbow 60s infinite;
}*/

```



## 设置网站背景图



- vi themes/hexo-theme-matery/source/css/matery.css

```css
body {
    /* background-color: #eaeaea; */
    background: linear-gradient(60deg, rgba(255, 165, 150, 0.5) 5%, rgba(0, 228, 255, 0.35)) 0% 0% / cover, url("https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/H21b5f6b8496141a1979a33666e1074d9x.jpg"), url("https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/H21b5f6b8496141a1979a33666e1074d9x.jpg") 0px 0px;
    background-attachment: fixed;
    margin: 0;
    color: #34495e;
}

```



1.5 适配目录



- 好像没有生效

```shell
 vi themes/hexo-theme-matery/source/css/post.css
```





```css
.toc-widget {
    width: 345px;
    padding-left: 20px;
    background-color: rgb(255, 255, 255,0.7);
    border-radius: 10px;
    box-shadow: 0 10px 35px 2px rgba(0, 0, 0, .15), 0 5px 15px rgba(0, 0, 0, .07), 0 2px 5px -5px rgba(0, 0, 0, .1) !important;
}

```



## 修改banner图

- 方式一：banner轮播

  - 在hexo-theme-matery._config中配置featureImages

  

  ```yaml
  featureImages:
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover17.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover18.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover19.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover20.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover21.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover22.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover23.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover24.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover25.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover26.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover27.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover28.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover29.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover30.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover31.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover32.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover33.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover34.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover35.jpg
  - https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover36.jpg
  
  ```

  - vi themes/hexo-theme-matery/layout/_partial/bg-cover-content.ejs

  ```js
  <script>
      // 每天切换 banner 图.  Switch banner image every day.
      //var bannerUrl = "<%- theme.jsDelivr.url %><%- url_for('/medias/banner/') %>" + new Date().getDay() + '.jpg';
      //$('.bg-cover').css('background-image', 'url(' + bannerUrl + ')');
      // 随机选择配置文件中featureImages配置的图片
      $('.bg-cover').css('background-image', 'url(<%- theme.featureImages[Math.floor(Math.random() * theme.featureImages.length + 1)-1] %>)');
  </script>
  ```

- 方式二：设置为外部链接图片

- vi themes/hexo-theme-matery/layout/_partial/bg-cover-content.ejs

```js
<script>
    // 每天切换 banner 图.  Switch banner image every day.
    //var bannerUrl = "<%- theme.jsDelivr.url %><%- url_for('/medias/banner/') %>" + new Date().getDay() + '.jpg';
    //$('.bg-cover').css('background-image', 'url(' + bannerUrl + ')');
    // 随机选择配置文件中featureImages配置的图片
    //$('.bg-cover').css('background-image', 'url(<%- theme.featureImages[Math.floor(Math.random() * theme.featureImages.length + 1)-1] %>)');
    //固定一张图片
    $('.bg-cover').css('background-image', 'url(https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover3.jpg)');

</script>
```





## 优化背景壁纸和目录栏

- vi themes/hexo-theme-matery/source/css/matery.css

```css
body {
    /* background-color: #eaeaea; */
    background: linear-gradient(60deg, rgba(255, 165, 150, 0.5) 5%, rgba(0, 228, 255, 0.35)) 0% 0% / cover, url("https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/%E8%83%8C%E6%99%AF%E9%80%8F%E6%98%8E%E5%9B%BE%E7%89%87.png"), url("https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/H21b5f6b8496141a1979a33666e1074d9x.jpg") 0px 0px;
    background-attachment: fixed;
    margin: 0;
    color: #34495e;
}

```



## 修改页脚访问量等信息

-  vi themes/hexo-theme-matery/layout/_partial/footer.ejs

- 增加建站时间

```js
<script language=javascript>
    function siteTime() {
        window.setTimeout("siteTime()", 1000);
        var seconds = 1000;
        var minutes = seconds * 60;
        var hours = minutes * 60;
        var days = hours * 24;
        var years = days * 365;
        var today = new Date();
        var todayYear = today.getFullYear();
        var todayMonth = today.getMonth() + 1;
        var todayDate = today.getDate();
        var todayHour = today.getHours();
        var todayMinute = today.getMinutes();
        var todaySecond = today.getSeconds();
        /* Date.UTC() -- 返回date对象距世界标准时间(UTC)1970年1月1日午夜之间的毫秒数(时间戳)
        year - 作为date对象的年份，为4位年份值
        month - 0-11之间的整数，做为date对象的月份
        day - 1-31之间的整数，做为date对象的天数
        hours - 0(午夜24点)-23之间的整数，做为date对象的小时数
        minutes - 0-59之间的整数，做为date对象的分钟数
        seconds - 0-59之间的整数，做为date对象的秒数
        microseconds - 0-999之间的整数，做为date对象的毫秒数 */
        var t1 = Date.UTC(2017, 09, 11, 00, 00, 00); //北京时间2018-2-13 00:00:00
        var t2 = Date.UTC(todayYear, todayMonth, todayDate, todayHour, todayMinute, todaySecond);
        var diff = t2 - t1;
        var diffYears = Math.floor(diff / years);
        var diffDays = Math.floor((diff / days) - diffYears * 365);
        var diffHours = Math.floor((diff - (diffYears * 365 + diffDays) * days) / hours);
        var diffMinutes = Math.floor((diff - (diffYears * 365 + diffDays) * days - diffHours * hours) / minutes);
        var diffSeconds = Math.floor((diff - (diffYears * 365 + diffDays) * days - diffHours * hours - diffMinutes * minutes) / seconds);
        document.getElementById("sitetime").innerHTML = "本站已运行 " +diffYears+" 年 "+diffDays + " 天 " + diffHours + " 小时 " + diffMinutes + " 分钟 " + diffSeconds + " 秒";
    }/*因为建站时间还没有一年，就将之注释掉了。需要的可以取消*/
    siteTime();
</script>

```



## 新增社交链接

-  vi themes/hexo-theme-matery/layout/_partial/social-link.ejs

- 添加git链接

```ejs
<% if (theme.socialLink.git) { %>
    <a href="<%= theme.socialLink.git %>" class="tooltipped" target="_blank" data-tooltip="访问我的Git" data-position="top" data-delay="50">
        <i class="fa-brands fa-gitlab"></i>
    </a>
<% } %>

```



- 其中图标类似fa-gitlab可以在[Font Awesome]([Font Awesome](https://fontawesome.com/search))中查找
- 常用图标如下

```
Facebook: fa-facebook

Twitter: fa-twitter

Google-plus: fa-google-plus

Linkedin: fa-linkedin

Tumblr: fa-tumblr

Medium: fa-medium

Slack: fa-slack

新浪微博: fa-weibo

微信: fa-wechat

QQ: fa-qq
```



- 然后在主题配置文件中配置自己的git地址



```yaml
socialLink:
  github:
  git: https://gitee.com/better_better
  email: 15652533044@163.com
  facebook: # https://www.facebook.com/xxx
  twitter: # https://twitter.com/xxx
  qq: 1028354023
  weibo: # https://weibo.com/xxx
  zhihu: # https://www.zhihu.com/xxx
  rss: true # true、false

```



## 修改打赏二维码

- 在**主题文件**的 `source/medias/reward` 文件中，可以替换成你的的微信和支付宝的打赏二维码图片

## 部署到多个仓库

- 在根目录下设置deploy



```yaml
deploy:
- type: git
repo: https://gitee.com/better_better/hexo-theme-matery.git
branch: master
ignore_hidden: false
- type: git
repo: https://gitee.com/better_better/hexo-theme-matery.git
branch: master
ignore_hidden: false
```

## 文章字数统计



```shell
npm i --save hexo-wordcount
```



- 修改根目录下的_config.yaml

```yaml
wordCount:
enable: false # 将这个值设置为 true 即可.
postWordCount: true
min2read: true
totalCount: true
```

## 添加rss订阅

- 安装插件

```shell
npm install hexo-generator-feed --save
```

- 修改根目录下的_config.yaml

```yaml
feed:
type: atom
path: atom.xml
limit: 20
hub:
content:
content_limit: 140
content_limit_delim: ' '
order_by: -date
```



## 添加动态标签



- vi themes/hexo-theme-matery/layout/layout.ejs

```js
<script type="text/javascript">
    var OriginTitile = document.title,
        st;
    document.addEventListener("visibilitychange", function () {
        document.hidden ? (document.title = "看不见我🙈~看不见我🙈~", clearTimeout(st)) : (document.title =
            "(๑•̀ㅂ•́) ✧被发现了～", st = setTimeout(function () {
                document.title = OriginTitile
            }, 3e3))
    })
</script>


```



## 新建文章模板

- 修改/scaffolds/post.md中的内容

```json
---
title: {{ title }}
date: {{ date }}
author: 
img: 
coverImg: 
top: false
cover: false
toc: true
mathjax: false
password:
summary:
tags:
categories:
---


```



## 添加404页面

- hexo new page 404
- vi ./source/404/404.md 添加如下内容

```json
---
title: 404 Not Found
toc: false
comments: false
layout: 404
type: 404
permalink: /404
description: "Oops～，我崩溃了！找不到你想要的页面 :("
---

```

- vi themes/hexo-theme-matery/layout/404.ejs 添加如下内容

```js
<style type="text/css">
    /* don't remove. */
    .about-cover {
        height: 90.2vh;
    }
</style>
<div class="bg-cover pd-header about-cover">
    <div class="container">
        <div class="row">
            <div class="col s10 offset-s1 m8 offset-m2 l8 offset-l2">
                <div class="brand">
                    <div class="title center-align">
                        404
                    </div>
                    <div class="description center-align">
                        <%= page.description %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 每天切换 banner 图.  Switch banner image every day.
    $('.bg-cover').css('background-image', 'url(https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover3.jpg)');
</script>

```

- 在nginx的config做如下配置
- 本网站做了私有话部署，是部署在阿里云服务器，所以需要需改静态资源服务器的404指向
- 如果是托管在gitee 或者github上显示404页面，需要在/source/目录下新建404.md文件，文件内容和404.index内容相同，这是因为gitee或者github托管时，静态资源服务器配置的404页面是在根目录下

```sh
    server {
        listen       81;
        server_name  _;
        location / {
            root /home/repository;
            index index.html;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
        location = /404.html {
            # 放错误页面的目录路径。
            root /home/repository;
        }
    }

```

## 去除banner上的logo 和左上角title



```shell
vi themes/hexo-theme-matery/layout/_partial/header.ejs
```



```js
<header class="navbar-fixed">
    <nav id="headNav" class="bg-color nav-transparent">
        <div id="navContainer" class="nav-wrapper container">
            <div class="brand-logo">
                <a href="<%- url_for() %>" class="waves-effect waves-light">
                    <!-- 去掉首页banner上的logo显示-->
                    <!-- <% if (theme.logo !== undefined && theme.logo.length > 0) { %>
                    <img src="<%- theme.jsDelivr.url %><%- url_for(theme.logo) %>" class="logo-img" alt="LOGO">
                    <% } %> -->
                    <!-- 去掉左上角网站title-->
                    <!-- <span class="logo-span"><%= config.title %></span> -->
                </a>
            </div>
            <%- partial('_partial/navigation') %>
        </div>

        <% if (theme.githubLink && theme.githubLink.enable) { %>
            <%- partial('_partial/github-link') %>
        <% } %>
    </nav>

</header>

```

## 修改建站时间为动态变化



```shell
 vi themes/hexo-theme-matery/layout/_partial/footer.ejs
```



```js
            <!-- 运行天数提醒. -->
            <% if (theme.time.enable) { %>
                <span id="sitetime"> Loading ...</span>
		        <span class="my-face">ღゝ◡╹)ノ♡</span>
                <!-- <script>
                    var calcSiteTime = function () {
                        var seconds = 1000;
                        var minutes = seconds * 60;
                        var hours = minutes * 60;
                        var days = hours * 24;
                        var years = days * 365;
                        var today = new Date();
                        var startYear = "<%- theme.time.year %>";
                        var startMonth = "<%- theme.time.month %>";
                        var startDate = "<%- theme.time.date %>";
                        var startHour = "<%- theme.time.hour %>";
                        var startMinute = "<%- theme.time.minute %>";
                        var startSecond = "<%- theme.time.second %>";
                        var todayYear = today.getFullYear();
                        var todayMonth = today.getMonth() + 1;
                        var todayDate = today.getDate();
                        var todayHour = today.getHours();
                        var todayMinute = today.getMinutes();
                        var todaySecond = today.getSeconds();
                        var t1 = Date.UTC(startYear, startMonth, startDate, startHour, startMinute, startSecond);
                        var t2 = Date.UTC(todayYear, todayMonth, todayDate, todayHour, todayMinute, todaySecond);
                        var diff = t2 - t1;
                        var diffYears = Math.floor(diff / years);
                        var diffDays = Math.floor((diff / days) - diffYears * 365);

                        // 区分是否有年份.
                        var language = '<%- config.language %>';
                        if (startYear === String(todayYear)) {
                            document.getElementById("year").innerHTML = todayYear;
                            var daysTip = 'This site has been running for ' + diffDays + ' days';
                            if (language === 'zh-CN') {
                                daysTip = '本站已运行 ' + diffDays + ' 天';
                            } else if (language === 'zh-HK') {
                                daysTip = '本站已運行 ' + diffDays + ' 天';
                            }
                            document.getElementById("sitetime").innerHTML = daysTip;
                        } else {
                            document.getElementById("year").innerHTML = startYear + " - " + todayYear;
                            var yearsAndDaysTip = 'This site has been running for ' + diffYears + ' years and '
                                + diffDays + ' days';
                            if (language === 'zh-CN') {
                                yearsAndDaysTip = '本站已运行 ' + diffYears + ' 年 ' + diffDays + ' 天';
                            } else if (language === 'zh-HK') {
                                yearsAndDaysTip = '本站已運行 ' + diffYears + ' 年 ' + diffDays + ' 天';
                            }
                            document.getElementById("sitetime").innerHTML = yearsAndDaysTip;
                        }
                    }

                    calcSiteTime();
                </script> -->

                <script language=javascript> 
                    function siteTime() { 
                        window.setTimeout("siteTime()", 1000); 
                        var seconds = 1000; var minutes = seconds * 60; 
                        var hours = minutes * 60; 
                        var days = hours * 24; 
                        var years = days * 365; 
                        var today = new Date(); 
                        var todayYear = today.getFullYear(); 
                        var todayMonth = today.getMonth() + 1; 
                        var todayDate = today.getDate(); 
                        var todayHour = today.getHours(); 
                        var todayMinute = today.getMinutes(); 
                        var todaySecond = today.getSeconds(); 
                        /* Date.UTC() -- 返回date对象距世界标准时间(UTC)1970年1月1日午夜之间的毫秒数(时间戳) year - 作为date对象的年份，为4位年份值 month - 0-11之间的整数，做为date对象的月份 day - 1-31之间的整数，做为date对象的天数 hours - 0(午夜24点)-23之间的整数，做为date对象的小时数 minutes - 0-59之间的整数，做为date对象的分钟数 seconds - 0-59之间的整数，做为date对象的秒数 microseconds - 0-999之间的整数，做为date对象的毫秒数 */ 
                        var t1 = Date.UTC(2017, 09, 11, 00, 00, 00); //北京时间2018-2-13 00:00:00 
                        var t2 = Date.UTC(todayYear, todayMonth, todayDate, todayHour, todayMinute, todaySecond); var diff = t2 - t1; 
                        var diffYears = Math.floor(diff / years); 
                        var diffDays = Math.floor((diff / days) - diffYears * 365); 
                        var diffHours = Math.floor((diff - (diffYears * 365 + diffDays) * days) / hours);
                        var diffMinutes = Math.floor((diff - (diffYears * 365 + diffDays) * days - diffHours * hours) / minutes); 
                        var diffSeconds = Math.floor((diff - (diffYears * 365 + diffDays) * days -diffHours * hours - diffMinutes * minutes) / seconds);
                        document.getElementById("sitetime").innerHTML = "本站已运行 " +diffYears+" 年 "+diffDays + " 天 " + diffHours + " 小时 " + diffMinutes + " 分钟 " + diffSeconds + " 秒";
                    } /*因为建站时间还没有一年，就将之注释掉了。需要的可以取消*/ 
                    siteTime(); 
                </script>
            <% } %>
```



## 卜算子



```shell
 vi themes/hexo-theme-matery/layout/_partial/footer.ejs
```



- 在打开文件的中替换原来的内容为以下内容

  

```js

            <% if (theme.busuanziStatistics && theme.busuanziStatistics.totalTraffic) { %>
                <span id="busuanzi_container_site_pv" style='display:none'>
                    <i class="fa fa-heart-o"></i>
                    本站总访问量 <span id="busuanzi_value_site_pv" class="white-color"></span>
                </span>
            <% } %>
            <% if (theme.busuanziStatistics && theme.busuanziStatistics.totalNumberOfvisitors) { %>
                <span id="busuanzi_container_site_uv" style='display:none'>
                    人次,&nbsp;访客数 <span id="busuanzi_value_site_uv" class="white-color"></span> 人.
                </span>
            <% } %>
```



- 在这个文件最后加上如下代码



```js
<script> $(document).ready(function () { 
    var int = setInterval(fixCount, 50); // 50ms周期检测函数 
    var pvcountOffset = 80000; // 初始化首次数据 
    var uvcountOffset = 20000; function fixCount() { 
        if (document.getElementById("busuanzi_container_site_pv").style.display != "none") { 
        $("#busuanzi_value_site_pv").html(parseInt($("#busuanzi_value_site_pv").html()) + pvcountOffset); 
        clearInterval(int); 
        } 
        if ($("#busuanzi_container_site_pv").css("display") != "none") { 
            $("#busuanzi_value_site_uv").html(parseInt($("#busuanzi_value_site_uv").html()) + uvcountOffset); // 加上初始数据 
            clearInterval(int); // 停止检测 
        } } }); 

</script>
```



## 替换icon和baner上的图标

```
替换 themes\hexo-theme-matery\source\medias中的logo.png
替换 themes\hexo-theme-matery\source  favicon.png
```

## 添加博客动态标签



```shell
 vi themes/hexo-theme-matery/layout/layout.ejs
```

- 在对应的位置下添加如下代码

```js
<script type="text/javascript">
    var OriginTitile = document.title,
        st;
    document.addEventListener("visibilitychange", function () {
        document.hidden ? (document.title = "看不见我🙈~看不见我🙈~", clearTimeout(st)) : (document.title =
            "(๑•̀ㅂ•́) ✧被发现了～", st = setTimeout(function () {
                document.title = OriginTitile
            }, 3e3))
    })
</script>

```



## hexo-neat代码优化加速

- 站点根目录下_config.yaml添加如下内容

```yaml
#hexo-neat 优化提速插件（去掉HTML、css、js的blank字符）
neat_enable: true
neat_html:
  enable: true
  exclude:
    - '**/*.md'
neat_css:
  enable: true
  exclude:
    - '**/*.min.css'
neat_js:
  enable: true
  mangle: true
  output:
  compress:
  exclude:
    - '**/*.min.js'
    - '**/**/instantpage.js'
    - '**/matery.js'
```

- 安装插件

```
npm install hexo-neat
```

- 运行hexo

```shell
hexo clean && hexo g&& hexo s
```

## 修复详情页下面的上一篇/下一篇摘要失效

```
vi theme/hexo-theme-matery/layout/_partial/prev-next.js
```

- 找到上一页对应的位置，大概在41行

```js
 
                    <div class="summary block-with-text">
                        <% if (page.prev.summary && page.prev.summary.length > 0) { %>
                            <%- page.prev.summary %>
                        <% } else { %>
                            <%- strip_html(page.prev.content).substring(0, 70) %>
                       <% } %>
                   </div>

```



- 找到下一页对应的位置，大概在103行

```js
                    <div class="summary block-with-text">
                        <% if (page.summary && page.summary.length > 0) { %>
                            <%- page.summary %>
                        <% } else { %>
                            <%- strip_html(page.content).substring(0, 70) %>
                        <% } %>
                   </div>

```



## 文章详情页头部添加作者信息



```shell
vi themes/hexo-theme-matery/layout/_partial/post-detail.ejs
```



- 在36行附近添加如下内容

```js

                <% if (page.author && page.author.length > 0) { %>
                <div class="post-date info-break-policy">
                    <i class="fa-solid fa-user-pen"></i><%- __('author') %>:&nbsp;&nbsp;
                    <%- page.author %>
                </div>
                <% } %>


```



## 标签



- 最终效果如下

{%r%}
紅色
{%endr%}
{%g%}
綠色
{%endg%}
{%y%}
黃色
{%endy%}



- 在themes/hexo-theme-matery/scripts/ 新建block.js文件

```shell
vi themes/hexo-theme-matery/scripts/block.js
```



- 添加如下内容

```js
hexo.extend.tag.register('r', function(args, content){
  var className =  args.join(' ');
  return '<div class="uk-alert uk-alert-danger"><i class="fas fa-exclamation-triangle"></i> ' + content + '</div>';
}, {ends: true});

hexo.extend.tag.register('g', function(args, content){
  var className =  args.join(' ');
  return '<div class="uk-alert uk-alert-success"><i class="fa fa-check-circle"></i> ' + content + '</div>';
}, {ends: true});

hexo.extend.tag.register('y', function(args, content){
  var className =  args.join(' ');
  return '<div class="uk-alert uk-alert-warning"><i class="fa fa-exclamation-circle"></i> ' + content + '</div>';
}, {ends: true});
```



- 在head.ejs文件中添加样式

```shell
vi themes/hexo-theme-matery/layout/_partial/head.ejs

```



```shell
<style type="text/css">
        .uk-alert {
            margin-bottom: 15px;
            padding: 10px;
            background: #ebf7fd;
            color: #2d7091;
            border: 1px solid rgba(45, 112, 145, 0.3);
            border-radius: 4px;
            text-shadow: 0 1px 0 #ffffff;
        }
        .uk-alert-success {
            background: #e8ece2;
            color: #659f13;
            border-left: 6px solid rgba(120, 199, 9);
            font-weight: 600;
        }
        .uk-alert-warning {
            background: #fff1f0;
            color: rgb(73, 59, 156);
            border-left: 6px solid rgb(83, 27, 184, 0.3);
            font-weight: 600;
        }
        .uk-alert-danger {
            background: #f8f8f6;
            color: #eb360d;
            border-left: 6px solid#eb360d;
            font-weight: 600;
        }
 </style>
```



- 引用方法

```
{%r%}
紅色
{%endr%}
{%g%}
綠色
{%endg%}
{%y%}
黃色
{%endy%}
```



## 图片懒加载

- 在博客根目录执行

```shell
npm install hexo-lazyload-image --save
```

- 根目录配置文件中开启懒加载

```yaml
lazyload:
  enable: true 
  onlypost: false  # 是否只对文章的图片做懒加载
  loadingImg: # eg ./images/loading.gif
```

- 到这里就配置完了，执行`hexo cl&&hexo g&&hexo s`就有效果了，以后博客上的图片就都是懒加载了，以上步骤理论上任何主题都可以用

  一般情况下懒加载会和gallery插件会发生冲突，结果可能就是点开图片，左翻右翻都是loading image。matery主题的解决方案是：

  修改 `/themes/matery/source/js` 中的 `matery.js`文件

- 在108行加入以下内容

```js
$(document).find('img[data-original]').each(function(){
    $(this).parent().attr("href", $(this).attr("data-original"));
});
```

- 修改后代码

```js
   
$('#articleContent, #myGallery').lightGallery({
            selector: '.img-item',
            // 启用字幕
            subHtmlSelectorRelative: true
        });

        // 懒加载防止插件冲突
        $(document).find('img[data-original]').each(function(){
        $(this).parent().attr("href", $(this).attr("data-original"));
        });

        // progress bar init
        const progressElement = window.document.querySelector('.progress-bar');
        if (progressElement) {
            new ScrollProgress((x, y) => {
                progressElement.st

```



- 做完这步之后，还有点小Bug，首页的logo点击会直接打开logo图，而不是跳到首页。

  伪解决方案：打开 `/themes/matery/layout/_partial/header.ejs`文件，

  在`img`和`span`的两个头加个`div`：

```js
<div class="brand-logo">
    <a href="<%- url_for() %>" class="waves-effect waves-light">
        <div>
            <% if (theme.logo !== undefined && theme.logo.length > 0) { %>
            <img src="<%= theme.logo %>" class="logo-img" alt="LOGO">
            <% } %>
            <span class="logo-span"><%- config.title %></span>
        </div>
    </a>
</div>
```



## 自定义加载logo



- `hexo-lazyload-image` 插件提供了自定义loading图片的选项
- 方法就是在 `loadingImg` 后配置图片的路径就好了

```yaml
lazyload:
  enable: true 
  onlypost: false  # 是否只对文章的图片做懒加载
  loadingImg: /medias/loading.gif # eg ./images/loading.gif
```



## 解决懒加载后图片不能立即显示问题

- 此优化后可以做到懒加载无感知

- 在根目录的配置文件_config.yaml 添加如下内容

```yaml
lazyload:
  enable: true
  onlypost: false # optional
  loadingImg: # optional eg ./images/loading.gif
  isSPA: false # optional
  preloadRatio: 4 # optional, default is 1 通过修改该值可以调节预加载的阈值
```



- 配置优化达到性能最佳

```yaml
# 图片懒加载
lazyload:
  enable: true
  onlypost: false  # 是否只对文章的图片做懒加载
  loadingImg: /medias/loading.gif #eg ./images/loading.gif
  isSPA: false
  preloadRatio: 4
```



##  我的梦想card添加一言

- vi themes\hexo-theme-matery\source\css\matery.css
- 在最后添加如下样式内容

```css
/* 增加每日一言模块 */
.poem-wrap {
    position: relative;
    width: 730px;
    max-width: 80%;
    border: 2px solid #797979;
    border-top: 0;
    text-align: center;
    margin: 80px auto;
}
.poem-left {
    left: 0;
}
.poem-border {
    position: absolute;
    height: 2px;
    width: 27%;
    background-color: #797979;
}
.poem-right {
    right: 0;
}
.poem-wrap h1 {
    position: relative;
    margin-top: -20px;
    display: inline-block;
    letter-spacing: 4px;
    color: #797979;
}
.poem-wrap p:nth-of-type(1) {
    font-size: 25px;
    text-align: center;
    margin: 0 auto;
}
.poem-wrap p {
    width: 70%;
    margin: auto;
    line-height: 30px;
    color: #797979;
    font-family: "Linux Biolinum", "Noto Serif SC", Helvetica, Arial, Menlo, Monaco, monospace, sans-serif;
}
.poem-wrap p:nth-of-type(2) {
    font-size: 18px;
    margin: 15px auto;
}
```



- vi themes\hexo-theme-matery\layout\_widget\dream.ejs
- 修改为如下内容

```js
<script>
    fetch('https://v1.hitokoto.cn?c=d&c=h&c=j')
      .then(function (res){
        return res.json();
      })
      .then(function (data) {
        var info = document.getElementById('info');
        var poem = document.getElementById('poem');
        poem.innerText = data.hitokoto;
        info.innerText = "--" + data.from_who + "《" + data.from + "》" 
      })
      .catch(function (err) {
        console.error(err);
      })
  </script>
  
  <!-- 加入网易云音乐热门评论，实时更新 -->
<div class="poem-wrap">
    <% if (theme.dream.showTitle){ %>
    <div class="poem-border poem-left">

    </div>
    <div class="poem-border poem-right">

    </div>
    <h1><%= theme.dream.title %></h1>
    <% } %>
    <p id="poem">loading...</p>
    <p id="info">loading...</p>
    <!-- <p id="hitokoto">正在加载一言...</p> -->
</div>
  
  
```



- 在主题配置文件中开启dream显示

```yaml
dream:
  enable: true
  showTitle: true
  title: 摘录
  text: ""  # 此时text的内容不会显示，内容会自动使用一言api的内容
```



{%g%}
可以在其他地方引用，只需要将deream.ejs中的代码加入需要引用的ejs文件中即可
{%endg%}





## 自定义我的相册

- 修改主题配置文件
- ` vi themes\hexo-theme-matery\_config.yml`

```
  # 二级菜单写法如下
  媒体:
    icon: fas fa-list
    children:
      - name: 相册
        url: /galleries
        icon: fas fa-image
  #    - name: Musics
```

- 新建相册页

```
hexo new page gallery
```



- 在`source\galleries\`下新建或者修改index.md为以下内容

```json
---
title: galleries
date: 2022-11-27 13:11:36
type: "galleries"
layout: "galleries"
---

```



- 在`themes\hexo-theme-matery\source\css\` 新建或者修改gallery.css

- ```shell
  vi themes\hexo-theme-matery\source\css\gallery.css
  ```



```css
.gallery-wrapper{
  padding-top: 30px;
}
.gallery-wrapper .gallery-box{
  padding: 5px !important;
}

.gallery-wrapper .gallery-item {
  display: block;
  overflow: hidden;
  background-color: #fff;
  padding: 5px;
  padding-bottom: 0;
  position: relative;
  -moz-box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.22);
  -webkit-box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.22);
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.22);
}

.gallery-cover-box{
  width: 100%;
  padding-top: 60%;
  text-align: center;
  overflow: hidden;
  position: relative;
  background: center center no-repeat;
  -webkit-background-size: cover;
  background-size: cover;
}

.gallery-cover-box .gallery-cover-img {
  display: inline-block;
  width: 100%;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%,-50%);
}
.gallery-item .gallery-name{
  font-size: 14px;
  line-height: 24px;
  text-align: center;
  color: #666;
  margin: 0;
}

.waterfall {
  column-count: 3;
  column-gap: 1em;
}
.photo-wrapper{
  padding-top: 20px;
}
.photo-item {
  display: block;
  padding: 10px;
  padding-bottom: 0;
  margin-bottom: 14px;
  font-size: 0;
  -moz-page-break-inside: avoid;
  -webkit-column-break-inside: avoid;
  break-inside: avoid;
  background: white;
  -moz-box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.22);
  -webkit-box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.22);
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.22);
}
.photo-item img {
  width: 100%;
}
.photo-item .photo-name{
  font-size: 14px;
  line-height: 30px;
  text-align: center;
  margin-top: 10px;
  margin-bottom: 10px;
  border-top: 1px solid #dddddd;
}

/*适配移动端布局*/
@media only screen and (max-width: 601px) {
  .waterfall {
    column-count: 2;
    column-gap: 1em;
  }
}
```



-  在`themes\hexo-theme-matery\layout\`目录下新建 或者修改`galleries.ejs` 文件，替换为以下内容

- 该版本为添加了一言api的版本，如果不需要删除对应的代码就行

```js
<link rel="stylesheet" href="/css/gallery.css">

<%- partial('_partial/bg-cover') %>


<!-- 一言API -->
<!-- 现代写法，推荐 -->
<!-- 兼容低版本浏览器 (包括 IE)，可移除 -->
<script src="https://cdn.jsdelivr.net/npm/bluebird@3/js/browser/bluebird.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/whatwg-fetch@2.0.3/fetch.min.js"></script>
<!--End-->
<script>
    fetch('https://v1.hitokoto.cn?c=d&c=h&c=j')
      .then(function (res){
        return res.json();
      })
      .then(function (data) {
        var info = document.getElementById('info');
        var poem = document.getElementById('poem');
        poem.innerText = data.hitokoto;
        if (data.from_who==null){
            info.innerText = "《" + data.from + "》" 
        }
        else{
            info.innerText = "--" + data.from_who + "《" + data.from + "》" 
        }
      })
      .catch(function (err) {
        console.error(err);
      })
  </script>

<!-- 加入网易云音乐热门评论，实时更新 -->
<div class="poem-wrap">
    <div class="poem-border poem-left">
    </div>
    <div class="poem-border poem-right">
    </div>
    <h1>时光机</h1>
    <p id="poem">loading...</p>
    <p id="info">loading...</p>
    <!-- <p id="hitokoto">正在加载一言...</p> -->
</div>


<main class="content">
    <div class="container">
        <% if (site.data && site.data.galleries) { %>
        <% var galleries = site.data.galleries; %>
        <div class="gallery-wrapper row">
            <% for (var i = 0, len = galleries.length; i < len; i++) { %>
            <% var gallery = galleries[i]; %>
            <div class="col s6 m4 l4 xl3 gallery-box">
                <a href="./<%- gallery.name %>" class="gallery-item" data-aos="zoom-in-up">
                     <div class="gallery-cover-box" style="background-image: url(https://zhangtq-gallery.oss-cn-hangzhou.aliyuncs.com/cover/<%- gallery.cover%>);">
                    </div>
                    <p class="gallery-name">
                        <%- gallery.name %>
                    </p>
                </a>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
</main>


```



- 在`themes\hexo-theme-matery\layout\`下新建或者修改`gallery.ejs` 文件

```js
<link rel="stylesheet" href="/css/gallery.css">
<link type="text/css" href="/libs/fancybox/jquery.fancybox.css" rel="stylesheet">
<link type="text/css" href="/libs/justifiedGallery/justifiedGallery.min.css" rel="stylesheet">

<%- partial('_partial/post-cover') %>
<%
let galleries = [];
if (site.data && site.data.galleries) {
    galleries = site.data.galleries;
}
var pageTitle = page.title;
function getCurrentGallery(galleries, pageTitle) {
    for (let i = 0; i < galleries.length; i++) {
        if (galleries[i]['name'] == pageTitle) {
            return galleries[i];
        }
    }
}
var currentGallery = getCurrentGallery(galleries, pageTitle)

var photos = currentGallery.photos;

let imageStr = ''

for (var i = 0, len = photos.length; i < len; i++) {
    var photo = photos[i];

     imageStr += "<a href=\"https://zhangtq-gallery.oss-cn-hangzhou.aliyuncs.com/photo/" + photo + "\"" +
            "     class=\"photo-item\" rel=\"example_group\"" +
            "     data-fancybox=\"images\">" +
            "      <img src=\"https://zhangtq-gallery.oss-cn-hangzhou.aliyuncs.com/photo/" + photo + "\"" +
            "       alt=" + photo + ">\n" +
            "    </a>"

}
%>



<!-- 一言API -->
<!-- 现代写法，推荐 -->
<!-- 兼容低版本浏览器 (包括 IE)，可移除 -->
<script src="https://cdn.jsdelivr.net/npm/bluebird@3/js/browser/bluebird.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/whatwg-fetch@2.0.3/fetch.min.js"></script>
<!--End-->
<script>
    fetch('https://v1.hitokoto.cn?c=d&c=h&c=j')
      .then(function (res){
        return res.json();
      })
      .then(function (data) {
        var info = document.getElementById('info');
        var poem = document.getElementById('poem');
        poem.innerText = data.hitokoto;
        if (data.from_who==null){
            info.innerText = "《" + data.from + "》" 
        }
        else{
            info.innerText = "--" + data.from_who + "《" + data.from + "》" 
        }
      })
      .catch(function (err) {
        console.error(err);
      })
  </script>

<!-- 加入网易云音乐热门评论，实时更新 -->
<div class="poem-wrap">
    <div class="poem-border poem-left">
    </div>
    <div class="poem-border poem-right">
    </div>
    <h1>时光机</h1>
    <p id="poem">loading...</p>
    <p id="info">loading...</p>
    <!-- <p id="hitokoto">正在加载一言...</p> -->
</div>

<div class="container">
    <div class="photo-wrapper">
        <% if (page.password ) { %>

            <script src="/js/crypto-js.js"></script>
            <script src="/js/gallery-encrypt.js"></script>
            <div id="hbe-security">
                <div class="hbe-input-container">
                    <input type="password" class="hbe-form-control" id="pass"  placeholder="请输入密码查看内容"/>
                    <a href="javascript:;" class="btn-decrypt" id="btn_decrypt">解密</a>
                </div>
            </div>
            <div  id="mygallery">
                <div class="waterfall" id="encrypt-blog" style="display:none">
                    <%- aes(imageStr, page.password) %>
                </div>
            </div>
        <% } else { %>
            <div class="waterfall" id="encrypt-blog">
                <%- imageStr %>
            </div>
        <% } %>
    </div>
</div>

<script src="/libs/fancybox/fancybox.js"></script>
<script src="/libs/justifiedGallery/justifiedGallery.min.js"></script>
<script>

  $("a[rel=example_group]").fancybox();
  $("#encrypt-blog").justifiedGallery({margins: 5, rowHeight: 150});

</script>
```





- {%r%}
  需要几个文件，我把文件地址放在下面，用浏览器打开链接，就会显示出代码，然后复制粘贴到文加中去就行。开头的是文件路径，如果没有的话，就新建一个就 OK 了。
  {%endr%}

- `hemes\hexo-theme-matery\source\libs\fancybox\jquery.fancybox.css`

  https://cdn.jsdelivr.net/gh/Yafine/cdn@3.3.4/source/libs/fancybox/jquery.fancybox.css

- `themes\hexo-theme-matery\source\libs\fancybox\fancybox.js`

  https://cdn.jsdelivr.net/gh/Yafine/cdn@3.3.4/source/libs/fancybox/fancybox.js

- `themes\hexo-theme-matery\source\libs\justifiedGallery\justifiedGallery.min.css`

  https://cdn.jsdelivr.net/gh/Yafine/cdn@3.3.4/source/libs/justifiedGallery/justifiedGallery.min.css

- `themes\hexo-theme-matery\source\libs\justifiedGallery\justifiedGallery.min.js`

  https://cdn.jsdelivr.net/gh/Yafine/cdn@3.3.4/source/libs/justifiedGallery/justifiedGallery.min.js

- `hemes\hexo-theme-matery\source\js\crypto-js.js`

  https://cdn.jsdelivr.net/gh/Yafine/cdn@3.3.4/source/js/crypto-js.js

- `hemes\hexo-theme-matery\source\js\gallery-encrypt.js`

  https://cdn.jsdelivr.net/gh/Yafine/cdn@3.3.4/source/js/gallery-encrypt.js



> 链接有可能失效，这里提供压缩包下载
>
> [点击下载](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/gallery-css-js/gallery-css-js.zip)





## 相册加密

- 依赖于上面的的`crypto-js.js`和`gallery-encrypt.js`放到相同的目录下就可以

```shell
npm install --save hexo-blog-encrypt
npm install crypto-js
```



- `vi themes\hexo-theme-matery\_config.yml` 修改enable为True

```yaml
verifyPassword:
  enable: True
  promptMessage: 请输入访问本文章的密码
  errorMessage: 密码错误，将返回主页！
```



- 新建如下` themes\hexo-theme-matery\scripts\helpers\` 目录，如果目录不存在先新建目录
- 在encrypt.j文件中加入如下内容

```js
/* global hexo */
'use strict';
const CryptoJS = require('crypto-js');
hexo.extend.helper.register('aes', function(content,password){
  content = escape(content);
  content = CryptoJS.enc.Utf8.parse(content);
  content = CryptoJS.enc.Base64.stringify(content);
  content = CryptoJS.AES.encrypt(content, String(password)).toString();

  return content;
});
```





- 在`themes\hexo-theme-matery\source\css\` 的my.css中添加如下内容

```css
.hbe-input-container  .btn-decrypt{
  display: inline-block;
  vertical-align: top;
  width: 120px;
  height: 32px;
  line-height: 32px;
  font-size: 16px;
  color: #ffffff;
  background-color: #3f90ff;
  text-align: center;
  -webkit-border-radius: 3px;
  -moz-border-radius: 3px;
  border-radius: 3px;
}
```



- 至此，添加密码功能就实现了
- 在新建的 **[index.md](http://index.md/)** 文章内添加 **password**属性，后面写上你的密码即可，然后执行命令，查看本地效果即可***注意：密码需要经过sha256加密*， 这里提供加密网站[在线加密网站](http://www.ttmd5.com/hash.php)





## 一级菜单或二级菜单页面改成友链形式

- `themes\hexo-theme-matery\_config.yml` 这里以二级菜单书籍为例

```yaml
  Friends:
    url: /friends
    icon: fas fa-address-book
  # 二级菜单写法如下
  媒体:
    icon: fas fa-list
    children:
      - name: 相册
        url: /galleries
        icon: fas fa-image
      - name: 书籍
        url: /books
        icon: fas fa-book
```

- `vi themes\hexo-theme-matery\languages\zh-CN.yml` 添加如下内容
- 这一步相当于做了中英文对照，使页面下的大标题和菜单中文一致，如果不做的话，在页面上会直接显示books,而不是书籍

```yaml
books: 书籍 
```

- `hexo new page books`
- `vi source\books\index.md` 替换为如下内容

```json
---
title: books
date: 2022-11-27 20:53:29
type: "books"
layout: "books"
---

```

- 拷贝friends.ej文件作为books.ejs

```shell
cp themes\hexo-theme-matery\layout\friends.ejs themes\hexo-theme-matery\layout\books.ejs
```

- 修改books.ejs

```shell
vi themes\hexo-theme-matery\layout\books.ejs
```



- 打开 musics.ejs 文本内搜索 friends ，把它们改成 books，**注意定义的 class 和 id 内的不要改，只改变量**，更改目标为下图高亮部分

![image-20221128001429060](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221128001429060.png)



-  复制friends.json 文件为books.json

```yaml
cp source\_data\friends.json source\_data\books.json
```



- hexo g && hexo s
- 至此就会将页面改为友链样式，后续只需要在books.json中修改具体内容就可以了

## 自定义菜单下友链样式修改

- 修改缩略图边框为方形（大多图片是方形的，这样后续添加内容会更美观）
- 以下步骤其实就是找到你菜单详情页面的js文件，做出修改

```shell
vi themes\hexo-theme-matery\layout\books.ejs
```



- 这个属性是控制弯曲度的

```js
.frind-ship img {
	border-radius: 15px;
}
```



- 修改高度，还是上面这个文件,由于我后来对卡片内容做了调整，后来值有所变化，按需修改width和height值就可以了

```js
.frind-ship .title img {
	width: 100px;
	height: 167px;
	flex-shrink: 0;
}
```



- 增加显示卡片内容
- 先看效果图

![image-20221128002626121](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221128002626121.png)



- 还是上面的文件,大约210行附近，这块的内容可以自定以，注意取值和json 文件的字段相同就行

```js
                                    <div class="title">
                                        <img src="<%- url_for(friend.avatar) %>" alt="img">
                                        <div>
                                            <h5><%= friend.name %></h5>
                                            <h5><%= friend.type %></h5>
                                            <h5><%= friend.recommendation %></h5>
                                            <!-- <h5><%= friend.process %></h5> -->
                                        </div>
                                    </div>
```



- 修改books.json文件



```json
[
    {
    "avatar": "https://zhangtq-gallery.oss-cn-hangzhou.aliyuncs.com/fenmian/s34144077.jpg",
    "name": "深入理解分布式系统",
	"type": "科技/互联网",
	"recommendation": "★★★★",
	"process": "在看ing",
    "url": "https://book.douban.com/subject/35794814/",
    "title": "了解书籍"
}, {
    "avatar": "https://zhangtq-gallery.oss-cn-hangzhou.aliyuncs.com/fenmian/s29434304.jpg",
    "name": "流畅的Python",
    "type": "互联网/编程",
	"recommendation": "★★★★",
	"process": "在看ing",
    "url": "https://book.douban.com/subject/27028517/",
    "title": "了解书籍"    
}, {
    "avatar": "https://zhangtq-gallery.oss-cn-hangzhou.aliyuncs.com/fenmian/s33964410.jpg",
    "name": "Go语言底层原理剖析",
	"type": "互联网/编程",
	"recommendation": "★★★★★",
	"process": "已看完(2020/9/22)",
    "url": "https://book.douban.com/subject/35556889/",
    "title": "了解书籍"
}
]
```



- 一级菜单和二级菜单的改法相同，只是在_config.yaml里配置的menu 不一致罢了

```yaml
  Friends:
    url: /friends
    icon: fas fa-address-book
  # 二级菜单写法如下
  媒体:
    icon: fas fa-list
    children:
      - name: 相册
        url: /galleries
        icon: fas fa-image
      - name: 书籍
        url: /books
        icon: fas fa-book
```





```yaml
  # 一级菜单写法如下
  Friends:
    url: /friends
    icon: fas fa-address-book
  书籍：
  url: /books
  icon: fas fa-book
```



- 注意头像链接，可以下载下来放到自己的图床上比如oss ，防止不能访问，目前豆瓣的头像会有限制

# hexo+ typora+ oss 最佳实践



{%r%}
不推荐通过方式一下载插件的方式来显示图片，这里会提供方法但是强烈建议使用方式二
{%endr%}



### 方式一

-  修改博客根目录中`_config.yml`文件的配置项`post_asset_folder`为`true`：
- 完成此设置后，当你通过`hexo new 文件名`新建博客后，会产生一个和文件同名的文件夹。
- 下载插件 npm install https://github.com/CodeFalling/hexo-asset-image --save
- 当文章需要添加图片时，将需要添加的图片放入同名的文件夹中，同时通过相对路径索引到该图片
- 在typora中设置： 文件-->偏好设置-->图像





![1587393533151](https://www.freesion.com/images/433/1b1e2e6531d46b4b8c32e82084e30819.png)



- 以后直接粘贴图片就可以自动保存到 hexo 配置的 post_asset_folder 文件夹里,自动渲染了
- 直接渲染时会发现显示不了，此时需要在typora中将图片路径前的文件目录去除
- 可以通过typor中批量替换的方式，但是替换后在typora中又不能显示了，网页显示正常

### 方式二通过阿里云oss图床



- 阿里云的操作就不再这里详谈了，有一点注意的使创建bucket后需要将buckeet改为公开
- 配置typora： 文件-->偏好设置



- ![image-20221126194736863](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221126194736863.png)

- 在进行第五步打开配置文件添加如下内容

```json
{
  "picBed": {
    "uploader": "aliyun",
    "aliyun": {
      "accessKeyId": "****",
      "accessKeySecret": "*****",
      "bucket": "zhangtq-blog",//换成你自己的Bucket名称
      "area": "oss-cn-hangzhou",//OSS概览里的EndPoint(地域节点)，“.”前面的内容
      "path": "content_picture/",//Bucket下的文件夹，没有可以不写，默认不要文件夹
      "customUrl": "https://*******.aliyuncs.com",//OSS概览里的Bucket域名(开头加上https://)
      "options": ""//可以不写
    }
  },
  "picgoPlugins": {
  }
}
```



-  至此，每次我们复制图片到typora中后，都会自动上传至oss，同时在md文件中自动引用url

> 最开是博主是按照大多数人一样，通过在根目录下设置post_asset_folder: true，这样每次hexo new 文件名后会产生一个同名的文件夹

