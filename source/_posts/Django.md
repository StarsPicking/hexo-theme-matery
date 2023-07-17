---
title: Django
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: 你的分类
tags:
  - 你的标签
abbrlink: 28675
date: 2023-06-25 11:04:41
img:
coverImg:
summary:
---

# django

## web服务器

### web框架本质

- 对于所有的Web应用，本质上其实就是一个socket服务端，用户的浏览器其实就是一个socket客户端。
- 真实web框架一般会分为两部分：服务器程序和应用程序。
  - 1）服务器程序：负责对socket服务器进行封装，并在请求到来时，对请求的各种数据进行整理
  - 2）应用程序：负责具体的逻辑处理



### socket创建web服务

```python
import socket

def handle_request(client):
    buf = client.recv(1024)
    client.send("HTTP/1.1 200 OK\r\n\r\n".encode('utf-8'))      # 伪造浏览器请求头
    client.send("Hello, Seven".encode('utf-8'))                  # 返回数据到客户端浏览器

def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.bind(('localhost', 8000))
    sock.listen(5)
    while True:
        connection, address = sock.accept()
        handle_request(connection)
        connection.close()

if __name__ == '__main__':
    main()
```




![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210214201207490.565a7d72.png)



## django框架

### django、tornado、flask框架比较

- django: 重量级web服务器，包含了web开发中常用的功能、组件的框架；ORM、Session、Form、Admin、分页、中间件、信号、缓存....）；
- Flask: 封装功能不及Django完善，性能不及Tornado，但是Flask的第三方开源组件比丰富；
- Tornado: 最大特性就是异步非阻塞、原生支持WebSocket协议；

- `以 京东、淘宝、楼下小卖部 比喻`

  - `django就像京东`，服务齐全，有自营商品，有自己的仓库，有自己的快递，一条龙服务，你懂的
  - `flask就像是淘宝`，自己没有商品，没有仓库，没有快递，但是你可以选择三方的（韵达，中通等）
  - `tornado就像是门口小卖部`，一个特点，快，不用等，但是东西很少，没有三方组件，需要自己动手写

  

- 使用参考

  - 1）小型web应用设计的功能点不多，使用Flask比较合适；
  - 2）大型web应用设计的功能点比较多，使用的组件也会比较多，使用Django（自带功能多不用去找插件）；
  - 3）如果追求性能可以考虑Tornado

### MVC模式

- M全拼为Model，主要封装对数据库层的访问，对数据库中的数据进行增、删、改、查操作。
- V全拼为View，用于封装结果，生成页面展示的html内容。
- C全拼为Controller，用于接收请求，处理业务逻辑，与Model和View交互，返回结果。

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210214204226395.a9789c36.png)



### MVT(Django设计模式)

- M全拼为Model，与MVC中的M功能相同，负责和数据库交互，进行数据处理。
- V全拼为View，与MVC中的C功能相同，接收请求，进行业务处理，返回应答。
- T全拼为Template，与MVC中的V功能相同，负责封装构造要返回的html(`或者是json数据`)。

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210214204504660.47273228.png)

```python
source ~/.bashrc                                        # 执行virtualenvwrapper安装脚本
```



## 环境安装



### virtualenvwrapper使用

```python
mkvirtualenv test1                  # 创建虚拟环境
mkvirtualenv test2env -p python3
lsvirtualenv                       # 查看虚拟环境 
workon  test1                      # 进入虚拟环境
deactivate                         # 退出虚拟环境 
rmvirtualenv test1                   # 删除虚拟环境 
pip list                           # 查看虚拟环境下的安装包 
```



### 使用复习

```shell
pip
pip install # 安装依赖包
pip uninstall # 卸载依赖包
pip list # 查看已经安装的依赖包
pip freeze > requirements.txt  # 导出依赖包
pip install -r requirements.txt # 从文件安装依赖包
```



## django安装



### 创建虚拟环境

```shell
mkvirtualenv  djenv      # 创建虚拟环境 djenv
workon djenv           # 进入虚拟环境
pip list             # 可以看到，当前python环境和系统安装的python环境不同
```



### 安装Django 2.0.4

```python
pip install django==2.0.4
```



###  安装慢修改pip源

- 打开我的电脑在地址栏里输入：`%APPDATA%` 后回车，然后就进入了C:\Users\Lenovo\AppData\Roaming 这个路劲里面
- 添加文件： `C:\Users\Lenovo\AppData\Roaming \pip\pip.ini`文件，写一下内容

```python
[global]
timeout = 6000
index-url = http://pypi.douban.com/simple
trusted-host = pypi.douban.com
```

## 创建django项目

###  创建django项目

```python
(djenv) c:\tmp>workon djenv                         ## 进入虚拟环境
(djenv) c:\tmp>django-admin startproject mysite           ## 创建django项目
(djenv) c:\tmp>cd mysite                           ## 进入项目目录
D:\mysite>  python manage.py runserver 127.0.0.1:8000       ## 运行mysite项目
## 浏览器访问：http://127.0.0.1:8000/
```



![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210214212742257.d60e0a8a.png)

####  工程目录说明

```python
C:.
│  db.sqlite3                ## sqlite数据库文件（settings.py中默认连接的数据库）
│  manage.py                ## 项目管理脚本
│
└─mysite
    │  settings.py           ## 是项目的整体配置文件
    │  urls.py              ## 总路由
    │  wsgi.py              ## 是项目与WSGI兼容的Web服务器入口
    │  __init__.py
```



#### 运行开发服务器



- 在开发阶段，为了能够快速预览到开发的效果
- django提供了一个纯python编写的轻量级web服务器，仅在开发阶段使用。
- 可以不写IP和端口，默认IP是127.0.0.1，默认端口为8000

```python
python manage.py runserver ip:端口
或：
python manage.py runserver
```

####  配置setting.py

##### 配置模板路径



```python
TEMPLATES = [
    {
       'DIRS': [os.path.join(BASE_DIR,'templates')],
    },
]
```

##### 配置静态目录



```python
#像ccs和js这些静态文件如果想要使用必须在这里配置路径
STATICFILES_DIRS = (
    os.path.join(BASE_DIR,'static'),
)
```

##### 注释CSRF



```python
MIDDLEWARE = [
    ## 'django.middleware.csrf.CsrfViewMiddleware',
]
```

##### 修改时区



```python
## LANGUAGE_CODE = 'en-us'
LANGUAGE_CODE = 'zh-hans'

## TIME_ZONE = 'UTC'
TIME_ZONE = 'Asia/Shanghai'
```



### 创建子应用三部曲

####  创建子应用

```python
(djenv) c:\tmp\mysite>  python manage.py startapp app01
```



```python
C:.
│  db.sqlite3               ## sqlite数据库文件（settings.py中默认连接的数据库）
│  manage.py               ## 项目管理脚本
│
├─app01 （子应用目录）
│  │  admin.py            ## 配置django admin后台
│  │  apps.py
│  │  models.py            ## 配置django表，负责和数据库交互，进行数据处理
│  │  tests.py
│  │  views.py             ## 接收请求，进行业务处理，返回应答
│  │  __init__.py
│  │
│  └─migrations
│          __init__.py
│
└─mysite
    │  settings.py           ## 是项目的整体配置文件
    │  urls.py              ## 总路由
    │  wsgi.py              ## 是项目与WSGI兼容的Web服务器入口
    │  __init__.py
```



#### 注册子应用



```python
INSTALLED_APPS = [
    'app01.apps.App01Config',
]
```



#### 配置主路由



- `mysite\urls.py`

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    # 配置路由分发
    path('app01/', include(('app01.urls', 'app01'), namespace='app01')),
]
```

####  添加子路由



- `app01/urls.py`

```python
from django.urls import path, re_path
from app01 import views

urlpatterns = [
    re_path(r'index1/$', views.index1, name='index1'),
]
```



#### 创建视图



- `app01/views.py`

```python
from django.shortcuts import render, HttpResponse

def index1(request):
    return HttpResponse("Hello World")
```

### PyCharm打开项目

#### 添加虚拟环境



- 文件 –》 设置 –》项目:mysite –》 python解释器

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210214215013077.a3eebe26.png)

#### 添加解释器



![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210214215125468.85c3521f.png)



### 配置跨域



```python
1. 安装包
pip install django-cors-headers 

2. 注册应用
INSTALLED_APPS = [
    ...
    'corsheaders',   # 添加 django-cors-headers 使其可以进行 cors 跨域
]
3. 添加中间件
MIDDLEWARE = [
    # 放在中间件第一个
    'corsheaders.middleware.CorsMiddleware',
    ...
]
4. 设置
# CORS跨域请求白名单设置
CORS_ORIGIN_WHITELIST = (
    'http://127.0.0.1:8080',
    'http://localhost:8080',
)
CORS_ALLOW_CREDENTIALS = True  # 允许携带cookie
```


## 路由配置



### Django路由分发



- `mysite/urls.py`

```python
# mysite/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    # 配置路由分发
    path('app01/', include(('app01.urls', 'app01'), namespace='app01')),
]
```

### 普通url



#### app01/urls.py





```python
from django.urls import path, re_path
from app01 import views

urlpatterns = [
    re_path('index1/$', views.index1, name='indexname1'),          # 方法1：无正则匹配url
]


```

#### app01/views.py



```python
from django.shortcuts import HttpResponse

# 方法1：无正则匹配url（ http://127.0.0.1:8000/index1/?uid=1 ）
def index1(request):
    print( request.GET )             # {"uid": "1"}
    nid = request.GET.get('uid')    # 1
    return HttpResponse('无正则匹配url')
```



### 正则的url `(\d+)`

#### app01/urls.py



- http://127.0.0.1:8000/app01/index1/

```python
from django.urls import path, re_path
from app01 import views

urlpatterns = [
    re_path('index2/(\d+)/$', views.index2, name='indexname2'),     # 方法2：基于(\d+)正则的url
]
```



#### app01/views.py



- http://127.0.0.1:8000/app01/index2/1/

```python
from django.shortcuts import HttpResponse

# 方法2：基于(\d+)正则的url（  http://127.0.0.1:8000/index2/1/  ）
def index2(request, uid):
    print( uid )                    # 1
    return HttpResponse('基于(\d+)正则的url')
```



###  正则分组`(?P<nid>\d+)`



- 基于正则分组`(?P<nid>\d+)`，可以不考虑接收参数顺序 (推荐)

##### app01/urls.py



- http://127.0.0.1:8000/app01/index3/1/2/

```python
from django.urls import path, re_path
from app01 import views

urlpatterns = [
    re_path('index3/(?P<nid>\d+)/(?P<pid>\d+)/$', views.index3, name='indexname3'),        # 方法3：基于(\d+)正则的url
]
```



#### app01/views.py



```python
from django.shortcuts import HttpResponse

# 方法3：基于正则分组(?P<nid>\d+)（  http://127.0.0.1:8000/app01/index3/1/2/  ）
def index3(request, nid, pid):
    print(nid)                     # 1
    print(pid)                     # 2
    return HttpResponse('基于正则分组url')
```



### 使用name构建自己想要的url

#### app01/urls.py



- http://127.0.0.1:8000/app01/index3/1/2/

```python
from django.urls import path, re_path
from app01 import views

urlpatterns = [
    re_path('index4/$', views.index4),                               # 方法4：使用name构建自己想要的url
]
```



#### app01/views.py



```python
from django.shortcuts import HttpResponse
from django.urls import reverse

# 方法4：使用name构建自己想要的url （http://127.0.0.1:8000/index4/）
def index4(request):
    url1 = reverse('indexname1')                         # /index1/
    url2 = reverse('indexname2', args=(1,))                  # /index2/1/2/
    url3 = reverse('indexname3', kwargs={'pid': 1, "nid":2})       # /index3/1/2/
    return render(request, 'index.html')
```

#### 反解出url中的name



- 根据request.path中的绝对路径反解出url中的name名字

```python
resolve_url_obj = resolve(request.path)         # request.path路径： /student/homework_detail/52
resolve_url_obj.url_name                   # 从path中解析出url名字 url_name = homework_detail
```



## 请求与响应

### 请求request

#### 常见request内容

```python
# 1、request.POST         # 获取post请求数据
# 2、request.GET          # 获取get请求
# 3、request.FILES        # 获取文件
# 4、request.getlist       # 获取表达中列表
# 5、request.method        # 获取请求方式 get/post
# 6、request.path_info      #获取当前url
# 7、request.body          #自己获取请求体数据
```

#### `app01/views.py`



```python
def login(request):
    if request.method == 'GET':
        return render(request,'data.html')
    elif request.method == 'POST':
        v = request.POST.get('gender')      #1 获取单选框的value值
        v = request.POST.getlist('favor')   #2 获取多选框value：['11', '22', '33']
        v = request.POST.getlist('city')    #3 获取多选下拉菜单：['bj', 'sh', 'gz']
        print(v.name,type(v))


        #当服务器端取客户端发送来的数据，不会将数据一下拿过来而是一点点取(chunks就是文件分成的块)
        
        obj = request.FILES.get('fff')      #4 下面是获取客户端上传的文件（如：图片）
        import os
        file_path = os.path.join('upload',obj.name)
        f = open(file_path,mode='wb')
        for i in obj.chunks():
            f.write(i)
        f.close()

        return render(request,'login.html')
```

#### data.html

```html
<form action="/login/" method="post" enctype="multipart/form-data">
    <p>
        <input type="text" name="user" placeholder="用户名">
    </p>
    
    {# 1、单选框，返回单条数据的列表 #}
    <p>     
        男：<input type="radio" name="gender" value="1">
        女：<input type="radio" name="gender" value="2">
        人妖：<input type="radio" name="gender" value="3">
    </p>

    {# 2、多选框、返回多条数据列表 #}
    <p>     
        男：<input type="checkbox" name="favor" value="11">
        女：<input type="checkbox" name="favor" value="22">
        张扬：<input type="checkbox" name="favor" value="33">
    </p>

    {# 3、多选，返回多条数据的列表 #}
    <p>     
        <select name="city" multiple>
            <option value="bj">北京</option>
            <option value="sh">上海</option>
            <option value="gz">广州</option>
        </select>
    </p>

    {# 4、提交文件 #}
    <p><input type="file" name="fff"></p>
    <input type="submit" value="提交">
</form>
```



### 响应

#### HttpResponse



- 需要手动将字符串转化成json字符串并相应到前端
- 传到到前端的是json字符串，还需要手动进行转化

```python
import json
from django.http import HttpResponse

def testResponse(request):
    data={
        'name':'zhangsan',
        'age':18,
    }
    # 默认格式：content_type="text/plain"
    return HttpResponse(json.dumps(data), content_type="application/json")
    # return HttpResponse(json.dumps(data), content_type="text/plain")
```



####  JsonResponse



- JsonResponse继承HttpResponse
- 数据类型装自动换成json字符串并相应到前端，传到前端的是数据类型而非json字符串

```python
import json
from django.http import JsonResponse

def testResponse(request):
    data={
        'name':'张三',
        'age':18,
    }
    return JsonResponse(data=data)
```



####  Response



- 是Django rest-framework框架中封装好的响应对象
- 但是只能在继承于rest-framework的APIView的视图类中使用. 比较推荐.
- 安装：`pip install djangorestframework==3.9.2`

```python
from rest_framework.views import APIView

class TestResponse(APIView):
    def get(self,request,*args,**kwargs):
        data = {
            'name': '张三',
            'age': 18,
        }
        return Response({'name': 'zhangsan'})
```

#### render



- 返回html页面

```python
def index(request):
    return render(request, 'index.html',{'users':['zhangsan','lisi','wangwu']})
```



#### redirect



- 重定向到新的页面

```python
return redirect('https://www.baidu.com')
```



## 类视图

### 类视图



#### 函数视图弊端



- 以函数的方式定义的视图称为**函数视图**，函数视图便于理解。
- 但是遇到一个视图对应的路径提供了多种不同HTTP请求方式的支持时
- 便需要在一个函数中编写不同的业务逻辑，代码可读性与复用性都不佳。

```python
 def register(request):
    """处理注册"""

    # 获取请求方法，判断是GET/POST请求
    if request.method == 'GET':
        # 处理GET请求，返回注册页面
        return render(request, 'register.html')
    else:
        # 处理POST请求，实现注册逻辑
        return HttpResponse('这里实现注册逻辑')
```



#### 类视图引入



- 在Django中也可以使用类来定义一个视图，称为**类视图**。
- 使用类视图可以将视图对应的不同请求方式以类中的不同方法来区别定义。
- `类视图的好处`
  - 1）**代码可读性好**
  - 2）**类视图相对于函数视图有更高的复用性**， 如果其他地方需要用到某个类视图的某个特定逻辑，直接继承该类视图即可
- `类视图原理`
  - 1）调用流程 as_view-->view-->dispatch
  - 2）getattr('对象','字符串')

```python
from django.views import View

class RegisterView(View):
    """类视图：处理注册"""

    def get(self, request):
        """处理GET请求，返回注册页面"""
        return JsonResponse({"name":"zhangsan"})

    def post(self, request):
        """处理POST请求，实现注册逻辑"""
        return JsonResponse({"name":"zhangsan"})
```





### 类视图添加装饰器

1、 dispatch是父类中用来反射的函数，找对应的函数（比对应函数先执行）

- 2、 比如你发送post请求就可以通过dispatch找到对应的post函数进行处理，get就会找到get函数处理
- `添加路由`

```python
from django.urls import path, re_path
from app01 import views

urlpatterns = [
    re_path('home/', views.Home.as_view()),
]
```



#### 定义一个装饰器



```python
def my_decorator(func):
    def wrapper(request, *args, **kwargs):
        print('自定义装饰器被调用了')
        print('请求路径%s' % request.path)
        return func(request, *args, **kwargs)
    return wrapper
```

#### 为特定请求方法添加装饰器



- 在类视图中使用为函数视图准备的装饰器时，不能直接添加装饰器
- 需要使用**method_decorator**将其转换为适用于类视图方法的装饰器。
- **method_decorator装饰器使用name参数指明被装饰的方法**

```python
from django.shortcuts import HttpResponse
from django.views import View
from django.utils.decorators import method_decorator

# 为全部请求方法添加装饰器
@method_decorator(my_decorator, name='dispatch')
class DemoView(View):
    def get(self, request):
        print('get方法')
        return HttpResponse('ok')

    def post(self, request):
        print('post方法')
        return HttpResponse('ok')

# 只给get请求添加装饰器
@method_decorator(my_decorator, name='get')
class DemoView(View):
    def get(self, request):
        print('get方法')
        return HttpResponse('ok')

    def post(self, request):
        print('post方法')
        return HttpResponse('ok')
```



#### 为特定请求方法添加装饰器

```python
from django.shortcuts import HttpResponse
from django.views import View
from django.utils.decorators import method_decorator

# 为特定请求方法添加装饰器
class DemoView(View):

    @method_decorator(my_decorator)  # 为get方法添加了装饰器
    def get(self, request):
        print('get方法')
        return HttpResponse('ok')

    @method_decorator(my_decorator)  # 为post方法添加了装饰器
    def post(self, request):
        print('post方法')
        return HttpResponse('ok')

    def put(self, request):  # 没有为put方法添加装饰器
        print('put方法')
        return HttpResponse('ok')
```



### 类视图Mixin扩展类



- 使用面向对象多继承的特性，可以通过定义父类（作为扩展类）
- 在父类中定义想要向类视图补充的方法，类视图继承这些扩展父类，便可实现代码复用。
- 定义的扩展父类名称通常以Mixin结尾。

```python
class ListModelMixin(object):
    """
    list扩展类
    """
    def list(self, request, *args, **kwargs):
        ...

class CreateModelMixin(object):
    """
    create扩展类
    """
    def create(self, request, *args, **kwargs):
        ...

class BooksView(CreateModelMixin, ListModelMixin, View):
    """
    同时继承两个扩展类，复用list和create方法
    """
    def get(self, request):
        self.list(request)
        ...

    def post(self, request):
        self.create(request)
        ...
```



## 中间件



### 初识中间件



####  什么是中间件

- Django中间件是修改 Django request 或者 response 对象的钩子
- 可以理解为是介于 HttpRequest 与 HttpResponse 处理之间的一道处理过程。
- Django中间件作用：
  - 修改请求，即传送到 view 中的 HttpRequest 对象。
  - 修改响应，即 view 返回的 HttpResponse 对象。

####  中间件处理过程

- 1、首先客户端发起请求，会将请求交给settings.py中排在最前面的中间件
- 2、前面中间件收到请求会调用类中的process_request方法处理，然后交给下一个中间件的process_request函数
- 3、到达最后一个中间件的process_request函数处理后会到达url路由系统
- 4、然后从路由系统直接跳转到第一个中间件的process_view函数，依次向后面中间的process_view传递
  - 最后到达views.py处理函数，获取网页中的数据
- 5、获取的数据会交给最后一个中间件的process_response方法处理，然后依次向前面的中间件process_response
  - 方法提交请求的内容，最后由最前面的中间件将请求数据返回到客户端
- 6、在任一中间件的process_request和process_view方法中有返回值就会直接返回给process_response

#### 生命周期图解

- 1、首先会交给中间件，中间件处理后交给路由系统
- 2、路由系统
  - 1：Django程序会到urls.py文件中找到对应请求的处理函数（视图函数）
- 3、视图函数
  - 1：视图函数会找到对应的html模板文件
  - 2：然后到数据库中取得数据替换html模板中的内容
  - 3：使用static中的js和css文件结合对html渲染
  - 4：最后Django将最终渲染后的html文件返回给中间件
- 4、中间件再调用process_response方法处理，最后交给用户

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210215211340365.9fe90a86.png)

### .中间件使用

####  创建存放中间件的文件夹

- 1. 在工程目录下创建任意目录，这里创建路径为： `/project/middle/m1.py`

#### settings.py中注册中间件

```text
MIDDLEWARE = [
    'middle.m1.Row1',
    'middle.m1.Row2',
    'middle.m1.Row3',
]
```



####  写处理函数test

- 在views.py文件中写处理函数test

```text
def test(request):
    # int('fds')    #当views函数出现异常，中间件中的process_exception执行
    print('没带钱|')
    return HttpResponse('ok')
```



#### 定义中间件

- 在/project/middle/m1.py文件中定义中间件

```python
from django.utils.deprecation import MiddlewareMixin

class Row1(MiddlewareMixin):
    def process_request(self,request):
        print('process_request_1')

    def process_view(self,request, view_func, view_func_args, view_func_kwargs):
        #view_func_args:   url中传递的非字典的值会用这个变量接收
        #view_func_kwargs: url中传递的字典会传递到这个变量接收（如：nid=1）
        print('process_view_1')

    def process_response(self,request, response):    #response就是拿到的返回信息
        print('response_1')
        return response

    def process_exception(self, request, exception):
        '''只有当views函数中异常这个函数才会执行'''
        if isinstance(exception, ValueError):
            return HttpResponse('>>出现异常了')

        
class Row2(MiddlewareMixin):
    def process_request(self,request):
        print('process_request_2')
        #1 如果在Row2中的process_request中有返回值，那么就不会到达Row3
        #2 Row2直接将返回值交给自己的process_response再交给Row1的process_response
        #3 最后客户端页面显示的就是‘走’请求没机会到达views函数，不会打印‘没带钱’
        # return HttpResponse('走')

    def process_view(self,request, view_func, view_func_args, view_func_kwargs):
        print('process_view_2')

    def process_response(self,request, response):
        print('response_2')
        return response

    
class Row3(MiddlewareMixin):
    def process_request(self,request):
        print('process_request_3')

    def process_view(self,request, view_func, view_func_args, view_func_kwargs):
        print('process_view_3')

    def process_response(self,request, response):
        print('response_3')
        return response
```





## cookie

### cookie



####  cookie简介

- 1.cookie实质就是客户端硬盘中存放的键值对，利用这个特性可以用来做用户验证
- 2.比如：{“username”: “dachengzi”} #再次访问url就会携带这些信息过来

#### 前端操作cookie

- 说明： 使用下面方法操cookie必须先引入jquery.cookie.js
- 1. 前端获取cookie值： **var v = $.cookie**('per_page_count');
- 1. 前端设置cookie值： **$.cookie**('per_page_count',v);

#### 后端操作cookie

- 说明： response = HttpResponse(...) 或 response ＝ render(request, ...)
- 1. 后端设置cookie值： **response.set_cookie**('username',"zhangsan")
- 1. 后端后去cookie值： **request.COOKIES.get**('username')

####  设置cookie时常用参数

```python
def cookie(request):
    #1 获取cookie中username111得值
    request.COOKIES.get('username111')

    #2 设置cookie的值，关闭浏览器失效
    response.set_cookie('key',"value")
    # 设置cookie, N秒只后失效
    response.set_cookie('username111',"value",max_age=10)

    #3 设置cookie, 截止时间失效（expires后面指定那个时间点失效）
    import datetime
    current_date = datetime.datetime.utcnow()
    exp_date = current_date + datetime.timedelta(seconds=5)         #seconds指定再过多少秒过期
    response.set_cookie('username111',"value",expires=exp_date)

    #4 设置cookie是可以使用关键字salt对cookie加密（加密解密的salt中值必须相同）
    obj = HttpResponse('s')

    obj.set_signed_cookie('username',"kangbazi",salt="asdfasdf")
    request.get_signed_cookie('username',salt="asdfasdf")

    #5 设置cookie生效路径
    path = '/'

    #6 删除cookie中is_login的值
    response.delete_cookie('is_login')
    return response
```



### **使用cookie实现用户登录、注销**

####  views.py

```python
from django.shortcuts import render,HttpResponse,redirect

def index(request):
    username = request.COOKIES.get('username')        # 获取cookie
    if not username:
        return redirect('/login/')
    return HttpResponse(username)

def login(request):
    if request.method == "GET":
        return render(request,'login.html')
    if request.method == "POST":
        u = request.POST.get('username')
        p = request.POST.get('pwd')
        if u == 'tom' and p == '123':
            res = redirect('/index/')
            res.set_cookie('username',u,max_age=500)        # 设置500s免登陆
            return res
        else:
            return render(request,'login.html')

def logout(req):
    response = redirect('/login/')
    #清理cookie里保存username
    response.delete_cookie('username')
    return response
```

####  login.html

```text
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <form action="/login/" method="POST">
        <input type="text" name="username" placeholder="用户名">
        <input type="text" name="pwd" placeholder="密码">
        <input type="submit" value="提交">
    </form>
</body>
</html>
```



### CSRF原理

- 1、当用户第一次发送get请求时，服务端不仅给客户端返回get内容，而且中间包含一个随机字符串
- 2、这个字符串是加密的，只有服务端自己可以反解
- 3、当客户端发送POST请求提交数据时，服务端会验证客户端是否携带这个随机字符串, 没有就会引发csrf错误
- 4、如果没有csrf，那么黑客可以通过任意表单向我们的后台提交数据，不安全



## session

### Session

####  原理

```
session操作依赖cookie
```

- 1.基于Cookie做用户验证时：敏感信息不适合放在cookie中
- 2.用户成功登陆后服务端会生成一个随机字符串并将这个字符串作为字典key，将用户登录信息作为value
- 3.当用户再次登陆时就会带着这个随机字符串过来，就不必再输入用户名和密码了
- 4.用户使用cookie将这个随机字符串保存到客户端本地，当用户再来时携带这个随机字符串
  - 服务端根据这个随机字符串查找对应的session中的值，这样就避免敏感信息泄露

####  Cookie和Session对比

- 1、Cookie是保存在用户浏览器端的键值对
- 2、Session是保存在服务器端的键值对

####  setting.py配置session

- 公用配置

```python
# 1、SESSION_COOKIE_NAME ＝ "sessionid"          # Session的cookie保存在浏览器上时的key，即：sessionid＝随机字符串（默认）
# 2、SESSION_COOKIE_PATH ＝ "/"                  # Session的cookie保存的路径（默认）
# 3、SESSION_COOKIE_DOMAIN = None                # Session的cookie保存的域名（默认）
# 4、SESSION_COOKIE_SECURE = False               # 是否Https传输cookie（默认）
# 5、SESSION_COOKIE_HTTPONLY = True              # 是否Session的cookie只支持http传输（默认）
# 6、SESSION_COOKIE_AGE = 1209600                # Session的cookie失效日期（2周）（默认）
# 7、SESSION_EXPIRE_AT_BROWSER_CLOSE = False     # 是否关闭浏览器使得Session过期（默认）
# 8、SESSION_SAVE_EVERY_REQUEST = False          # 是否每次请求都保存Session，默认修改之后才保存（默认）
                                                 # 10s 免登陆时，这里必须配置成True
```



- settings.py中配置使用session五种方法

```python
#1 数据库（默认）   #将session数据保存到数据库中
SESSION_ENGINE = 'django.contrib.sessions.backends.db'

#2 缓存             #将session数据保存到缓存中
# 使用的缓存别名（默认内存缓存，也可以是memcache），此处别名依赖缓存的设置
# 'default'是下面链接的缓存别名，也可以是另一缓存名'db1'
SESSION_ENGINE = 'django.contrib.sessions.backends.cache'
SESSION_CACHE_ALIAS = 'default'
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': [
            '172.19.26.240:11211',
            '172.19.26.242:11211',
        ]
    },
    'db1': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': [
            '172.19.26.240:11211',
            '172.19.26.242:11211',
        ]
    },
}

#3 文件Session
# 缓存文件路径，如果为None，则使用tempfile模块获取一个临时地址tempfile.gettempdir()
# 如：/var/folders/d3/j9tj0gz93dg06bmwxmhh6_xm0000gn/T把他当做session目录
SESSION_ENGINE = 'django.contrib.sessions.backends.file'
SESSION_FILE_PATH = os.path.join(BASE_DIR,'cache')          #保存session的文件夹目录

#4 缓存+数据库Session        #默认到缓存中拿session数据，没有再到数据库中取
SESSION_ENGINE = 'django.contrib.sessions.backends.cached_db'

#5 加密cookie Session        #其实质使用的是cookie，将数据放到了客户端，但是数据经过了加密
SESSION_ENGINE = 'django.contrib.sessions.backends.signed_cookies'
```

####  操作session

```python
def index11(request):                #request.session中存放了所有用户信息
    #1 获取   Session中数据
    request.session['k1']
    request.session.get('k1',None)
    
    #2 设置
    request.session['k1'] = 123
    request.session.setdefault('k1',123)    # 存在则不设置
    
    #3 删除
    del request.session['k1']               #删除某个键值对
    #删除某用户登录时在数据库生成的随机字符串的整条数据全部删除
    request.session.delete("session_key")
    
    #4 注销  当用户注销时使用request.session.clear()
    request.session.clear()         #这个短句相当于下面这个长句
    request.session.delete(request.session.session_key)
    
    #5 设置超时时间（默认超时时间两周）
    request.session.set_expiry("value")
    # 如果value是个整数，session会在些秒数后失效。
    # 如果value是个datatime或timedelta，session就会在这个时间后失效。
    # 如果value是0,用户关闭浏览器session就会失效。
    # 如果value是None,session会依赖全局session失效策略。
    
    # 所有 键、值、键值对
    request.session.keys()
    request.session.values()
    request.session.items()
    request.session.iterkeys()
    request.session.itervalues()
    request.session.iteritems()
    
    # 获取某个用户session的随机字符串（不常用）
    request.session.session_key
    
    # 将所有Session失效日期小于当前日期的数据删除（数据库中可以设置超时时间）
    request.session.clear_expired()
    
    # 检查 用户session的随机字符串 在数据库中是否存在（不常用）
    request.session.exists("session_key")
```



### session登录和注销

- `session实现用户十秒免登陆，以及注销功能`

#### 主要功能说明

- 1.session默认使用数据库session，使用前必须先执行下面命令
  - python manage.py makemigrations
  - python manage.py migrate
- 2.settings.py中配置每次用户访问都会推辞更新时间
  - SESSION_SAVE_EVERY_REQUEST = True
- 3.实现10s免登陆关键步骤
  - 1）设置session ： request.session['is_login'] = True
  - 2）设置10s超时： request.session.set_expiry(10)
  - 3）获取session ： request.session.get('is_login')

####  views.py

```python
from django.shortcuts import render,HttpResponse,redirect

def index(request):
    if request.session.get('is_login'):
        return render(request,'index.html',{'username':request.session.get('username')})
    else:
        return HttpResponse('滚')

def login(request):
    if request.method == 'GET':
        return render(request,'login.html')
    elif request.method == 'POST':
        user = request.POST.get('user')
        pwd = request.POST.get('pwd')
        if user == 'tom' and pwd == '123':
            #1 生成随机字符串
            #2 写到用户浏览器cookie
            #3 保存到session中
            #4 在随机字符串对应的字典中设置相关内容
            #5 有等号设置session键值对，没有等号获取键的值

            request.session['username']=user       #1 用户登录成功设置用户名

            request.session['is_login'] = True     #2 登陆成功时可以设置一个标志

            if request.POST.get('rmb') == '1':     #3 当勾选checkbox框后设置10秒超时
                request.session.set_expiry(10)     #4 设置10s后超时，需要重新登录
            return redirect('/index')
        else:
            return render(request,'login.html')

def logout(request):
    request.session.clear()                         #5 访问'/logout/'时注销登陆
    return redirect('/login/')
```




####  login.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <form action="/login/" method="POST">
        <input type="text" name="user">
        <input type="text" name="pwd">
        <input type="checkbox" name="rmb" value="1">十秒免登陆
        <input type="submit" value="提交">
    </form>
</body>
</html>
```

#### index.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <h1>欢饮登陆：{{ username }},{{ request.session.username }}</h1>
    <a href="/logout/">注销</a>
</body>
</html>
```



#### settings.py

```python
SESSION_SAVE_EVERY_REQUEST = True
```

# model以及数据连接



## 创建数据库

###  创建mysql库

```python
mysql>  create database testdb charset utf8;       # 创建数据库
mysql>  drop database testdb;                 # 删除数据库
mysql>  show databases;                     # 查看刚刚创建的数据库
```



###  创建用户并授权

```text
# 1、创建用户
create user 'django'@'%' identified by '123456';

# 2、授予django用户授予对 testdb 数据库的操作权限
GRANT ALL ON testdb.* TO 'django'@'%';
flush privileges;
select host,user from mysql.user;

# 3、删除用户
Delete FROM mysql.user Where User='django' and Host=”localhost”; 
Delete FROM mysql.user Where User='django'; 
```

## 配置django

### 安装PyMySQL

```text
pip install PyMySQL
```



###  主动修改为pymysql

- Django默认使用MySQLdb模块链接MySQL，但在python3中还没有MySQLdb
- 主动修改为pymysql，在project同名文件夹下的__init__文件中添加如下代码即可

```python
from pymysql import install_as_MySQLdb
install_as_MySQLdb()
```



###  修改DATABASES配置

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'testdb', 
        'USER': 'django',
        'PASSWORD': '123456',
        'HOST': '123.56.94.237',
        'PORT': '3306',
    }
}
```



###  创建表

```python
python manage.py makemigrations
python manage.py migrate
```

## 定义模型







## 定义模型举例

- 模型类被定义在"应用/models.py"文件中。
- 模型类必须继承自Model类，位于包django.db.models中。

```python
from django.db import models

#定义图书模型类BookInfo
class BookInfo(models.Model):
    btitle = models.CharField(max_length=20, verbose_name='名称')
    bpub_date = models.DateField(verbose_name='发布日期')
    bread = models.IntegerField(default=0, verbose_name='阅读量')
    bcomment = models.IntegerField(default=0, verbose_name='评论量')
    is_delete = models.BooleanField(default=False, verbose_name='逻辑删除')

    class Meta:
        db_table = 'tb_books'  # 指明数据库表名
        verbose_name = '图书'  # 在admin站点中显示的名称
        verbose_name_plural = verbose_name  # 显示的复数名称

    def __str__(self):
        """定义每个数据对象的显示信息"""
        return self.btitle

#定义英雄模型类HeroInfo
class HeroInfo(models.Model):
    GENDER_CHOICES = (
        (0, 'female'),
        (1, 'male')
    )
    hname = models.CharField(max_length=20, verbose_name='名称') 
    hgender = models.SmallIntegerField(choices=GENDER_CHOICES, default=0, verbose_name='性别')  
    hcomment = models.CharField(max_length=200, null=True, verbose_name='描述信息') 
    hbook = models.ForeignKey(BookInfo, on_delete=models.CASCADE, verbose_name='图书')  # 外键
    is_delete = models.BooleanField(default=False, verbose_name='逻辑删除')

    class Meta:
        db_table = 'tb_heros'
        verbose_name = '英雄'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.hname
```



### 源信息Meta

```python
from django.db import models

class UserInfo(models.Model):
        username = models.CharField(max_length=32)
        password = models.CharField(max_length=32)
        class Meta:
            #1 数据库中生成的表名称 默认 app名称 + 下划线 + 类名
            db_table = "table_name"     #自己指定创建的表名

            #2 Django Admin 中显示的表名称
            verbose_name='user'          #在Django admin后台显示时表名是users

            #3 verbose_name加s
            verbose_name_plural='user'  #若果这个字段也是user那么4中表名才显示user

            #4 联合唯一索引
            unique_together = (("name", "password"),)

            #5 联合索引   (缺点是最左前缀，写SQL语句基于password时不能命中索引，查找慢)
            #  如：select * from tb where password = ‘xx’    就无法命中索引
            index_together = [
                ("name", "password"),
            ]
# 更多：https://docs.djangoproject.com/en/1.10/ref/models/options/
```

### 字段

####  常用字段

```python
from django.db import models

class UserGroup(models.Model):
    uid = models.AutoField(primary_key=True)

    name = models.CharField(max_length=32,null=True, blank=True)
    email = models.EmailField(max_length=32)
    text = models.TextField()

    ctime = models.DateTimeField(auto_now_add=True)      # 只有添加时才会更新时间
    uptime = models.DateTimeField(auto_now=True)         # 只要修改就会更新时间

    ip1 = models.IPAddressField()               # 字符串类型，Django Admin以及ModelForm中提供验证 IPV4 机制
    ip2 = models.GenericIPAddressField()           # 字符串类型，Django Admin以及ModelForm中提供验证 Ipv4和Ipv6

    active = models.BooleanField(default=True)

    data01 = models.DateTimeField()              # 日期+时间格式 YYYY-MM-DD HH:MM[:ss[.uuuuuu]][TZ
    data02 = models.DateField()                 # 日期格式      YYYY-MM-DD
    data03 = models.TimeField()                 # 时间格式      HH:MM[:ss[.uuuuuu]]

    age = models.PositiveIntegerField()           # 正小整数 0 ～ 32767
    balance = models.SmallIntegerField()          # 小整数 -32768 ～ 32767
    money = models.PositiveIntegerField()         # 正整数 0 ～ 2147483647
    bignum = models.BigIntegerField()           # 长整型(有符号的) -9223372036854775808 ～ 9223372036854775807
    
    user_type_choices = (
        (1, "超级用户"),
        (2, "普通用户"),
        (3, "普普通用户"),
    )
    user_type_id = models.IntegerField(choices=user_type_choices, default=1)
```

####  不常用字段

```python
URLField(CharField)
    - 字符串类型，Django Admin以及ModelForm中提供验证 URL

SlugField(CharField)
    - 字符串类型，Django Admin以及ModelForm中提供验证支持 字母、数字、下划线、连接符（减号）

CommaSeparatedIntegerField(CharField)
    - 字符串类型，格式必须为逗号分割的数字

UUIDField(Field)
    - 字符串类型，Django Admin以及ModelForm中提供对UUID格式的验证

FilePathField(Field)
    - 字符串，Django Admin以及ModelForm中提供读取文件夹下文件的功能
    - 参数：
            path,                      文件夹路径
            match=None,                正则匹配
            recursive=False,           递归下面的文件夹
            allow_files=True,          允许文件
            allow_folders=False,       允许文件夹

FileField(Field)
    - 字符串，路径保存在数据库，文件上传到指定目录
    - 参数：
        upload_to = ""      上传文件的保存路径
        storage = None      存储组件，默认django.core.files.storage.FileSystemStorage

ImageField(FileField)
    - 字符串，路径保存在数据库，文件上传到指定目录
    - 参数：
        upload_to = ""      上传文件的保存路径
        storage = None      存储组件，默认django.core.files.storage.FileSystemStorage
        width_field=None,   上传图片的高度保存的数据库字段名（字符串）
        height_field=None   上传图片的宽度保存的数据库字段名（字符串）


DurationField(Field)
    - 长整数，时间间隔，数据库中按照bigint存储，ORM中获取的值为datetime.timedelta类型

FloatField(Field)
    - 浮点型

DecimalField(Field)
    - 10进制小数
    - 参数：
        max_digits，小数总长度
        decimal_places，小数位长度

BinaryField(Field)
    - 二进制类型
```

### 参数

| 选项         | 说明                                                         |
| :----------- | ------------------------------------------------------------ |
| null         | 如果为True，表示允许为空，默认值是False                      |
| blank        | 如果为True，则该字段允许为空白，默认值是False                |
| db_column    | 字段的名称，如果未指定，则使用属性的名称                     |
| db_index     | 若值为True, 则在表中会为此字段创建索引，默认值是False        |
| default      | 默认                                                         |
| primary_key  | 若为True，则该字段会成为模型的主键字段，默认值是False，一般作为AutoField的选项使用 |
| unique       | 如果为True, 这个字段在表中必须有唯一值，默认值是False        |
| related_name | 在关联查询中,代替单一对象查找多对象 对象名小写_set(book.heroinfo_set.all() 的写法 |
| auto_now_add | 只在数据添加的时候,记录时间                                  |
| auto_now     | 数据添加和更新的时候,记录时间                                |





## 一对多创建表

###  创建一对多表

```python
from django.db import models

class UserInfo(models.Model):
    name = models.CharField(max_length=64,unique=True)
    ut = models.ForeignKey(to='UserType', on_delete=models.CASCADE)

    class Meta:
        db_table = 'tb_userinfo'           # 指明数据库表名
        verbose_name = '用户信息'        # 在admin站点中显示的名称
        verbose_name_plural = verbose_name   # 显示的复数名称

    def __str__(self):
        """定义每个数据对象的显示信息"""
        return self.name

class UserType(models.Model):
    type_name = models.CharField(max_length=64,unique=True)

    class Meta:
        db_table = 'tb_usertype'                # 指明数据库表名
        verbose_name = '用户类型'             # 在admin站点中显示的名称
        verbose_name_plural = verbose_name   # 显示的复数名称
```



### 可选参数

```python
1、to,                                # 要进行关联的表名
2、to_field=None,                        # 要关联的表中的字段名称
3、on_delete=None,                        # 当删除关联表中的数据时，当前表与其关联的行的行为
      - models.CASCADE             # ，删除关联数据，与之关联也删除
      - models.DO_NOTHING           # ，删除关联数据，引发错误IntegrityError
      - models.PROTECT             # ，删除关联数据，引发错误ProtectedError
      - models.SET_NULL            # ，删除关联数据，与之关联的值设置为null（前提FK字段需要设置为可空）
      - models.SET_DEFAULT          # ，删除关联数据，与之关联的值设置为默认值（前提FK字段需要设置默认值）
      - models.SET               # ，删除关联数据，
4、related_name=None,                     # 反向操作时，使用的字段名，用于代替 【表名_set】 如： obj.表名_set.all()
                                    # 在做自关联时必须指定此字段，防止查找冲突
5、delated_query_name=None,                  # 反向操作时，使用的连接前缀，用于替换【表名】
                                                # 如：models.UserGroup.objects.filter(表名__字段名=1).values('表名__字段名')
6、limit_choices_to=None,                   # 在Admin或ModelForm中显示关联数据时，提供的条件：
            - limit_choices_to={'nid__gt': 5}
            - limit_choices_to=lambda : {'nid__gt': 5}
7、db_constraint=True                      # 是否在数据库中创建外键约束
8、parent_link=False                       # 在Admin中是否显示关联数据
```



### [#](http://v5blog.cn/pages/df1ddc/#_1-3-一对多基本查询)1.3 一对多基本查询

```python
from django.shortcuts import render,HttpResponse
from app01 import models

def orm(request):
    # 1 创建
    # 创建数据方法一
    models.UserInfo.objects.create(name='root', ut_id=2)
    # 创建数据方法二
    obj = models.UserInfo(name='root', ut_id=2)
    obj.save()
    # 创建数据库方法三(传入字典必须在字典前加两个星号)
    dic = {'name': 'root', 'ut_id': 2}
    models.UserInfo.objects.create(**dic)

    # 2 删除
    # models.UserInfo.objects.all().delete()  # 删除所有
    models.UserInfo.objects.filter(name='root').delete()  # 删除指定

    # 3 更新
    # models.UserInfo.objects.all().update(ut_id=1)
    # models.UserInfo.objects.filter(name='zhangsan').update(ut_id=4)

    # 4.1 正向查找 user_obj.ut.type_name
    print( models.UserInfo.objects.get(name='zhangsan').ut.type_name )
    print( models.UserInfo.objects.filter(ut__type_name='student') )

    # 4.2 反向查找 type_obj.userinfo_set.all()
    print( models.UserType.objects.get(type_name='student').userinfo_set.all() )
    print( models.UserType.objects.get(type_name='student').userinfo_set.filter(name='zhangsan') )

    return HttpResponse('orm')
```



## 正向反向查

### related_query_name设置

```python
from django.db import models

class UserType(models.Model):
    user_type_name = models.CharField(max_length=32)
    def __str__(self):
        return self.user_type_name            #只有加上这个，Django admin才会显示表名

class User(models.Model):
    username = models.CharField(max_length=32)
    pwd = models.CharField(max_length=64)
    ut = models.ForeignKey(
        to='UserType',
        to_field='id',

        # 1、反向操作时，使用的连接前缀，用于替换【表名】
        # 如： models.UserGroup.objects.filter(a__字段名=1).values('a__字段名')
        related_query_name='a',

        #2、反向操作时，使用的字段名，用于代替 【表名_set】 如： obj.b_set.all()
        # 使用时查找报错
        # related_name='b',
    )
```



###  正向方向查

```python
from django.shortcuts import HttpResponse
from app01 import models

def orm(request):
    # 1 正向查找
    #1.1 正向查找user表用户名
    print(models.User.objects.get(username='zhangsan').username)           # zhangsan

    #1.2 正向跨表查找用户类型
    print(models.User.objects.get(username='zhangsan').ut.user_type_name)  # student

    #1.3 双下划线正向跨表正向查找
    print( models.User.objects.all().values('ut__user_type_name','username') )


    # 2 反向查找
    # 2.1：【表名_set】，反向查找user表中用户类型为student 的所有用户
    print( models.UserType.objects.get(user_type_name='student').user_set.all() )           # [<User: lisi>, <User: wangwu>]

    # 2.2：【a__字段名】反向查找user表中张三在UserType表中的类型：（[<UserType: teacher>]）
    print( models.UserType.objects.filter(a__username='zhangsan') )                         # student
    # 这里的a是user表的ForeignKey字段的参数：related_query_name='a'

    # 2.3: 双下划线跨表反向查找
    print( models.UserType.objects.all().values('a__username', 'user_type_name') )


    # 3 自动创建User表和UserType表中的数据
    '''
    username = [{'username':'zhangsan','pwd':'123','ut_id':'1'},
                {'username':'lisi','pwd':'123','ut_id':'1'},
                {'username':'wangwu','pwd':'123','ut_id':'1'},]

    user_type = [{'user_type_name':'student'},{'user_type_name':'teacher'},]

    for type_dic in user_type:
        models.UserType.objects.create(**type_dic)

    for user_dic in username:
        models.User.objects.create(**user_dic)
    '''
    return HttpResponse('orm')
```




## values和values_list

```python
from django.shortcuts import HttpResponse
from app01 import models

def orm(request):
    # 第一种：values-----获取的内部是字典  拿固定列数
    # 1.1 正向查找： 使用ForeignKey字段名ut结合双下划线查询
    models.User.objects.filter(username='zhangsan').values('username', 'ut__user_type_name')

    # 1.2 向查找： 使用ForeignKey的related_query_name='a',的字段
    models.UserType.objects.all().values('user_type_name', 'a__username')


    # 第二种：values_list-----获取的是元组  拿固定列数
    # 1.1 正向查找： 使用ForeignKey字段名ut结合双下划线查询
    stus = models.User.objects.filter(username='zhangsan').values_list('username', 'ut__user_type_name')

    # 1.2 反向查找： 使用ForeignKey的related_query_name='a',的字段
    utype = models.UserType.objects.all().values_list('user_type_name', 'a__username')


    # 3 自动创建User表和UserType表中的数据
    '''
    username = [{'username':'zhangsan','pwd':'123','ut_id':'1'},
                {'username':'lisi','pwd':'123','ut_id':'1'},
                {'username':'wangwu','pwd':'123','ut_id':'1'},]

    user_type = [{'user_type_name':'student'},{'user_type_name':'teacher'},]

    for type_dic in user_type:
        models.UserType.objects.create(**type_dic)

    for user_dic in username:
        models.User.objects.create(**user_dic)
    '''

    return HttpResponse('orm')
```





## 多对多

### 不创建第三张表`推荐`(法1)



- **第一种**： 自己不创建第三张关系表，有m2m字段: 根据queryset对象增删改查（**推荐**）

####  创建表

```python
from django.db import models

class UserInfo(models.Model):
    username = models.CharField(max_length=32)
    def __str__(self):
        return self.username

class UserGroup(models.Model):
    group_name = models.CharField(max_length=64)
    user_info = models.ManyToManyField(to='UserInfo',related_query_name='m2m')

    def __str__(self):
        return self.group_name
13
```

####  根据queryset对象操作

```python
from django.shortcuts import HttpResponse
from app01 import models

def orm(request):
    user_info_obj = models.UserInfo.objects.get(username='zhangsan')
    user_info_objs = models.UserInfo.objects.all()

    group_obj = models.UserGroup.objects.get(group_name='group_python')
    group_objs = models.UserGroup.objects.all()

    # 添加: 正向
    group_obj.user_info.add(user_info_obj)
    group_obj.user_info.add(*user_info_objs)
    # 删除：正向
    group_obj.user_info.remove(user_info_obj)
    group_obj.user_info.remove(*user_info_objs)

    # 添加: 反向
    user_info_obj.usergroup_set.add(group_obj)
    user_info_obj.usergroup_set.add(*group_objs)
    # 删除：反向
    user_info_obj.usergroup_set.remove(group_obj)
    user_info_obj.usergroup_set.remove(*group_objs)

    # 查找：正向
    print(group_obj.user_info.all())                                # 查找group_python组中所有用户
    print(group_obj.user_info.all().filter(username='zhangsan'))
    # 查找：反向
    print(user_info_obj.usergroup_set.all())                        # 查找用户zhangsan属于那些组
    print(user_info_obj.usergroup_set.all().filter(group_name='group_python'))


    # 双下划线 正向、反向查找
    # 正向：从用户组表中查找zhangsan属于哪个用户组：[<UserGroup: group_python>]
    print( models.UserGroup.objects.filter(user_info__username='zhangsan'))

    # 反向：从用户表中查询group_python组中有哪些用户：related_query_name='m2m'
    print( models.UserInfo.objects.filter(m2m__group_name='group_python'))


    # 自动创建UserInfo表和UserGroup表中的数据
    '''
    user_list = [{'username':'zhangsan'},
                {'username':'lisi'},
                {'username':'wangwu'},]
    group_list = [{'group_name':'group_python'},
               {'group_name':'group_linux'},
               {'group_name':'group_mysql'},]

    for c in user_list:
        models.UserInfo.objects.create(**c)

    for l in group_list:
        models.UserGroup.objects.create(**l)
    '''

    return HttpResponse('orm')
```

### 自己创建第三张关系表(法2)

- **第二种**： 自己创建第三张关系表，无 m2m 字段，自己链表查询

```python
from django.db import models

#表1：主机表
class Host(models.Model):
    nid = models.AutoField(primary_key=True)
    hostname = models.CharField(max_length=32,db_index=True)

#表2：应用表
class Application(models.Model):
    name = models.CharField(max_length=32)

#表3：自定义第三张关联表
class HostToApp(models.Model):
    hobj = models.ForeignKey(to="Host",to_field="nid")
    aobj = models.ForeignKey(to='Application',to_field='id')

# 向第三张表插入数据，建立多对多外键关联
HostToApp.objects.create(hobj_id=1,aobj_id=2)
```



### 根据外检ID操作(法3)

- **第三种**： 自己不创建第三张关系表，有m2m字段: 根据数字id增删改查

####  创建表

```python
from django.db import models

class Host(models.Model):
    hostname = models.CharField(max_length=32,db_index=True)

class Group(models.Model):
    group_name = models.CharField(max_length=32)
    m2m = models.ManyToManyField("Host")
```



####  根据id增删改查

```python
from django.shortcuts import HttpResponse
from app01 import models

def orm(request):
    # 使用间接方法对第三张表操作
    obj = models.Group.objects.get(id=1)

    # 1、添加
    obj.m2m.add(1)           # 在第三张表中增加一个条目(1,1)
    obj.m2m.add(2, 3)        # 在第三张表中增加条目（1,2）（1,3）两条关系
    obj.m2m.add(*[1,3])        # 在第三张表中增加条目（1,2）（1,3）两条关系

    # 2、删除
    obj.m2m.remove(1)             # 删除第三张表中的（1,1）条目
    obj.m2m.remove(2, 3)          # 删除第三张表中的（1,2）（1,3）条目
    obj.m2m.remove(*[1, 2, 3])    # 删除第三张表中的（1,1）（1,2）（1,3）条目

    # 3、清空
    obj.m2m.clear()                 # 删除第三张表中application条目等于1的所有条目

    # 4 更新
    obj.m2m.set([1, 2,])             # 第三张表中会删除所有条目，然后创建（1,1）（1,2）条目

    # 5 查找
    print( obj.m2m.all() )           # 等价于 models.UserInfo.objects.all()

    # 6 反向查找： 双下划线
    hosts = models.Group.objects.filter(m2m__id=1)         # 在Host表中id=1的主机同时属于那些组


    # 自动创建Host表和Group表中的数据
    '''
    hostname = [{'hostname':'zhangsan'},
                {'hostname':'lisi'},
                {'hostname':'wangwu'},]
    group_name = [{'group_name':'DBA'},{'group_name':'public'},]

    for h in hostname:
        models.Host.objects.create(**h)
    for u in group_name:
        models.Group.objects.create(**u)
    '''

    return HttpResponse('orm')
```

## ManyToManyField参数

- 创建m2m多对多时ManyToManyField可以添加的参数

```python
1、to,                        # 要进行关联的表名
2、related_name=None,         # 反向操作时，使用的字段名，用于代替 【表名_set】如： obj.表名_set.all()
3、related_query_name=None,   # 反向操作时，使用的连接前缀，用于替换【表名】     
                              # 如： models.UserGroup.objects.filter(表名__字段名=1).values('表名__字段名')
4、limit_choices_to=None,     # 在Admin或ModelForm中显示关联数据时，提供的条件：
                              # - limit_choices_to={'nid__gt': 5}
5、symmetrical=None,          # 用于多对多自关联，symmetrical用于指定内部是否创建反向操作字段
6、through=None,              # 自定义第三张表时，使用字段用于指定关系表
7、through_fields=None,       # 自定义第三张表时，使用字段用于指定关系表中那些字段做多对多关系表
8、db_constraint=True,        # 是否在数据库中创建外键约束
   db_table=None,             # 默认创建第三张表时，数据库中表的名称
```



## values和values_list

```python
from django.shortcuts import HttpResponse
from app01 import models

def orm(request):
    # 第一种：values-----获取的内部是字典,拿固定列数
    # 1.1 正向查找： 使用ManyToManyField字段名user_info结合双下划线查询
    models.UserGroup.objects.filter(group_name='group_python').values('group_name', 'user_info__username')

    # 1.2 反向查找： 使用ManyToManyField的related_query_name='m2m',的字段
    models.UserInfo.objects.filter(username='zhangsan').values('username', 'm2m__group_name')


    # 第二种：values_list-----获取的是元组  拿固定列数
    # 2.1 正向查找： 使用ManyToManyField字段名user_info结合双下划线查询
    models.UserGroup.objects.filter(group_name='group_python').values_list('group_name', 'user_info__username')

    # 2.2 反向查找： 使用ManyToManyField的related_query_name='m2m',的字段
    lesson = models.UserInfo.objects.filter(username='zhangsan').values_list('username', 'm2m__group_name')

    # 自动创建UserInfo表和UserGroup表中的数据
    '''
    # user_info_obj = models.UserInfo.objects.get(username='lisi')
    # user_info_objs = models.UserInfo.objects.all()
    #
    # group_obj = models.UserGroup.objects.get(group_name='group_python')
    # group_objs = models.UserGroup.objects.all()
    #
    # group_obj.user_info.add(*user_info_objs)
    # user_info_obj.usergroup_set.add(*group_objs)

    user_list = [{'username':'zhangsan'},
                {'username':'lisi'},
                {'username':'wangwu'},]
    group_list = [{'group_name':'group_python'},
               {'group_name':'group_linux'},
               {'group_name':'group_mysql'},]

    for c in user_list:
        models.UserInfo.objects.create(**c)

    for l in group_list:
        models.UserGroup.objects.create(**l)
    '''

    return HttpResponse('orm')
```



## 一大波Model操作

### 基本操作

```python
from django.shortcuts import HttpResponse
from app01 import models

def orm(request):
    # 1 创建
    # 创建数据方法一
    models.UserInfo.objects.create(username='root', password='123')
    # 创建数据方法二
    obj = models.UserInfo(username='alex', password='123')
    obj.save()
    # 创建数据库方法三(传入字典必须在字典前加两个星号)
    dic = {'username': 'eric', 'password': '666'}
    models.UserInfo.objects.create(**dic)

    # 2 查
    result = models.UserInfo.objects.all()  # 查找所有条目
    result = models.UserInfo.objects.filter(username='alex', password='123')
    for row in result:
        print(row.id, row.username, row.password)

    # 3 删除
    models.UserInfo.objects.all().delete()  # 删除所有
    models.UserInfo.objects.filter(username='alex').delete()  # 删除指定

    # 4 更新
    models.UserInfo.objects.all().update(password='12345')
    models.UserInfo.objects.filter(id=4).update(password='15')

    # 5 获取个数
    models.UserInfo.objects.filter(name='seven').count()

    # 6 执行原生SQL
    # 6.1 执行原生SQL
    models.UserInfo.objects.raw('select * from userinfo')

    # 6.2 如果SQL是其他表时，必须将名字设置为当前UserInfo对象的主键列名
    models.UserInfo.objects.raw('select id as nid from 其他表')

    # 6.3 指定数据库
    models.UserInfo.objects.raw('select * from userinfo', using="default")

    return HttpResponse('orm')
```



### 进阶操作

- `进阶操作：牛掰掰的双下划线`

```python
1、大于，小于
        # models.Tb1.objects.filter(id__gt=1)                 # 获取id大于1的值
        # models.Tb1.objects.filter(id__gte=1)                # 获取id大于等于1的值
        # models.Tb1.objects.filter(id__lt=10)                # 获取id小于10的值
        # models.Tb1.objects.filter(id__lte=10)               # 获取id小于10的值
        # models.Tb1.objects.filter(id__lt=10, id__gt=1)      # 获取id大于1 且 小于10的值
2、in
        # models.Tb1.objects.filter(id__in=[11, 22, 33])      # 获取id等于11、22、33的数据
        # models.Tb1.objects.exclude(id__in=[11, 22, 33])     # not in
3、isnull
        # Entry.objects.filter(pub_date__isnull=True)         #双下划线isnull，查找pub_date是null的数据
4、contains                                                    #就是原生sql的like操作:模糊匹配
        # models.Tb1.objects.filter(name__contains="ven")
        # models.Tb1.objects.filter(name__icontains="ven")    # icontains大小写不敏感
        # models.Tb1.objects.exclude(name__icontains="ven")
5、range
        # models.Tb1.objects.filter(id__range=[1, 2])          # 范围bettwen and
6、order by
        # models.Tb1.objects.filter(name='seven').order_by('id')      # asc     没有减号升续排列
        # models.Tb1.objects.filter(name='seven').order_by('-id')     # desc      有减号升续排列
7、group by
        # from django.db.models import Count, Min, Max, Sum
        # models.Tb1.objects.filter(c1=1).values('id').annotate(c=Count('num'))        #根据id列进行分组
        # SELECT "app01_tb1"."id", COUNT("app01_tb1"."num") AS "c" FROM "app01_tb1" 
        # WHERE "app01_tb1"."c1" = 1 GROUP BY "app01_tb1"."id"
8、limit 、offset    #分页
        # models.Tb1.objects.all()[10:20]
9、regex正则匹配，iregex 不区分大小写
        # Entry.objects.get(title__regex=r'^(An?|The) +')
        # Entry.objects.get(title__iregex=r'^(an?|the) +')

        
10、date
        # Entry.objects.filter(pub_date__date=datetime.date(2005, 1, 1))          #__data表示日期查找，2005-01-01
        # Entry.objects.filter(pub_date__date__gt=datetime.date(2005, 1, 1))
11、year
        # Entry.objects.filter(pub_date__year=2005)                               #__year根据年查找
        # Entry.objects.filter(pub_date__year__gte=2005)
12、month
        # Entry.objects.filter(pub_date__month=12)
        # Entry.objects.filter(pub_date__month__gte=6)
13、day
        # Entry.objects.filter(pub_date__day=3)
        # Entry.objects.filter(pub_date__day__gte=3)
14、week_day
        # Entry.objects.filter(pub_date__week_day=2)
        # Entry.objects.filter(pub_date__week_day__gte=2)
15、hour
        # Event.objects.filter(timestamp__hour=23)
        # Event.objects.filter(time__hour=5)
        # Event.objects.filter(timestamp__hour__gte=12)
16、minute
        # Event.objects.filter(timestamp__minute=29)
        # Event.objects.filter(time__minute=46)
        # Event.objects.filter(timestamp__minute__gte=29)
17、second
        # Event.objects.filter(timestamp__second=31)
        # Event.objects.filter(time__second=2)
        # Event.objects.filter(timestamp__second__gte=31)
```



### 时间过滤

- 根据天/小时进行过滤

```python
from django.utils import timezone
from report.models import *

now = timezone.now()
# start_time = now - timezone.timedelta(days=7)
start_time = now - timezone.timedelta(hours=240)  # 查询10天前的数据
end_time = now

qs = AllClarm.objects.filter(start_tm__range=(start_time, end_time))
```



## F()和Q()查询

### F()

- F() ---- 专门取对象中某列值的操作
- **作用：**F()允许Django在未实际链接数据的情况下具有对数据库字段的值的引用

```python
from django.shortcuts import HttpResponse
from app01 import models
from django.db.models import F,Q

def orm(request):
    # 每访问一次数据库中zhangsan的年纪就会自动增加1
    models.Student.objects.filter(name='zhangsan').update(age=F("age") + 1)
    return HttpResponse('orm')
```



### Q()

####  Q查询基本使用

- 1、Q对象(django.db.models.Q)可以对关键字参数进行封装，从而更好地应用多个查询
- 2、可以组合使用 &（and）,|（or），~（not）操作符，当一个操作符用于两个Q的对象,它产生一个新的Q对象
- 3、如： **Q(Q(nid=8) | Q(nid__gt=10)) & Q(caption='root')**

```python
from django.shortcuts import HttpResponse
from app01 import models
from django.db.models import F,Q

def orm(request):
    # 查找学生表中年级大于1小于30姓zhang的所有学生
    stus = models.Student.objects.filter(
        Q(age__gt=1) & Q(age__lt=30),
        Q(name__startswith='zhang')
    )
    print('stu',stus)   #运行结果：[<Student: zhangsan>]
    return HttpResponse('orm')
```



### 动态添加查询条件

- 动态添加多个and和or查询条件

#####  项目中动态添加or查询条件

```python
def table_search(request,admin_class,object_list):
   search_key = request.GET.get('_q','')
   q_obj = Q()
   q_obj.connector = 'OR'
   for column in admin_class.search_fields:
      q_obj.children.append(('%s__contains'%column,search_key))
   res = object_list.filter(q_obj)
   return res
```



####  or动态添加多个查询条件

```python
# or动态添加多个查询条件
>>> from crm import models
>>> from django.db.models import Q
>>> con = Q()                                   #1. 实例化一个Q()查询类
>>> con.connector = "OR"                           #2. 指定使用‘OR’条件
>>> con.children.append(('qq__contains','123'))           #3. qq字段中包含‘123’
>>> con.children.append(('name__contains','name0'))         #4. name字段中包含‘naem0’
>>> con
<Q: (OR: ('qq__contains', '123'), ('name__contains', 'name0'))>   
                            #5. 查找name字段中包含‘naem0’或qq字段包含‘123’的所有条目
>>> models.Customer.objects.values('qq','name').filter(con)    
```



####  and和or结合查询

```python
# and和or结合查询
#1. 导入模块
>>> from crm import models
>>> from django.db.models import Q

#2. q1：查询id=1或者id=2的所有条目  （or条件）
>>> q1 = Q()
>>> q1.connector = 'OR'
>>> q1.children.append(('id',1))
>>> q1.children.append(('id',2))

#3. q2：查询id=1的所有条目  （or条件）
>>> q2 = Q()
>>> q2.connector = 'OR'
>>> q2.children.append(('id',1))

#4. con：结合q1和q2条件结果是查询id=1的所有条目     （结合q1,q2的and条件）
>>> con = Q()
>>> con.add(q1,'AND')
   <Q: (OR: ('id', 1), ('id', 2))>
>>> con.add(q2,'AND')
   <Q: (AND: (OR: ('id', 1), ('id', 2)), ('id', 1))>
>>> models.Customer.objects.values('qq','name').filter(con)
   <QuerySet [{'qq': '123456765432', 'name': 'haha'}]>
```



## aggregate和annotate

### aggregate聚合函数

- **作用：**从数据库中取出一个汇总的集合
- `aggregate求最大值、最小值、平局值等`

```python
from django.db.models import Count,Avg,Max,Sum
def orm(request):

    stus = models.Student.objects.aggregate(
        stu_num=Count('age'),     #计算学生表中有多少条age条目
        stu_avg=Avg('age'),       #计算学生的平均年纪
        stu_max=Max('age'),       #找到年纪最大的学生
        stu_sum=Sum('age'))       #将表中的所有年纪相加

    print('stu',stus)
    return HttpResponse('ok')
#运行结果：{'stu_sum': 69, 'stu_max': 24, 'stu_avg': 23.0, 'stu_num': 3}
```



### 实现聚合group by查询

- **作用:**对查询结果进行分组，比如分组求出各年龄段的人数
- **注:** annotate后面加filter过滤相当于原生sql语句中的having

```python
from django.db.models import Count, Avg, Max, Min, Sum
def orm(request):
    #1 按年纪分组查找学生表中各个年龄段学生人数：（22岁两人，24岁一人）
    # 查询结果：[{'stu_num': 2, 'age': 22}, {'stu_num': 1, 'age': 24}]

    stus1 = models.Student.objects.values('age').annotate(stu_num=Count('age'))

    #2 按年纪分组查找学生表中各个年龄段学生人数，并过滤出年纪大于22的：
    # 查询结果：[{'stu_num': 1, 'age': 24}] （年级大于22岁的仅一人，年级为24岁）

    stus2 = models.Student.objects.values('age').annotate(stu_num=Count('age')).filter(age__gt=22)

    #3 先按年纪分组，然后查询出各个年龄段学生的平均成绩
    # 查询结果：[{'stu_Avg': 86.5, 'age': 22}, {'stu_Avg': 99.0, 'age': 24}]
    # 22岁平均成绩：86.5      24岁平均成绩：99

    stus3 = models.Student.objects.values('age').annotate(stu_Avg=Avg('grade'))

    return HttpResponse('ok')
```



### aggregate和annotate区别

- 1. Aggregate作用是从数据库取出一个汇总的数据（比如，数量，最大，最小，平均等）
- 1. 而annotate是先按照设定的条件对数据进行分组，然后根据不同组分别对数据进行汇总



# DRF框架



## web开发两种模式



###  前后端不分离

- 前端看到的效果都是由后端控制的
- 后端通过渲染之后给前端返回完整的html页面，前端与后端的耦合度很高

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210217141549707.9cd57893.png)

### 前后端分离

- 后端仅返回前端所需的数据，至于数据怎么进行展示
- 由前端自己进行控制，前端与后端的耦合度很低

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210217141750396.6758eb34.png)

###  开发模式对比

- `前后端不分离`：完整的页面是在后端生成的，后端给前端返回完整的页面，前端只是进行展示。
- `前后端分离`：完整的页面是在前端生成的，后端只给前端返回所需的数据，前端将数据填充在页面上。
- `优缺点比较：`
  - 前后端不分离适合于纯网页的应用，前后端分离可以对接不同类型的客户端。

| 开发模式     | 优点                     | 缺点                    |
| ------------ | ------------------------ | ----------------------- |
| 前后端不分离 | 利于SEO(搜索引擎优化)    | 仅适合于纯网页的应用    |
| 前后端分离   | 可以对接不同类型的客户端 | 不利于SEO(搜索引擎优化) |







## Restful风格



### RESTFUL风格

#### 什么是RESTful风格

详情查看博客地址：https://www.cnblogs.com/xiaonq/p/10053234.html

####  什么是RESTful

- REST与技术无关，代表的是`一种软件架构风格`（REST是Representational State Transfer的简称，中文翻译为“表征状态转移”）
- REST从资源的角度类审视整个网络，它将分布在网络中某个节点的`资源通过URL进行标识`
- 所有的数据，不过是通过网络获取的还是`操作（增删改查）`的数据，都是资源，将一切数据视为资源是REST区别与其他架构风格的最本质属性
- 对于REST这种面向资源的架构风格，有人提出一种全新的结构理念，即：面向资源架构（ROA：Resource Oriented Architecture）

#### web开发本质

- 对数据库中的表进行增删改查操作
- Restful风格就是把所有数据都当做资源，对表的操作就是对资源操作
- 在url同通过 资源名称来指定资源
- 通过 get/post/put/delete/patch 对资源的操作

### RESTful设计规范

####  URL路径

- `面向资源编程`： 路径，视网络上任何东西都是资源，均使用名词表示（可复数）,不要使用动词

```python
# 不好的例子：url中含有动词
/getProducts
/listOrders

# 正确的例子：地址使用名词复数
GET /products      # 将返回所有产品信息
POST /products     # 将新建产品信息
GET /products/4     # 将获取产品4
PUT /products/4     # 将更新产品4
```



####  请求方式

- 访问同一个URL地址，采用不同的请求方式，代表要执行不同的操作
- 常用的HTTP请求方式有如下四种：

| 请求方式 | 说明                     |
| -------- | ------------------------ |
| GET      | 获取资源数据(单个或多个) |
| POST     | 新增资源数据             |
| PUT      | 修改资源数据             |
| DELETE   | 删除资源数据             |

- 例如

```python
GET /books          # 获取所有图书数据
POST /books          # 新建一本图书数据
GET /books/<id>/       # 获取某个指定的图书数据
PUT /books/<id>/       # 更新某个指定的图书数据
DELETE /books/<id>/     # 删除某个指定的图书数据
```



####  过滤信息

- `过滤，分页，排序`：通过在url上传参的形式传递搜索条件
- 常见的参数：

```python
?limit=10                   # 指定返回记录的数量。
?offset=10                   # 指定返回记录的开始位置。
?page=2&pagesize=100             # 指定第几页，以及每页的记录数。
?sortby=name&order=asc             # 指定返回结果按照哪个属性排序，以及排序顺序。
```



#### 响应状态码

- 重点状态码

```python
'''1. 2XX请求成功'''
# 1.1 200 请求成功，一般用于GET与POST请求
# 1.2 201 Created - [POST/PUT/PATCH]：用户新建或修改数据成功。
# 204 NO CONTENT - [DELETE]：用户删除数据成功。

'''3. 4XX客户端错误'''
# 3.1 400 INVALID REQUEST - [POST/PUT/PATCH]：用户发出的请求有错误。
# 3.2 401 Unauthorized - [*]：表示用户没有权限（令牌、用户名、密码错误）。
# 3.3 403 Forbidden - [*] 表示用户得到授权（与401错误相对），但是访问是被禁止的。
# 3.4 404 NOT FOUND - [*]：用户发出的请求针对的是不存在的记录。

'''4. 5XX服务端错误'''
# 500 INTERNAL SERVER ERROR - [*]：服务器内部错误，无法完成请求
# 501 Not Implemented     服务器不支持请求的功能，无法完成请求

更多状态码参考：https://www.runoob.com/http/http-status-codes.html
```



- 详细状态码

```python
'''1. 2XX请求成功'''
# 1.1 200 请求成功，一般用于GET与POST请求
# 1.2 201 Created - [POST/PUT/PATCH]：用户新建或修改数据成功。
# 202 Accepted - [*]：表示一个请求已经进入后台排队（异步任务）
# 204 NO CONTENT - [DELETE]：用户删除数据成功。
'''2. 3XX重定向'''
# 301 NO CONTENT - 永久重定向
# 302 NO CONTENT - 临时重定向
'''3. 4XX客户端错误'''
# 3.1 400 INVALID REQUEST - [POST/PUT/PATCH]：用户发出的请求有错误。
# 3.2 401 Unauthorized - [*]：表示用户没有权限（令牌、用户名、密码错误）。
# 3.3 403 Forbidden - [*] 表示用户得到授权（与401错误相对），但是访问是被禁止的。
# 3.4 404 NOT FOUND - [*]：用户发出的请求针对的是不存在的记录。
# 406 Not Acceptable - [GET]：用户请求的格式不可得（比如用户请求JSON格式，但是只有XML格式）。
# 410 Gone -[GET]：用户请求的资源被永久删除，且不会再得到的。
# 422 Unprocesable entity - [POST/PUT/PATCH] 当创建一个对象时，发生一个验证错误。
'''4. 5XX服务端错误'''
# 500 INTERNAL SERVER ERROR - [*]：服务器内部错误，无法完成请求
# 501 Not Implemented     服务器不支持请求的功能，无法完成请求

更多状态码参考：https://www.runoob.com/http/http-status-codes.html
```







## DRF框架作用

### DRF核心任务

#### DRF核心任务

- 序列化：将对象转换为字典或者json的过程。
- 反序列化：将字典或json转换保存到对象中的过程。
- RestAPI核心工作：
  - 将数据库中的数据序列化为前端所需的格式，并进行返回。
  - 将前端传递的数据反序列化保存为模型类对象，并保存到数据库。
- 在开发REST API接口时，视图中主要做了三件事：
  - ① 将请求的数据（如：JSON格式）转换为模型类对象
  - ② 操作数据库
  - ③ 将模型类对象转换为响应的数据（如：JSON格式）

####  序列化

- **广义的概念**：将一种数据转换为另外一种格式的过程。
- **本课程特指**：`将对象转换为字典或json的过程`。

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210217145158339.ef343d9c.png)

####  反序列化

- **广义的概念**：和序列化相反的转换过程。
- **本课程特指**：将字典或json转换为对象的过程。

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210217145342846.25a820ca.png)

### Django REST framework 简介

####  作用

- **Django REST framework可以帮助我们大大提高REST API的开发速度。**
- 在序列化与反序列化时，虽然操作的数据可能不同，但是过程是相似的，这部分操作DRF框架进行了封装。
- 在开发REST API的视图时，虽然每个视图操作的数据可能不同
- 但增、删、改、查的基本流程是一样的，这部分代码DRF框架也进行了封装。
  - **增**：校验请求数据 → 反序列化-将数据保存到对象中 → 保存数据到数据库 → 将保存的对象序列化返回
  - **删**：判断要删除的数据是否存在 → 执行数据库删除 → 返回响应
  - **改**：判断要修改的数据是否存在 → 校验请求的数据 → 反序列化-将数据保存到对象中 → 保存数据到数据库 → 将保存的对象序列化返回
  - **查(1个或多个)**：查询数据库 → 将数据序列化返回

####  特点

- **提供了定义序列化器的方法，使用序列化器可以进行数据的序列化和反序列化**
- **提供了丰富的类视图、Mixin扩展类、子类视图、视图集，简化视图代码的编写**
- 多种身份认证和权限控制方式的支持
- 内置了限流系统
- 直观的API web界面
- 可扩展性，插件丰富

**参考资料**：[DRF框架官方文档(opens new window)](http://www.django-rest-framework.org/)

**`总结`**：

- 作用：快速开发RestAPI接口。
- 特点：进行了大量封装，提高API开发速度。
- 核心功能：序列化器和视图。





## 04.环境安装与使用

### 安装djangorestframework

- DRF框架依赖于Django，`需要先安装Django环境，再安装djangorestframework`

```python
pip install djangorestframework==3.11.0        # 安装djangorestframework
pip install django-filter==2.3.0             # 安装过滤器
```



- 创建django环境

```python
# ① 创建一个名为django2.2的虚拟环境
mkvirtualenv -p python django2.2

# ② 进入django2.2虚拟环境
workon django2.2

# ③ 安装Django环境
pip install Django==2.2.5
```



### DRF配置

####  创建一个测试项目

```python
(django2.2) C:\Users\Lenovo>  cd C:\tmp
(django2.2) C:\tmp>  django-admin startproject drf_demo
(django2.2) C:\tmp\drf_demo>  python manage.py startapp book
```



####  DRF应用注册

- setting.py中注册djangorestframework

```python
INSTALLED_APPS = [
    'rest_framework',             # 注册 djangorestframework
    'book.apps.BookConfig',         # 注册刚刚创建的APP：book
]
```



####  路由分发

- `drf_demo/urls.py`

```python
from django.contrib import admin
from django.urls import path,include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('book/', include(('book.urls', 'book'), namespace='book')),
]
```




####  定义模型

```python
from django.db import models

#定义图书模型类BookInfo
class BookInfo(models.Model):
    btitle = models.CharField(max_length=20, verbose_name='名称')
    bpub_date = models.DateField(verbose_name='发布日期')
    bread = models.IntegerField(default=0, verbose_name='阅读量')
    bcomment = models.IntegerField(default=0, verbose_name='评论量')
    is_delete = models.BooleanField(default=False, verbose_name='逻辑删除')

    class Meta:
        db_table = 'tb_books'  # 指明数据库表名
        verbose_name = '图书'  # 在admin站点中显示的名称
        verbose_name_plural = verbose_name  # 显示的复数名称

    def __str__(self):
        """定义每个数据对象的显示信息"""
        return self.btitle
```



- 创建表

```python
(django2.2) C:\tmp\drf_demo>   python manage.py makemigrations
(django2.2) C:\tmp\drf_demo>   python manage.py migrate
```




### DRF框架功能演示

####  步骤1：创建序列化器类

- 在 `book` 应用中新建 `serializers.py` 用于保存所要创建的序列化器类。

```python
from rest_framework import serializers
from book.models import BookInfo

class BookInfoSerializer(serializers.ModelSerializer):
    """图书序列化器类"""
    class Meta:
        model = BookInfo
        fields = '__all__'
```



**小知识**：

- model：指定该序列化器类所对应的模型类
- fields：指定依据模型类的哪些字段生成对应序列化器类的字段，__all__代表所有

####  步骤2：编写视图

- `book/views.py`

```python
from rest_framework.viewsets import ModelViewSet
from book.serializers import BookInfoSerializer
from book.models import BookInfo

class BookInfoViewSet(ModelViewSet):
    """视图集"""
    queryset = BookInfo.objects.all()
    serializer_class = BookInfoSerializer
```



**小知识**：

- queryset：指定视图在进行数据查询时所使用的查询集
- serializer_class：指定视图在进行序列化或反序列化时所使用的序列化器类

#### 步骤3：定义路由

- `book/urls.py`

```python
from django.urls import re_path
from book import views

urlpatterns = [

]

# 路由Router
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register('books', views.BookInfoViewSet, basename='books')
urlpatterns += router.urls
```



- **小知识：什么是路由Router？**
- **答：动态生成视图集中的处理方法的url配置项。**

#### 步骤四：测试接口

#####  测试获取所有图书接口

```javascript
http://127.0.0.1:8000/book/book/
```



- 返回结果

```python
{
    "code": 0,
    "msg": "success",
    "books": [
        {
            "id": 1,
            "btitle": "西游记",
            "bpub_date": "2020-08-11",
            "bread": 1234,
            "bcomment": 779
        },
        {
            "id": 2,
            "btitle": "红楼梦",
            "bpub_date": "2020-09-19",
            "bread": 123,
            "bcomment": 5555
        },
        {
            "id": 3,
            "btitle": "水浒传",
            "bpub_date": "2020-02-12",
            "bread": 100,
            "bcomment": 0
        }
    ]
}
```



#####  测试创建图书接口

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210217161335502.50100fe9.png)

#####  测试修改图书接口

```javascript
http://127.0.0.1:8000/book/book/1/
```



![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210217161518715.c3c049c3.png)

#####  测试删除数据接口

```javascript
http://127.0.0.1:8000/book/book/1/
```







## Serializer

### Serializer介绍

- Serializer三个作用
- 第一：序列化
- 第二: 反序列化
- 第三：数据校验

####  定义Serializer

```python
# -*- coding: utf-8 -*-
from rest_framework import serializers
from book.models import BookInfo


class APIViewBookInfoSerializer(serializers.Serializer):
    """图书数据序列化器"""
    id = serializers.IntegerField(label='ID', read_only=True)       # 主键序列化
    # 第一：普通字段序列化
    btitle = serializers.CharField(label='名称', max_length=20)
    bpub_date = serializers.DateField(label='发布日期')
    bread = serializers.IntegerField(label='阅读量', required=False)
    bcomment = serializers.IntegerField(label='评论量', required=False)
    # 第二：一对多字段序列化
    heroinfo_set = serializers.PrimaryKeyRelatedField(read_only=True, many=True)
    # 第三：自定义显示（显示多对多）
    xxx = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = BookInfo

    # 自定义显示 多对多 字段
    def get_xxx(self,row):
        '''row: 传过来的正是 BookInfo表的对象'''
        books = row.btitle   # 获取用户名
        return books
```

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26

### [#](http://v5blog.cn/pages/4037e0/#_1-2-序列化-作用1)1.2 序列化：`作用1`

```python
class APIViewBookInfoViewSet(APIView):
    def get(self, request):
        obj = BookInfo.objects.all()
        ser = serializers.BookInfoSerializer1(instance=obj, many=True)  # 序列化多条数据
        # ser = serializers.BookInfoSerializer1(instance=obj[0])            # 序列化一条数据
        return Response(ser.data)
```



### [#](http://v5blog.cn/pages/4037e0/#_1-3-反序列化-作用2)1.3 反序列化：`作用2`

```python
    # 创建
    def post(self,request):
        ser =  serializers.BookInfoSerializer1(data=request.data)
        # 判断提交数据是否合法
        if ser.is_valid():
            ser.save()
            return Response(data=ser.data, status=201)
        return Response(data=ser.errors,status=400)
```



### [#](http://v5blog.cn/pages/4037e0/#_1-4-字段校验-作用3)1.4 字段校验：`作用3`

```python
class BookInfoSerializer1(serializers.Serializer):
    """图书数据序列化器"""
    
    # 定义单一字段验证的方法
    def validate_name(self, value):
        if value == 'root':
            raise serializers.ValidationError('不能创建root管理员账号')
        return value

    # 定义多字段验证方法
    def validate(self, attrs):
        if attrs['name'] == 'admin':
            raise serializers.ValidationError('不能创建admin用户')
        return attrs
```



### 序列化&反序列化

####  book/models.py

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210217194315866.32871eca.png)

```python
from django.db import models

#定义图书模型类BookInfo
class BookInfo(models.Model):
    btitle = models.CharField(max_length=20, verbose_name='名称')
    bpub_date = models.DateField(verbose_name='发布日期')
    bread = models.IntegerField(default=0, verbose_name='阅读量')
    bcomment = models.IntegerField(default=0, verbose_name='评论量')
    is_delete = models.BooleanField(default=False, verbose_name='逻辑删除')

    class Meta:
        db_table = 'tb_books'  # 指明数据库表名
        verbose_name = '图书'  # 在admin站点中显示的名称
        verbose_name_plural = verbose_name  # 显示的复数名称

    def __str__(self):
        """定义每个数据对象的显示信息"""
        return self.btitle


#定义英雄模型类HeroInfo
class HeroInfo(models.Model):
    GENDER_CHOICES = (
        (0, 'female'),
        (1, 'male')
    )
    hname = models.CharField(max_length=20, verbose_name='名称')
    hgender = models.SmallIntegerField(choices=GENDER_CHOICES, default=0, verbose_name='性别')
    hcomment = models.CharField(max_length=200, null=True, verbose_name='描述信息')
    hbook = models.ForeignKey(BookInfo, on_delete=models.CASCADE, verbose_name='图书')  # 外键
    is_delete = models.BooleanField(default=False, verbose_name='逻辑删除')

    class Meta:
        db_table = 'tb_heros'
        verbose_name = '英雄'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.hname
```





####  book/serializers.py

```python
# -*- coding: utf-8 -*-
from rest_framework import serializers
from book.models import BookInfo


class BookInfoSerializer1(serializers.Serializer):
    """图书数据序列化器"""
    id = serializers.IntegerField(label='ID', read_only=True)       # 主键序列化
    # 第一：普通字段序列化
    btitle = serializers.CharField(label='名称', max_length=20)
    bpub_date = serializers.DateField(label='发布日期')
    bread = serializers.IntegerField(label='阅读量', required=False)
    bcomment = serializers.IntegerField(label='评论量', required=False)
    # 第二：一对多字段序列化
    heroinfo_set = serializers.PrimaryKeyRelatedField(read_only=True, many=True)
    # 第三：自定义显示（显示多对多）
    xxx = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = BookInfo

    # 自定义显示 多对多 字段
    def get_xxx(self,row):
        '''row: 传过来的正是 BookInfo表的对象'''
        books = row.btitle   # 获取用户名
        return books

    # 定义创建语法：ser.save()执行，就会立刻调用create方法用来创建数据
    def create(self, validated_data):
        '''validated_data: 表单或者vue请求携带的json：{"username":"zhangsan","password":"123456"}'''
        return self.Meta.model.objects.create(**validated_data)

    # 定义更新方法
    def update(self, instance, validated_data):
        '''
        instance : 查询的对象
        validated_data :  postman提交的json数据 {"username":"zhangsan","password":"123456"}
        '''
        if validated_data.get('btitle'):
            instance.btitle = validated_data['btitle']
        if validated_data.get('bpub_date'):
            instance.bpub_date = validated_data['bpub_date']
        instance.save()
        return instance
```

####  book/views.py

```python
from rest_framework.views import APIView
from rest_framework.response import Response
from book import serializers
from book.models import BookInfo


class APIViewBookInfoViewSet(APIView):
    def get(self, request):
        obj = BookInfo.objects.all()
        ser = serializers.BookInfoSerializer1(instance=obj, many=True)  # 关联数据多条
        # ser = serializers.BookInfoSerializer1(instance=obj[0])           # 关联数据一条
        return Response(ser.data)

    # 创建
    def post(self,request):
        ser =  serializers.BookInfoSerializer1(data=request.data)
        # 判断提交数据是否合法
        if ser.is_valid():
            ser.save()
            return Response(data=ser.data, status=201)
        return Response(data=ser.errors,status=400)

    # 更新
    def put(self, request):
        pk = request.query_params.get('pk')
        try:
            bookinfo = BookInfo.objects.get(id = pk)
        except Exception as e:
            return Response(data='不存在', status=201)
        # 创建序列化对象，并将要反序列化的数据传递给data构造参数，进而进行验证
        ser = serializers.BookInfoSerializer1(bookinfo, data=request.data)
        if ser.is_valid():
            ser.save()
            return Response(data=ser.data, status=201)
        return Response(data=ser.errors,status=400)
```

#### [ book/urls.py

```python
from django.urls import re_path,path
from book import views

urlpatterns = [
    path('book1/', views.APIViewBookInfoViewSet.as_view()),
]
```



####  测试接口

#####  get获取数据

> http://127.0.0.1:8000/book/book1/

```python
[
    {
        "id": 1,
        "btitle": "西游记",
        "bpub_date": "2020-08-11",
        "bread": 666,
        "bcomment": 123,
        "heroinfo_set": [],
        "xxx": "西游记"
    },
    {
        "id": 2,
        "btitle": "水浒传",
        "bpub_date": "2020-08-11",
        "bread": 200,
        "bcomment": 100,
        "heroinfo_set": [],
        "xxx": "水浒传"
    }
]
```



#####  post添加数据

> http://127.0.0.1:8000/book/book1/

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210217181023301.90459b60.png)

#####  put修改数据

> http://127.0.0.1:8000/book/book1/?pk=4

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210217181515171.f1ff07c7.png)

### 嵌套序列化

####  book/serializers.py

```python
from rest_framework import serializers
from book.models import BookInfo,HeroInfo

class HeroInfoSerializer(serializers.Serializer):
    """英雄数据序列化器"""
    GENDER_CHOICES = (
        (0, '男'),
        (1, '女')
    )
    id = serializers.IntegerField(label='ID', read_only=True)
    hname = serializers.CharField(label='名字', max_length=20)
    hgender = serializers.ChoiceField(label='性别', choices=GENDER_CHOICES, required=False)
    hcomment = serializers.CharField(label='描述信息', max_length=200, required=False)

    class Meta:
        model = HeroInfo


class BookInfoSerializer1(serializers.Serializer):
    """图书数据序列化器"""
    id = serializers.IntegerField(label='ID', read_only=True)       # 主键序列化
    # 第一：普通字段序列化
    btitle = serializers.CharField(label='名称', max_length=20)
    bpub_date = serializers.DateField(label='发布日期')
    bread = serializers.IntegerField(label='阅读量', required=False)
    bcomment = serializers.IntegerField(label='评论量', required=False)
    # 第二：一对多字段序列化
    # heroinfo_set = serializers.PrimaryKeyRelatedField(read_only=True, many=True)
    heroinfo_set = HeroInfoSerializer(many=True)
    # 第三：自定义显示（显示多对多）
    xxx = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = BookInfo

    # 自定义显示 多对多 字段
    def get_xxx(self,row):
        '''row: 传过来的正是 BookInfo表的对象'''
        books = row.btitle   # 获取用户名
        return books
```

#### 查询结果

```python
[
    {
        "id": 1,
        "btitle": "西游记",
        "bpub_date": "2020-08-11",
        "bread": 666,
        "bcomment": 123,
        "heroinfo_set": [
            {
                "id": 1,
                "hname": "孙悟空",
                "hgender": 1,
                "hcomment": "七十二变"
            },
            {
                "id": 2,
                "hname": "猪八戒",
                "hgender": 1,
                "hcomment": "天蓬元帅"
            }
        ],
        "xxx": "西游记"
    },
    {
        "id": 2,
        "btitle": "水浒传",
        "bpub_date": "2020-08-11",
        "bread": 200,
        "bcomment": 100,
        "heroinfo_set": [],
        "xxx": "水浒传"
    },
    {
        "id": 3,
        "btitle": "红楼梦",
        "bpub_date": "2020-08-11",
        "bread": 0,
        "bcomment": 0,
        "heroinfo_set": [],
        "xxx": "红楼梦"
    },
    {
        "id": 4,
        "btitle": "三国演义2",
        "bpub_date": "2018-08-19",
        "bread": 0,
        "bcomment": 0,
        "heroinfo_set": [],
        "xxx": "三国演义2"
    }
]
```

### 字段类型和选项参数

####  通用参数

- 无论哪种字段类型都可以使用的选项参数。

| 参数名称           | 说明                                     |
| ------------------ | ---------------------------------------- |
| **read_only**      | 表明该字段仅用于序列化输出，默认False    |
| **write_only**     | 表明该字段仅用于反序列化输入，默认False  |
| **required**       | 表明该字段在反序列化时必须输入，默认True |
| **default**        | 序列化和反序列化时使用的默认值           |
| **error_messages** | 包含错误编号与错误信息的字典             |
| **label**          | 用于HTML展示API页面时，显示的字段名称    |

> 注：定义序列化器类的字段时，如果没有指定read_only和write_only，则这两个参数默认值都为False，表明对应的字段既在序列化时使用，也在反序列化时使用。

#### 常用字段类型

| 字段                    | 字段构造方式                                                 |
| ----------------------- | ------------------------------------------------------------ |
| **BooleanField**        | BooleanField()                                               |
| **NullBooleanField**    | NullBooleanField()                                           |
| **CharField**           | CharField(max_length=None, min_length=None, allow_blank=False, trim_whitespace=True) |
| **EmailField**          | EmailField(max_length=None, min_length=None, allow_blank=False) |
| **RegexField**          | RegexField(regex, max_length=None, min_length=None, allow_blank=False) |
| **SlugField**           | SlugField(max_length=50, min*length=None, allow_blank=False) 正则字段，验证正则模式 [-a-zA-Z0-9*-]+ |
| **URLField**            | URLField(max_length=200, min_length=None, allow_blank=False) |
| **UUIDField**           | UUIDField(format='hex_verbose') format: 1) `'hex_verbose'` 如`"5ce0e9a5-5ffa-654b-cee0-1238041fb31a"` 2） `'hex'` 如 `"5ce0e9a55ffa654bcee01238041fb31a"` 3）`'int'` - 如: `"123456789012312313134124512351145145114"` 4）`'urn'` 如: `"urn:uuid:5ce0e9a5-5ffa-654b-cee0-1238041fb31a"` |
| **IPAddressField**      | IPAddressField(protocol='both', unpack_ipv4=False, **options) |
| **IntegerField**        | IntegerField(max_value=None, min_value=None)                 |
| **FloatField**          | FloatField(max_value=None, min_value=None)                   |
| **DecimalField**        | DecimalField(max_digits, decimal_places, coerce_to_string=None, max_value=None, min_value=None) max_digits: 最多位数 decimal_palces: 小数点位置 |
| **DateTimeField**       | DateTimeField(format=api_settings.DATETIME_FORMAT, input_formats=None) |
| **DateField**           | DateField(format=api_settings.DATE_FORMAT, input_formats=None) |
| **TimeField**           | TimeField(format=api_settings.TIME_FORMAT, input_formats=None) |
| **DurationField**       | DurationField()                                              |
| **ChoiceField**         | ChoiceField(choices) choices与Django的用法相同               |
| **MultipleChoiceField** | MultipleChoiceField(choices)                                 |
| **FileField**           | FileField(max_length=None, allow_empty_file=False, use_url=UPLOADED_FILES_USE_URL) |
| **ImageField**          | ImageField(max_length=None, allow_empty_file=False, use_url=UPLOADED_FILES_USE_URL) |
| **ListField**           | ListField(child=, min_length=None, max_length=None)          |
| **DictField**           | DictField(child=)                                            |



## ModelSerializer

### ModelSerializer

####  ModelSerializer特点

- ModelSerializer是Serializer类的子类
- 相对于Serializer，增加了以下功能：
  - 基于模型类字段自动生成序列化器类的字段
  - 包含默认的create()和update()方法的实现

#### 定义ModelSerializer语法

```python
from rest_framework import serializers

class BookInfoSerializer(serializers.ModelSerializer):
    """图书序列化器类"""
    class Meta:
        model = BookInfo
        fields = '__all__'
        # exclude = ('is_delete',)
        extra_kwargs = {
            'bread': {'min_value': 0, 'required': True},
            'bcomment': {'min_value': 0, 'required': True},
            'btitle': {'min_length': 3}
        }
```



####  查看自动生成字段

```python
(django2.2) C:\tmp\drf_demo>python manage.py shell -i ipython
In [1]: from book.serializers import BookInfoSerializer2
In [2]: book = BookInfoSerializer2()
In [3]: book
BookInfoSerializer2():
    id = IntegerField(label='ID', read_only=True)
    heroinfo_set = HeroInfoSerializer(many=True):
        id = IntegerField(label='ID', read_only=True)
        hname = CharField(label='名字', max_length=20)
        hgender = ChoiceField(choices=((0, '男'), (1, '女')), label='性别', required=False)
        hcomment = CharField(label='描述信息', max_length=200, required=False)
    btitle = CharField(label='名称', max_length=20)
    bpub_date = DateField(label='发布日期')
    bread = IntegerField(label='阅读量', required=False)
    bcomment = IntegerField(label='评论量', required=False)
    is_delete = BooleanField(label='逻辑删除', required=False)
```



### ModelSerializer使用

####  book/serializers.py

```python
# -*- coding: utf-8 -*-
from rest_framework import serializers
from book.models import BookInfo,HeroInfo

class HeroInfoSerializer(serializers.Serializer):
    """英雄数据序列化器"""
    GENDER_CHOICES = (
        (0, '男'),
        (1, '女')
    )
    id = serializers.IntegerField(label='ID', read_only=True)
    hname = serializers.CharField(label='名字', max_length=20)
    hgender = serializers.ChoiceField(label='性别', choices=GENDER_CHOICES, required=False)
    hcomment = serializers.CharField(label='描述信息', max_length=200, required=False)

    class Meta:
        model = HeroInfo


class BookInfoSerializer2(serializers.ModelSerializer):
    # 字段名名, 必须是模型可以 . 引用到的变量
    # BookInfo().   "heroinfo_set"  才能作为字段名,  如果是集合, 需要加many=True,
    heroinfo_set = HeroInfoSerializer(many=True)   # 
    """图书序列化器类"""
    class Meta:
        model = BookInfo
        fields = '__all__'
```



####  查询结果

```python
[
    {
        "id": 1,
        "heroinfo_set": [
            {
                "id": 1,
                "hname": "孙悟空",
                "hgender": 1,
                "hcomment": "七十二变"
            },
            {
                "id": 2,
                "hname": "猪八戒",
                "hgender": 1,
                "hcomment": "天蓬元帅"
            }
        ],
        "btitle": "西游记",
        "bpub_date": "2020-08-11",
        "bread": 666,
        "bcomment": 123,
        "is_delete": false
    },
    {
        "id": 2,
        "heroinfo_set": [],
        "btitle": "水浒传",
        "bpub_date": "2020-08-11",
        "bread": 200,
        "bcomment": 100,
        "is_delete": false
    },
    {
        "id": 3,
        "heroinfo_set": [],
        "btitle": "红楼梦",
        "bpub_date": "2020-08-11",
        "bread": 0,
        "bcomment": 0,
        "is_delete": false
    },
    {
        "id": 4,
        "heroinfo_set": [],
        "btitle": "三国演义2",
        "bpub_date": "2018-08-19",
        "bread": 0,
        "bcomment": 0,
        "is_delete": false
    }
]
```




### 多对多序列化

```python
# -*- coding: utf-8 -*-
from rest_framework import serializers
from course.models import *


class CourseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Course
        fields = '__all__'  # 所有字段


class SectionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sections
        fields = '__all__'


class ChaptersSerializer(serializers.ModelSerializer):
    sections = SectionsSerializer(many=True)

    class Meta:
        model = Chapters
        fields = '__all__'


class CourseDeepSerializer(CourseSerializer):
    # 字段名名, 必须是模型可以 . 引用到的变量
    # Course().   "chapters"  才能作为字段名,  如果是集合, 需要加many=True,
    chapters = ChaptersSerializer(many=True)
```







## APIVIEW



### DRF全局配置

####  settings.py注册

- 注册

```python
INSTALLED_APPS = [
    'rest_framework',
    'django_filters',
]
```



####  全局配置DRF

```python
# 过滤器
# 1,安装 django-filter
# 2,注册应用
# 3,配置settings, 在view里配置可过滤的字段
# 4,使用 查询字符串携带过滤信息

REST_FRAMEWORK = {
    # 1.认证器（全局）：用户登录校验用户名密码或者token是否合法
    'DEFAULT_AUTHENTICATION_CLASSES': [
        # 'rest_framework_jwt.authentication.JSONWebTokenAuthentication', # 在DRF中配置JWT认证
        'rest_framework.authentication.SessionAuthentication',          # 使用session时的认证器
        'rest_framework.authentication.BasicAuthentication'             # 提交表单时的认证器
    ],
    #2.权限配置（全局）： 顺序靠上的严格（根据不同的用户角色，可以操作不同的表）
    'DEFAULT_PERMISSION_CLASSES': [
        # 'rest_framework.permissions.IsAdminUser',                # 管理员可以访问
        # 'rest_framework.permissions.IsAuthenticated',            # 认证用户可以访问
        # 'rest_framework.permissions.IsAuthenticatedOrReadOnly',  # 认证用户可以访问, 否则只能读取
        # 'rest_framework.permissions.AllowAny',                   # 所有用户都可以访问
    ],
    #3.限流（防爬虫）
    'DEFAULT_THROTTLE_CLASSES': [
        'rest_framework.throttling.AnonRateThrottle',
        'rest_framework.throttling.UserRateThrottle',
    ],
    #3.1限流策略
    'DEFAULT_THROTTLE_RATES': {
        'user': '1000/hour',    # 认证用户每小时100次
        'anon': '300/day',       # 未认证用户每天能访问3次
    },

    'DEFAULT_CONTENT_NEGOTIATION_CLASS': 'rest_framework.negotiation.DefaultContentNegotiation',
    'DEFAULT_METADATA_CLASS': 'rest_framework.metadata.SimpleMetadata',
    'DEFAULT_VERSIONING_CLASS': None,

    #4.分页（全局）：全局分页器, 例如 省市区的数据自定义分页器, 不需要分页
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    # 每页返回数量
    'PAGE_SIZE': 10,  # 默认 None

    #5.过滤器后端
    'DEFAULT_FILTER_BACKENDS': [
        'django_filters.rest_framework.DjangoFilterBackend',
        # 'django_filters.rest_framework.backends.DjangoFilterBackend', 包路径有变化
    ],

    #5.1过滤排序（全局）：Filtering 过滤排序
    'SEARCH_PARAM': 'search',
    'ORDERING_PARAM': 'ordering',

    'NUM_PROXIES': None,

    #6.版本控制：Versioning  接口版本控制
    'DEFAULT_VERSION': None,
    'ALLOWED_VERSIONS': None,
    'VERSION_PARAM': 'version',
}
```



### APIView基本使用

####  book/models.py

```python
from django.db import models

#定义图书模型类BookInfo
class BookInfo(models.Model):
    btitle = models.CharField(max_length=20, verbose_name='名称')
    bpub_date = models.DateField(verbose_name='发布日期')
    bread = models.IntegerField(default=0, verbose_name='阅读量')
    bcomment = models.IntegerField(default=0, verbose_name='评论量')
    is_delete = models.BooleanField(default=False, verbose_name='逻辑删除')

    class Meta:
        db_table = 'tb_books'  # 指明数据库表名
        verbose_name = '图书'  # 在admin站点中显示的名称
        verbose_name_plural = verbose_name  # 显示的复数名称

    def __str__(self):
        """定义每个数据对象的显示信息"""
        return self.btitle
```




####  book/serializers.py

```python
# -*- coding: utf-8 -*-
from rest_framework import serializers
from book.models import BookInfo

class BookInfoSerializer2(serializers.ModelSerializer):
    """图书序列化器类"""
    class Meta:
        model = BookInfo
        fields = '__all__'
```

####  book/views.py

```python
from rest_framework.views import APIView
from rest_framework.response import Response
from book import serializers
from book.models import BookInfo

class APIViewBookInfoViewSet(APIView):
    def get(self, request):
        obj = BookInfo.objects.all()
        ser = serializers.BookInfoSerializer2(instance=obj, many=True)  # 关联数据多条
        return Response(ser.data)
```



####  book/urls.py

```python
from django.urls import re_path,path
from book import views

urlpatterns = [
    path('book1/', views.APIViewBookInfoViewSet.as_view()),
]
```



####  测试接口

#####  get获取数据

> http://127.0.0.1:8000/book/book1/

```python
[
    {
        "id": 1,
        "btitle": "西游记",
        "bpub_date": "2020-08-11",
        "bread": 666,
        "bcomment": 123,
        "heroinfo_set": [],
        "xxx": "西游记"
    },
    {
        "id": 2,
        "btitle": "水浒传",
        "bpub_date": "2020-08-11",
        "bread": 200,
        "bcomment": 100,
        "heroinfo_set": [],
        "xxx": "水浒传"
    }
]
```




#####  post添加数据

> http://127.0.0.1:8000/book/book1/

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210217181023301.90459b60.png)

#####  put修改数据

> http://127.0.0.1:8000/book/book1/?pk=4

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210217181515171.f1ff07c7.png)

### 自定义分页

####  自定义分页

```python
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.pagination import PageNumberPagination
from book import serializers
from book.models import BookInfo


# 分页（局部）：自定义分页器 局部
class PageNum(PageNumberPagination):
    # 查询字符串中代表每页返回数据数量的参数名, 默认值: None
    page_size_query_param = 'page_size'
    # 查询字符串中代表页码的参数名, 有默认值: page
    # page_query_param = 'page'
    # 一页中最多的结果条数
    max_page_size = 2

class APIViewBookInfoViewSet(APIView):
    def get(self, request):
        queryset = BookInfo.objects.all()
        # 分页
        pg = PageNum()
        page_objs = pg.paginate_queryset(queryset=queryset, request=request, view=self)
        ser = serializers.BookInfoSerializer2(instance=page_objs, many=True)  # 关联数据多条
        return Response(ser.data)
```




####  测试分页效果

> ```
> 查找第一页，每页显示两条数据
> ```
>
> http://127.0.0.1:8000/book/book1/?page=1&page_size=2

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210217213123806.c06a63de.png)

### 认证权限

####  使用自带权限

```python
# 注：认证类都在 `rest_framework.authentication` 模块中
from rest_framework.authentication import SessionAuthentication
from rest_framework.permissions import IsAuthenticated, AllowAny


class APIViewBookInfoViewSet(APIView):
    authentication_classes = (SessionAuthentication,)
    # permission_classes = [IsAuthenticated]   # 只有认证用户才能访问接口
    permission_classes = [AllowAny]   # 只有认证用户才能访问接口

    def get(self, request):
        queryset = BookInfo.objects.all()
        # 分页
        pg = PageNum()
        page_objs = pg.paginate_queryset(queryset=queryset, request=request, view=self)
        ser = serializers.BookInfoSerializer2(instance=page_objs, many=True)  # 关联数据多条
        return Response(ser.data)
```



####  自定义权限

#####  自定义权限

```python
from rest_framework.permissions import BasePermission

# 自定义权限（局部）
class MyPermission(BasePermission):
    # has_permission 是用户对这个视图有没有 GET POST PUT PATCH DELETE 权限的分别判断
    def has_permission(self, request, view):
        print('has_perm')
        # print(view.kwargs.get("pk"), request.user.id)
        """判断用户对模型有没有访问权"""
        # 任何用户对使用此权限类的视图都有访问权限
        if request.user.is_superuser:
            # 管理员对用户模型有访问权
            return True
        elif view.kwargs.get('pk') == str(request.user.id):
            # 携带的id和用户的id相同时有访问权
            return True
        return False

    # has_object_permission 是用户过了 has_permission 判断有权限以后，再判断这个用户有没有对一个具体的对象有没有操作权限
    def has_object_permission(self, request, view, obj):
        print('has_object_perm')
        """获取单个数据时,判断用户对某个数据对象是否有访问权限"""
        if request.user.id == obj.id:
            return True
        return False
```



##### 使用自定义权限

```python
# 注：认证类都在 `rest_framework.authentication` 模块中
from rest_framework.authentication import SessionAuthentication

class APIViewBookInfoViewSet(APIView):
    authentication_classes = (SessionAuthentication,)
    permission_classes = [MyPermission,]     # 只有认证用户才能访问接口

    def get(self, request):
        queryset = BookInfo.objects.all()
        # 分页
        pg = PageNum()
        page_objs = pg.paginate_queryset(queryset=queryset, request=request, view=self)
        ser = serializers.BookInfoSerializer2(instance=page_objs, many=True)  # 关联数据多条
        return Response(ser.data)
```



### 限流

#### 全局配置

- `DEFAULT_THROTTLE_RATES` 可以使用 `second`、`minute`、`hour` 或`day`来指明限流周期。

```python
REST_FRAMEWORK = {
    ...
    # 针对匿名用户和认证通过用户分别进行限流控制
    'DEFAULT_THROTTLE_CLASSES': (
        # 针对未登录(匿名)用户的限流控制类
        'rest_framework.throttling.AnonRateThrottle',
        # 针对登录(认证通过)用户的限流控制类
        'rest_framework.throttling.UserRateThrottle'
    ),
    # 指定限流频次
    'DEFAULT_THROTTLE_RATES': {
        # 认证用户的限流频次
        'user': '5/minute',
        # 匿名用户的限流频次
        'anon': '3/minute',
    },
}
```



####  指定视图配置

- 也可以某个视图中通过 `throttle_classes` 属性来指定某视图所使用的限流控制类

```python
from rest_framework.throttling import AnonRateThrottle

class BookInfoViewSet(ReadOnlyModelViewSet):
    ...
    # 此时设置当前视图仅针对匿名用户进行限流控制
    throttle_classes = [AnonRateThrottle]
```



### 过滤

####  自定义过滤

```python
from django_filters.rest_framework import DjangoFilterBackend

class APIViewBookInfoViewSet(APIView):
    filter_backends = (DjangoFilterBackend,)
    # 指定过滤字段, 不设置, 过滤功能不起效
    filter_fields = ('btitle', )  # ?username=tom&phone=&is_active=true

    def filter_queryset(self, queryset):
        for backend in list(self.filter_backends):
            queryset = backend().filter_queryset(self.request, queryset, self)
        return queryset

    def get(self, request):
        queryset = BookInfo.objects.all()
        # 过滤
        queryset = self.filter_queryset(queryset)

        # 分页
        pg = PageNum()
        page_objs = pg.paginate_queryset(queryset=queryset, request=request, view=self)
        ser = serializers.BookInfoSerializer2(instance=page_objs, many=True)  # 关联数据多条
        return Response(ser.data)
```




#### 测试过滤功能

http://127.0.0.1:8000/book/book1/?btitle=西游记

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210218085423621.7845ebf5.png)

### 排序

####  配置排序

```python
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import OrderingFilter

class APIViewBookInfoViewSet(APIView):
    filter_backends = (DjangoFilterBackend,OrderingFilter)
    # 指定过滤字段, 不设置, 过滤功能不起效
    filter_fields = ('btitle', )  # ?username=tom&phone=&is_active=true
    # 5.1指定排序字段, 不设置, 排序功能不起效
    ordering_fields = ('id',)    # ?ordering=-id

    def filter_queryset(self, queryset):
        for backend in list(self.filter_backends):
            queryset = backend().filter_queryset(self.request, queryset, self)
        return queryset
```



####  测试排序功能

http://127.0.0.1:8000/book/book1/?ordering=-id

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210218091655102.4c00dd73.png)







## 初始化项目结构

### 初始化项目结构

```python
└─shiyanlou_project          # 项目根路径
    │  .gitignore             # 提交git仓库时，不提交的文件必须要在这里进行标注
    │  README.en.md           # 英文（项目介绍）
    │  README.md              # 中文项目简介
    │  requirements.txt       # django项目安装文件
    │
    ├─celery_task            # 用来存放celery相关文件（以便分布式部署）
    │      __init__.py
    │
    ├─db                     # 数据库相关：1.数据库初始化sql脚本； 2.数据库维护脚本，清理，备份脚本
    ├─scrips                 # 脚本目录：1.定时任务脚本；2.页面静态化脚本；处理项目脚本
    ├─logs                   # 存放日志
    ├─packages               # 外部包，原始的，未配置的：1.七牛云sdk；2.阿里云短信；
    └─uwsgi_conf             # uwsgi配置，日志，pid
    │
    │
    └─syl                    # 真正的django项目（代码）django-admin startproject   项目名
        │  apps （python包）                   # Django各种app模块 
        │  libs （python包）                   # 七牛云sdk+配置（外部下载）
        │  utils （python包）                  # 小工具，常用函数(自己写的)
        │  static                 
        │  templates
        │  syl（项目配置）
        │  manager.py
```

![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20200925112025607.bc2897fc.png)

### 创建Django项目

```python
root@dev:shiyanlou_project# workon syl
(syl) root@dev:shiyanlou_project# cd /aaa/shiyanlou_project/
(syl) root@dev:shiyanlou_project# django-admin startproject syl
# 注：创建三个python包， apps、utils、libs
```



- 使用pycharm打开项目

  - 1.右击---->编辑配置----->

    - ```text
         PYTHONUNBUFFERED               1 
         DJANGO_SETTINGS_MODULE         syl.settings
      ```

      
      
  - ![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20201026153155814.5e3d43ff.png)
    
- 2.文件---->设置----->
  
  - ![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20201026153355278.2a5009a1.png)
  
- 3.文件---->设置----->
  
  - ![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20201026153527196.acc40888.png)

### 创建user模型

####  创建用户模型user

```python
python ../manage.py startapp user  # 创建user模型
```

1

####  在setting.py中注册user模型（第一步）

```python
INSTALLED_APPS = [
    'user.apps.UserConfig',
]
# 注：pycharm无法联想，需要把apps文件夹设置为源根
```



- 要想让pycharm识别要这样操作
  - ![img](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20201026185113022.9b1340d1.png)

####  syl/urls.py添加主路由（第二步）

```python
urlpatterns = [
    path('user/', include('user.urls')),
]
```

#### syl/settings.py中添加apps路径

```python
# 把apps目录插入，到系统包搜索路径第一个位置中
sys.path.insert(0,os.path.join(BASE_DIR,'apps'))
```



####  创建 user/urls.py子路由文件（第三步）

```python
from django.urls import path

urlpatterns = [

]
```



### 重写Django默认认证用户模型

####  重写django user表

```python
from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.
class User(AbstractUser):
    phone = models.CharField('手机号',max_length=20)
    img = models.ImageField(upload_to='user',null=True)
    nick_name = models.CharField('昵称',max_length=20)
    address = models.CharField('地址',max_length=255)

    class Meta:
        db_table = 'tb_user'
```



####  syl/settings.py中注册

```python
# 注册自己的用户模型类: 应用名.模型名，指定我们重写的User表进行身份验证
AUTH_USER_MODEL = 'user.User'
```



####  配置mysql

```python
'''1.创建mysql数据库'''
mysql> create database syldatabase charset utf8;

'''2.在syl/settings.py中配置mysql'''
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'syldatabase',              # 指定数据库名称：syldatabase
        'USER': 'root',
        'PASSWORD': '1',
        'HOST': '127.0.0.1',
        'PORT': '3306',
    }
}
```




#### 生成表

```python
python manage.py makemigrations
python manage.py migrate
```



### python中的三种路径

####  操作系统绝对路径（第一种）

- django 静态文件查找, 模板查找（第一种）

```python
# 去配置好的 文件夹 中查找指定的文件
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STATIC_URL = '/static/'
# /teach/shiyanlou_project/syl/apps/user/   # linux
# E:\_000\XSX
```



####  django 导包路径（第二种）

- 第一：`当期文件夹`
- 第二：`sys.path`

~~~python
导包之前, 包的上级路径, 需要存在于 python system 的 path
sys.path  这是一个列表
```
sys.path.insert(0, os.path.join(BASE_DIR, 'apps'))
```
from xxx import yyy  才能成功
~~~



####  django模型引用（第三种）

```python
想使用 一个 models.py 文件中的模型
apps名称.model模型名
'users.User'
```









## ModelViewSet

### DRF初始化

- 1.DRF框架的8个核心功能

```python
1.认证（用户登录校验用户名密码或者token是否合法）
2.权限（根据不同的用户角色，可以操作不同的表）
3.限流（限制接口访问速度）
4.序列化（返回json）
5.分页
6.版本（接口版本号，用 v1/v2/v3）
	# api.example.com/v1/login     # 只有用户名密码登录
	# api.example.com/v2/login     # 手机号，微信 登录
7.过滤（username=zhangsan）
8.排序（ordering=-id）
```



- `2.相关包`

```python
'''1.序列化相关'''
serializer
ModelSerializer
'''2.DRF视图函数继承'''
APIView
ModelViewSet
```



####  安装DRF

```python
pip install djangorestframework==3.11.0        # 安装djangorestframework
pip install django-filter==2.3.0             # 安装过滤器
```



####  在syl/settings.py中注册

```python
INSTALLED_APPS = [
    'django_filters',
    'rest_framework',
]
```



####  syl/settings.py配置DRF

```python
# 过滤器
# 1,安装 django-filter
# 2,注册应用
# 3,配置settings, 在view里配置可过滤的字段
# 4,使用 查询字符串携带过滤信息

REST_FRAMEWORK = {
    # 文档报错： AttributeError: ‘AutoSchema’ object has no attribute ‘get_link’
    # 用下面的设置可以解决
    'DEFAULT_SCHEMA_CLASS': 'rest_framework.schemas.AutoSchema',
    # 默认设置是:
    # 'DEFAULT_SCHEMA_CLASS': 'rest_framework.schemas.openapi.AutoSchema',

    # 异常处理器
    # 'EXCEPTION_HANDLER': 'user.utils.exception_handler',

    # Base API policies
    'DEFAULT_RENDERER_CLASSES': [
        'rest_framework.renderers.JSONRenderer',
        'rest_framework.renderers.BrowsableAPIRenderer',
    ],
    'DEFAULT_PARSER_CLASSES': [
        'rest_framework.parsers.JSONParser',
        'rest_framework.parsers.FormParser',
        'rest_framework.parsers.MultiPartParser'
    ],
    # 1.认证器（全局）：用户登录校验用户名密码或者token是否合法
    'DEFAULT_AUTHENTICATION_CLASSES': [
        # 'rest_framework_jwt.authentication.JSONWebTokenAuthentication',    # 在DRF中配置JWT认证
        # 'rest_framework.authentication.SessionAuthentication',  # 使用session时的认证器
        # 'rest_framework.authentication.BasicAuthentication'     # 提交表单时的认证器
    ],
    #2.权限配置（全局）： 顺序靠上的严格（根据不同的用户角色，可以操作不同的表）
    'DEFAULT_PERMISSION_CLASSES': [
        # 'rest_framework.permissions.IsAdminUser',                # 管理员可以访问
        # 'rest_framework.permissions.IsAuthenticated',            # 认证用户可以访问
        # 'rest_framework.permissions.IsAuthenticatedOrReadOnly',  # 认证用户可以访问, 否则只能读取
        # 'rest_framework.permissions.AllowAny',                   # 所有用户都可以访问
    ],
    #3.限流（防爬虫）
    'DEFAULT_THROTTLE_CLASSES': [
        'rest_framework.throttling.AnonRateThrottle',
        'rest_framework.throttling.UserRateThrottle',
    ],
    #3.1限流策略
    'DEFAULT_THROTTLE_RATES': {
        'user': '100/hour',    # 认证用户每小时100次
        'anon': '3/day',       # 未认证用户每天能访问3次
    },

    'DEFAULT_CONTENT_NEGOTIATION_CLASS': 'rest_framework.negotiation.DefaultContentNegotiation',
    'DEFAULT_METADATA_CLASS': 'rest_framework.metadata.SimpleMetadata',
    'DEFAULT_VERSIONING_CLASS': None,

    #4.分页（全局）：全局分页器, 例如 省市区的数据自定义分页器, 不需要分页
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    # 每页返回数量
    'PAGE_SIZE': 10,  # 默认 None

    #5.过滤器后端
    'DEFAULT_FILTER_BACKENDS': [
        'django_filters.rest_framework.DjangoFilterBackend',
        # 'django_filters.rest_framework.backends.DjangoFilterBackend', 包路径有变化
    ],

    #5.1过滤排序（全局）：Filtering 过滤排序
    'SEARCH_PARAM': 'search',
    'ORDERING_PARAM': 'ordering',

    'NUM_PROXIES': None,

    #6.版本控制：Versioning  接口版本控制
    'DEFAULT_VERSION': None,
    'ALLOWED_VERSIONS': None,
    'VERSION_PARAM': 'version',

    # Authentication  认证
    # 未认证用户使用的用户类型
    'UNAUTHENTICATED_USER': 'django.contrib.auth.models.AnonymousUser',
    # 未认证用户使用的Token值
    'UNAUTHENTICATED_TOKEN': None,

    # View configuration
    'VIEW_NAME_FUNCTION': 'rest_framework.views.get_view_name',
    'VIEW_DESCRIPTION_FUNCTION': 'rest_framework.views.get_view_description',

    'NON_FIELD_ERRORS_KEY': 'non_field_errors',

    # Testing
    'TEST_REQUEST_RENDERER_CLASSES': [
        'rest_framework.renderers.MultiPartRenderer',
        'rest_framework.renderers.JSONRenderer'
    ],
    'TEST_REQUEST_DEFAULT_FORMAT': 'multipart',

    # Hyperlink settings
    'URL_FORMAT_OVERRIDE': 'format',
    'FORMAT_SUFFIX_KWARG': 'format',
    'URL_FIELD_NAME': 'url',

    # Encoding
    'UNICODE_JSON': True,
    'COMPACT_JSON': True,
    'STRICT_JSON': True,
    'COERCE_DECIMAL_TO_STRING': True,
    'UPLOADED_FILES_USE_URL': True,

    # Browseable API
    'HTML_SELECT_CUTOFF': 1000,
    'HTML_SELECT_CUTOFF_TEXT': "More than {count} items...",

    # Schemas
    'SCHEMA_COERCE_PATH_PK': True,
    'SCHEMA_COERCE_METHOD_NAMES': {
        'retrieve': 'read',
        'destroy': 'delete'
    },
}
```



### DRF使用

- 认证、权限、限流、分页、过滤、序列化

####  user/urls.py

- ModelViewSet注册路由三部曲

```python
from django.urls import include, path
from user import views
from rest_framework.routers import SimpleRouter, DefaultRouter

# 自动生成路由方法, 必须使用视图集
# router = SimpleRouter()  # 没有根路由  /user/ 无法识别
router = DefaultRouter()                       # 1.有根路由
router.register(r'user', views.UserViewSet)    # 2.配置路由

urlpatterns = [
    path('index/', views.index),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))  # 认证地址
]

urlpatterns += router.urls     # 3.模块地址
```




```python
[<URLPattern '^user/$' [name='user-list']>, 
 <URLPattern '^user\.(?P<format>[a-z0-9]+)/?$' [name='user-list']>,
 <URLPattern '^user/actived/$' [name='user-actived']>, 
 <URLPattern '^user/actived\.(?P<format>[a-z0-9]+)/?$' [name='user-actived']>, 
 <URLPattern '^user/unactived/$' [name='user-unactived']>, 
 <URLPattern '^user/unactived\.(?P<format>[a-z0-9]+)/?$' [name='user-unactived']>, <URLPattern '^user/(?P<pk>[^/.]+)/$' [name='user-detail']>, <URLPattern '^user/(?P<pk>[^/.]+)\.(?P<format>[a-z0-9]+)/?$' [name='user-detail']>, <URLPattern '^$' [name='api-root']>, <URLPattern '^\.(?P<format>[a-z0-9]+)/?$' [name='api-root']>] DRF
```



####  serializers.py

- 创建`user/serializers.py`写序列化器
- 功能一：数据校验，`创建/修改数据`
  - 在创建数据或者修改数据时校验用户提交的数据是否合法
  - 用户名必须是8位以上，邮箱、手机号是合法的
- 功能二：序列化
  - 把通过model查询的queryset对象转换成JSON格式

```python
from rest_framework import serializers
from user.models import User


def address_validate(data):
    # data：是用户提交的地址这个字段的数据（河南省 郑州市）
    # 独立校验器
    # raise serializers.ValidationError('请填写实际地址')  # 有错就抛出异常
    # 没错就返回数据
    return data


class UserSerializer(serializers.ModelSerializer):
    # 1.独立校验器：重新设定字段, 替换掉模型中的设定, 重新设定地址的长度为5
    # address_validate是自定义的数据校验函数
    address = serializers.CharField(max_length=255, min_length=5, validators=[address_validate])

    # 2.单一字段验证（validate_字段名）, 验证地址
    def validate_address(self, data):
        if data == '测试':
            raise serializers.ValidationError('请填写实际地址')  # 有错就抛出异常
        return data  # 没错就返回结果

    def validate_phone(self, data):
        # 不符合手机号格式
        # raise serializers.ValidationError('手机号格式不正确')
        model = self.root.Meta.model
        num = model.objects.filter(phone=data).count()
        if num > 0:
            raise serializers.ValidationError('手机号已存在')
        return data

    # 3.所有属性验证器
    def validate(self, attrs):
        # attrs：{"username":"zhangsan", "phone":"18538752511", ....}
        # 所有属性验证器
        # self.context 中有request和view上下文
        # self.context['view'].action 可以取到动作
        # attrs 是需要序列化的数据
        # raise serializers.ValidationError('xxx错误')  # 有问题报错
        return attrs  # 没问题返回数据

    class Meta:
        model = User              # 具体对哪个表进行序列化
        fields = '__all__'  # 所有字段
        # fields = ('id', )       # 临时添加字段也需要写在这里
        # exclude = ['id']  # 排除 id 字段
        # read_only_fields = ('',)  # 指定字段为 read_only,


class UserUnActiveSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'is_active')  # 临时添加字段也需要写在这里
        # fields = '__all__'  # 所有字段
```




#### user/views.py

```python
from django.http import HttpResponse
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets
from rest_framework.authentication import BasicAuthentication, SessionAuthentication
from rest_framework.decorators import action
from rest_framework.filters import OrderingFilter
from rest_framework.permissions import AllowAny, IsAdminUser, IsAuthenticated, IsAuthenticatedOrReadOnly
from rest_framework.response import Response
from rest_framework.throttling import UserRateThrottle
from rest_framework.pagination import PageNumberPagination
from rest_framework.views import APIView
from rest_framework.permissions import BasePermission, SAFE_METHODS
from user.models import User
from user.serializers import UserSerializer, UserUnActiveSerializer


def index(request):
    # 需要认证才能访问的视图
    return HttpResponse('hello')


# 分页（局部）：自定义分页器 局部
class PageNum(PageNumberPagination):
    # 查询字符串中代表每页返回数据数量的参数名, 默认值: None
    page_size_query_param = 'page_size'
    # 查询字符串中代表页码的参数名, 有默认值: page
    # page_query_param = 'page'
    # 一页中最多的结果条数
    max_page_size = 2


# 自定义权限（局部）
class MyPermission(BasePermission):
    # has_permission 是用户对这个视图有没有 GET POST PUT PATCH DELETE 权限的分别判断
    def has_permission(self, request, view):
        print('has_perm')
        # print(view.kwargs.get("pk"), request.user.id)
        """判断用户对模型有没有访问权"""
        # 任何用户对使用此权限类的视图都有访问权限
        if request.user.is_superuser:
            # 管理员对用户模型有访问权
            return True
        elif view.kwargs.get('pk') == str(request.user.id):
            # 携带的id和用户的id相同时有访问权
            return True
        return False

    # has_object_permission 是用户过了 has_permission 判断有权限以后，再判断这个用户有没有对一个具体的对象有没有操作权限
    # 这样设置以后，即使是django admin管理员也只能查询自己user标的信息，不能查询其他用户的单条信息
    def has_object_permission(self, request, view, obj):
        print('has_object_perm')
        """获取单个数据时,判断用户对某个数据对象是否有访问权限"""
        if request.user.id == obj.id:
            return True
        return False


class UserViewSet(viewsets.ModelViewSet):
    """
    完成产品的增删改查
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer  # 优先使用 get_serializer_class 返回的序列化器

    # # 1.认证：自定义认证类, 自定义会覆盖全局配置
    # authentication_classes = (BasicAuthentication, SessionAuthentication)
    # # 2.权限：自定义权限类
    # permission_classes = (MyPermission,)
    
    # 3.分页：自定义分页器 覆盖全局配置
    pagination_class = PageNum
    
    # 4.限流：自定义限流类
    throttle_classes = [UserRateThrottle]

    # 5.过滤：指定过滤方法类, 排序方法类, 一个或多个
    filter_backends = (DjangoFilterBackend, OrderingFilter)  # 同时支持过滤和排序
    # 5.1指定排序字段, 不设置, 排序功能不起效
    ordering_fields = ('date_joined', 'id')              # ?ordering=-id
    # 5.2指定过滤字段, 不设置, 过滤功能不起效
    filter_fields = ('username', 'phone', 'is_active')   # ?username=tom&phone=&is_active=true


    # 根据不同的请求, 获得不同的序列化器
    def get_serializer_class(self):
        if self.action == 'unactived':
            return UserUnActiveSerializer
        else:
            return UserSerializer

    @action(methods=['get'], detail=False)
    def unactived(self, request, *args, **kwargs):
        # 获取查询集, 过滤出未激活的用户
        qs = self.queryset.filter(is_active=False)
        # 使用序列化器, 序列化查询集, 并且是
        ser = self.get_serializer(qs, many=True)
        return Response(ser.data)
    
    @action(methods=['get'], detail=False)
    def actived(self, request, *args, **kwargs):
        # 获取查询集, 过滤出未激活的用户
        qs = self.queryset.filter(is_active=True)
        # 使用序列化器, 序列化查询集, 并且是
        ser = self.get_serializer(qs, many=True)
        return Response(ser.data)
```





### 测试接口

#### 查询 接口

- 查询路由

```python
#1.查询所有用户
http://192.168.56.100:8888/user/user/
#2.查询id=1的用户
http://192.168.56.100:8888/user/user/1/    #3.查询 用户名（tom），激活的用户
http://192.168.56.100:8888/user/user/?username=tom&phone=&is_active=true
#4.查询所有用户 用id 反向排序
http://192.168.56.100:8888/user/user/?ordering=-id
#5.查询用户表中第一页，每页显示一条数据
http://192.168.56.100:8888/user/user/?page=1&page_size=1
```



- 增加（POST）

```python
#1.增加用户
http://192.168.56.100:8888/user/user/
```

- 修改（PUT）

```python
# 修改用户信息
http://192.168.56.100:8888/user/user/1/
```



- 删除（DELETE）

```python
# 删除用户
http://192.168.56.100:8888/user/user/1/
```




####  自定义认证权限

#####  测试`全局权限`功能

- 在浏览器中，打开任意接口，未登录用户只能发送get请求，只有登录用户才能发送post等请求

```python
# http://192.168.56.100:8888/user/user/
'''syl/settings.py中设置，只有认证用户可以访问, 否则只能读取
REST_FRAMEWORK = {
    #2.权限配置（全局）： 顺序靠上的严格
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticatedOrReadOnly',  # 认证用户可以访问, 否则只能读取
    ],
}
```



#####  测试`自定义权限`功能

- `注：自定义权限会覆盖settings.py中配置的全局权限`
- 1.自定义权限（`其实应该写到一个单独的文件内进行公用，这里先写到这里进行测试`）

```python
# 自定义权限（局部）
class MyPermission(BasePermission):
    # has_permission 是用户对这个视图有没有 GET POST PUT PATCH DELETE 权限的分别判断
    def has_permission(self, request, view):
        print('has_perm')
        # print(view.kwargs.get("pk"), request.user.id)
        """判断用户对模型有没有访问权"""
        # 任何用户对使用此权限类的视图都有访问权限
        if request.user.is_superuser:
            # 管理员对用户模型有访问权
            return True
        elif view.kwargs.get('pk') == str(request.user.id):
            # 携带的id和用户的id相同时有访问权
            return True
        return False

    # has_object_permission 是用户过了 has_permission 判断有权限以后，再判断这个用户有没有对一个具体的对象有没有操作权限
    def has_object_permission(self, request, view, obj):
        print('has_object_perm')
        """获取单个数据时,判断用户对某个数据对象是否有访问权限"""
        if request.user.id == obj.id:
            return True
        return False
```



- 2.`user/viesws.py视图函数中指定当前视图要用的`权限类

```python
class UserViewSet(viewsets.ModelViewSet):
    # 2.权限：自定义权限类
    permission_classes = (MyPermission,)
```

####  限流

- `syl/settings.py中配置限流`

```python
http://192.168.56.100:8888/user/apiview/
'''修改syl/settings.py配置限速设置'''
REST_FRAMEWORK = {
    #3.1 限流策略
    'DEFAULT_THROTTLE_RATES': {
        'user': '3/hour',    # 认证用户每小时10次
        'anon': '3/day',     # 未认证用户每天
    },
}
```



#### 序列化

- `user/serialzers.py`

```python
from rest_framework import serializers
from user.models import User

def address_validate(data):
    # 独立校验器
    # raise serializers.ValidationError('请填写实际地址')  # 有错就抛出异常
    # 没错就返回数据
    return data


class UserSerializer(serializers.ModelSerializer):
    # 1.独立校验器：重新设定字段, 替换掉模型中的设定, 重新设定地址的长度为5
    address = serializers.CharField(max_length=255, min_length=5, validators=[address_validate])

    # 2.单一字段验证, 验证地址，validate_字段名
    def validate_address(self, data):
        if data == '测试':
            raise serializers.ValidationError('请填写实际地址')  # 有错就抛出异常
        return data  # 没错就返回结果

    def validate_phone(self, data):
        # 不符合手机号格式
        # raise serializers.ValidationError('手机号格式不正确')
        model = self.root.Meta.model
        num = model.objects.filter(phone=data).count()
        if num > 0:
            raise serializers.ValidationError('手机号已存在')
        return data

    # 3.所有属性验证器
    def validate(self, attrs):
        # attrs：{"username":"zhangsan", "phone":"18538752511", ....}
        # 所有属性验证器
        # self.context 中有request和view上下文
        # self.context['view'].action 可以取到动作
        # attrs 是需要序列化的数据
        # raise serializers.ValidationError('xxx错误')  # 有问题报错
        return attrs  # 没问题返回数据

    class Meta:
        model = User        # 指定表
        # fields = ('id', ) # 临时添加字段也需要写在这里
        fields = '__all__'  # 所有字段
        # exclude = ['id']  # 排除 id 字段
        read_only_fields = ('id',)  # 指定字段为 read_only,

        # 扩展address： extra_kwargs = {}  # 局部替换某些字段的设定, 或者新增设定
        extra_kwargs = {
            "address": {
                "min_length": 5,  # 给地址增加 最小长度限制
                "default": '默认测试地址',  # 增加默认值
            }
        }
```



####  自定义分页

```javascript
http://192.168.56.100:8888/user/user/?page=1&page_size=1
```

1

- 1.`user/views.py`中定义自定义分页类

```python
# 分页（局部）：自定义分页器 局部
class PageNum(PageNumberPagination):
    # 查询字符串中代表每页返回数据数量的参数名, 默认值: None
    page_size_query_param = 'page_size'
    # 查询字符串中代表页码的参数名, 有默认值: page
    # page_query_param = 'page'
    # 一页中最多的结果条数
    max_page_size = 2
```




- 2.`user/views.py`视图函数中使用

```python
class UserViewSet(viewsets.ModelViewSet):
    # 3.分页：自定义分页器 覆盖全局配置
    pagination_class = PageNum
```



####  过滤和排序

- 测试url

```python
#1.过滤：查询 用户名（tom），激活的用户
http://192.168.56.100:8888/user/user/?username=tom&phone=&is_active=true
#2.排序：查询所有用户 用id 反向排序
http://192.168.56.100:8888/user/user/?ordering=-id
```



- `user/views.py`视图函数中配置过滤和排序字段

```python
class UserViewSet(viewsets.ModelViewSet):
    # 5.过滤：指定过滤方法类, 排序方法类, 一个或多个
    filter_backends = (DjangoFilterBackend, OrderingFilter)  # 同时支持过滤和排序
    
    # 5.1指定排序字段, 不设置, 排序功能不起效
    ordering_fields = ('date_joined', 'id')  # ?ordering=-id
    # 5.2指定过滤字段, 不设置, 过滤功能不起效
    filter_fields = ('username', 'phone', 'is_active')  # ?username=tom&phone=&is_active=true
```



### 多对多序列化

```python
# -*- coding: utf-8 -*-
from rest_framework import serializers
from course.models import *


class CourseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Course
        fields = '__all__'  # 所有字段


class SectionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sections
        fields = '__all__'


class ChaptersSerializer(serializers.ModelSerializer):
    sections = SectionsSerializer(many=True)

    class Meta:
        model = Chapters
        fields = '__all__'


class CourseDeepSerializer(CourseSerializer):
    # 字段名名, 必须是模型可以 . 引用到的变量
    # Course().   "chapters"  才能作为字段名,  如果是集合, 需要加many=True,
    chapters = ChaptersSerializer(many=True)
```




### 其他用法

####  views.py

```python
from rest_framework import viewsets, status
class DAppViewSet(viewsets.ModelViewSet):
    serializer_class = DAppSerializer
    queryset = DApp.objects.all()
    filter_class = DAppFilter

    def list(self, *args, **kwargs):
        orig_queryset = self.filter_queryset(self.get_queryset())
        fav_qs = UserFavoriteProject.objects.filter(user=self.request.user).values_list('project__id', flat=True)
        queryset = orig_queryset.exclude(pk__in=fav_qs)
        pu_qs = ProjectGroupUser.objects.filter(user=self.request.user).values_list('project__id', flat=True)
        qs = queryset.exclude(pk__in=pu_qs).values_list('id', flat=True)
        pk_lists = list(fav_qs) + list(pu_qs) + list(qs)

        ordering = 'FIELD(`id`, %s)' % ','.join(str(p) for p in pk_lists)
        queryset = orig_queryset.filter(pk__in=list(pk_lists)).extra(select={'ordering': ordering}, order_by=('ordering',))

        page = self.paginate_queryset(queryset)

        result_queryset = queryset
        if page is not None:
            result_queryset = page

        serializer = self.get_serializer(result_queryset, many=True)
        if page is not None:
            result = self.get_paginated_response(serializer.data)
        else:
            result = Response(serializer.data)
        return result
```




####  serializers.py

```python
class DAppSerializer(DynamicFieldsSerializerMixin, serializers.ModelSerializer):
    name = serializers.CharField(required=True)
    git_repo = serializers.CharField(required=True)
    project = serializers.SlugRelatedField(slug_field='name', required=True, allow_null=True, queryset=DProject.objects.all())
    level = serializers.CharField(required=True)
    creator = serializers.SlugRelatedField(slug_field='full_name', required=False, many=False, queryset=User.objects.all())
    create_time = serializers.DateTimeField(required=False, read_only=True)
    update_time = serializers.DateTimeField(required=False, read_only=True)
    is_archived = serializers.BooleanField(required=False)
    is_deleted = serializers.BooleanField(required=False)
    is_favorite = False
    channel_apps = []

    class Meta:
        model = DApp
        fields = ('id', 'name', 'git_repo', 'project', 'creator', 'create_time', 'update_time', 'is_archived', 'is_deleted', 'level')
        validators = [
            UniqueTogetherValidator(
                queryset=DApp.objects.filter(is_deleted=False),
                fields=['name', 'project'],
                message="该团队下已有同名应用!"
            )
        ]

    def create(self, validated_data):
        validated_data['creator'] = self.context['request'].user
        instance = super(DAppSerializer, self).create(validated_data)
        for channel_app in self.channel_apps:
            obj = ChannelApp.objects.create(**channel_app)
            obj.done_app = instance
            obj.save()
        AppGroupUser.objects.create(user=self.context['request'].user,app=instance,role='1')
        return instance

    def update(self, instance, validated_data):
        user = self.context['request'].user
        if self.is_favorite is True:
            UserFavoriteApp.objects.get_or_create(user=user, app=instance)
        elif self.is_favorite is False:
            favorite = UserFavoriteApp.objects.filter(user=user, app=instance).last()
            if favorite:
                favorite.delete()
        for channel_app in self.channel_apps:
            qs = ChannelApp.objects.filter(**channel_app).filter(done_app=instance)
            if not qs.exists():
                obj = ChannelApp.objects.create(**channel_app)
                obj.done_app = instance
                obj.save()

        return super(DAppSerializer, self).update(instance, validated_data)

    def to_internal_value(self, data):
        if 'is_favorite' in data:
            self.is_favorite = data.pop('is_favorite')
        if 'channel_apps' in data:
            self.channel_apps = data.pop('channel_apps')
        return super(DAppSerializer, self).to_internal_value(data)

    def to_representation(self, instance):
        result = super(DAppSerializer, self).to_representation(instance)
        project = instance.project
        # 1.找到所有"团队管理员"
        items = ProjectGroupUser.objects.filter(project=project, role='1').values_list("user__full_name", flat=True)
        admins = {item.strip() for item in items if item.strip()}

        # 2.找到所有"应用管理员"
        items = AppGroupUser.objects.filter(app=instance, role='1').values_list("user__full_name", flat=True)
        app_admins = {item.strip() for item in items if item.strip()}
        admins.update(app_admins)
        result['admins'] = list(admins)

        # 3.判断是否 "is_favorite"
        user = self.context['request'].user
        qs = UserFavoriteApp.objects.filter(user=user, app=instance)
        result['is_favorite'] = True if qs.exists() else False

        # 4.判断是否有"编辑应用"权限
        pg = ProjectGroupUser.objects.filter(project=project, user=user, role='1')
        ag = AppGroupUser.objects.filter(app=instance, user=user, role='1')
        sys_admin = SysRole.objects.filter(user=user,role='1')
        result['can_be_updated'] = any([pg.exists(), ag.exists(), sys_admin.exists()])

        values = ChannelApp.objects.filter(done_app=instance).values(
            "channel", "channel_sys_name", "channel_app_domain", "channel_app_name", "channel_app_type",
            "channel_app_language")
        result["channel_apps"] = list(values)
        result['locked'] = self.get_app_locked(instance)
        return result

    def get_app_locked(self, instance):
        if DeltaInstance.objects.filter(Q(app=instance) & ~Q(status__config_name__in=['success', 'cancel'])):
            return True
        return False
```



#### filters.py

```python
class DAppFilter(FilterSet):
    name = CharFilter(lookup_expr="icontains")
    is_archived = CaseInsensitiveBooleanFilter()
    is_deleted = CaseInsensitiveBooleanFilter()
    project = CharFilter(method="filter_project")
    exact_name = CharFilter(method="filter_exact_name")
    project_id = CharFilter(method="filter_project_id")

    class Meta:
        model = DApp
        fields = ('name', 'is_archived', 'is_deleted', 'project')

    def filter_project(self, qs, name, value):
        return qs.filter(project__name=value)

    def filter_exact_name(self, qs, name, value):
        return qs.filter(name=value, is_deleted=False)

    def filter_project_id(self, qs, name, value):
        user = self.request.user
        project_id = value
        # 如果是"系统管理员",和团队管理员可以看见所有
        if CurrentUserRoles.is_sys_admin(user) or CurrentUserRoles.is_project_admin(user, project_id):
            return qs.all()
        # 查询当前用户，在project_id这个团队下，角色为应用管理员的所有 应用角色
        project_apps = AppGroupUser.objects.filter(app__project_id=project_id, user=user, role='1')
        app_ids = [appuser.app.id for appuser in project_apps]
        if project_apps:
            return qs.filter(id__in=app_ids)
        return qs.none()
```
