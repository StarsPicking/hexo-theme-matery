---
title: go基础
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: Go
tags:
  - go基础
abbrlink: 65207
date: 2022-10-29 13:07:40
img:
coverImg:
summary:

---

# go语言安装和介绍

## go语言介绍



> go语言是googe在2009年正式对外发布的一门编程语言
>
> 根据go开发者自述，近10多年，计算机从单机c语言时代到现在互联网时代的java，都没有出现特别令人满意的语言。c++给人的感觉是， 花了100%的精力，却只有60%的开发效率，产能比太低，java和c#又来源于c++
>
> 随着硬件的不断升级，这些语言不能充分的利用硬件以及cpu
>
> 因此，一门高效、简洁、开源的语言诞生了
>
> go语言不仅拥有静态编译语言的安全和高性能，而又达到了动态语言的开发速度和易维护性
>
> 有人形容：go = c + python
>
> go非常有潜力，目前几个火爆的场景下都有应用，比如web开发、区块链、游戏服务端开发、分布式/云计算

## go语言解决的问题

- 多核硬件下的资源利用问题
- 超大规模分布式计算集群
- web开发模式导致的前所未有的开发规模和更新速度

## win安装go语言

### 下载go



- [go官网下载]( https://golang.org/dl/ )

- [go镜像站下载](https://golang.google.cn/dl/)

  

  ![1667039669273](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/1667039669273.png)

### 验证安装

- go 1.11后无需手动配置环境变量，使用go mod 管理项目

- 也不需要必须把项目放在gopath 目录下，可以再任何目录下新建项目

- go1.13以后彻底不需要gopath了

  ```shell
  go version   # 查看版本
  go env       # 查看环境
  ```

  

### 安装依赖包



- 这里的更新不是指版本的更新,而是指引入新依赖，不使用 go get ,我怎么在项目中加新包呢?

- 直接项目中 import 这个包,之后更新依赖即可依赖更新请从检测依赖部分一直执行即可,即

- 参考：https://blog.csdn.net/weixin_41519463/article/details/103501485

  ```shell
  go mod init      # 初始化go.mod
  go mod tidy      # 更新依赖文件
  go mod download    # 下载依赖文件
  go mod vendor     # 将依赖转移至本地的vendor文件
  go mod edit      # 手动修改依赖文件
  go mod graph      # 打印依赖图
  go mod verify     # 校验依赖
  ```

  

# vscode配置

## 下载vscode

- [官网]( https://code.visualstudio.com/)

  

## 汉化



 ![image-20210513210124050.a52b64f4](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210513210124050.a52b64f4.png)



## 安装go语言插件



![image-20210513210342871.8ce13397](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20210513210342871.8ce13397.png)





## 运行一个示例程序

- 进入项目目录新建文件main.go

```go
package main

// 导入语句
import "fmt"
// 程序的入口
func main(){
    fmt.Print("hello world")
}
```



- 打开终端选择cmd或者powershell
- 执行命令**go build hello.go**
- 目录下会生成 hello.exe 然后运行命令**hello.exe**会看到命令行输出hello world



## go mod配置代理

https://goproxy.io是一个国内的代理
执行

```shell
# 旧版，已废弃
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.io,direct

```



```go
# 新版改成如下链接
go env -w GO111MODULE=on
go env -w GOPROXY=https://proxy.golang.com.cn,direct
```

关闭vscode重新打开，再次点击install all

![在这里插入图片描述](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/20200731113650658.png)

成功安装

开启go mod 代理后也可以手动安装

go get -u -v github.com/mdempsky/gocode
go get -u -v github.com/uudashr/gopkgs/v2/cmd/gopkgs
go get -u -v github.com/ramya-rao-a/go-outline
go get -u -v github.com/acroca/go-symbols
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v github.com/cweill/gotests/...
go get -u -v github.com/fatih/gomodifytags
go get -u -v github.com/josharian/impl
go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct
go get -u -v github.com/haya14busa/goplay/cmd/goplay
go get -u -v github.com/godoctor/godoctor
go get -u -v github.com/go-delve/delve/cmd/dlv
go get -u -v github.com/stamblerre/gocode
go get -u -v github.com/rogpeppe/godef
go get -u -v github.com/sqs/goreturns
go get -u -v golang.org/x/lint/golint



## 基本命令

- go run

  -  像执行脚本文件一样执行go代码

- go install

  - 分为两步：

    1. 执行go build命令，然

    2. 后将exe 拷贝到go path路径下，这样在环境变量里就可以用了

## 跨平台编译

```cmd
CGO_ENABLED=0 
GOOS=linux
GOARCH=amd64
go build main.go
```



## vscode 切换默认终端

- 选择默认配置文件

  ![image-20230316101919989](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230316101919989.png)



- 选择cmd配置文件

  ![image-20230316102038271](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230316102038271.png)





# 基本语法

## go语言文件的基本结构

```go
package main

// 导入语句
import "fmt"

// 函数的外部只能是标识符（变量、常量、函数、类型）的声明

// 函数的入口
func main(){
    
}
```



## 变量的定义方式

### var 声明单个变量



```go
var name string
var age int
var isOk bool

```

### var 批量声明变量



```go
package main
import "fmt"
var {
	name strig
	age int
	isOk bool	
}
var S1 string="张三"  // 声明变量同时赋值

func main(){
    name = "张三"
    age = 16
    isOk = true
    fmt.Print(isOk) // 在终端中打印内容
    fmt.Printf("name:%s"，name) // %s占位符，使用name这个变量的值替换占位符
    fmt.Println(age) // 打印完指定的内容之后会在后面加一个换行符
}
```



### 声明变量同时赋值



```go
package main
import "fmt"
var {
	name strig
	age int
	isOk bool	
}
var S1 string="张三"  // 声明变量同时赋值
```



### 列表推导式声明变量



```go
var name = "张三"
var age = 18
var isOk = bool
```

### 函数内使用简短变量



```go
// 只能在函数里使用
func main{
	age := 18
	name := "张三"
}
```

### 简短变量



```go
func foo()(int, string){
	return 10, "匿名变量"
}

func main(){
	content, _ = foo()
}
```

**go语言中声明的局部变量必须使用，不使用编译不过去**

**go语言中变量的命名建议使用小驼峰**



### 匿名变量



```go
package main

import "fmt"

// 函数外面只能防止标识符（函数/变量/常数/类型）的申明
var name string
var age int
var isOk bool
// 批量申明， 推荐使用小驼峰方式
var (
	name1 string
	age2  int	
	isOk3 bool
	//
)

var(
	nums int
	goods string
	
)
// 常量：常量是恒定不变的量
func foo()(int, string){
	return 10, "匿名变量"
}
func main() {
	var username, gender string
	username = "张三"
	gender = "男"
	name = "理想"
	age = 16
	isOk = true
	fmt.Println(username, gender)
	fmt.Printf("%d", age)
	// go语言中申明的非全局变量必须使用，不使用编译不过去
	fmt.Println()                 // 打印一句话，默认打印换行
	fmt.Printf("name:%s\n", name) // 使用printf %s占位符
	fmt.Println(age)
	fmt.Println(isOk)
	fmt.Print("你好")  // 不会换行

	// 简短变量申明  
	s3 := "go语言真是太好了"
	fmt.Printf("print: %v\n", s3)
	// 匿名变量
	_, content := foo()
	fmt.Println(content)
	// 同一个作用域中不能申明同名的变量
}


```



## 常量

### 常量的定义

- 常量： 定义了之后不能修改， 在程序运行期间不会改变的值

  

### 声明常量



```go
const(
	statusOk = 200
	notFound = 404
)
```

### 批量声明变量



- 批量声明变量时，如果某一行声明后没有赋值，默认和上一行的值相同

```go
const(
	n1 = 100
	n2
	n3
)
```

### iota

#### iota的定义

- iota : go语言里的常量计数器，只能在常量的表达式中使用

- 在const 关键字出现时将被重置为0， 

- const每新增一行常量声明，将使iota的值+1

  

```go
const (

  a1 = iota  // 0
  a2 = iota  // 1
  _ = iota   // 2
  a3     // 3
)


```

#### iota的使用 

- 插队

```go
const (

  b1 = iota  // 0

  b2 = 100  // 100

  b3 = iota  // 2

  b4 = iota  // 3

)
```



- 多个变量声明在一行, 不会iota不会增加，只有换行才会增加

```go
const (

  d1, d2 = iota + 1, iota + 2  // 1， 2



  d3, d4 = iota + 1, iota + 2  // 2， 3



)


```

- 定义数量级

```go
const (

  _ = iota

  KB = 1<< (10*iota)

  MB = 1<< (10*iota)

  GB = 1<< (10*iota)

  TB = 1<< (10*iota)

  PB = 1<< (10*iota)

)


func main(){

  fmt.Println(a1, a2, a3)

  fmt.Println(b1, b2, b3, b4)

  fmt.Println(d1, d2, d3, d4)

}
```

## fmt 包

### 输出方式比较



- Print

  - 一次输入多个值的时候中间没有空格

  - Print 不会自动换行

    

- Printf

  - 格式化输出

- Println

  - 一次输入多个值的时候中间有空格
  - Pritln会自动给换行

### 实例



```go
func main()  {
	var n = 100
	fmt.Printf("%T\n", n)  // 查看类型
	fmt.Printf("%v\n", n)  // 查看变量的值
	fmt.Printf("%b\n", n)  // 
	fmt.Printf("%d\n", n)  // 十进制
	fmt.Printf("%o\n", n)  // 
	fmt.Printf("%x\n", n)

	var s = "hello world"
	fmt.Printf("%T\n", s)
	fmt.Printf("%s\n", s)
	fmt.Printf("%v\n", s)
	fmt.Printf("%#v\n", s)  // 字符串会显示引号
}
```



## 整形

### 介绍



> 整形是所有编程语言里面的基础数据类型，在`go`语言当中，同时支持`int`和`uint`两种类型。但是具体的长度还要取决于不同的编译器实现。`go`里面同样有直接定义好位数的类型。
> 全部的类型如下:

![image-20230320211244687](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230320211244687.png)



### 进制转换

```go
package main

import "fmt"


// 整形
func main(){

	var i1 = 101
	fmt.Printf("%d\n", i1)
	fmt.Printf("%b\n", i1) // 十进制转二进制
	fmt.Printf("%o\n", i1)  // 十进制转八进制
	fmt.Printf("%x\n", i1)  // 十进制转十六进制

	// 八进制
	i2 := 077
	fmt.Printf("%d\n", i2)
	// 十六进制
	i3 := 0xff
	fmt.Printf("%d\n", i3)
	fmt.Printf("%T\n", i3)
	// 声明int类型
	i4 := int8(9)
	fmt.Printf("%d\n", i4)
	fmt.Printf("%T\n", i4)
}
```



## 浮点数

> go语言拥有两种浮点类型，一种是float64，每个64位的浮点数需要占用8字节，另一种是float32,占用4字节。



**go语言中默认的浮点类型位float64位， float32位不能直接赋值给float64位**





## 复数

略

## 布尔值

> go语言的bool 用来声明布尔变量，布尔类型只有true和false两个值
>
> 



**注意**

- 布尔变量的默认值位false
- go语言中不允许将整形强制转化位布尔类型
- 布尔类型无法参与运算x，也无法与其他类型进行转化

## 字符串类型

- Go 语言里的字符串的内部实现使用 UTF-8 编码。


### 字符串的表示

- 字符串的值为双引号(")中的内容，可以在 Go 语言的源码中直接添加非 ASCII 码字符串

```go
s := "沙河"
```

### 字符

- 字符： 单引号表示，单独的字母数字符号表示一个字符

- go 语言字符有两类: byte类型  rune类型， 代表utf8字符

  

```go
c1 := '沙'
c2 := 's'
c3 := 'h'
fmt.Printf("%s", s)
```

### 字节



- 一个字节=8Bit(8个二进制位)

-  一个'a' 字符占一个字节

- 一个utf8编码的汉字'沙' 一般占3个字节


### 转义字符串

| 转义符 | 含义     |
| ------ | -------- |
| \r     | 回车符号 |
| \n     | 换行     |
| \t     | 制表符   |
| \\\'   | 单引号   |
| \\\"   | 双引号   |
| \\\    | 反斜杠   |

```go
package main
import "fmt"

func main(){
    // 输出路径E:\【物语终焉】老男孩带你21周搞定Go语言【全 242】\01-50\01-50
	path1 := "E:\\【物语终焉】老男孩带你21周搞定Go语言【全 242】\\01-50\\01-50"
    // \ 本来就是具有特殊意义，需要告诉系统\ 就表示单纯的\，此时需要转义符
    
    // 让结果中带有双引号
    path2 := "\"E:\\【物语终焉】老男孩带你21周搞定Go语言【全 242】\\01-50\\01-50\""
    fmt.Printf(path2)
    
    // 让结果中带有单引号
    path3 := "'E:\\【物语终焉】老男孩带你21周搞定Go语言【全 242】\\01-50\\01-50'"
    
    // 多行字符串 使用反引号，原样输出
    s := `李白
		杜甫
	`
}
```

### 字符串拼接

```go
    name := "我是"
	content := "程序猿"

	ss := name + content
	fmt.Println(ss)
```

### 分割

```go
path1 := "E:\\【物语终焉】老男孩带你21周搞定Go语言【全 242】\\01-50\\01-50"

ret := strings.Split(path1, "\\")
fmt.Println(ret)
```

### 前后缀匹配



```go
	ss2 := "我是中国人"

	fmt.Println(strings.Contains(ss2, "我是"))

	// 前缀匹配
	fmt.Println(strings.HasPrefix(ss2, "我"))
	// 后缀匹配
	fmt.Println(strings.HasSuffix(ss2, "r人"))

```

### strings.Index()



```go
package main
import (
	"fmt"
	"strings"
)
func main() {
	var str = "this is golang"
	var index = strings.Index(str, "go") //从前往后
	fmt.Println(index)   // 8 （判断字符串 go 出现的位置）
}
```

### join拼接

```go
package main
import (
	"fmt"
	"strings"
)
func main() {
	var str = "123-456-789"
	var arr = strings.Split(str, "-")    // [123 456 789]
	var str2 = strings.Join(arr, "*")    // 123*456*789
	fmt.Println(arr)
	fmt.Println(str2)
}
```

### 字符串的修改(rune)

```go
package main

import "fmt"

func main() {
	// 字符串修改 ： 字符串不能直接修改
	s2 := "白萝卜"
	s3 := []rune(s2)  // ['白', '萝', '萝']  转换后是单个字符
	s3[0] = '红'  // 替换时需要用字符
	fmt.Println(string(s3))  // string 将rune 强制转换为字符
	c1 := "红"
	c2 := '红'  // rune 类型 int32
	fmt.Printf("c1: %T, c2:%T", c1, c2)
	c3 := "h"  // string
	c4 := 'h'  // int32
	fmt.Printf("c3: %T, c4:%T\n", c3, c4)

}
```

### 获取每一个字符

```go
package main

import "fmt"

func main() {
	s := "hello,沙河"

	n := len(s)
	fmt.Println(n)
	for _, c := range s{ // 从字符中取出每个字符
		fmt.Printf("%c\n", c) //%c : 字符

	}
}
```

## if

```go
package main

import "fmt"

func main(){
	age := 10
	if age > 18 {
		fmt.Println("饭店今天开业啦")

	}else{
		fmt.Println("改写作业了")
	}

	if age > 35 {
		fmt.Println("中年")
	} else if age >18 {
		fmt.Println("成年")
	} else {
		fmt.Println("未成年")
	}

	if age := 19; age >18{
		fmt.Println("今天要开学了")
	} else{
		fmt.Printf("今天天气不错")
	}
}
```

## for

```go
package main

import "fmt"

func main(){
	// 基本格式
	for i :=0; i<10; i++{
		fmt.Println(i)
	}
	// 变种1
	var i = 5
	for ;i < 10; i++{
		fmt.Println(i)
	}
	// 变种2
	j := 1
	for j<10 {
		fmt.Println("测试")
		fmt.Println(j)
		j++
	}

	// for range 返回字字符串的索引和值
	s := "hello沙河"
	for i, v := range s{
		fmt.Printf("%d %c\n", i, v)
	}

	// 打印99乘法表
	for i:=1; i<10; i++{
		for j:=1; j < 10; j++{
			if j<=i{
				if i * j <10{
					fmt.Printf("%d * %d = %d     ", j, i, i*j)
				}else{
					fmt.Printf("%d * %d = %d    ", j, i, i*j)
				}
				
			}
			if j == i{
				fmt.Printf("\n")
			}
		}
	}
	// 借助制表符
	for i :=1; i<10; i++{
		for j := 1; j <= i; j++{
			fmt.Printf("%d*%d=%d \t", j, i, i*j)
		}
		fmt.Println()
	}
}
```



### continue和break



```go
package main

import "fmt"

// func main() {
// 	for i := 0; i < 10; i++ {
// 		if i == 5 {
			
// 			continue
// 		}
// 		fmt.Println(i)
// 	}
// }


var name string
func main() {
	for i :=0; i<=10; i++ {
		if i==5 {
			continue
			
		}
		fmt.Println(i)
	}
	name = "张三李四王麻子"

	for i, c := range name{
		// fmt.Println(string(i), string(c))
		fmt.Printf("i: %d, c:%c\n", i, c )
	}
}
```



### switch



```go
package main

import "fmt"

func main(){
    
    var n=5
    
    switch n {
    case 1: 
        fmt.Println("大拇指")
    case 2:
        fmt.Println("食指")
    case 3:
        fmt.Println("中指")
    case 4:
        fmt.Println("无名指")
    case 5:
        fmt.Println("小拇指")
    default:
        fmt.Println("脚趾头")
    }
    
	// 变种
	switch n :=3;n {
	case 1:
		fmt.Println("食指")
	case 2:
		fmt.Println("中指")
	case 3:
		fmt.Println("大拇指")
	case 4, 5, 6, 7:
		fmt.Println("不是指头")
	}
}
```





### goto

```go
package main

// 跳出循环
func main(){
	var flag = false
	for i:=0; i<10; i++{
		for j := 0; j<10; j++{
			if j == 2 {
				flag = true
				break  // 跳出内层循环
			}
		}
		if flag == true{
			break  // 跳出外层循环
		}

	}

	// 使用goto 跳出循环
	for i := 0; i<10; i++ {
		for j := 0; j<10; j++{
			goto xx   // 跳转到xx标签
		}
	}
	xx:  // label标签

}
```



## 小结



### 内容回顾



* GOPATH: go语言的工作区， 代码存放路径

* go env: 命令行输入，列出和go相关的环境变量

  ![image-20230401112155016](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230401112155016.png)

  

- GOPATH/bin添加到环境变量： go install命令会把生成的二进制可执行文件拷贝到GOPATH/bin路径下

* GOROOT: 安装go语言的路径

### 命令



* go build  编译go 程序
* go build -o "xxxx.exe"  编译成xxx.exe可执行文件
* go run main.go 像执行脚本一样执行main.go 文件
* go install  先编译后拷贝



### go 语言文件基础语法

存放go源代码的文件后缀名是.go

文件第一行： package关键字声明包

如果要编写一个可执行文件，必须要有main包和mian入口函数

main 函数外的语句必须以关键字开头

函数内部定义的变量必须使用



```go
package main

// 单行注释
/* 多行注释 */

func main(){
    
}

```



### 变量和常量

#### 变量声明

- 三种声明方式

  - var name string

  - var name = "沙河"

  - 函数内部专属 name := "沙河"

- 匿名变量
  - 某些变量必须接受但是不使用时 用_

#### 常量

- const声明

  * const PI=3.14

- iota

  	- iota在const关键字出现的时候置为0
  	
  	- const中每新增一行，iota加1

### 流程控制

#### if 



```go
var age = 20
if age > 18{
	fmt.Println("成年人")
} else{
	fmt.Println("学成")
}
```

#### for



```go
// 方式一
for i:=0;i<10;i++{
	fmt.Println(i)
}
// 方式二
var i=0
for ;i<10;i++{
    fmt.Println(i)
}
// 方式三
var j = 0
for j<10 {
    for.Println("无线循环")
}

for i, v := range "沙河有沙又有河" {
    fmt.Println(i, v)
    fmt.Printf("%d %c\", i, v)
}

               
               
```



### 基本数据类型

- 整形：

  - 无符号：uint8、uint16、uint32、uint64

  - 带符号：int8、int16、int32、int64

    *int具体是32位还是64位看操作系统*

  - uintptr: 表示指针

  - 

- 浮点型：

  - float64、float32
  - go语言里浮点数默认ffloat64

  

- 复数：

  - complex128和complex64

  

- 布尔值：
  - true和flase
  - 不能和其他字符转做转换
- 字符串
  - 常用方法
  - 不能被直接修改
- 字符串、字符、字节都是什么？
  - 字符串：双引号包裹
  - 字符：单引号包裹的是字符，单个字母，符号，单个文字
  - 字节：1byte=8bit
  - go语言中给的字符串都是UTF8编码，UTF8中一个汉字常占用3个字节





## 运算符



- 算数运算符

![image-20230403210843682](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230403210843682.png)



- 逻辑运算符

  

![image-20230403210941626](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230403210941626.png)



- 位运算符

![image-20230403211458044](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230403211458044.png)



- 赋值运算符



![image-20230403213421601](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230403213421601.png)



```go
package main

import "fmt"

// 测试运算符

func main(){
	var(
		a = 5
		b = 8
	)

	fmt.Println(a, b)
	// 算术运算发
	fmt.Println( a + b)
	fmt.Println( a - b)
	fmt.Println( a * b)
	fmt.Println( a / b)
	fmt.Println( a % b)
	a ++   // a = a+1
	b --   // b = b-1
	
	// 关系运算符
	fmt.Println( a == b)
	fmt.Println( a < b)
	fmt.Println( a <= b)
	fmt.Println( a > b)
	fmt.Println( a >= b)
	fmt.Println( a != b)

	// 逻辑运算符

	age := 22
	// and 
	if age >18 &&age<60{
		fmt.Println("苦逼上班")
	} else {
		fmt.Println("不用上班")
	}
	// or
	if age<18 || age > 60 {
		fmt.Println("不用上班")
	} else {
		fmt.Println("苦逼上班")
	}

	// 取反 ！
	is_finished := false
	fmt.Println(is_finished)
	fmt.Println(!is_finished)

	// 位运算 针对二进制数
	// 5 的二进制 0101
	// 2 的二进制 0010

	// &： 按位与 全1为1，有0则0
	fmt.Println(5 & 2)  // 0000

	// |: 按位或 有1为1
	fmt.Println(5 | 2)  // 0111

	// ^: 按位异或 两位不同则为1
	fmt.Println(5^2) // 0111

	// <<: 左移指定位数  0101
	fmt.Println( 5 << 1)  //1010  10\
	fmt.Println(1 << 10)  // 10000000000 => 1024
	// >> 右移
	fmt.Println(5 >> 1 ) // 0010
	fmt.Println(5 >> 2 ) // 0001
	fmt.Println(5 >> 3 ) // 0000
	
	/*
	var m = int8(1)
	fmt.Println(m<<10) // 该句会有问题，超出位数
	*/


}
```



## 数组

- 存放元素的容器
- 必须指定存放元素的类型和容量（长度）

- 数组的长度是数组类型的一部分



### 定义：

```
var 数组变量名[元素数量]T
```

比如 var a[5] int, 数组的长度必须是常量，并且长度是数组的一部分，一旦定义，长度不能改变。[5]int 和[10]int是不同的类型

```go
var a [3]int
var b [4]int
a = b // 不可以这样，因为此时a和b是不同的类型
```



### 初始化

方法一：

初始化数组是可以使用初始化列表来设置数组元素的值



```go
func main(){
	var a [3]int
    var b [3]int{1, 2}
    var cityArray = [3]string{"北京", "上海", "深圳"}
    fmt.Println(a)
    fmt.Println(b)
    fmt.Println(cityArray)
}
```



方法二：

编译器根据初始值的个数自行推断数组的长度

```go
func main(){
	var testArray [3]int
	var numArray = [...]int{1, 2}
    var cityArray = [...]string{"北京"，"上海"}
    
}
```



方法三：

指定索引值的方式初始化数组

```go
func main(){
	a := [...]int{1:1, 3:5}
	fmt.Println(a)
}
```



### 数组的遍历

```go
func main(){
    var a = [...]string{"北京"，"上海", "深圳"}
    
    for i := 0;i < len(a); i++{
        fmt.Println(a[i])
    }
    
    for index, value := range a{
        fmt.Println(index, value)
    }
}
```



### 多维数组的定义

```go
func main(){
    a := [3][2]string{
        {"北京"，"上海"}，
        {"广州"， "天津"}，
        {"成都"，"重庆"}
    }
    fmt.Println(a) //[[北京 上海] [广州 深圳] [成都 重庆]]
    fmt.Println(a[2][1]) //支持索引取值:重庆
    
}
```





### 二维数组的遍历

```go
func main(){
	a := [3][2]string{
		{"北京", "上海"},
		{"广州", "深圳"},
		{"成都", "重庆"},
	}
    
    for _, v := range a{
        for _, vv := range v{
            fmt.Printf("%s\t", vv)
        }
    }
}
```



{%r%}

注意：多维数组只有第一层可以使用...来让编译器推到数组长度

{%endr%}

```go
//支持的写法
a := [...][2]string{
	{"北京", "上海"},
	{"广州", "深圳"},
	{"成都", "重庆"},
}
//不支持多维数组的内层使用...
b := [3][...]string{
	{"北京", "上海"},
	{"广州", "深圳"},
	{"成都", "重庆"},
}
```



### 数组是值类型

数组时值类型(每次拷贝都是完全拷贝)， 区别于引用类型

```go
b1 := [3]int{1, 2, 3}
b2 := b1
b2[0] = 100
fmt.Println(b1, b2)
```

### 练习



1. 求数组[1, 3, 5, 7, 9]的和

   ```go
   	totalNum := 0
   	for _, value := range numList {
   		totalNum += value
   	fmt.Println(totalNum)
   	}
   ```

   

2. 找出数组中和为指定值的两个元素的下标，比如从数组`[1, 3, 5, 7, 8]`中找出和为8的两个元素的下标分别为`(0,3)`和`(1,2)`。

   

   ```go
   	numArray := [...]int{1, 3, 5, 7, 8}
   	for index1, value1 := range numArray{
   		target := 8 - value1
   		for index2, value2 := range numArray{
   			if value2 == target{
   				fmt.Println(index1, index2)
   
   			}
   		}
   	}
   
   ```

### 切片

因为数组的长度是固定的并且数组长度属于类型的一部分，所以数组有很多的局限性。





#### 定义

切片（Slice）是一个拥有相同类型元素的可变长度的序列。它是基于数组类型做的一层封装。它非常灵活，支持自动扩容。

切片是一个引用类型，它的内部结构包含`地址`、`长度`和`容量`。切片一般用于快速地操作一块数据集合。

```go
var name []T
```

示例

```go
	var s1 []int    //定义一个存放int类型元素的切片
	var s2 []string //定义一个存放string类型元素的切片
	fmt.Println(s1, s2)
```



#### 初始化

```go
	s1 = []int{1, 2, 3}
	s2 = []string{"沙河", "珠江", "平山村"}

	var a []string
	var b = []int{}
	var c = []bool{false, true}
	var d = []bool{false, true}
	fmt.Println(a)
	fmt.Println(b)
	fmt.Println(c)
	fmt.Println(d)
	fmt.Println(a == nil) // true
	fmt.Println(b == nil) // false
	fmt.Println(c == nil) // false
```



#### 切片比较

```go

	var c = []bool{false, true}
	var d = []bool{false, true}
// fmt.Println(c == d)  // 切片是引用类型不能直接比较，只能和nil进行比较
```





#### 长度和容量

```go
// 切片拥有自己的长度和容量，通常用len求长度，用cap求容量
	// 注意len cap的区别, 切片的容量是指底层数组的容量
	fmt.Printf("len(s1):%d cap(s1): %d\n", len(s1), len(s1))
	fmt.Printf("len(s1):%d cap(s2): %d\n", len(s1), len(s2))
```



#### 由数组得到切片

```go
	a1 := [...]int{1, 3, 5, 7, 9, 11, 13}
	s3 := a1[0:4]
	fmt.Println(s3)
	s4 := a1[1:6]
	fmt.Println(s4)
	s5 :=a1[:4]
	s6 := a1[3:]
	s7 :=a1[:]
	fmt.Println(s5, s6, s7)
```



#### 切片再切片

```go
	// 切片再切片
	s8 := s6[3:]
	fmt.Printf("len(s8): %d    cap(s8): %d\n", len(s8), cap(s8))
	// 切片是一个引用类型
	fmt.Println("s6:", s6)
	a1[6] = 1300
	fmt.Println("s6:", s6)

```



#### 切片的本质

- 切片的本质就是对底层数组的封装，它包含了三个信息：底层数组的指针、切片的长度（len）和切片的容量（cap）举个例子，现在有一个数组`a := [8]int{0, 1, 2, 3, 4, 5, 6, 7}`，切片`s1 := a[:5]`，相应示意图如下

![image-20230404224746573](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230404224746573.png)



- 切片`s2 := a[3:6]`，相应示意图如下：

![image-20230404224824013](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230404224824013.png)





#### 切片判空

- 要检查切片是否为空，请始终使用len(s) == 0来判断，而不应该使用s == nil来判断。



#### 切片比较

- 切片之间是不能比较的，我们不能使用`==`操作符来判断两个切片是否含有全部相等元素。 切片唯一合法的比较操作是和`nil`比较。 一个`nil`值的切片并没有底层数组，一个`nil`值的切片的长度和容量都是0。但是我们不能说一个长度和容量都是0的切片一定是`nil`，例如下面的示例：

  ```go
  var s1 []int         //len(s1)=0;cap(s1)=0;s1==nil
  s2 := []int{}        //len(s2)=0;cap(s2)=0;s2!=nil
  s3 := make([]int, 0) //len(s3)=0;cap(s3)=0;s3!=nil
  ```

- 所以要判断一个切片是否是空的，要是用`len(s) == 0`来判断，不应该使用`s == nil`来判断。

#### 切片赋值拷贝

```go
func main() {
	s1 := make([]int, 3) //[0 0 0]
	s2 := s1             //将s1直接赋值给s2，s1和s2共用一个底层数组
	s2[0] = 100
	fmt.Println(s1) //[100 0 0]
	fmt.Println(s2) //[100 0 0]
}
```



#### make函数生成切片

```go
func main() {
	s1 := make([]int, 3) //[0 0 0]
}
```



#### 切片的遍历

```go
func main() {
	s := []int{1, 3, 5}

	for i := 0; i < len(s); i++ {
		fmt.Println(i, s[i])
	}

	for index, value := range s {
		fmt.Println(index, value)
	}
}
```



#### append方法

```go
	var s []int
	s = append(s, 1)
	s = append(s, 2)
	s2 := []int{5, 6, 7}
	s = append(s, s2...)
	fmt.Println(s)

	// 通过var 声明的零值切片可以直接append ,不需要初始化后在append
	
```



#### 切片的扩容



```go
newcap := old.cap
doublecap := newcap + newcap
if cap > doublecap {
	newcap = cap
} else {
	if old.len < 1024 {
		newcap = doublecap
	} else {
		// Check 0 < newcap to detect overflow
		// and prevent an infinite loop.
		for 0 < newcap && newcap < cap {
			newcap += newcap / 4
		}
		// Set newcap to the requested cap when
		// the newcap calculation overflowed.
		if newcap <= 0 {
			newcap = cap
		}
	}
}
```



- 首先判断，如果新申请容量（cap）大于2倍的旧容量（old.cap），最终容量（newcap）就是新申请的容量（cap）。
- 否则判断，如果旧切片的长度小于1024，则最终容量(newcap)就是旧容量(old.cap)的两倍，即（newcap=doublecap），
- 否则判断，如果旧切片长度大于等于1024，则最终容量（newcap）从旧容量（old.cap）开始循环增加原来的1/4，即（newcap=old.cap,for {newcap += newcap/4}）直到最终容量（newcap）大于等于新申请的容量(cap)，即（newcap >= cap）
- 如果最终容量（cap）计算值溢出，则最终容量（cap）就是新申请容量（cap）。



```go
	// append 添加元素和扩容
	var numSlice []int
	for i :=0;i<10;i++{
		numSlice = append(numSlice,i)
		fmt.Printf("%v  len: %d   cap: %d  ptr:%p\n", 
		numSlice, len(numSlice), cap(numSlice), numSlice)
	}

```



#### copy函数

由于切片是引用类型，所以a和b其实都指向了同一块内存地址。修改b的同时a的值也会发生变化。

Go语言内建的`copy()`函数可以迅速地将一个切片的数据复制到另外一个切片空间中，`copy()`函数的使用格式如下

```go
// copy(destSlice, srcSlice []T)
func main() {
	// copy()复制切片
	a := []int{1, 2, 3, 4, 5}
	c := make([]int, 5, 5)
	copy(c, a)     //使用copy()函数将切片a中的元素复制到切片c
	fmt.Println(a) //[1 2 3 4 5]
	fmt.Println(c) //[1 2 3 4 5]
	c[0] = 1000
	fmt.Println(a) //[1 2 3 4 5]
	fmt.Println(c) //[1000 2 3 4 5]
```



#### 删除元素





- Go语言中并没有删除切片元素的专用方法，我们可以使用切片本身的特性来删除元素。 代码如下

```go
func main() {
	// 从切片中删除元素
	a := []int{30, 31, 32, 33, 34, 35, 36, 37}
	// 要删除索引为2的元素
	a = append(a[:2], a[3:]...)
	fmt.Println(a) //[30 31 33 34 35 36 37]
}
```



- 总结一下就是：要从切片a中删除索引为`index`的元素，操作方法是`a = append(a[:index], a[index+1:]...)`



## 指针

> 任何程序数据载入内存后，在内存都有他们的地址，这就是指针。而为了保存一个数据在内存中的地址，我们就需要指针变量。



- 因此Go语言中的指针操作非常简单，我们只需要记住两个符号：`&`（取地址）和`*`（根据地址取值)



### 指针地址和指针类型

- 每个变量在运行时都拥有一个地址，这个地址代表变量在内存中的位置。Go语言中使用`&`字符放在变量前面对变量进行“取地址”操作
- Go语言中的值类型（int、float、bool、string、array、struct）都有对应的指针类型，如：`*int`、`*int64`、`*string`等。

- 取变量指针的语法如下

```go
ptr := &v    // v的类型为T
```



- v:代表被取地址的变量，类型为`T`
- ptr:用于接收地址的变量，ptr的类型就为`*T`，称做T的指针类型。*代表指针。

```go
package main

import "fmt"

func main() {

	// &: 取地址
	// *：根据地址取值

	n := 18
	fmt.Println(&n)
	p := &n
	fmt.Println(p)
	fmt.Printf("%T\n", p)  // *int
	
	m := *p
	fmt.Println(m)

	mm := "你好"
	fmt.Println(&mm)
	fmt.Printf("%T", &mm)  // *string

}
```



### 指针取值



- 在对普通变量使用&操作符取地址后会获得这个变量的指针，然后可以对指针使用*操作，也就是指针取值，代码如下。



```
func main() {
	//指针取值
	a := 10
	b := &a // 取变量a的地址，将指针保存到b中
	fmt.Printf("type of b:%T\n", b)
	c := *b // 指针取值（根据指针去内存取值）
	fmt.Printf("type of c:%T\n", c)
	fmt.Printf("value of c:%v\n", c)
}
```



### 指针传值



```go
func modify1(x int) {
	x = 100
}

func modify2(x *int) {
	*x = 100
}

func main() {
	a := 10
	modify1(a)
	fmt.Println(a) // 10
	modify2(&a)
	fmt.Println(a) // 100
}
```



**总结**



- 取地址操作符`&`和取值操作符`*`是一对互补操作符，`&`取出地址，`*`根据地址取出地址指向的值。



## new和make

### new



new是一个内置的函数，它的函数签名如下：

```go
func new(Type) *Type
```

其中，

- Type表示类型，new函数只接受一个参数，这个参数是一个类型
- *Type表示类型指针，new函数返回一个指向该类型内存地址的指针。

new函数不太常用，使用new函数得到的是一个类型的指针，并且该指针对应的值为该类型的零值。举个例子：

```go
func main() {
	a := new(int)
	b := new(bool)
	fmt.Printf("%T\n", a) // *int
	fmt.Printf("%T\n", b) // *bool
	fmt.Println(*a)       // 0
	fmt.Println(*b)       // false
}	
```

本节开始的示例代码中`var a *int`只是声明了一个指针变量a但是没有初始化，指针作为引用类型需要初始化后才会拥有内存空间，才可以给它赋值。应该按照如下方式使用内置的new函数对a进行初始化之后就可以正常对其赋值了：

```go
func main() {
	var a *int
	a = new(int)
	*a = 10
	fmt.Println(*a)
}
```





### make

make也是用于内存分配的，区别于new，它只用于slice、map以及channel的内存创建，而且它返回的类型就是这三个类型本身，而不是他们的指针类型，因为这三种类型就是引用类型，所以就没有必要返回他们的指针了。make函数的函数签名如下：

```go
func make(t Type, size ...IntegerType) Type
```

make函数是无可替代的，我们在使用slice、map以及channel的时候，都需要使用make进行初始化，然后才可以对它们进行操作。这个我们在上一章中都有说明，关于channel我们会在后续的章节详细说明。

本节开始的示例中`var b map[string]int`只是声明变量b是一个map类型的变量，需要像下面的示例代码一样使用make函数进行初始化操作之后，才能对其进行键值对赋值：

```go
func main() {
	var b map[string]int
	b = make(map[string]int, 10)
	b["沙河娜扎"] = 100
	fmt.Println(b)
}
```







### new与make的区别

1. 二者都是用来做内存分配的。
2. make只用于slice、map以及channel的初始化，返回的还是这三个引用类型本身；
3. 而new用于类型的内存分配，并且内存对应的值为类型零值，返回的是指向类型的指针。



## map 函数

> map 是一种基于key-value的数据结构， go语言中的map是一种引用结构，类型，必须初始化才能使用，其内部使用hash来实现





### 定义



Go语言中 `map`的定义语法如下：

```go
map[KeyType]ValueType
```

其中，

- KeyType:表示键的类型。
- ValueType:表示键对应的值的类型。

map类型的变量默认初始值为nil，需要使用make()函数来分配内存。语法为：

```go
make(map[KeyType]ValueType, [cap])
```

其中cap表示map的容量，该参数虽然不是必须的，但是我们应该在初始化map的时候就为其指定一个合适的容量。





### map的基本使用

```go
package main

import "fmt"

func main(){

	var m1 map[string] int

	fmt.Println((m1==nil))
	m1 = make(map[string]int, 10)  // 一定要初始化

	m1["理想"] = 18
	m1["jiwuming"] = 35
	fmt.Println(m1)
	fmt.Println(m1["理想"])
	

    // 元素类型的为map的切片

	var s1 = make([]map[int]string, 1, 10)
}
```



###  map 判断键值是否存在

- value, ok := map[key] 判断是狗存在某个key

```go
//value, ok := map[key] 判断是狗存在某个key

	scoreMap := make(map[string]int)
	scoreMap["张三"] = 90
	scoreMap["李四"] = 100

	v, ok := scoreMap["张三"]

	if ok {
		fmt.Println(v)
	} else {
		fmt.Println("查无此人")
	}
```



### 遍历

```go
func main() {
	scoreMap := make(map[string]int)
	scoreMap["张三"] = 90
	scoreMap["小明"] = 100
	scoreMap["娜扎"] = 60
	for k, v := range scoreMap {
		fmt.Println(k, v)
	}
}
```





如果只是遍历key 可以用如下写法

```go
func main() {
	scoreMap := make(map[string]int)
	scoreMap["张三"] = 90
	scoreMap["小明"] = 100
	scoreMap["娜扎"] = 60
	for k := range scoreMap {
		fmt.Println(k)
	}
}
```



### 删除



- delete(map, key)表示从中删除一组键值对

```go
func main(){
	scoreMap := make(map[string]int)
	scoreMap["张三"] = 90
	scoreMap["小明"] = 100
	scoreMap["娜扎"] = 60
	delete(scoreMap, "小明")//将小明:100从map中删除
	for k,v := range scoreMap{
		fmt.Println(k, v)
	}
}
```





### 按照指定顺序遍历

```go
func main() {
	rand.Seed(time.Now().UnixNano()) //初始化随机数种子

	var scoreMap = make(map[string]int, 200)

	for i := 0; i < 100; i++ {
		key := fmt.Sprintf("stu%02d", i) //生成stu开头的字符串
		value := rand.Intn(100)          //生成0~99的随机整数
		scoreMap[key] = value
	}
	//取出map中的所有key存入切片keys
	var keys = make([]string, 0, 200)
	for key := range scoreMap {
		keys = append(keys, key)
	}
	//对切片进行排序
	sort.Strings(keys)
	//按照排序后的key遍历map
	for _, key := range keys {
		fmt.Println(key, scoreMap[key])
	}
}
```





### 练习题

1. 写一个程序，统计一个字符串中每个单词出现的次数。比如：”how do you do”中how=1 do=2 you=1

```go
```





## 函数

### 定义

- 函数是组织好的可重复使用的、用于执行指定任务的代码模块

```go
package main
import "fmt"
// 函数

// 函数存在的意义
// 函数是一段代码的分装
// 把一段代码的逻辑抽象出来，给他起个名子，每次用到他的时候直接使用函数名调用就看可以了
// 使代码更加简介清晰


// 函数的定义
func sum(x int, y int)(ret int){
	return x + y

}

// 没有返回值
func f1(x int, y int){
	fmt.Println(x + y)
}

// 没有参数和返回值
func f2(){
	fmt.Println("没有返回值值和参数")
}

// 没有参数但是由返回值
func f3() int{
	fmt.Println("没有参数但是由返回值")
	return 3
}

//参数可以命名也可以不命名
// 命名的返回值就相当于在函数中声明一个变量
func f4( x int, y int)(ret int){
	ret = x + y
	return   // 此时可以省略return 后面的ret
}

// 多个返回值
func f5(x int, y int)(int, string){

	return 1, "沙河"
}

// 参数的类型简写
// 当参数中有连续多个参数的类型一致时，我们可以省略非最后一个的类型
func f6(x, y int) int{
	return x + y
}

// 可变长参数
func f7(x string, y...int){
	fmt.Println(x)
	fmt.Println(y)  // y的类型是切片 []int
}
// go语言中函数没有默认参数这个概念

func main(){
	r := sum(1, 2)
	fmt.Println(r)
}
```



### 函数的调用

- 定义了函数之后，我们可以通过`函数名()`的方式调用函数





### 作用域

#### 全局作用域

- 全局变量是定义在函数外部的变量，他在程序整个的原型周期内部有效， 在函数内部可以访问全局变量

  ```go
  package main
  
  import "fmt"
  
  var num int64 = 10
  func testGlobalVar(){
      fmt.Printf("num=%d\n", num)  // 函数内部访问全局变量
  }
  
  func main(){
      testGlobalVar() // num=10
  }
  ```

  

#### 局部作用域



- 局部变量有分为两种： 函数内部的定义的变量违法在该函数外使用

​	

```go
func testLocalVar() {
	//定义一个函数局部变量x,仅在该函数内生效
	var x int64 = 100
	fmt.Printf("x=%d\n", x)
}

func main() {
	testLocalVar()
	fmt.Println(x) // 此时无法使用变量x
}
```







- 如果局部变量和全局变量重名，有限访问局部变量

```go
package main

import "fmt"

//定义全局变量num
var num int64 = 10

func testNum() {
	num := 100
	fmt.Printf("num=%d\n", num) // 函数中优先使用局部变量
}
func main() {
	testNum() // num=100
}
```



### 函数类型域变量

#### 定义函数类型

- 使用type关键字来定义一个函数类型，具体格式如下

```go
type calculation func(int, int) int
```

- 上面语句定义了一个calculation类型的函数， 例如下面代码都是calculation的类型

  ```go
  func add(x, y int) int {
  	ruturn x + y
  }
  
  func sub(x, y int) int {
      reutrn x - y
  }
  ```

- add 和sub都能赋值给calculation类型的变量

  ```go
  var c calculation
  c = add
  ```

- 函数类型变量

```go
package main
import "fmt"


func add(x, y int) int {
	return x + y
}

func sub(x, y int) int {
	return x - y
}

type calculation func(int, int) int
func main() {
	var c calculation               // 声明一个calculation类型的变量c
	c = add                         // 把add赋值给c
	fmt.Printf("type of c:%T\n", c) // type of c:main.calculation
	fmt.Println(c(1, 2))            // 像调用add一样调用c

	f := add                        // 将函数add赋值给变量f
	fmt.Printf("type of f:%T\n", f) // type of f:func(int, int) int
	fmt.Println(f(10, 20))          // 像调用add一样调用f
}
```



### 高阶函数

#### 函数作为参数

- 函数可以作为参数

  ```go
  func add(x, y int) int{
  	return x + y
  }
  
  func calc(x, y, op func(int, int) int) int {
      return op(x, y)
  }
  func main(){
      ret2 := calc(10, 20, add)
      fmt.Println(ret2) // 30
  }
  ```

  



- 函数作为返回值

  ```go
  func do(s string)(func(int, int) int, error){
      switch s {
          case "+":
          	return add, nil
          case "-":
          	return sub, nil
          default:
          err := errors.New("无法识别的操作法")
          return nil , err
      
      }
  }
  ```

  

### 匿名函数和闭包

#### 匿名函数

- 函数当然还可以作为返回值，但是在Go语言中函数内部不能再像之前那样定义函数了，只能定义匿名函数。匿名函数就是没有函数名的函数，匿名函数的定义格式如下：

  ```
  func(参数，参数)(返回值， 返回值){
  
  }
  ```

-  匿名函数因为没有函数名，所以没办法像普通函数那样调用，所以匿名函数需要保存到某个变量或者作为立即执行函数:

  ```go
  func main(){
  
  	// 函数内部没有办法声明带名字的函数
  	f1 := func(x, y int){
  		fmt.Println(x + y)
  	}
  	f1(10, 20)
  
  	// 如果只是使用一次的函数，还可以立即执行函数
  
  	func(x, y int){
  		fmt.Println(x +y)
  		fmt.Println("hello world")
  	}(100, 200)
  }
  
  ```

-  匿名函数多用于实现回调函数和闭包



### 闭包

- 闭包指的是一个函数和域其他相关的引用环境组合而成的实体，`闭包=函数+引用环境`

- 闭包函数示例一

  ```go
  func adder() func(int) int {
  	var x int
  	return func(y int) int {
  		x += y
  		return x
  	}
  }
  func main() {
  	var f = adder()
  	fmt.Println(f(10)) //10
  	fmt.Println(f(20)) //30
  	fmt.Println(f(30)) //60
  
  	f1 := adder()
  	fmt.Println(f1(40)) //40
  	fmt.Println(f1(50)) //90
  }
  ```

- 闭包函数示例二

  ```go
  func makeSuffixFunc(suffix string) func(string) string {
  	return func(name string) string {
  		if !strings.HasSuffix(name, suffix) {
  			return name + suffix
  		}
  		return name
  	}
  }
  
  func main() {
  	jpgFunc := makeSuffixFunc(".jpg")
  	txtFunc := makeSuffixFunc(".txt")
  	fmt.Println(jpgFunc("test")) //test.jpg
  	fmt.Println(txtFunc("test")) //test.txt
  }
  ```

- 闭包示例三

  ```go
  func calc(base int) (func(int) int, func(int) int) {
  	add := func(i int) int {
  		base += i
  		return base
  	}
  
  	sub := func(i int) int {
  		base -= i
  		return base
  	}
  	return add, sub
  }
  
  func main() {
  	f1, f2 := calc(10)
  	fmt.Println(f1(1), f2(2)) //11 9
  	fmt.Println(f1(3), f2(4)) //12 8
  	fmt.Println(f1(5), f2(6)) //13 7
  }
  ```

  

### defer语句

- Go语言中的`defer`语句会将其后面跟随的语句进行延迟处理。在`defer`归属的函数即将返回时，将延迟处理的语句按`defer`定义的逆序进行执行，也就是说，先被`defer`的语句最后被执行，最后被`defer`的语句，最先被执行。

  ```go
  func main() {
  	fmt.Println("start")
  	defer fmt.Println(1)
  	defer fmt.Println(2)
  	defer fmt.Println(3)
  	fmt.Println("end")
  }
  ```

#### defer 执行时机

在Go语言的函数中`return`语句在底层并不是原子操作，它分为给返回值赋值和RET指令两步。而`defer`语句执行的时机就在返回值赋值操作后，RET指令执行前。具体如下图所示：



![image-20230419211056900](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230419211056900.png)



#### defer 案例



- 阅读下面代码，写出最后的打印结果

```go
func f1() int {
	x := 5
	defer func() {
		x++
	}()
	return x  // 1. 返回值赋值  2. defer 3.RET
}
// 答案 5

func f2() (x int) {
	defer func() {
		x++
	}()
	return 5 // 1. 返回值赋值 x=5 2.defer x++ 3. RET
} 
// 答案 6

func f3() (y int) {
	x := 5
	defer func() {
		x++
	}()
	return x  // 1. 返回值赋值 y=x=5, 2. defer x++ 3.RET
    
}
// 答案5

func f4() (x int) {
	defer func(x int) {
		x++  // x当作参数传入进去了，所以改变的是x的副本，所以答案还是5
	}(x)
	return 5
}

// 答案5

func main(){

	fmt.Println(f1())
	fmt.Println(f2())
	fmt.Println(f3())
	fmt.Println(f4())

}
```

#### defer面试题

```go
func calc(index string, a, b int) int {
	ret := a + b
	fmt.Println(index, a, b, ret)
	return ret
}

func main() {
	x := 1
	y := 2
    defer calc("AA", x, calc("A", x, y)) // 先计算第二个参数的结果为3, 会输出A 1 2 3 执行defer x相当于执行calc(AA, 1, 3)输出 AA  1, 3, 4
    x = 10
    defer calc("BB", x, calc("B", x, y)) // 先计算第二个参数的结果为12， 输出B 10 2 12  执行defer calc("BB", 10, 12) 输出BB 10 12 22
	y = 20
}
```



上面代码的输出结果是多少？



综合上面分析以及defer的执行顺序得到如下结果

1. A 1 2 3
2. B 10 2 12
3. BB 10 12 22
4. AA  1 3 4



{%r%}

defer注册要延迟执行的函数时该函数所有的参数都需要确定其值

{%endr%}



## 内置函数介绍

![image-20230419214805356](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230419214805356.png)





### panic/recover

Go语言中目前（Go1.12）是没有异常机制，但是使用`panic/recover`模式来处理错误。 `panic`可以在任何地方引发，但`recover`只有在`defer`调用的函数中有效。 首先来看一个例子：



```go
package main

import "fmt"

func funcA(){
	fmt.Println("func A")
}

func funcB(){
	panic("panic in B")
}

func funcC(){
	fmt.Println("func C")
}
func main(){
	funcA()
	funcB()
	funcC()

}
```



输出：

```shell
func A
panic: panic in B

goroutine 1 [running]:
main.funcB(...)
        G:/go_project/day03/func_panic/main.go:10
main.main()
        G:/go_project/day03/func_panic/main.go:18 +0x66
```



分析： 程序运行期间`funcB`中引发了`panic`导致程序崩溃，异常退出了。这个时候我们就可以通过`recover`将程序恢复回来，继续往后执行。



```go
func funcA() {
	fmt.Println("func A")
}

func funcB() {
	defer func() {
		err := recover()
		//如果程序出出现了panic错误,可以通过recover恢复过来
		if err != nil {
			fmt.Println("recover in B")
		}
	}()
	panic("panic in B")
}

func funcC() {
	fmt.Println("func C")
}
func main() {
	funcA()
	funcB()
	funcC()
}
```



{%r%}

1. recover()必须要搭配defer使用
2. defer一定要定义在可能引发panic的语句之前

{%endr%}



## fmt标准库介绍

#### Print

> `Print`系列函数会将内容输出到系统的标准输出，区别在于`Print`函数直接输出内容，`Printf`函数支持格式化输出字符串，`Println`函数会在输出内容的结尾添加一个换行符。



```go
func main() {
	fmt.Print("在终端打印该信息。")
	name := "沙河小王子"
	fmt.Printf("我是：%s\n", name)
	fmt.Println("在终端打印单独一行显示")
}


```



```shell
在终端打印该信息。我是：沙河小王子
在终端打印单独一行显示
```

#### Fprint

> `Fprint`系列函数会将内容输出到一个`io.Writer`接口类型的变量`w`中，我们通常用这个函数往文件中写入内容

```go
func Fprint(w io.Writer, a ...interface{}) (n int, err error)
func Fprintf(w io.Writer, format string, a ...interface{}) (n int, err error)
func Fprintln(w io.Writer, a ...interface{}) (n int, err error)
```

举例

```go
// 将标准输出写入内容
fmt.Fprintln(os.Stdout, "像标准输出写入内容")
fileObj, err := os.OpenFile("./xxx.txt", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
if err != nil {
	fmt.Println("打开文件出错，err:", err)
	return
}
name := "沙河小王子"
// 向打开的文件句柄中写入内容
fmt.Fprintf(fileObj, "往文件中写如信息：%s", name)
```



#### Sprint

> `Sprint`系列函数会把传入的数据生成并返回一个字符串。





```go
func Sprint(a ...interface{}) string
func Sprintf(format string, a ...interface{}) string
func Sprintln(a ...interface{}) string
```



简单代码示例

```go
s1 := fmt.Sprint("沙河小王子")
name := "沙河小王子"
age := 18
s2 := fmt.Sprintf("name:%s,age:%d", name, age)
s3 := fmt.Sprintln("沙河小王子")
fmt.Println(s1, s2, s3)
```



#### Errorf

> `Errorf`函数根据format参数生成格式化字符串并返回一个包含该字符串的错误。



```go
func Errorf(format string, a ...interface{}) error
```



通常用来自定义错误类型

```go
err := fmt.Errorf("这是一个错误")
```



```go
e := errors.New("原始错误e")
w := fmt.Errorf("Wrap了一个错误%w", e)
```



#### 格式化占位符

- 通用占位符

![image-20230419222115673](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230419222115673.png)



示例代码如下：

```go
fmt.Printf("%v\n", 100)
fmt.Printf("%v\n", false)
o := struct{ name string }{"小王子"}
fmt.Printf("%v\n", o)
fmt.Printf("%#v\n", o)
fmt.Printf("%T\n", o)
fmt.Printf("100%%\n")
```

输出结果如下：

```bash
100
false
{小王子}
struct { name string }{name:"小王子"}
struct { name string }

100%
```



- 布尔型

![image-20230419222246501](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230419222246501.png)





- 整形

![image-20230419222326482](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230419222326482.png)



- 浮点数

![image-20230419222539519](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230419222539519.png)



示例代码如下：

```go
f := 12.34
fmt.Printf("%b\n", f)
fmt.Printf("%e\n", f)
fmt.Printf("%E\n", f)
fmt.Printf("%f\n", f)
fmt.Printf("%g\n", f)
fmt.Printf("%G\n", f)
```

输出结果如下：

```bash
6946802425218990p-49
1.234000e+01
1.234000E+01
12.340000
12.34
12.34
```



- 字符串和byte

![image-20230419222617095](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230419222617095.png)



示例代码如下：

```go
s := "小王子"
fmt.Printf("%s\n", s)
fmt.Printf("%q\n", s)
fmt.Printf("%x\n", s)
fmt.Printf("%X\n", s)
```

输出结果如下：

```bash
小王子
"小王子"
e5b08fe78e8be5ad90
E5B08FE78E8BE5AD90
```



- 指针

![image-20230419222726130](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230419222726130.png)



示例代码如下：

```go
a := 10
fmt.Printf("%p\n", &a)
fmt.Printf("%#p\n", &a)
```

输出结果如下：

```bash
0xc000094000
c000094000
```



- 宽度标识符

  > 宽度通过一个紧跟在百分号后面的十进制数指定，如果未指定宽度，则表示值时除必需之外不作填充。精度通过（可选的）宽度后跟点号后跟的十进制数指定。如果未指定精度，会使用默认精度；如果点号后没有跟数字，表示精度为0。举例如下



![image-20230419222902057](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230419222902057.png)



示例代码如下：

```go
n := 12.34
fmt.Printf("%f\n", n)
fmt.Printf("%9f\n", n)
fmt.Printf("%.2f\n", n)
fmt.Printf("%9.2f\n", n)
fmt.Printf("%9.f\n", n)
```

输出结果如下：

```bash
12.340000
12.340000
12.34
    12.34
       12
```



- 其他flag

![image-20230419222944774](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230419222944774.png)



举个例子：

```go
s := "小王子"
fmt.Printf("%s\n", s)
fmt.Printf("%5s\n", s)
fmt.Printf("%-5s\n", s)
fmt.Printf("%5.7s\n", s)
fmt.Printf("%-5.7s\n", s)
fmt.Printf("%5.2s\n", s)
fmt.Printf("%05s\n", s)
```

输出结果如下：

```bash
小王子
  小王子
小王子  
  小王子
小王子  
   小王
00小王子
```







#### fmt.Scan



#### fmt.Scanf

#### fmt.Scanln

#### bufil.NewReader

#### Fscan

#### Sscan





### 类型别名和自定义类型



- 自定义类型

  >在Go语言中有一些基本的数据类型，如`string`、`整型`、`浮点型`、`布尔`等数据类型， Go语言中可以使用`type`关键字来定义自定义类型。
  >
  >自定义类型是定义了一个全新的类型。我们可以基于内置的基本类型定义，也可以通过struct定义。例如：

  ```go
  //将MyInt定义为int类型
  type MyInt int
  ```

  通过`type`关键字的定义，`MyInt`就是一种新的类型，它具有`int`的特性。

- 类型别名

>
>
>类型别名是`Go1.9`版本添加的新功能。
>
>类型别名规定：TypeAlias只是Type的别名，本质上TypeAlias与Type是同一个类型。就像一个孩子小时候有小名、乳名，上学后用学名，英语老师又会给他起英文名，但这些名字都指的是他本人。

```go
type TypeAlias = Type


```



我们之前见过的`rune`和`byte`就是类型别名，他们的定义如下：

```go
type byte = uint8
type rune = int32
```



- 区别

  > 类型别名与类型定义表面上看只有一个等号的差异，我们通过下面的这段代码来理解它们之间的区别。

  ```go
  //类型定义
  type NewInt int
  
  //类型别名
  type MyInt = int
  
  func main() {
  	var a NewInt
  	var b MyInt
  	
  	fmt.Printf("type of a:%T\n", a) //type of a:main.NewInt
  	fmt.Printf("type of b:%T\n", b) //type of b:int
  }
  ```

  结果显示a的类型是`main.NewInt`，表示main包下定义的`NewInt`类型。b的类型是`int`。`MyInt`类型只会在代码中存在，编译完成时并不会有`MyInt`类型。



## 结构体





### 结构体的定义

> 使用`type`和`struct`关键字来定义结构体，具体代码格式如下：

```go
type 类型名 struct {
    字段名 字段类型
    字段名 字段类型
    …
}
```

示例如下

```go
type person struct {
	name string
	city string
	age  int8
}
```



同样类型的字段也可以写在一行，

```go
type person1 struct {
	name, city string
	age        int8
}
```



### 结构体实例化

只有当结构体实例化时，才会真正地分配内存。也就是必须实例化后才能使用结构体的字段。

结构体本身也是一种类型，我们可以像声明内置类型一样使用`var`关键字声明结构体类型。

```go
var 结构体实例 结构体类型
```



### 基本实例化

举个例子：

```go
type person struct {
	name string
	city string
	age  int8
}

func main() {
	var p1 person
	p1.name = "沙河娜扎"
	p1.city = "北京"
	p1.age = 18
	fmt.Printf("p1=%v\n", p1)  //p1={沙河娜扎 北京 18}
	fmt.Printf("p1=%#v\n", p1) //p1=main.person{name:"沙河娜扎", city:"北京", age:18}
}
```

我们通过`.`来访问结构体的字段（成员变量）,例如`p1.name`和`p1.age`等。



### 匿名结构体

在定义一些临时数据结构等场景下还可以使用匿名结构体。

```go
package main
     
import (
    "fmt"
)
     
func main() {
    var user struct{Name string; Age int}
    user.Name = "小王子"
    user.Age = 18
    fmt.Printf("%#v\n", user)
}
```



### 创建指针类型结构体

我们还可以通过使用`new`关键字对结构体进行实例化，得到的是结构体的地址。 格式如下：



```go
var p2 = new(person)
fmt.Printf("%T\n", p2)     //*main.person
fmt.Printf("p2=%#v\n", p2) //p2=&main.person{name:"", city:"", age:0}
```



需要注意的是在Go语言中支持对结构体指针直接使用`.`来访问结构体的成员。



```go
var p2 = new(person)
p2.name = "小王子"
p2.age = 28
p2.city = "上海"
fmt.Printf("p2=%#v\n", p2) //p2=&main.person{name:"小王子", city:"上海", age:28}
```



### 结构体的地址实例化

使用`&`对结构体进行取地址操作相当于对该结构体类型进行了一次`new`实例化操作。

```go
p3 := &person{}
fmt.Printf("%T\n", p3)     //*main.person
fmt.Printf("p3=%#v\n", p3) //p3=&main.person{name:"", city:"", age:0}
p3.name = "七米"
p3.age = 30
p3.city = "成都"
fmt.Printf("p3=%#v\n", p3) //p3=&main.person{name:"七米", city:"成都", age:30}
```



`p3.name = "七米"`其实在底层是`(*p3).name = "七米"`，这是Go语言帮我们实现的语法糖。





### 结构体初始化



没有初始化的结构体，其成员变量都是对应其类型的零值。

```
type person struct {
	name string
	city string
	age  int8
}

func main() {
	var p4 person
	fmt.Printf("p4=%#v\n", p4) //p4=main.person{name:"", city:"", age:0}
}
```



- ### 使用键值对初始化

使用键值对对结构体进行初始化时，键对应结构体的字段，值对应该字段的初始值。

```go
p5 := person{
	name: "小王子",
	city: "北京",
	age:  18,
}
fmt.Printf("p5=%#v\n", p5) //p5=main.person{name:"小王子", city:"北京", age:18}
```



也可以对结构体指针进行键值对初始化，例如：

```go
p7 := &person{
	city: "北京",
}
fmt.Printf("p7=%#v\n", p7) //p7=&main.person{name:"", city:"北京", age:0}
```



- ### 使用值的列表初始化

初始化结构体的时候可以简写，也就是初始化的时候不写键，直接写值：

```go
p8 := &person{
	"沙河娜扎",
	"北京",
	28,
}
fmt.Printf("p8=%#v\n", p8) //p8=&main.person{name:"沙河娜扎", city:"北京", age:28}
```



使用这种格式初始化时，需要注意：

1. 必须初始化结构体的所有字段。
2. 初始值的填充顺序必须与字段在结构体中的声明顺序一致。
3. 该方式不能和键值初始化方式混用。



- 结构体内存布局

结构体占用一块连续的内存。

```go
type test struct {
	a int8
	b int8
	c int8
	d int8
}
n := test{
	1, 2, 3, 4,
}
fmt.Printf("n.a %p\n", &n.a)
fmt.Printf("n.b %p\n", &n.b)
fmt.Printf("n.c %p\n", &n.c)
fmt.Printf("n.d %p\n", &n.d)
```



输出：

```bash
n.a 0xc0000a0060
n.b 0xc0000a0061
n.c 0xc0000a0062
n.d 0xc0000a0063
```





### 空结构体

空结构体是不占用空间的。

```go
var v struct{}
fmt.Println(unsafe.Sizeof(v))  // 0
```





### 面试题

请问下面那代码的执行结果是什么？

```go
type student struct {
	name string
	age  int
}

func main() {
	m := make(map[string]*student)
	stus := []student{
		{name: "小王子", age: 18},
		{name: "娜扎", age: 23},
		{name: "大王八", age: 9000},
	}

	for _, stu := range stus {
		m[stu.name] = &stu
        
	}
	for k, v := range m {
		fmt.Println(k, "=>", v.name)
	}
}
```







### 构造函数

Go语言的结构体没有构造函数，我们可以自己实现。 例如，下方的代码就实现了一个`person`的构造函数。 因为`struct`是值类型，如果结构体比较复杂的话，值拷贝性能开销会比较大，所以该构造函数返回的是结构体指针类型。



```go
func newPerson(name, city string, age int8) *person {
	return &person{
		name: name,
		city: city,
		age:  age,
	}
}
```

调用构造函数

```go
p9 := newPerson("张三", "沙河", 90)
fmt.Printf("%#v\n", p9) //&main.person{name:"张三", city:"沙河", age:90}
```



{%r%}

注意：

{%endr%}

>  构造函数通常以new开头

### 方法和接收者

Go语言中的`方法（Method）`是一种作用于特定类型变量的函数。这种特定类型变量叫做`接收者（Receiver）`。接收者的概念就类似于其他语言中的`this`或者 `self`。



方法的定义格式如下：

```go
func (接收者变量 接收者类型) 方法名(参数列表) (返回参数) {
    函数体
}
```

其中，

- 接收者变量：接收者中的参数变量名在命名时，官方建议使用接收者类型名称首字母的小写，而不是`self`、`this`之类的命名。例如，`Person`类型的接收者变量应该命名为 `p`，`Connector`类型的接收者变量应该命名为`c`等。
- 接收者类型：接收者类型和参数类似，可以是指针类型和非指针类型。
- 方法名、参数列表、返回参数：具体格式与函数定义相同

举个例子：

```go
//Person 结构体
type Person struct {
	name string
	age  int8
}

//NewPerson 构造函数
func NewPerson(name string, age int8) *Person {
	return &Person{
		name: name,
		age:  age,
	}
}

//Dream Person做梦的方法
func (p Person) Dream() {
	fmt.Printf("%s的梦想是学好Go语言！\n", p.name)
}

func main() {
	p1 := NewPerson("小王子", 25)
    p1.Dream()
}
```

方法与函数的区别是，函数不属于任何类型，方法属于特定的类型。



{%g%}

类似python的类方法

{%endg%}



### 指针类型的接收者

指针类型的接收者由一个结构体的指针组成，由于指针的特性，调用方法时修改接收者指针的任意成员变量，在方法结束后，修改都是有效的。这种方式就十分接近于其他语言中面向对象中的`this`或者`self`。 例如我们为`Person`添加一个`SetAge`方法，来修改实例变量的年龄。



```go
// SetAge 设置p的年龄
// 使用指针接收者
func (p *Person) SetAge(newAge int8) {
	p.age = newAge
}
```

调用该方法：

```go
func main() {
	p1 := NewPerson("小王子", 25)
	fmt.Println(p1.age) // 25
	p1.SetAge(30)
	fmt.Println(p1.age) // 30
}
```





当方法作用于值类型接收者时，Go语言会在代码运行时将接收者的值复制一份。在值类型接收者的方法中可以获取接收者的成员值，但修改操作只是针对副本，无法修改接收者变量本身。

```go
// SetAge2 设置p的年龄
// 使用值接收者
func (p Person) SetAge2(newAge int8) {
	p.age = newAge
}

func main() {
	p1 := NewPerson("小王子", 25)
	p1.Dream()
	fmt.Println(p1.age) // 25
	p1.SetAge2(30) // (*p1).SetAge2(30)
	fmt.Println(p1.age) // 25
}
```



### 什么时候应该使用指针类型接收者

1. 需要修改接收者中的值
2. 接收者是拷贝代价比较大的大对象
3. 保证一致性，如果有某个方法使用了指针接收者，那么其他的方法也应该使用指针接收者。



### 任意类型添加方法

在Go语言中，接收者的类型可以是任何类型，不仅仅是结构体，任何类型都可以拥有方法。 举个例子，我们基于内置的`int`类型使用type关键字可以定义新的自定义类型，然后为我们的自定义类型添加方法。



```go
//MyInt 将int定义为自定义MyInt类型
type MyInt int

//SayHello 为MyInt添加一个SayHello的方法
func (m MyInt) SayHello() {
	fmt.Println("Hello, 我是一个int。")
}
func main() {
	var m1 MyInt
	m1.SayHello() //Hello, 我是一个int。
	m1 = 100
	fmt.Printf("%#v  %T\n", m1, m1) //100  main.MyInt
}
```



{%r%} 

**注意事项：** 非本地类型不能定义方法，也就是说我们不能给别的包的类型定义方法。

{%endr%}





### 结构体的匿名字段

结构体允许其成员字段在声明时没有字段名而只有类型，这种没有名字的字段就称为匿名字段。

```go
//Person 结构体Person类型
type Person struct {
	string
	int
}

func main() {
	p1 := Person{
		"小王子",
		18,
	}
	fmt.Printf("%#v\n", p1)        //main.Person{string:"北京", int:18}
	fmt.Println(p1.string, p1.int) //北京 18
}
```



{%r%}

注意：

{%endr%}

这里匿名字段的说法并不代表没有字段名，而是默认会采用类型名作为字段名，结构体要求字段名称必须唯一，因此一个结构体中同种类型的匿名字段只能有一个。



### 嵌套结构体

一个结构体中可以嵌套包含另一个结构体或结构体指针，就像下面的示例代码那样



```go
//Address 地址结构体
type Address struct {
	Province string
	City     string
}

//User 用户结构体
type User struct {
	Name    string
	Gender  string
	Address Address
}

func main() {
	user1 := User{
		Name:   "小王子",
		Gender: "男",
		Address: Address{
			Province: "山东",
			City:     "威海",
		},
	}
	fmt.Printf("user1=%#v\n", user1)//user1=main.User{Name:"小王子", Gender:"男", Address:main.Address{Province:"山东", City:"威海"}}
}
```



### 嵌套匿名字段



上面user结构体中嵌套的`Address`结构体也可以采用匿名字段的方式，例如：

```go
//Address 地址结构体
type Address struct {
	Province string
	City     string
}

//User 用户结构体
type User struct {
	Name    string
	Gender  string
	Address //匿名字段
}

func main() {
	var user2 User
	user2.Name = "小王子"
	user2.Gender = "男"
	user2.Address.Province = "山东"    // 匿名字段默认使用类型名作为字段名
	user2.City = "威海"                // 匿名字段可以省略
	fmt.Printf("user2=%#v\n", user2) //user2=main.User{Name:"小王子", Gender:"男", Address:main.Address{Province:"山东", City:"威海"}}
}
```



当访问结构体成员时会先在结构体中查找该字段，找不到再去嵌套的匿名字段中查找。



### 嵌套结构体的字段名冲突

嵌套结构体内部可能存在相同的字段名。在这种情况下为了避免歧义需要通过指定具体的内嵌结构体字段名。

```go
//Address 地址结构体
type Address struct {
	Province   string
	City       string
	CreateTime string
}

//Email 邮箱结构体
type Email struct {
	Account    string
	CreateTime string
}

//User 用户结构体
type User struct {
	Name   string
	Gender string
	Address
	Email
}

func main() {
	var user3 User
	user3.Name = "沙河娜扎"
	user3.Gender = "男"
	// user3.CreateTime = "2019" //ambiguous selector user3.CreateTime
	user3.Address.CreateTime = "2000" //指定Address结构体中的CreateTime
	user3.Email.CreateTime = "2000"   //指定Email结构体中的CreateTime
}
```



### 结构体的继承

Go语言中使用结构体也可以实现其他编程语言中面向对象的继承。

```go
//Animal 动物
type Animal struct {
	name string
}

func (a *Animal) move() {
	fmt.Printf("%s会动！\n", a.name)
}

//Dog 狗
type Dog struct {
	Feet    int8
	*Animal //通过嵌套匿名结构体实现继承
}

func (d *Dog) wang() {
	fmt.Printf("%s会汪汪汪~\n", d.name)
}

func main() {
	d1 := &Dog{
		Feet: 4,
		Animal: &Animal{ //注意嵌套的是结构体指针
			name: "乐乐",
		},
	}
	d1.wang() //乐乐会汪汪汪~
	d1.move() //乐乐会动！
}
```



### 结构体字段的可见性

结构体中字段大写开头表示可公开访问，小写表示私有（仅在定义当前结构体的包中可访问）。



### 结构体与JSON序列化

JSON(JavaScript Object Notation) 是一种轻量级的数据交换格式。易于人阅读和编写。同时也易于机器解析和生成。JSON键值对是用来保存JS对象的一种方式，键/值对组合中的键名写在前面并用双引号`""`包裹，使用冒号`:`分隔，然后紧接着值；多个键值之间使用英文`,`分隔。



```go
//Student 学生
type Student struct {
	ID     int
	Gender string
	Name   string
}

//Class 班级
type Class struct {
	Title    string
	Students []*Student
}

func main() {
	c := &Class{
		Title:    "101",
		Students: make([]*Student, 0, 200),
	}
	for i := 0; i < 10; i++ {
		stu := &Student{
			Name:   fmt.Sprintf("stu%02d", i),
			Gender: "男",
			ID:     i,
		}
		c.Students = append(c.Students, stu)
	}
	//JSON序列化：结构体-->JSON格式的字符串
	data, err := json.Marshal(c)
	if err != nil {
		fmt.Println("json marshal failed")
		return
	}
	fmt.Printf("json:%s\n", data)
	//JSON反序列化：JSON格式的字符串-->结构体
	str := `{"Title":"101","Students":[{"ID":0,"Gender":"男","Name":"stu00"},{"ID":1,"Gender":"男","Name":"stu01"},{"ID":2,"Gender":"男","Name":"stu02"},{"ID":3,"Gender":"男","Name":"stu03"},{"ID":4,"Gender":"男","Name":"stu04"},{"ID":5,"Gender":"男","Name":"stu05"},{"ID":6,"Gender":"男","Name":"stu06"},{"ID":7,"Gender":"男","Name":"stu07"},{"ID":8,"Gender":"男","Name":"stu08"},{"ID":9,"Gender":"男","Name":"stu09"}]}`
	c1 := &Class{}
	err = json.Unmarshal([]byte(str), c1)
	if err != nil {
		fmt.Println("json unmarshal failed!")
		return
	}
	fmt.Printf("%#v\n", c1)
}
```





### 结构体标签(Tag)

`Tag`是结构体的元信息，可以在运行的时候通过反射的机制读取出来。 `Tag`在结构体字段的后方定义，由一对**反引号**包裹起来，具体的格式如下：

```bash
`key1:"value1" key2:"value2"`
```

结构体tag由一个或多个键值对组成。键与值使用冒号分隔，值用双引号括起来。同一个结构体字段可以设置多个键值对tag，不同的键值对之间使用空格分隔。

**注意事项：** 为结构体编写`Tag`时，必须严格遵守键值对的规则。结构体标签的解析代码的容错能力很差，一旦格式写错，编译和运行时都不会提示任何错误，通过反射也无法正确取值。例如不要在key和value之间添加空格。

例如我们为`Student`结构体的每个字段定义json序列化时使用的Tag：

```go
//Student 学生
type Student struct {
	ID     int    `json:"id"` //通过指定tag实现json序列化该字段时的key
	Gender string //json序列化是默认使用字段名作为key
	name   string //私有不能被json包访问
}

func main() {
	s1 := Student{
		ID:     1,
		Gender: "男",
		name:   "沙河娜扎",
	}
	data, err := json.Marshal(s1)
	if err != nil {
		fmt.Println("json marshal failed!")
		return
	}
	fmt.Printf("json str:%s\n", data) //json str:{"id":1,"Gender":"男"}
}
```



### 结构体和方法补充知识

因为slice和map这两种数据类型都包含了指向底层数据的指针，因此我们在需要复制它们时要特别注意。我们来看下面的例子：

```go
type Person struct {
	name   string
	age    int8
	dreams []string
}

func (p *Person) SetDreams(dreams []string) {
	p.dreams = dreams
}

func main() {
	p1 := Person{name: "小王子", age: 18}
	data := []string{"吃饭", "睡觉", "打豆豆"}
	p1.SetDreams(data)

	// 你真的想要修改 p1.dreams 吗？
	data[1] = "不睡觉"
	fmt.Println(p1.dreams)  // ?
}
```





正确的做法是在方法中使用传入的slice的拷贝进行结构体赋值。

```go
func (p *Person) SetDreams(dreams []string) {
	p.dreams = make([]string, len(dreams))
	copy(p.dreams, dreams)
}
```



同样的问题也存在于返回值slice和map的情况，在实际编码过程中一定要注意这个问题。





## 包与依赖管理



### 包介绍

Go语言中支持模块化的开发理念，在Go语言中使用`包（package）`来支持代码模块化和代码复用。一个包是由一个或多个Go源码文件（.go结尾的文件）组成，是一种高级的代码复用方案，Go语言为我们提供了很多内置包，如`fmt`、`os`、`io`等。

例如，在之前的章节中我们频繁使用了`fmt`这个内置包。

```go
package main

import "fmt"

func main(){
  fmt.Println("Hello world!")
}
```



### 定义包

我们可以根据自己的需要创建自定义包。一个包可以简单理解为一个存放`.go`文件的文件夹。该文件夹下面的所有`.go`文件都要在非注释的第一行添加如下声明，声明该文件归属的包。

```go
package packagename
```

其中：

- package：声明包的关键字
- packagename：包名，可以不与文件夹的名称一致，不能包含 `-` 符号，最好与其实现的功能相对应。

另外需要注意一个文件夹下面直接包含的文件只能归属一个包，同一个包的文件不能在多个文件夹下。包名为`main`的包是应用程序的入口包，这种包编译后会得到一个可执行文件，而编译不包含`main`包的源代码则不会得到可执行文件。

### 标识符可见性

在同一个包内部声明的标识符都位于同一个命名空间下，在不同的包内部声明的标识符就属于不同的命名空间。想要在包的外部使用包内部的标识符就需要添加包名前缀，例如`fmt.Println("Hello world!")`，就是指调用`fmt`包中的`Println`函数。

如果想让一个包中的标识符（如变量、常量、类型、函数等）能被外部的包使用，那么标识符必须是对外可见的（public）。在Go语言中是通过标识符的首字母大/小写来控制标识符的对外可见（public）/不可见（private）的。在一个包内部只有首字母大写的标识符才是对外可见的。

例如我们定义一个名为`demo`的包，在其中定义了若干标识符。在另外一个包中并不是所有的标识符都能通过`demo.`前缀访问到，因为只有那些首字母是大写的标识符才是对外可见的。

```go
package demo

import "fmt"

// 包级别标识符的可见性

// num 定义一个全局整型变量
// 首字母小写，对外不可见(只能在当前包内使用)
var num = 100

// Mode 定义一个常量
// 首字母大写，对外可见(可在其它包中使用)
const Mode = 1

// person 定义一个代表人的结构体
// 首字母小写，对外不可见(只能在当前包内使用)
type person struct {
	name string
	Age  int
}

// Add 返回两个整数和的函数
// 首字母大写，对外可见(可在其它包中使用)
func Add(x, y int) int {
	return x + y
}

// sayHi 打招呼的函数
// 首字母小写，对外不可见(只能在当前包内使用)
func sayHi() {
	var myName = "七米" // 函数局部变量，只能在当前函数内使用
	fmt.Println(myName)
}
```



同样的规则也适用于结构体，结构体中可导出字段的字段名称必须首字母大写。

```go
type Student struct {
	Name  string // 可在包外访问的方法
	class string // 仅限包内访问的字段
}
```



### 包的引入

要在当前包中使用另外一个包的内容就需要使用`import`关键字引入这个包，并且import语句通常放在文件的开头，`package`声明语句的下方。完整的引入声明语句格式如下:

```go
import importname "path/to/package"
```

其中：

- importname：引入的包名，通常都省略。默认值为引入包的包名。
- path/to/package：引入包的路径名称，必须使用双引号包裹起来。
- Go语言中禁止循环导入包。

一个Go源码文件中可以同时引入多个包，例如：

```go
import "fmt"
import "net/http"
import "os"
```

当然可以使用批量引入的方式。

```go
import (
    "fmt"
  	"net/http"
    "os"
)
```

当引入的多个包中存在相同的包名或者想自行为某个引入的包设置一个新包名时，都需要通过`importname`指定一个在当前文件中使用的新包名。例如，在引入`fmt`包时为其指定一个新包名`f`。

```go
import f "fmt"
```

这样在当前这个文件中就可以通过使用`f`来调用`fmt`包中的函数了。

```go
f.Println("Hello world!")
```

如果引入一个包的时候为其设置了一个特殊`_`作为包名，那么这个包的引入方式就称为匿名引入。一个包被匿名引入的目的主要是为了加载这个包，从而使得这个包中的资源得以初始化。 被匿名引入的包中的`init`函数将被执行并且仅执行一遍。

```go
import _ "github.com/go-sql-driver/mysql"
```

匿名引入的包与其他方式导入的包一样都会被编译到可执行文件中。

需要注意的是，Go语言中不允许引入包却不在代码中使用这个包的内容，如果引入了未使用的包则会触发编译错误。

### init初始化函数

在每一个Go源文件中，都可以定义任意个如下格式的特殊函数：

```go
func init(){
  // ...
}
```

这种特殊的函数不接收任何参数也没有任何返回值，我们也不能在代码中主动调用它。当程序启动的时候，init函数会按照它们声明的顺序自动执行。

一个包的初始化过程是按照代码中引入的顺序来进行的，所有在该包中声明的`init`函数都将被串行调用并且仅调用执行一次。每一个包初始化的时候都是先执行依赖的包中声明的`init`函数再执行当前包中声明的`init`函数。确保在程序的`main`函数开始执行时所有的依赖包都已初始化完成。



![包初始化函数执行顺序示意图](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/package01.png)



每一个包的初始化是先从初始化包级别变量开始的。例如从下面的示例中我们就可以看出包级别变量的初始化会先于`init`初始化函数。

```go
package main

import "fmt"

var x int8 = 10

const pi = 3.14

func init() {
  fmt.Println("x:", x)
  fmt.Println("pi:", pi)
  sayHi()
}

func sayHi() {
	fmt.Println("Hello World!")
}

func main() {
	fmt.Println("你好，世界！")
}
```

输出结果：

```bash
x: 10
pi: 3.14
Hello World!
你好，世界！
```

在上面的代码中，我们了解了Go语言中包的定义及包的初始化过程，这让我们能够在开发时按照自己的需要定义包。同时我们还学到了如何在我们的代码中引入其它的包，不过在本小节的所有示例中我们都是引入Go内置的包。现代编程语言大多都允许开发者对外发布包/库，也支持开发者在自己的代码中引入第三方库。这样的设计能够让广大开发者一起参与到语言的生态环境建设当中，把生态建设的更加完善。



### go module介绍

Go module 是 Go1.11 版本发布的依赖管理方案，从 Go1.14 版本开始推荐在生产环境使用，于Go1.16版本默认开启。Go module 提供了以下命令供我们使用：

go module相关命令

|      命令       |                   介绍                   |
| :-------------: | :--------------------------------------: |
|   go mod init   |      初始化项目依赖，生成go.mod文件      |
| go mod download |          根据go.mod文件下载依赖          |
|   go mod tidy   | 比对项目文件中引入的依赖与go.mod进行比对 |
|  go mod graph   |              输出依赖关系图              |
|   go mod edit   |              编辑go.mod文件              |
|  go mod vendor  |     将项目的所有依赖导出至vendor目录     |
|  go mod verify  |        检验一个依赖包是否被篡改过        |
|   go mod why    |          解释为什么需要某个依赖          |

Go语言在 go module 的过渡阶段提供了 `GO111MODULE` 这个环境变量来作为是否启用 go module 功能的开关，考虑到 Go1.16 之后 go module 已经默认开启，所以本书不再介绍该配置，对于刚接触Go语言的读者而言完全没有必要了解这个历史包袱。



**GOPROXY**

这个环境变量主要是用于设置 Go 模块代理（Go module proxy），其作用是用于使 Go 在后续拉取模块版本时能够脱离传统的 VCS 方式，直接通过镜像站点来快速拉取。

GOPROXY 的默认值是：`https://proxy.golang.org,direct`，由于某些原因国内无法正常访问该地址，所以我们通常需要配置一个可访问的地址。目前社区使用比较多的有两个`https://goproxy.cn`和`https://goproxy.io`，当然如果你的公司有提供GOPROXY地址那么就直接使用。设置GOPAROXY的命令如下：

```bash
go env -w GOPROXY=https://goproxy.cn,direct
```

GOPROXY 允许设置多个代理地址，多个地址之间需使用英文逗号 “,” 分隔。最后的 “direct” 是一个特殊指示符，用于指示 Go 回源到源地址去抓取（比如 GitHub 等）。当配置有多个代理地址时，如果第一个代理地址返回 404 或 410 错误时，Go 会自动尝试下一个代理地址，当遇见 “direct” 时触发回源，也就是回到源地址去抓取。



**GOPRIVATE**

设置了GOPROXY 之后，go 命令就会从配置的代理地址拉取和校验依赖包。当我们在项目中引入了非公开的包（公司内部git仓库或 github 私有仓库等），此时便无法正常从代理拉取到这些非公开的依赖包，这个时候就需要配置 GOPRIVATE 环境变量。GOPRIVATE用来告诉 go 命令哪些仓库属于私有仓库，不必通过代理服务器拉取和校验。

GOPRIVATE 的值也可以设置多个，多个地址之间使用英文逗号 “,” 分隔。我们通常会把自己公司内部的代码仓库设置到 GOPRIVATE 中，例如：

```bash
$ go env -w GOPRIVATE="git.mycompany.com"
```

这样在拉取以`git.mycompany.com`为路径前缀的依赖包时就能正常拉取了。

此外，如果公司内部自建了 GOPROXY 服务，那么我们可以通过设置 `GONOPROXY=none`，允许通内部代理拉取私有仓库的包。



### 使用go module引入包

接下来我们将通过一个示例来演示如何在开发项目时使用 go module 拉取和管理项目依赖。



**初始化项目** 我们在本地新建一个名为`holiday`项目，按如下方式创建一个名为`holiday`的文件夹并切换到该目录下：

```bash
$ mkdir holiday
$ cd holiday
```



目前我们位于`holiday`文件夹下，接下来执行下面的命令初始化项目。

```bash
$ go mod init holiday
go: creating new go.mod: module holiday
```



该命令会自动在项目目录下创建一个`go.mod`文件，其内容如下。

```go
module holiday

go 1.16
```



其中：

- module holiday：定义当前项目的导入路径
- go 1.16：标识当前项目使用的 Go 版本

`go.mod`文件会记录项目使用的第三方依赖包信息，包括包名和版本，由于我们的`holiday`项目目前还没有使用到第三方依赖包，所以`go.mod`文件暂时还没有记录任何依赖包信息，只有当前项目的一些信息。

接下来，我们在项目目录下新建一个`main.go`文件，其内容如下：





```go
// holiday/main.go

package main

import "fmt"

func main() {
	fmt.Println("现在是假期时间...")
}
```



然后，我们的`holiday`项目现在需要引入一个第三方包`github.com/q1mi/hello`来实现一些必要的功能。类似这样的场景在我们的日常开发中是很常见的。我们需要先将依赖包下载到本地同时在`go.mod`中记录依赖信息，然后才能在我们的代码中引入并使用这个包。下载依赖包主要有两种方法。

第一种方法是在项目目录下执行`go get`命令手动下载依赖的包：

```bash
holiday $ go get -u github.com/q1mi/hello
go get: added github.com/q1mi/hello v0.1.1
```

这样默认会下载最新的发布版本，你也可以指定想要下载指定的版本号的。

```bash
holiday $ go get -u github.com/q1mi/hello@v0.1.0
go: downloading github.com/q1mi/hello v0.1.0
go get: downgraded github.com/q1mi/hello v0.1.1 => v0.1.0
```

如果依赖包没有发布任何版本则会拉取最新的提交，最终`go.mod`中的依赖信息会变成类似下面这种由默认v0.0.0的版本号和最新一次commit的时间和hash组成的版本格式：

```go
require github.com/q1mi/hello v0.0.0-20210218074646-139b0bcd549d
```

如果想指定下载某个commit对应的代码，可以直接指定commit hash，不过没有必要写出完整的commit hash，一般前7位即可。例如：

```bash
holiday $ go get github.com/q1mi/hello@2ccfadd
go: downloading github.com/q1mi/hello v0.1.2-0.20210219092711-2ccfaddad6a3
go get: added github.com/q1mi/hello v0.1.2-0.20210219092711-2ccfaddad6a3
```

此时，我们打开`go.mod`文件就可以看到下载的依赖包及版本信息都已经被记录下来了。

```go
module holiday

go 1.16

require github.com/q1mi/hello v0.1.0 // indirect
```

行尾的`indirect`表示该依赖包为间接依赖，说明在当前程序中的所有 import 语句中没有发现引入这个包。

另外在执行`go get`命令下载一个新的依赖包时一般会额外添加`-u`参数，强制更新现有依赖。

第二种方式是我们直接编辑`go.mod`文件，将依赖包和版本信息写入该文件。例如我们修改`holiday/go.mod`文件内容如下：

```go
module holiday

go 1.16

require github.com/q1mi/hello latest
```

表示当前项目需要使用`github.com/q1mi/hello`库的最新版本，然后在项目目录下执行`go mod download`下载依赖包。

```bash
holiday $ go mod download
```

如果不输出其它提示信息就说明依赖已经下载成功，此时`go.mod`文件已经变成如下内容。

```go
module holiday

go 1.16

require github.com/q1mi/hello v0.1.1
```

从中我们可以知道最新的版本号是`v0.1.1`。如果事先知道依赖包的具体版本号，可以直接在`go.mod`中指定需要的版本然后再执行`go mod download`下载。

这种方法同样支持指定想要下载的commit进行下载，例如直接在`go.mod`文件中按如下方式指定commit hash，这里只写出来了commit hash的前7位。

```go
require github.com/q1mi/hello 2ccfadda
```

执行`go mod download`下载完依赖后，`go.mod`文件中对应的版本信息会自动更新为类似下面的格式。

```go
module holiday

go 1.16

require github.com/q1mi/hello v0.1.2-0.20210219092711-2ccfaddad6a3
```

下载好要使用的依赖包之后，我们现在就可以在`holiday/main.go`文件中使用这个包了。

```go
package main

import (
	"fmt"

	"github.com/q1mi/hello"
)

func main() {
	fmt.Println("现在是假期时间...")

	hello.SayHi() // 调用hello包的SayHi函数
}
```

将上述代码编译执行，就能看到执行结果了。

```bash
holiday $ go build
holiday $ ./holiday
现在是假期时间...
你好，我是七米。很高兴认识你。
```

当我们的项目功能越做越多，代码越来越多的时候，通常会选择在项目内部按功能或业务划分成多个不同包。Go语言支持在一个项目（project）下定义多个包（package）。

例如，我们在`holiday`项目内部创建一个新的package——`summer`，此时新的项目目录结构如下：

```bash
holidy
├── go.mod
├── go.sum
├── main.go
└── summer
    └── summer.go
```

其中`holiday/summer/summer.go`文件内容如下：

```go
package summer

import "fmt"

// Diving 潜水...
func Diving() {
	fmt.Println("夏天去诗巴丹潜水...")
}
```

此时想要在当前项目目录下的其他包或者`main.go`中调用这个`Diving`函数需要如何引入呢？这里以在`main.go`中演示详细的调用过程为例，在项目内其他包的引入方式类似。

```go
package main

import (
	"fmt"

	"holiday/summer" // 导入当前项目下的包

	"github.com/q1mi/hello" // 导入github上第三方包
)

func main() {
	fmt.Println("现在是假期时间...")
	hello.SayHi()

	summer.Diving()
}
```

从上面的示例可以看出，项目中定义的包都会以项目的导入路径为前缀。

如果你想要导入本地的一个包，并且这个包也没有发布到到其他任何代码仓库，这时候你可以在`go.mod`文件中使用`replace`语句将依赖临时替换为本地的代码包。例如在我的电脑上有另外一个名为`liwenzhou.com/overtime`的项目，它位于`holiday`项目同级目录下：

```bash
├── holiday
│   ├── go.mod
│   ├── go.sum
│   ├── main.go
│   └── summer
│       └── summer.go
└── overtime
    ├── go.mod
    └── overtime.go
```

由于`liwenzhou.com/overtime`包只存在于我本地，并不能通过网络获取到这个代码包，这个时候应该如何在`holidy`项目中引入它呢？

我们可以在`holidy/go.mod`文件中正常引入`liwenzhou.com/overtime`包，然后像下面的示例那样使用`replace`语句将这个依赖替换为使用相对路径表示的本地包。

```go
module holiday

go 1.16

require github.com/q1mi/hello v0.1.1
require liwenzhou.com/overtime v0.0.0

replace liwenzhou.com/overtime  => ../overtime
```

这样，我们就可以在`holiday/main.go`下正常引入并使用`overtime`包了。

```go
package main

import (
	"fmt"

	"holiday/summer" // 导入当前项目下的包

	"liwenzhou.com/overtime" // 通过replace导入的本地包

	"github.com/q1mi/hello" // 导入github上第三方包
)

func main() {
	fmt.Println("现在是假期时间...")
	hello.SayHi()

	summer.Diving()

	overtime.Do()
}
```

我们也经常使用`replace`将项目依赖中的某个包，替换为其他版本的代码包或我们自己修改后的代码包。

**go.mod文件**

`go.mod`文件中记录了当前项目中所有依赖包的相关信息，声明依赖的格式如下：

```bash
require module/path v1.2.3
```

其中：

- require：声明依赖的关键字
- module/path：依赖包的引入路径
- v1.2.3：依赖包的版本号。支持以下几种格式：
  - latest：最新版本
  - v1.0.0：详细版本号
  - commit hash：指定某次commit hash

引入某些没有发布过`tag`版本标识的依赖包时，`go.mod`中记录的依赖版本信息就会出现类似`v0.0.0-20210218074646-139b0bcd549d`的格式，由版本号、commit时间和commit的hash值组成。

![go module生成的版本信息组成示意图](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/module_version_info.png)

**go.sum文件**

使用go module下载了依赖后，项目目录下还会生成一个`go.sum`文件，这个文件中详细记录了当前项目中引入的依赖包的信息及其hash 值。`go.sum`文件内容通常是以类似下面的格式出现。

```go
<module> <version>/go.mod <hash>
```

或者

```go
<module> <version> <hash>
<module> <version>/go.mod <hash>
```

不同于其他语言提供的基于中心的包管理机制，例如 npm 和 pypi等，Go并没有提供一个中央仓库来管理所有依赖包，而是采用分布式的方式来管理包。为了防止依赖包被非法篡改，Go module 引入了`go.sum`机制来对依赖包进行校验。

**依赖保存位置**

Go module 会把下载到本地的依赖包会以类似下面的形式保存在 `$GOPATH/pkg/mod`目录下，每个依赖包都会带有版本号进行区分，这样就允许在本地存在同一个包的多个不同版本。

```bash
mod
├── cache
├── cloud.google.com
├── github.com
    	└──q1mi
          ├── hello@v0.0.0-20210218074646-139b0bcd549d
          ├── hello@v0.1.1
          └── hello@v0.1.0
...
```

如果想清除所有本地已缓存的依赖包数据，可以执行 `go clean -modcache` 命令。





### 使用go module发布包

在上面的小节中我们学习了如何在项目中引入别人提供的依赖包，那么当我们想要在社区发布一个自己编写的代码包或者在公司内部编写一个供内部使用的公用组件时，我们该怎么做呢？接下来，我们就一起编写一个代码包并将它发布到`github.com`仓库，让它能够被全球的Go语言开发者使用。

我们首先在自己的 github 账号下新建一个项目，并把它下载到本地。我这里就以创建和发布一个名为`hello`的项目为例进行演示。这个`hello`包将对外提供一个名为`SayHi`的函数，它的作用非常简单就是向调用者发去问候。

```bash
$ git clone https://github.com/q1mi/hello
$ cd hello
```

我们当前位于`hello`项目目录下，执行下面的命令初始化项目，创建`go.mod`文件。需要注意的是这里定义项目的引入路径为`github.com/q1mi/hello`，读者在自行测试时需要将这部分替换为自己的仓库路径。

```bash
hello $ go mod init github.com/q1mi/hello
go: creating new go.mod: module github.com/q1mi/hello
```

接下来我们在该项目根目录下创建 `hello.go` 文件，添加下面的内容：

```go
package hello

import "fmt"

func SayHi() {
	fmt.Println("你好，我是七米。很高兴认识你。")
}
```

然后将该项目的代码 push 到仓库的远端分支，这样就对外发布了一个Go包。其他的开发者可以通过`github.com/q1mi/hello`这个引入路径下载并使用这个包了。

一个设计完善的包应该包含开源许可证及文档等内容，并且我们还应该尽心维护并适时发布适当的版本。github 上发布版本号使用git tag为代码包打上标签即可。

```bash
hello $ git tag -a v0.1.0 -m "release version v0.1.0"
hello $ git push origin v0.1.0
```

经过上面的操作我们就发布了一个版本号为`v0.1.0`的版本。

Go modules中建议使用语义化版本控制，其建议的版本号格式如下：

![语义化版本号示意图](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/version_number.png)

其中：

- 主版本号：发布了不兼容的版本迭代时递增（breaking changes）。
- 次版本号：发布了功能性更新时递增。
- 修订号：发布了bug修复类更新时递增。

**发布新的主版本**

现在我们的`hello`项目要进行与之前版本不兼容的更新，我们计划让`SayHi`函数支持向指定人发出问候。更新后的`SayHi`函数内容如下：

```go
package hello

import "fmt"

// SayHi 向指定人打招呼的函数
func SayHi(name string) {
	fmt.Printf("你好%s，我是七米。很高兴认识你。\n", name)
}
```

由于这次改动巨大（修改了函数之前的调用规则），对之前使用该包作为依赖的用户影响巨大。因此我们需要发布一个主版本号递增的`v2`版本。在这种情况下，我们通常会修改当前包的引入路径，像下面的示例一样为引入路径添加版本后缀。

```go
// hello/go.mod

module github.com/q1mi/hello/v2

go 1.16
```

把修改后的代码提交：

```bash
hello $ git add .
hello $ git commit -m "feat: SayHi现在支持给指定人打招呼啦"
hello $ git push
```

打好 tag 推送到远程仓库。

```bash
hello $ git tag -a v2.0.0 -m "release version v2.0.0"
hello $ git push origin v2.0.0
```

这样在不影响使用旧版本的用户的前提下，我们新的版本也发布出去了。想要使用`v2`版本的代码包的用户只需按修改后的引入路径下载即可。

```bash
go get github.com/q1mi/hello/v2@v2.0.0
```

在代码中使用的过程与之前类似，只是需要注意引入路径要添加 v2 版本后缀。

```go
package main

import (
	"fmt"

	"github.com/q1mi/hello/v2" // 引入v2版本
)

func main() {
	fmt.Println("现在是假期时间...")

	hello.SayHi("张三") // v2版本的SayHi函数需要传入字符串参数
}
```

**废弃已发布版本**

如果某个发布的版本存在致命缺陷不再想让用户使用时，我们可以使用`retract`声明废弃的版本。例如我们在`hello/go.mod`文件中按如下方式声明即可对外废弃`v0.1.2`版本。

```go
module github.com/q1mi/hello

go 1.16


retract v0.1.2
```



用户使用go get下载`v0.1.2`版本时就会收到提示，催促其升级到其他版本。



## 接口





### 接口定义

每个接口类型由任意个方法签名组成，接口的定义格式如下：

```go
type 接口类型名 interface{
    方法名1( 参数列表1 ) 返回值列表1
    方法名2( 参数列表2 ) 返回值列表2
    …
}
```

其中：

- 接口类型名：Go语言的接口在命名时，一般会在单词后面添加`er`，如有写操作的接口叫`Writer`，有关闭操作的接口叫`closer`等。接口名最好要能突出该接口的类型含义。

- 方法名：当方法名首字母是大写且这个接口类型名首字母也是大写时，这个方法可以被接口所在的包（package）之外的代码访问。

- 参数列表、返回值列表：参数列表和返回值列表中的参数变量名可以省略。

- 举个例子，定义一个包含`Write`方法的`Writer`接口。

  ```go
  type Writer interface{
      Write([]byte) error
  }
  ```

  当你看到一个`Writer`接口类型的值时，你不知道它是什么，唯一知道的就是可以通过调用它的`Write`方法来做一些事情。



### 实现接口的条件

接口就是规定了一个**需要实现的方法列表**，在 Go 语言中一个类型只要实现了接口中规定的所有方法，那么我们就称它实现了这个接口。

我们定义的`Singer`接口类型，它包含一个`Sing`方法。

```go
// Singer 接口
type Singer interface {
	Sing()
}
```

我们有一个`Bird`结构体类型如下。

```go
type Bird struct {}
```

因为`Singer`接口只包含一个`Sing`方法，所以只需要给`Bird`结构体添加一个`Sing`方法就可以满足`Singer`接口的要求。

```go
// Sing Bird类型的Sing方法
func (b Bird) Sing() {
	fmt.Println("汪汪汪")
}
```

这样就称为`Bird`实现了`Singer`接口。



### 为什么要使用接口

现在假设我们有许多小动物，下面的代码定义了猫和狗，他们饿了都会叫

```go
package main
import "fmt"

type Cat struct{}

func (c Cat) Say(){
    fmt.Println("猫在叫")
}
type Dog struct{}

func (d Dog) Say(){
    fmt.Println("狗在叫")
}

func main(){
    c :=Cat()
    c.Say()
    d:= Dog()
    d.Say()
    
}
```

在这个时候，又跑来了一直羊，羊也会叫

```go
type Sheep struct{}

func (s Sheep) Say(){
    fmt.Println("羊在叫")
}
```

我们接下来定义一个饿肚子的场景

```go
// MakeCatHungry 猫饿了会喵喵喵~
func MakeCatHungry(c Cat) {
	c.Say()
}

// MakeSheepHungry 羊饿了会咩咩咩~
func MakeSheepHungry(s Sheep) {
	s.Say()
}
```



接下来会有越来越多的小动物跑过来，我们的代码世界该怎么拓展呢？

在饿肚子这个场景下，我们可不可以把所有动物都当成一个“会叫的类型”来处理呢？当然可以！使用接口类型就可以实现这个目标。 我们的代码其实并不关心究竟是什么动物在叫，我们只是在代码中调用它的`Say()`方法，这就足够了。

我们可以约定一个`Sayer`类型，它必须实现一个`Say()`方法，只要饿肚子了，我们就调用`Say()`方法。

然后我们定义一个通用的`MakeHungry`函数，接收`Sayer`类型的参数。

```go
// MakeHungry 饿肚子了...
func MakeHungry(s Sayer) {
	s.Say()
}
```

我们通过使用接口类型，把所有会叫的动物当成`Sayer`类型来处理，只要实现了`Say()`方法都能当成`Sayer`类型的变量来处理。

```go
var c cat
MakeHungry(c)
var d dog
MakeHungry(d)
```





在电商系统中我们允许用户使用多种支付方式（支付宝支付、微信支付、银联支付等），我们的交易流程中可能不太在乎用户究竟使用什么支付方式，只要它能提供一个实现支付功能的`Pay`方法让调用方调用就可以了。

再比如我们需要在某个程序中添加一个将某些指标数据向外输出的功能，根据不同的需求可能要将数据输出到终端、写入到文件或者通过网络连接发送出去。在这个场景下我们可以不关注最终输出的目的地是什么，只需要它能提供一个`Write`方法让我们把内容写入就可以了。

Go语言中为了解决类似上面的问题引入了接口的概念，接口类型区别于我们之前章节中介绍的那些具体类型，让我们专注于该类型提供的方法，而不是类型本身。使用接口类型通常能够让我们写出更加通用和灵活的代码。



### 面向接口编程

HP、Java等语言中也有接口的概念，不过在PHP和Java语言中需要显式声明一个类实现了哪些接口，在Go语言中使用隐式声明的方式实现接口。只要一个类型实现了接口中规定的所有方法，那么它就实现了这个接口。

Go语言中的这种设计符合程序开发中抽象的一般规律，例如在下面的代码示例中，我们的电商系统最开始只设计了支付宝一种支付方式：

```go
type ZhiFuBao struct {
	// 支付宝
}

// Pay 支付宝的支付方法
func (z *ZhiFuBao) Pay(amount int64) {
  fmt.Printf("使用支付宝付款：%.2f元。\n", float64(amount/100))
}

// Checkout 结账
func Checkout(obj *ZhiFuBao) {
	// 支付100元
	obj.Pay(100)
}

func main() {
	Checkout(&ZhiFuBao{})
}
```





随着业务的发展，根据用户需求添加支持微信支付。

```go
type WeChat struct {
	// 微信
}

// Pay 微信的支付方法
func (w *WeChat) Pay(amount int64) {
	fmt.Printf("使用微信付款：%.2f元。\n", float64(amount/100))
}
```



在实际的交易流程中，我们可以根据用户选择的支付方式来决定最终调用支付宝的Pay方法还是微信支付的Pay方法。

```go
// Checkout 支付宝结账
func CheckoutWithZFB(obj *ZhiFuBao) {
	// 支付100元
	obj.Pay(100)
}

// Checkout 微信支付结账
func CheckoutWithWX(obj *WeChat) {
	// 支付100元
	obj.Pay(100)
}
```

实际上，从上面的代码示例中我们可以看出，我们其实并不怎么关心用户选择的是什么支付方式，我们只关心调用Pay方法时能否正常运行。这就是典型的“不关心它是什么，只关心它能做什么”的场景。

在这种场景下我们可以将具体的支付方式抽象为一个名为`Payer`的接口类型，即任何实现了`Pay`方法的都可以称为`Payer`类型。

```go
// Payer 包含支付方法的接口类型
type Payer interface {
	Pay(int64)
}
```

此时只需要修改下原始的`Checkout`函数，它接收一个`Payer`类型的参数。这样就能够在不修改既有函数调用的基础上，支持新的支付方式。

```go
// Checkout 结账
func Checkout(obj Payer) {
	// 支付100元
	obj.Pay(100)
}

func main() {
	Checkout(&ZhiFuBao{}) // 之前调用支付宝支付

	Checkout(&WeChat{}) // 现在支持使用微信支付
}
```



像类似的例子在我们编程过程中会经常遇到：

- 比如一个网上商城可能使用支付宝、微信、银联等方式去在线支付，我们能不能把它们当成“支付方式”来处理呢？
- 比如三角形，四边形，圆形都能计算周长和面积，我们能不能把它们当成“图形”来处理呢？
- 比如满减券、立减券、打折券都属于电商场景下常见的优惠方式，我们能不能把它们当成“优惠券”来处理呢？

接口类型是Go语言提供的一种工具，在实际的编码过程中是否使用它由你自己决定，但是通常使用接口类型可以使代码更清晰易读。



那实现了接口又有什么用呢？一个接口类型的变量能够存储所有实现了该接口的类型变量。

例如在上面的示例中，`Dog`和`Cat`类型均实现了`Sayer`接口，此时一个`Sayer`类型的变量就能够接收`Cat`和`Dog`类型的变量。

```go
var x Sayer // 声明一个Sayer类型的变量x
a := Cat{}  // 声明一个Cat类型变量a
b := Dog{}  // 声明一个Dog类型变量b
x = a       // 可以把Cat类型变量直接赋值给x
x.Say()     // 喵喵喵
x = b       // 可以把Dog类型变量直接赋值给x
x.Say()     // 汪汪汪
```



### 值接收者和指针接收者

在结构体那一章节中，我们介绍了在定义结构体方法时既可以使用值接收者也可以使用指针接收者。那么对于实现接口来说使用值接收者和使用指针接收者有什么区别呢？接下来我们通过一个例子看一下其中的区别。

我们定义一个`Mover`接口，它包含一个`Move`方法。

```go
// Mover 定义一个接口类型
type Mover interface {
	Move()
}
```



#### 值接收者实现接口

我们定义一个`Dog`结构体类型，并使用值接收者为其定义一个`Move`方法。

````go
type Dog struct{}

func(d Dog) Move(){
    fmt.Println("狗会动")
}
````



此时实现mover接口的时Dog类型

```go
var x Mover  //声明mover类型

var d1 = Dog{}
x = d1 //可以将d1 赋值给变量x
x.Move()

var d2 = *Dog{}
x = d2    // d2是Dog指针类型
x.Move() // 也可以将d2赋值给变量x


```



从上面的代码中我们可以发现，使用值接收者实现接口之后，不管是结构体类型还是对应的结构体指针类型的变量都可以赋值给该接口变量。





## 日志库项目



### 需求分析

- 向文件中写入日志
- 日志分级别
  - debug
  - info
  - warning
  - error
  - fatal
- 日志支持开关控制
- 日志要有时间，行号，文件名，日志级别，具体的日志信息
- 日志文件需要切割

## 反射

> 反射是指在程序运行期间对程序本身进行访问和修改的能力。程序在编译时，变量被转换成内存地址，变量名不会被编译器写入到可执行部分，在运行程序时，程序无法获取自身信息
>
> 支持反射的语言可以在程序编译期间将变量的反射信息，如字段名称，类型信息，结构体信息等整合到可执行文件中，并给程序提供接口访问反射信息，这样就可以在程序运行期间获取类型的反射信息，并有能力修改他们
>
> Go程序在运行期间使用reflect包访问程序的反射信息
>
> 空接口可以存储任意类型的变量，那我们如何知道这个空接口保存的数据是什么呢。反射就是在运行时动态的获取一个变量的类型信息和值信息



### reflect包

在Go语言的反射机制中，任何接口都是由`一个具体类型`和`具体类型的值`两个部分组成。在Go语言中反射相关的功能有内置的reflect包提供，任意接口值在反射中都可以理解为有`reflect.Type`和`reflect.Value`两部分组成，并且reflect包还提供了`reflect.TypeOf`和`reflect.ValueOf`两个函数来获取任意对象的Value和Type

### TypeOf

> 在Go语言中使用`reflect.TypeOf（）`函数来获取任意值的类型对象（reflect.Type），程序通过类型对象可以访问任意值的类型信息

```go
package main

import (
	"fmt"
	"reflect"
)

func reflectType(x interface{}) {
	v := reflect.TypeOf(x)
	fmt.Printf("type:%v\n", v)
}

func main() {
	var a float32 = 3.14
	reflectType(a) // type:float32

	var b int64 = 100
	reflectType(b)
}

```



#### type name和type kind



在反射中关于类型还划分为两种：类型（Type）和种类（kind）。因为在Go语言中我们可以使用type关键字构造很多自定义类型，而`种类king`就是指底层的类型，但在反射中，当需要区分指针、结构体等大品种类型时，就会用到`种类（kind）`。

```go
package main

import (
	"fmt"
	"reflect"
)

type myInt int64

func reflectType(x interface{}) {
	t := reflect.TypeOf(x)
	fmt.Printf("type:%v kind:%v\n", t.Name(), t.Kind())
}

func main() {
	var a *float32
	var b myInt
	var c rune
	reflectType(a)  // type: kind:ptr
	reflectType(b)  // type:myInt kind:int64
	reflectType(c)  // type:int32 kind:int32

	type person struct {
		name string
		age  int
	}

	type book struct{ title string }
	var d = person{
		name: "沙河小王子",
		age:  18,
	}
	var e = book{title: "《跟着小王子学习Go语言》"}
	reflectType(d) //type:person kind:struct
	reflectType(e) //type:book kind:struct
}
```



Go语言的反射中像数组、切片、Map、指针等类型的变量，它们的`.Name()`都是返回`空`

### VelueOf

`reflect.ValueOf`返回的时`reflect.Value`类型，其中包含了原始的值信息

`reflect.Value` 与原始值之间可以相互转换

`reflect.Value`类型提供的获取原始值的方法如下

|           方法           |                             说明                             |
| :----------------------: | :----------------------------------------------------------: |
| Interface() interface {} | 将值以 interface{} 类型返回，可以通过类型断言转换为指定类型  |
|       Int() int64        |     将值以 int 类型返回，所有有符号整型均可以此方式返回      |
|      Uint() uint64       |     将值以 uint 类型返回，所有无符号整型均可以此方式返回     |
|     Float() float64      | 将值以双精度（float64）类型返回，所有浮点数（float32、float64）均可以此方式返回 |
|       Bool() bool        |                     将值以 bool 类型返回                     |
|     Bytes() []bytes      |               将值以字节数组 []bytes 类型返回                |
|     String() string      |                     将值以字符串类型返回                     |

通过反射获取值

```go

package main

import (
	"fmt"
	"reflect"
)

func reflectValue(x interface{}) {

	v := reflect.ValueOf(x)
	k := v.Kind()
	switch k {
	case reflect.Int64:
		fmt.Printf("type is int64, value is %d\n", int64(v.Int()))
	case reflect.Float32:
		fmt.Printf("type is float32, value is %f\n", float32(v.Float()))
	case reflect.Float64:
		// v.Float()从反射中获取浮点型的原始值，然后通过float64()强制类型转换
		fmt.Printf("type is float64, value is %f\n", float64(v.Float()))

	}

}

func main() {
	var a float32 = 3.14
	var b int64 = 100
	reflectValue(a)
	reflectValue(b)
	c := reflect.ValueOf((10))
	fmt.Printf("type c:%T\n", c) // type c : reflect.Value
}


```



### 通过反射设置变量的值

> 想要在函数中通过反射修改变量的值，需要注意函数参数传递的时值拷贝，必须传递变量地址才能修改变量，而反射中使用专有的`Elem()`方法来获取指针对应的值

```go
package main

import (
	"fmt"
	"reflect"
)

// func reflectSetValue1(x interface{}) {
// 	v := reflect.ValueOf(x)
// 	if v.Kind() == reflect.Int64{
// 		v.SetInt(200)  // 修改的时副本，reflect包惠引发panic
// 	}
// }

func reflectSetValue2(x interface{}) {
	v := reflect.ValueOf(x)

	if v.Elem().Kind() == reflect.Int64 {
		v.Elem().SetInt(200)
	}
}

func main() {
	var a int64 = 100
	// reflectSetValue1(a) //panic: reflect: reflect.Value.SetInt using unaddressable value
	reflectSetValue2(&a)
	fmt.Println(a)
}

```

### isNil和isValid

isNil()

```go
func (v value) IsNil() bool
```

`IsNil()`报告v持有的值是否为nil。v持有的值的分类必须是通道、函数、接口、映射、指针、切片之一；否则IsNil函数会导致panic。

#### isValid()

```go
func (v Value) IsValid() bool
```

`IsValid()`返回v是否持有一个值。如果v是Value零值会返回假，此时v除了IsValid、String、Kind之外的方法都会导致panic。



`IsNil()`常被用于判断指针是否为空；`IsValid()`常被用于判定返回值是否有效。

```go
package main

import (
	"fmt"
	"reflect"
)

func main() {
	var a *int
	fmt.Println("var a *int IsNil", reflect.ValueOf(a).IsNil())
	// nil
	fmt.Println("nil isValid:", reflect.ValueOf(nil).IsValid())

	b := struct{}{}
	fmt.Println("不存在结构体成员：", reflect.ValueOf(b).FieldByName("abc").IsValid())

	fmt.Println("不存在的结构体方法:", reflect.ValueOf(b).MethodByName("abc").IsValid())
	// map
	c := map[string]int{}
	// 尝试从map中查找一个不存在的键
	fmt.Println("map中不存在的键：", reflect.ValueOf(c).MapIndex(reflect.ValueOf("娜扎")).IsValid())
}

```



### 结构体反射

> 任意值通过reflect.TypeOf()获得反射对象 信息后，如果他的类型时结构体，可以通过反射对象（`reflect.Type`）的`NumField()`和`Field()`方法获得结构体成员的详细信息



reflect.Type中获取结构体成员相关的方法如下所示

| Field(i int) StructField                                    | 根据索引，返回索引对应的结构体字段的信息。                   |
| ----------------------------------------------------------- | ------------------------------------------------------------ |
| NumField() int                                              | 返回结构体成员字段数量。                                     |
| FieldByName(name string) (StructField, bool)                | 根据给定字符串返回字符串对应的结构体字段的信息。             |
| FieldByIndex(index []int) StructField                       | 多层成员访问时，根据 []int 提供的每个结构体的字段索引，返回字段的信息。 |
| FieldByNameFunc(match func(string) bool) (StructField,bool) | 根据传入的匹配函数匹配需要的字段。                           |
| NumMethod() int                                             | 返回该类型的方法集中方法的数目                               |
| Method(int) Method                                          | 返回该类型方法集中的第i个方法                                |
| MethodByName(string)(Method, bool)                          | 根据方法名返回该类型方法集中的方法                           |



### StructField 类型

`structField`类型用来描述结构体中的一个字段的信息。



```go
type StructField struct {
    // Name是字段的名字。PkgPath是非导出字段的包路径，对导出字段该字段为""。
    // 参见http://golang.org/ref/spec#Uniqueness_of_identifiers
    Name    string
    PkgPath string
    Type      Type      // 字段的类型
    Tag       StructTag // 字段的标签
    Offset    uintptr   // 字段在结构体中的字节偏移量
    Index     []int     // 用于Type.FieldByIndex时的索引切片
    Anonymous bool      // 是否匿名字段
}
```



### 结构体反射实例

> 当我们使用反射得到一个结构体数据之后可以通过索引一次获取字段信息，也可以通过字段名去获取指定字段信息

```go
package main

import (
	"fmt"
	"reflect"
)

type student struct {
	Name  string `json:"name"`
	Score int    `json:"score"`
}

func main() {

	stu1 := student{
		Name:  "小王子",
		Score: 90,
	}
	t := reflect.TypeOf(stu1)
	fmt.Println(t.Name(), t.Kind())
	// 通过for 循环遍历结构体所有字段信息
	for i := 0; i < t.NumField(); i++ {
		field := t.Field(i)
		fmt.Printf("name:%s, index:%d, type:%v, json tag:%v\n", field.Name, field.Index, field.Type, field.Tag.Get("json"))
	}
```



接下来编写一个函数`printMethod(s interface{})`来遍历打印s包含的方法。

```go
// 给student添加两个方法 Study和Sleep(注意首字母大写)
func (s student) Study() string {
	msg := "好好学习，天天向上。"
	fmt.Println(msg)
	return msg
}

func (s student) Sleep() string {
	msg := "好好睡觉，快快长大。"
	fmt.Println(msg)
	return msg
}

func printMethod(x interface{}) {
	t := reflect.TypeOf(x)
	v := reflect.ValueOf(x)

	fmt.Println(t.NumMethod())
	for i := 0; i < v.NumMethod(); i++ {
		methodType := v.Method(i).Type()
		fmt.Printf("method name:%s\n", t.Method(i).Name)
		fmt.Printf("method:%s\n", methodType)
		// 通过反射调用方法传递的参数必须是 []reflect.Value 类型
		var args = []reflect.Value{}
		v.Method(i).Call(args)
	}
}
```



## strconv标准库

> strconv包实现了基本数据类型和字符串之间的转换，主要有以下常用函数：`Atoi`、 `	Itoa`、`parse`系列、`format`系列、`append`系列





### string和int类型转换

#### Atoi

`Atoi()`函数用于将字符串类型的整数转换为int类型，函数签名如下。

```go
func Atoi(s string) (i int, err error)
```

如果传入的字符串参数无法转换为int类型，就会返回错误。

```go
s1 := "100"
i1, err := strconv.Atoi(s1)
if err != nil {
	fmt.Println("can't convert to int")
} else {
	fmt.Printf("type:%T value:%#v\n", i1, i1) //type:int value:100
}
```



#### Itoa

`Itoa()`函数用于将int类型数据转换为对应的字符串表示，具体的函数签名如下。

```go
func Itoa(i int) string
```

示例代码如下：

```go
i2 := 200
s2 := strconv.Itoa(i2)
fmt.Printf("type:%T value:%#v\n", s2, s2) //type:string value:"200"
```



{%g%}

【扩展阅读】这是C语言遗留下的典故。C语言中没有string类型而是用字符数组(array)表示字符串，所以`Itoa`对很多C系的程序员很好理解。

{%endg%}



### Parse系列函数

#### ParseBool

```go
func ParseBool(str string) (value bool, err error)
```

返回字符串表示的bool值。它接受1、0、t、f、T、F、true、false、True、False、TRUE、FALSE；否则返回错误。

#### ParseInt



```go
func ParseInt(s string, base int, bitSize int) (i int64, err error)
```

返回字符串表示的整数值，接受正负号。

base指定进制（2到36），如果base为0，则会从字符串前置判断，”0x”是16进制，”0”是8进制，否则是10进制；

bitSize指定结果必须能无溢出赋值的整数类型，0、8、16、32、64 分别代表 int、int8、int16、int32、int64；

返回的err是*NumErr类型的，如果语法有误，err.Error = ErrSyntax；如果结果超出类型范围err.Error = ErrRange。

#### ParseUnit

```go
func ParseUint(s string, base int, bitSize int) (n uint64, err error)
```

`ParseUint`类似`ParseInt`但不接受正负号，用于无符号整型。



#### ParseFloat

```go
func ParseFloat(s string, bitSize int) (f float64, err error)
```

解析一个表示浮点数的字符串并返回其值。

如果s合乎语法规则，函数会返回最为接近s表示值的一个浮点数（使用IEEE754规范舍入）。

bitSize指定了期望的接收类型，32是float32（返回值可以不改变精确值的赋值给float32），64是float64；

返回值err是*NumErr类型的，语法有误的，err.Error=ErrSyntax；结果超出表示范围的，返回值f为±Inf，err.Error= ErrRange。



```go
b, err := strconv.ParseBool("true")
f, err := strconv.ParseFloat("3.1415", 64)
i, err := strconv.ParseInt("-2", 10, 64)
u, err := strconv.ParseUint("2", 10, 64)
```



### Format系列函数

> Format系列函数实现了将给定类型数据格式化为string类型数据的功能。



#### FormatBool()

```go
func FormatBool(b bool) string
```

根据b的值返回”true”或”false”。

#### FormatInt()

```go
func FormatInt(i int64, base int) string
```

返回i的base进制的字符串表示。base 必须在2到36之间，结果中会使用小写字母’a’到’z’表示大于10的数字。

#### FormatUnit()

```go
func FormatUint(i uint64, base int) string
```

是FormatInt的无符号整数版本。

#### FormatFloat()

```go
func FormatFloat(f float64, fmt byte, prec, bitSize int) string
```



```go
s1 := strconv.FormatBool(true)
s2 := strconv.FormatFloat(3.1415, 'E', -1, 64)
s3 := strconv.FormatInt(-2, 16)
s4 := strconv.FormatUint(2, 16)

```



### 其他

### isPrint()

```go
func IsPrint(r rune) bool
```

返回一个字符是否是可打印的，和`unicode.IsPrint`一样，r必须是：字母（广义）、数字、标点、符号、ASCII空格。

### CanBackquote()

```go
func CanBackquote(s string) bool
```

返回字符串s是否可以不被修改的表示为一个单行的、没有空格和tab之外控制字符的反引号字符串。



## 并发编程





### goroutine



首先我们先来了解几个与并发编程相关的基本概念。

#### 串行、并发与并行



串行：我们都是先读小学，小学毕业后再读初中，读完初中再读高中。

并发：同一时间段内执行多个任务（你在用微信和两个女朋友聊天）。

并行：同一时刻执行多个任务（你和你朋友都在用微信和女朋友聊天）。

#### 进程、线程和协程



进程（process）：程序在操作系统中的一次执行过程，系统进行资源分配和调度的一个独立单位。

线程（thread）：操作系统基于进程开启的轻量级进程，是操作系统调度执行的最小单位。

协程（coroutine）：非操作系统提供而是由用户自行创建和控制的用户态‘线程’，比线程更轻量级。

#### 并发模型



业界将如何实现并发编程总结归纳为各式各样的并发模型，常见的并发模型有以下几种：

- 线程&锁模型

- Actor模型

- CSP模型

- Fork&Join模型

  

Go语言中的并发程序主要是通过基于CSP（communicating sequential processes）的goroutine和channel来实现，当然也支持使用传统的多线程共享内存的并发方式。



Goroutine 是 Go 语言支持并发的核心，在一个Go程序中同时创建成百上千个goroutine是非常普遍的，一个goroutine会以一个很小的栈开始其生命周期，一般只需要2KB。区别于操作系统线程由系统内核进行调度， goroutine 是由Go运行时（runtime）负责调度。例如Go运行时会智能地将 m个goroutine 合理地分配给n个操作系统线程，实现类似m:n的调度机制，不再需要Go开发者自行在代码层面维护一个线程池。

Goroutine 是 Go 程序中最基本的并发执行单元。每一个 Go 程序都至少包含一个 goroutine——main goroutine，当 Go 程序启动时它会自动创建。

在Go语言编程中你不需要去自己写进程、线程、协程，你的技能包里只有一个技能——goroutine，当你需要让某个任务并发执行的时候，你只需要把这个任务包装成一个函数，开启一个 goroutine 去执行这个函数就可以了，就是这么简单粗暴。

#### go关键字



Go语言中使用 goroutine 非常简单，只需要在函数或方法调用前加上`go`关键字就可以创建一个 goroutine ，从而让该函数或方法在新创建的 goroutine 中执行。

```go
go f()  // 创建一个新的 goroutine 运行函数f
```

匿名函数也支持使用`go`关键字创建 goroutine 去执行。

```go
go func(){
  // ...
}()
```

一个 goroutine 必定对应一个函数/方法，可以创建多个 goroutine 去执行相同的函数/方法。

#### 启动单个goroutine



启动 goroutine 的方式非常简单，只需要在调用函数（普通函数和匿名函数）前加上一个`go`关键字。

我们先来看一个在 main 函数中执行普通函数调用的示例。

```go
package main

import (
	"fmt"
)

func hello() {
	fmt.Println("hello")
}

func main() {
	hello()
	fmt.Println("你好")
}
```

将上面的代码编译后执行，得到的结果如下：

```bash
hello
你好
```

代码中 hello 函数和其后面的打印语句是串行的。

![main goroutine](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/goroutine01.png)

接下来我们在调用 hello 函数前面加上关键字`go`，也就是启动一个 goroutine 去执行 hello 这个函数。

```go
func main() {
	go hello() // 启动另外一个goroutine去执行hello函数
	fmt.Println("main goroutine done!")
}
```

将上述代码重新编译后执行，得到输出结果如下。

```bash
你好
```

这一次的执行结果只在终端打印了”你好”，并没有打印 `hello`。这是为什么呢？

其实在 Go 程序启动时，Go 程序就会为 main 函数创建一个默认的 goroutine 。在上面的代码中我们在 main 函数中使用 go 关键字创建了另外一个 goroutine 去执行 hello 函数，而此时 main goroutine 还在继续往下执行，我们的程序中此时存在两个并发执行的 goroutine。当 main 函数结束时整个程序也就结束了，同时 main goroutine 也结束了，所有由 main goroutine 创建的 goroutine 也会一同退出。也就是说我们的 main 函数退出太快，另外一个 goroutine 中的函数还未执行完程序就退出了，导致未打印出“hello”。

*main goroutine 就像是《权利的游戏》中的夜王，其他的 goroutine 都是夜王转化出的异鬼，夜王一死它转化的那些异鬼也就全部GG了。*

所以我们要想办法让 main 函数‘“等一等”将在另一个 goroutine 中运行的 hello 函数。其中最简单粗暴的方式就是在 main 函数中“time.Sleep”一秒钟了（这里的1秒钟只是我们为了保证新的 goroutine 能够被正常创建和执行而设置的一个值）。

按如下方式修改我们的示例代码。

```go
package main

import (
	"fmt"
	"time"
)

func hello() {
	fmt.Println("hello")
}

func main() {
	go hello()
	fmt.Println("你好")
	time.Sleep(time.Second)
}
```

将我们的程序重新编译后再次执行，程序会在终端输出如下结果，并且会短暂停顿一会儿。

```bash
你好
hello
```

为什么会先打印`你好`呢？

这是因为在程序中创建 goroutine 执行函数需要一定的开销，而与此同时 main 函数所在的 goroutine 是继续执行的。

![main goroutine和hello goorutine](https://www.liwenzhou.com/images/Go/concurrence/goroutine02.png)

在上面的程序中使用`time.Sleep`让 main goroutine 等待 hello goroutine执行结束是不优雅的



#### async.WaitGroup





Go 语言中通过`sync`包为我们提供了一些常用的并发原语，我们会在后面的小节单独介绍`sync`包中的内容。在这一小节，我们会先介绍一下 sync 包中的`WaitGroup`。当你并不关心并发操作的结果或者有其它方式收集并发操作的结果时，`WaitGroup`是实现等待一组并发操作完成的好方法。

下面的示例代码中我们在 main goroutine 中使用`sync.WaitGroup`来等待 hello goroutine 完成后再退出。

```go
package main

import (
	"fmt"
	"sync"
)

// 声明全局等待组变量
var wg sync.WaitGroup

func hello() {
	fmt.Println("hello")
	wg.Done() // 告知当前goroutine完成
}

func main() {
	wg.Add(1) // 登记1个goroutine
	go hello()
	fmt.Println("你好")
	wg.Wait() // 阻塞等待登记的goroutine完成
}
```



将代码编译后再执行，得到的输出结果和之前一致，但是这一次程序不再会有多余的停顿，hello goroutine 执行完毕后程序直接退出。

#### 动态栈



操作系统的线程一般都有固定的栈内存（通常为2MB）,而 Go 语言中的 goroutine 非常轻量级，一个 goroutine 的初始栈空间很小（一般为2KB），所以在 Go 语言中一次创建数万个 goroutine 也是可能的。并且 goroutine 的栈不是固定的，可以根据需要动态地增大或缩小， Go 的 runtime 会自动为 goroutine 分配合适的栈空间。

#### goroutine调度



操作系统内核在调度时会挂起当前正在执行的线程并将寄存器中的内容保存到内存中，然后选出接下来要执行的线程并从内存中恢复该线程的寄存器信息，然后恢复执行该线程的现场并开始执行线程。从一个线程切换到另一个线程需要完整的上下文切换。因为可能需要多次内存访问，索引这个切换上下文的操作开销较大，会增加运行的cpu周期。

区别于操作系统内核调度操作系统线程，goroutine 的调度是Go语言运行时（runtime）层面的实现，是完全由 Go 语言本身实现的一套调度系统——go scheduler。它的作用是按照一定的规则将所有的 goroutine 调度到操作系统线程上执行。

在经历数个版本的迭代之后，目前 Go 语言的调度器采用的是 `GPM` 调度模型。

![gpm](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/gpm.png)

其中：

- G：表示 goroutine，每执行一次`go f()`就创建一个 G，包含要执行的函数和上下文信息。
- 全局队列（Global Queue）：存放等待运行的 G。
- P：表示 goroutine 执行所需的资源，最多有 GOMAXPROCS 个。
- P 的本地队列：同全局队列类似，存放的也是等待运行的G，存的数量有限，不超过256个。新建 G 时，G 优先加入到 P 的本地队列，如果本地队列满了会批量移动部分 G 到全局队列。
- M：线程想运行任务就得获取 P，从 P 的本地队列获取 G，当 P 的本地队列为空时，M 也会尝试从全局队列或其他 P 的本地队列获取 G。M 运行 G，G 执行之后，M 会从 P 获取下一个 G，不断重复下去。
- Goroutine 调度器和操作系统调度器是通过 M 结合起来的，每个 M 都代表了1个内核线程，操作系统调度器负责把内核线程分配到 CPU 的核上执行。

单从线程调度讲，Go语言相比起其他语言的优势在于OS线程是由OS内核来调度的， goroutine 则是由Go运行时（runtime）自己的调度器调度的，完全是在用户态下完成的， 不涉及内核态与用户态之间的频繁切换，包括内存的分配与释放，都是在用户态维护着一块大的内存池， 不直接调用系统的malloc函数（除非内存池需要改变），成本比调度OS线程低很多。 另一方面充分利用了多核的硬件资源，近似的把若干goroutine均分在物理线程上， 再加上本身 goroutine 的超轻量级，以上种种特性保证了 goroutine 调度方面的性能。

#### GOMAXPROCS



Go运行时的调度器使用`GOMAXPROCS`参数来确定需要使用多少个 OS 线程来同时执行 Go 代码。默认值是机器上的 CPU 核心数。例如在一个 8 核心的机器上，GOMAXPROCS 默认为 8。Go语言中可以通过`runtime.GOMAXPROCS`函数设置当前程序并发时占用的 CPU逻辑核心数。（Go1.5版本之前，默认使用的是单核心执行。Go1.5 版本之后，默认使用全部的CPU 逻辑核心数。）



### channel

单纯地将函数并发执行是没有意义的。函数与函数间需要交换数据才能体现并发执行函数的意义。

虽然可以使用共享内存进行数据交换，但是共享内存在不同的 goroutine 中容易发生竞态问题。为了保证数据交换的正确性，很多并发模型中必须使用互斥量对内存进行加锁，这种做法势必造成性能问题

Go语言采用的并发模型是`CSP（Communicating Sequential Processes）`，提倡**通过通信共享内存**而不是**通过共享内存而实现通信**。

如果说 goroutine 是Go程序并发的执行体，`channel`就是它们之间的连接。`channel`是可以让一个 goroutine 发送特定值到另一个 goroutine 的通信机制。



Go 语言中的通道（channel）是一种特殊的类型。通道像一个传送带或者队列，总是遵循先入先出（First In First Out）的规则，保证收发数据的顺序。每一个通道都是一个具体类型的导管，也就是声明channel的时候需要为其指定元素类型。

### channel类型

`channel`是 Go 语言中一种特有的类型。声明通道类型变量的格式如下：

```go
var 变量名称 chan 元素类型
```

其中：

- chan：是关键字
- 元素类型：是指通道中传递元素的类型

举几个例子：

```go
var ch1 chan int   // 声明一个传递整型的通道
var ch2 chan bool  // 声明一个传递布尔型的通道
var ch3 chan []int // 声明一个传递int切片的通道
```

### channel零值

未初始化的通道类型变量其默认零值是`nil`。

```go
var ch chan int
fmt.Println(ch) // <nil>
```

### 初始化channel

声明的通道类型变量需要使用内置的`make`函数初始化之后才能使用。具体格式如下：

```go
make(chan 元素类型, [缓冲大小])
```

其中：

- channel的缓冲大小是可选的。

举几个例子：

```go
ch4 := make(chan int)
ch5 := make(chan bool, 1)  // 声明一个缓冲区大小为1的通道
```

### channel操作

通道共有发送（send）、接收(receive）和关闭（close）三种操作。而发送和接收操作都使用`<-`符号。

现在我们先使用以下语句定义一个通道：

```go
ch := make(chan int)
```

#### 发送

将一个值发送到通道中。

```go
ch <- 10 // 把10发送到ch中
```

#### 接收

从一个通道中接收值。

```go
x := <- ch // 从ch中接收值并赋值给变量x
<-ch       // 从ch中接收值，忽略结果
```

#### 关闭

我们通过调用内置的`close`函数来关闭通道。

```go
close(ch)
```

**注意：**一个通道值是可以被垃圾回收掉的。通道通常由发送方执行关闭操作，并且只有在接收方明确等待通道关闭的信号时才需要执行关闭操作。它和关闭文件不一样，通常在结束操作之后关闭文件是必须要做的，但关闭通道不是必须的。

关闭后的通道有以下特点：

1. 对一个关闭的通道再发送值就会导致 panic。
2. 对一个关闭的通道进行接收会一直获取值直到通道为空。
3. 对一个关闭的并且没有值的通道执行接收操作会得到对应类型的零值。
4. 关闭一个已经关闭的通道会导致 panic。

### 无缓冲的通道

无缓冲的通道又称为阻塞的通道。我们来看一下如下代码片段。

```go
func main() {
	ch := make(chan int)
	ch <- 10
	fmt.Println("发送成功")
}
```

上面这段代码能够通过编译，但是执行的时候会出现以下错误：

```bash
fatal error: all goroutines are asleep - deadlock!

goroutine 1 [chan send]:
main.main()
        .../main.go:8 +0x54
```

`deadlock`表示我们程序中的 goroutine 都被挂起导致程序死锁了。为什么会出现`deadlock`错误呢？

因为我们使用`ch := make(chan int)`创建的是无缓冲的通道，无缓冲的通道只有在有接收方能够接收值的时候才能发送成功，否则会一直处于等待发送的阶段。同理，如果对一个无缓冲通道执行接收操作时，没有任何向通道中发送值的操作那么也会导致接收操作阻塞。就像田径比赛中的4x100接力赛，想要完成交棒必须有一个能够接棒的运动员，否则只能等待。简单来说就是无缓冲的通道必须有至少一个接收方才能发送成功。

上面的代码会阻塞在`ch <- 10`这一行代码形成死锁，那如何解决这个问题呢？

其中一种可行的方法是创建一个 goroutine 去接收值，例如：

```go
func recv(c chan int) {
	ret := <-c
	fmt.Println("接收成功", ret)
}

func main() {
	ch := make(chan int)
	go recv(ch) // 创建一个 goroutine 从通道接收值
	ch <- 10
	fmt.Println("发送成功")
}
```



首先无缓冲通道`ch`上的发送操作会阻塞，直到另一个 goroutine 在该通道上执行接收操作，这时数字10才能发送成功，两个 goroutine 将继续执行。相反，如果接收操作先执行，接收方所在的 goroutine 将阻塞，直到 main goroutine 中向该通道发送数字10。

使用无缓冲通道进行通信将导致发送和接收的 goroutine 同步化。因此，无缓冲通道也被称为`同步通道`。

### 有缓冲的通道

还有另外一种解决上面死锁问题的方法，那就是使用有缓冲区的通道。我们可以在使用 make 函数初始化通道时，可以为其指定通道的容量，例如：

```go
func main() {
	ch := make(chan int, 1) // 创建一个容量为1的有缓冲区通道
	ch <- 10
	fmt.Println("发送成功")
}
```

只要通道的容量大于零，那么该通道就属于有缓冲的通道，通道的容量表示通道中最大能存放的元素数量。当通道内已有元素数达到最大容量后，再向通道执行发送操作就会阻塞，除非有从通道执行接收操作。就像你小区的快递柜只有那么个多格子，格子满了就装不下了，就阻塞了，等到别人取走一个快递员就能往里面放一个。

我们可以使用内置的`len`函数获取通道内元素的数量，使用`cap`函数获取通道的容量，虽然我们很少会这么做。

### 多返回值模式

当向通道中发送完数据时，我们可以通过`close`函数来关闭通道。当一个通道被关闭后，再往该通道发送值会引发`panic`，从该通道取值的操作会先取完通道中的值。通道内的值被接收完后再对通道执行接收操作得到的值会一直都是对应元素类型的零值。那我们如何判断一个通道是否被关闭了呢？

对一个通道执行接收操作时支持使用如下多返回值模式。

```go
value, ok := <- ch
```

其中：

- value：从通道中取出的值，如果通道被关闭则返回对应类型的零值。
- ok：通道ch关闭时返回 false，否则返回 true。

下面代码片段中的`f2`函数会循环从通道`ch`中接收所有值，直到通道被关闭后退出。

```go
func f2(ch chan int) {
	for {
		v, ok := <-ch
		if !ok {
			fmt.Println("通道已关闭")
			break
		}
		fmt.Printf("v:%#v ok:%#v\n", v, ok)
	}
}

func main() {
	ch := make(chan int, 2)
	ch <- 1
	ch <- 2
	close(ch)
	f2(ch)
}
```

### for range接收值

通常我们会选择使用`for range`循环从通道中接收值，当通道被关闭后，会在通道内的所有值被接收完毕后会自动退出循环。上面那个示例我们使用`for range`改写后会很简洁。

```go
func f3(ch chan int) {
	for v := range ch {
		fmt.Println(v)
	}
}
```

**注意：**目前Go语言中并没有提供一个不对通道进行读取操作就能判断通道是否被关闭的方法。不能简单的通过`len(ch)`操作来判断通道是否被关闭。

### 单向通道

在某些场景下我们可能会将通道作为参数在多个任务函数间进行传递，通常我们会选择在不同的任务函数中对通道的使用进行限制，比如限制通道在某个函数中只能执行发送或只能执行接收操作。想象一下，我们现在有`Producer`和`Consumer`两个函数，其中`Producer`函数会返回一个通道，并且会持续将符合条件的数据发送至该通道，并在发送完成后将该通道关闭。而`Consumer`函数的任务是从通道中接收值进行计算，这两个函数之间通过`Processer`函数返回的通道进行通信。完整的示例代码如下。

```go
package main

import (
	"fmt"
)

// Producer 返回一个通道
// 并持续将符合条件的数据发送至返回的通道中
// 数据发送完成后会将返回的通道关闭
func Producer() chan int {
	ch := make(chan int, 2)
	// 创建一个新的goroutine执行发送数据的任务
	go func() {
		for i := 0; i < 10; i++ {
			if i%2 == 1 {
				ch <- i
			}
		}
		close(ch) // 任务完成后关闭通道
	}()

	return ch
}

// Consumer 从通道中接收数据进行计算
func Consumer(ch chan int) int {
	sum := 0
	for v := range ch {
		sum += v
	}
	return sum
}

func main() {
	ch := Producer()

	res := Consumer(ch)
	fmt.Println(res) // 25

}
```

从上面的示例代码中可以看出正常情况下`Consumer`函数中只会对通道进行接收操作，但是这不代表不可以在`Consumer`函数中对通道进行发送操作。作为`Producer`函数的提供者，我们在返回通道的时候可能只希望调用方拿到返回的通道后只能对其进行接收操作。但是我们没有办法阻止在`Consumer`函数中对通道进行发送操作。

Go语言中提供了**单向通道**来处理这种需要限制通道只能进行某种操作的情况。

```go
<- chan int // 只接收通道，只能接收不能发送
chan <- int // 只发送通道，只能发送不能接收
```



### select多路复用



在某些场景下我们可能需要同时从多个通道接收数据。通道在接收数据时，如果没有数据可以被接收那么当前 goroutine 将会发生阻塞。你也许会写出如下代码尝试使用遍历的方式来实现从多个通道中接收值。

```go
for{
    // 尝试从ch1接收值
    data, ok := <-ch1
    // 尝试从ch2接收值
    data, ok := <-ch2
    …
}
```

这种方式虽然可以实现从多个通道接收值的需求，但是程序的运行性能会差很多。Go 语言内置了`select`关键字，使用它可以同时响应多个通道的操作。

Select 的使用方式类似于之前学到的 switch 语句，它也有一系列 case 分支和一个默认的分支。每个 case 分支会对应一个通道的通信（接收或发送）过程。select 会一直等待，直到其中的某个 case 的通信操作完成时，就会执行该 case 分支对应的语句。具体格式如下：

```go
select {
case <-ch1:
	//...
case data := <-ch2:
	//...
case ch3 <- 10:
	//...
default:
	//默认操作
}
```

Select 语句具有以下特点。

- 可处理一个或多个 channel 的发送/接收操作。
- 如果多个 case 同时满足，select 会**随机**选择一个执行。
- 对于没有 case 的 select 会一直阻塞，可用于阻塞 main 函数，防止退出。

下面的示例代码能够在终端打印出10以内的奇数，我们借助这个代码片段来看一下 select 的具体使用。

```go
package main

import "fmt"

func main() {
	ch := make(chan int, 1)
	for i := 1; i <= 10; i++ {
		select {
		case x := <-ch:
			fmt.Println(x)
		case ch <- i:
		}
	}
}
```

上面的代码输出内容如下。

```bash
1
3
5
7
9
```

示例中的代码首先是创建了一个缓冲区大小为1的通道 ch，进入 for 循环后：

- 第一次循环时 i = 1，select 语句中包含两个 case 分支，此时由于通道中没有值可以接收，所以`x := <-ch` 这个 case 分支不满足，而`ch <- i`这个分支可以执行，会把1发送到通道中，结束本次 for 循环；
- 第二次 for 循环时，i = 2，由于通道缓冲区已满，所以`ch <- i`这个分支不满足，而`x := <-ch`这个分支可以执行，从通道接收值1并赋值给变量 x ，所以会在终端打印出 1；
- 后续的 for 循环以此类推会依次打印出3、5、7、9。

### 并发安全和锁

有时候我们的代码中可能会存在多个 goroutine 同时操作一个资源（临界区）的情况，这种情况下就会发生`竞态问题`（数据竞态）。这就好比现实生活中十字路口被各个方向的汽车竞争，还有火车上的卫生间被车厢里的人竞争。

我们用下面的代码演示一个数据竞争的示例。

```go
package main

import (
	"fmt"
	"sync"
)

var (
	x int64

	wg sync.WaitGroup // 等待组
)

// add 对全局变量x执行5000次加1操作
func add() {
	for i := 0; i < 5000; i++ {
		x = x + 1
	}
	wg.Done()
}

func main() {
	wg.Add(2)

	go add()
	go add()

	wg.Wait()
	fmt.Println(x)
}
```

我们将上面的代码编译后执行，不出意外每次执行都会输出诸如9537、5865、6527等不同的结果。这是为什么呢？

在上面的示例代码片中，我们开启了两个 goroutine 分别执行 add 函数，这两个 goroutine 在访问和修改全局的`x`变量时就会存在数据竞争，某个 goroutine 中对全局变量`x`的修改可能会覆盖掉另一个 goroutine 中的操作，所以导致最后的结果与预期不符。



#### 互斥锁

互斥锁是一种常用的控制共享资源访问的方法，它能够保证同一时间只有一个 goroutine 可以访问共享资源。Go 语言中使用`sync`包中提供的`Mutex`类型来实现互斥锁。

`sync.Mutex`提供了两个方法供我们使用。



|          方法名          |    功能    |
| :----------------------: | :--------: |
|  func (m *Mutex) Lock()  | 获取互斥锁 |
| func (m *Mutex) Unlock() | 释放互斥锁 |

我们在下面的示例代码中使用互斥锁限制每次只有一个 goroutine 才能修改全局变量`x`，从而修复上面代码中的问题。

```go
package main

import (
	"fmt"
	"sync"
)

var x int64
var wg sync.WaitGroup
var m sync.Mutex

func add() {
	for i := 0; i < 5000; i++ {
		m.Lock()
		x = x + 1
		m.Unlock()
	}
	wg.Done()
}
func main() {
	wg.Add(2)

	go add()
	go add()
	wg.Wait()
	fmt.Println(x)

}

```



将上面的代码编译后多次执行，每一次都会得到预期中的结果——10000。

使用互斥锁能够保证同一时间有且只有一个 goroutine 进入临界区，其他的 goroutine 则在等待锁；当互斥锁释放后，等待的 goroutine 才可以获取锁进入临界区，多个 goroutine 同时等待一个锁时，唤醒的策略是随机的。

#### 读写互斥锁



互斥锁是完全互斥的，但是实际上有很多场景是读多写少的，当我们并发的去读取一个资源而不涉及资源修改的时候是没有必要加互斥锁的，这种场景下使用读写锁是更好的一种选择。读写锁在 Go 语言中使用`sync`包中的`RWMutex`类型。

`sync.RWMutex`提供了以下5个方法。

|               方法名                |              功能              |
| :---------------------------------: | :----------------------------: |
|      func (rw *RWMutex) Lock()      |            获取写锁            |
|     func (rw *RWMutex) Unlock()     |            释放写锁            |
|     func (rw *RWMutex) RLock()      |            获取读锁            |
|    func (rw *RWMutex) RUnlock()     |            释放读锁            |
| func (rw *RWMutex) RLocker() Locker | 返回一个实现Locker接口的读写锁 |

读写锁分为两种：读锁和写锁。当一个 goroutine 获取到读锁之后，其他的 goroutine 如果是获取读锁会继续获得锁，如果是获取写锁就会等待；而当一个 goroutine 获取写锁之后，其他的 goroutine 无论是获取读锁还是写锁都会等待。

下面我们使用代码构造一个读多写少的场景，然后分别使用互斥锁和读写锁查看它们的性能差异。

```go
var (
	x       int64
	wg      sync.WaitGroup
	mutex   sync.Mutex
	rwMutex sync.RWMutex
)

// writeWithLock 使用互斥锁的写操作
func writeWithLock() {
	mutex.Lock() // 加互斥锁
	x = x + 1
	time.Sleep(10 * time.Millisecond) // 假设读操作耗时10毫秒
	mutex.Unlock()                    // 解互斥锁
	wg.Done()
}

// readWithLock 使用互斥锁的读操作
func readWithLock() {
	mutex.Lock()                 // 加互斥锁
	time.Sleep(time.Millisecond) // 假设读操作耗时1毫秒
	mutex.Unlock()               // 释放互斥锁
	wg.Done()
}

// writeWithLock 使用读写互斥锁的写操作
func writeWithRWLock() {
	rwMutex.Lock() // 加写锁
	x = x + 1
	time.Sleep(10 * time.Millisecond) // 假设读操作耗时10毫秒
	rwMutex.Unlock()                  // 释放写锁
	wg.Done()
}

// readWithRWLock 使用读写互斥锁的读操作
func readWithRWLock() {
	rwMutex.RLock()              // 加读锁
	time.Sleep(time.Millisecond) // 假设读操作耗时1毫秒
	rwMutex.RUnlock()            // 释放读锁
	wg.Done()
}

func do(wf, rf func(), wc, rc int) {
	start := time.Now()
	// wc个并发写操作
	for i := 0; i < wc; i++ {
		wg.Add(1)
		go wf()
	}

	//  rc个并发读操作
	for i := 0; i < rc; i++ {
		wg.Add(1)
		go rf()
	}

	wg.Wait()
	cost := time.Since(start)
	fmt.Printf("x:%v cost:%v\n", x, cost)

}
```

我们假设每一次读操作都会耗时1ms，而每一次写操作会耗时10ms，我们分别测试使用互斥锁和读写互斥锁执行10次并发写和1000次并发读的耗时数据。

```go
// 使用互斥锁，10并发写，1000并发读
do(writeWithLock, readWithLock, 10, 1000) // x:10 cost:1.466500951s

// 使用读写互斥锁，10并发写，1000并发读
do(writeWithRWLock, readWithRWLock, 10, 1000) // x:10 cost:117.207592ms
```

从最终的执行结果可以看出，使用读写互斥锁在读多写少的场景下能够极大地提高程序的性能。不过需要注意的是如果一个程序中的读操作和写操作数量级差别不大，那么读写互斥锁的优势就发挥不出来。

#### sync.WaitGroup



在代码中生硬的使用`time.Sleep`肯定是不合适的，Go语言中可以使用`sync.WaitGroup`来实现并发任务的同步。 `sync.WaitGroup`有以下几个方法：

|                方法名                |        功能         |
| :----------------------------------: | :-----------------: |
| func (wg * WaitGroup) Add(delta int) |    计数器+delta     |
|        (wg *WaitGroup) Done()        |      计数器-1       |
|        (wg *WaitGroup) Wait()        | 阻塞直到计数器变为0 |

`sync.WaitGroup`内部维护着一个计数器，计数器的值可以增加和减少。例如当我们启动了 N 个并发任务时，就将计数器值增加N。每个任务完成时通过调用 Done 方法将计数器减1。通过调用 Wait 来等待并发任务执行完，当计数器值为 0 时，表示所有并发任务已经完成。

我们利用`sync.WaitGroup`将上面的代码优化一下：

```go
var wg sync.WaitGroup

func hello() {
	defer wg.Done()
	fmt.Println("Hello Goroutine!")
}
func main() {
	wg.Add(1)
	go hello() // 启动另外一个goroutine去执行hello函数
	fmt.Println("main goroutine done!")
	wg.Wait()
}
```

需要注意`sync.WaitGroup`是一个结构体，进行参数传递的时候要传递指针。

#### sync.Once



在某些场景下我们需要确保某些操作即使在高并发的场景下也只会被执行一次，例如只加载一次配置文件等。

Go语言中的`sync`包中提供了一个针对只执行一次场景的解决方案——`sync.Once`，`sync.Once`只有一个`Do`方法，其签名如下：

```go
func (o *Once) Do(f func())
```

**注意：**如果要执行的函数`f`需要传递参数就需要搭配闭包来使用。

#### 加载配置文件示例

延迟一个开销很大的初始化操作到真正用到它的时候再执行是一个很好的实践。因为预先初始化一个变量（比如在init函数中完成初始化）会增加程序的启动耗时，而且有可能实际执行过程中这个变量没有用上，那么这个初始化操作就不是必须要做的。我们来看一个例子：

```go
var icons map[string]image.Image

func loadIcons() {
	icons = map[string]image.Image{
		"left":  loadIcon("left.png"),
		"up":    loadIcon("up.png"),
		"right": loadIcon("right.png"),
		"down":  loadIcon("down.png"),
	}
}

// Icon 被多个goroutine调用时不是并发安全的
func Icon(name string) image.Image {
	if icons == nil {
		loadIcons()
	}
	return icons[name]
}
```

多个 goroutine 并发调用Icon函数时不是并发安全的，现代的编译器和CPU可能会在保证每个 goroutine 都满足串行一致的基础上自由地重排访问内存的顺序。loadIcons函数可能会被重排为以下结果：

```go
func loadIcons() {
	icons = make(map[string]image.Image)
	icons["left"] = loadIcon("left.png")
	icons["up"] = loadIcon("up.png")
	icons["right"] = loadIcon("right.png")
	icons["down"] = loadIcon("down.png")
}
```

在这种情况下就会出现即使判断了`icons`不是nil也不意味着变量初始化完成了。考虑到这种情况，我们能想到的办法就是添加互斥锁，保证初始化`icons`的时候不会被其他的 goroutine 操作，但是这样做又会引发性能问题。

使用`sync.Once`改造的示例代码如下：

```go
var icons map[string]image.Image

var loadIconsOnce sync.Once

func loadIcons() {
	icons = map[string]image.Image{
		"left":  loadIcon("left.png"),
		"up":    loadIcon("up.png"),
		"right": loadIcon("right.png"),
		"down":  loadIcon("down.png"),
	}
}

// Icon 是并发安全的
func Icon(name string) image.Image {
	loadIconsOnce.Do(loadIcons)
	return icons[name]
}
```

#### 并发安全的单例模式

下面是借助`sync.Once`实现的并发安全的单例模式：

```go
package singleton

import (
    "sync"
)

type singleton struct {}

var instance *singleton
var once sync.Once

func GetInstance() *singleton {
    once.Do(func() {
        instance = &singleton{}
    })
    return instance
}
```

`sync.Once`其实内部包含一个互斥锁和一个布尔值，互斥锁保证布尔值和数据的安全，而布尔值用来记录初始化是否完成。这样设计就能保证初始化操作的时候是并发安全的并且初始化操作也不会被执行多次。

#### sync.Map



Go 语言中内置的 map 不是并发安全的，请看下面这段示例代码。

```go
package main

import (
	"fmt"
	"strconv"
	"sync"
)

var m = make(map[string]int)

func get(key string) int {
	return m[key]
}

func set(key string, value int) {
	m[key] = value
}

func main() {
	wg := sync.WaitGroup{}
	for i := 0; i < 10; i++ {
		wg.Add(1)
		go func(n int) {
			key := strconv.Itoa(n)
			set(key, n)
			fmt.Printf("k=:%v,v:=%v\n", key, get(key))
			wg.Done()
		}(i)
	}
	wg.Wait()
}
```

将上面的代码编译后执行，会报出`fatal error: concurrent map writes`错误。我们不能在多个 goroutine 中并发对内置的 map 进行读写操作，否则会存在数据竞争问题。

像这种场景下就需要为 map 加锁来保证并发的安全性了，Go语言的`sync`包中提供了一个开箱即用的并发安全版 map——`sync.Map`。开箱即用表示其不用像内置的 map 一样使用 make 函数初始化就能直接使用。同时`sync.Map`内置了诸如`Store`、`Load`、`LoadOrStore`、`Delete`、`Range`等操作方法。

|                            方法名                            |              功能               |
| :----------------------------------------------------------: | :-----------------------------: |
|         func (m *Map) Store(key, value interface{})          |        存储key-value数据        |
| func (m *Map) Load(key interface{}) (value interface{}, ok bool) |       查询key对应的value        |
| func (m *Map) LoadOrStore(key, value interface{}) (actual interface{}, loaded bool) |    查询或存储key对应的value     |
| func (m *Map) LoadAndDelete(key interface{}) (value interface{}, loaded bool) |          查询并删除key          |
|            func (m *Map) Delete(key interface{})             |             删除key             |
|   func (m *Map) Range(f func(key, value interface{}) bool)   | 对map中的每个key-value依次调用f |

下面的代码示例演示了并发读写`sync.Map`。

```go
package main

import (
	"fmt"
	"strconv"
	"sync"
)

// 并发安全的map
var m = sync.Map{}

func main() {
	wg := sync.WaitGroup{}
	// 对m执行20个并发的读写操作
	for i := 0; i < 20; i++ {
		wg.Add(1)
		go func(n int) {
			key := strconv.Itoa(n)
			m.Store(key, n)         // 存储key-value
			value, _ := m.Load(key) // 根据key取值
			fmt.Printf("k=:%v,v:=%v\n", key, value)
			wg.Done()
		}(i)
	}
	wg.Wait()
}
```

#### 原子操作



针对整数数据类型（int32、uint32、int64、uint64）我们还可以使用原子操作来保证并发安全，通常直接使用原子操作比使用锁操作效率更高。Go语言中原子操作由内置的标准库`sync/atomic`提供。

#### atomic包



|                             方法                             |      解释      |
| :----------------------------------------------------------: | :------------: |
| func LoadInt32(addr *int32) (val int32) func LoadInt64(addr *int64) (val int64) func LoadUint32(addr *uint32) (val uint32) func LoadUint64(addr *uint64) (val uint64) func LoadUintptr(addr *uintptr) (val uintptr) func LoadPointer(addr *unsafe.Pointer) (val unsafe.Pointer) |    读取操作    |
| func StoreInt32(addr *int32, val int32) func StoreInt64(addr *int64, val int64) func StoreUint32(addr *uint32, val uint32) func StoreUint64(addr *uint64, val uint64) func StoreUintptr(addr *uintptr, val uintptr) func StorePointer(addr *unsafe.Pointer, val unsafe.Pointer) |    写入操作    |
| func AddInt32(addr *int32, delta int32) (new int32) func AddInt64(addr *int64, delta int64) (new int64) func AddUint32(addr *uint32, delta uint32) (new uint32) func AddUint64(addr *uint64, delta uint64) (new uint64) func AddUintptr(addr *uintptr, delta uintptr) (new uintptr) |    修改操作    |
| func SwapInt32(addr *int32, new int32) (old int32) func SwapInt64(addr *int64, new int64) (old int64) func SwapUint32(addr *uint32, new uint32) (old uint32) func SwapUint64(addr *uint64, new uint64) (old uint64) func SwapUintptr(addr *uintptr, new uintptr) (old uintptr) func SwapPointer(addr *unsafe.Pointer, new unsafe.Pointer) (old unsafe.Pointer) |    交换操作    |
| func CompareAndSwapInt32(addr *int32, old, new int32) (swapped bool) func CompareAndSwapInt64(addr *int64, old, new int64) (swapped bool) func CompareAndSwapUint32(addr *uint32, old, new uint32) (swapped bool) func CompareAndSwapUint64(addr *uint64, old, new uint64) (swapped bool) func CompareAndSwapUintptr(addr *uintptr, old, new uintptr) (swapped bool) func CompareAndSwapPointer(addr *unsafe.Pointer, old, new unsafe.Pointer) (swapped bool) | 比较并交换操作 |

#### 示例



我们填写一个示例来比较下互斥锁和原子操作的性能。

```go
package main

import (
	"fmt"
	"sync"
	"sync/atomic"
	"time"
)

type Counter interface {
	Inc()
	Load() int64
}

// 普通版
type CommonCounter struct {
	counter int64
}

func (c CommonCounter) Inc() {
	c.counter++
}

func (c CommonCounter) Load() int64 {
	return c.counter
}

// 互斥锁版
type MutexCounter struct {
	counter int64
	lock    sync.Mutex
}

func (m *MutexCounter) Inc() {
	m.lock.Lock()
	defer m.lock.Unlock()
	m.counter++
}

func (m *MutexCounter) Load() int64 {
	m.lock.Lock()
	defer m.lock.Unlock()
	return m.counter
}

// 原子操作版
type AtomicCounter struct {
	counter int64
}

func (a *AtomicCounter) Inc() {
	atomic.AddInt64(&a.counter, 1)
}

func (a *AtomicCounter) Load() int64 {
	return atomic.LoadInt64(&a.counter)
}

func test(c Counter) {
	var wg sync.WaitGroup
	start := time.Now()
	for i := 0; i < 1000; i++ {
		wg.Add(1)
		go func() {
			c.Inc()
			wg.Done()
		}()
	}
	wg.Wait()
	end := time.Now()
	fmt.Println(c.Load(), end.Sub(start))
}

func main() {
	c1 := CommonCounter{} // 非并发安全
	test(c1)
	c2 := MutexCounter{} // 使用互斥锁实现并发安全
	test(&c2)
	c3 := AtomicCounter{} // 并发安全且比互斥锁效率更高
	test(&c3)
}
```

`atomic`包提供了底层的原子级内存操作，对于同步算法的实现很有用。这些函数必须谨慎地保证正确使用。除了某些特殊的底层应用，使用通道或者 sync 包的函数/类型实现同步更好。



## 网络编程

### 分层模型



![osi七层模型](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/osi.png)



如下图所示，发送方的HTTP数据经过互联网的传输过程中会依次添加各层协议的标头信息，接收方收到数据包之后再依次根据协议解包得到数据。

![HTTP数据传输图解](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/httptcpip.png)



### socket编程

Socket是BSD UNIX的进程通信机制，通常也称作”套接字”，用于描述IP地址和端口，是一个通信链的句柄。Socket可以理解为TCP/IP网络的API，它定义了许多函数或例程，程序员可以用它们来开发TCP/IP网络上的应用程序。电脑上运行的应用程序通常通过”套接字”向网络发出请求或者应答网络请求。

### socket图解



`Socket`是应用层与TCP/IP协议族通信的中间软件抽象层。在设计模式中，`Socket`其实就是一个门面模式，它把复杂的TCP/IP协议族隐藏在`Socket`后面，对用户来说只需要调用Socket规定的相关函数，让`Socket`去组织符合指定的协议数据然后进行通信。

![socket图解](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/socket.png)



### TCP协议

TCP/IP(Transmission Control Protocol/Internet Protocol) 即传输控制协议/网间协议，是一种面向连接（连接导向）的、可靠的、基于字节流的传输层（Transport layer）通信协议，因为是面向连接的协议，数据像水流一样传输，会存在黏包问题。

### TCP服务端

一个TCP服务端可以同时连接很多个客户端，例如世界各地的用户使用自己电脑上的浏览器访问淘宝网。因为Go语言中创建多个goroutine实现并发非常方便和高效，所以我们可以每建立一次链接就创建一个goroutine去处理。

TCP服务端程序的处理流程：

1. 监听端口
2. 接收客户端请求建立链接
3. 创建goroutine处理链接。

我们使用Go语言的net包实现的TCP服务端代码如下：

```go
// tcp/server/main.go

// TCP server端

// 处理函数
func process(conn net.Conn) {
	defer conn.Close() // 关闭连接
	for {
		reader := bufio.NewReader(conn)
		var buf [128]byte
		n, err := reader.Read(buf[:]) // 读取数据
		if err != nil {
			fmt.Println("read from client failed, err:", err)
			break
		}
		recvStr := string(buf[:n])
		fmt.Println("收到client端发来的数据：", recvStr)
		conn.Write([]byte(recvStr)) // 发送数据
	}
}

func main() {
	listen, err := net.Listen("tcp", "127.0.0.1:20000")
	if err != nil {
		fmt.Println("listen failed, err:", err)
		return
	}
	for {
		conn, err := listen.Accept() // 建立连接
		if err != nil {
			fmt.Println("accept failed, err:", err)
			continue
		}
		go process(conn) // 启动一个goroutine处理连接
	}
}
```

将上面的代码保存之后编译成`server`或`server.exe`可执行文件。

### TCP客户端

一个TCP客户端进行TCP通信的流程如下：

1. 建立与服务端的链接
2. 进行数据收发
3. 关闭链接

使用Go语言的net包实现的TCP客户端代码如下：

```go
// tcp/client/main.go

// 客户端
func main() {
	conn, err := net.Dial("tcp", "127.0.0.1:20000")
	if err != nil {
		fmt.Println("err :", err)
		return
	}
	defer conn.Close() // 关闭连接
	inputReader := bufio.NewReader(os.Stdin)
	for {
		input, _ := inputReader.ReadString('\n') // 读取用户输入
		inputInfo := strings.Trim(input, "\r\n")
		if strings.ToUpper(inputInfo) == "Q" { // 如果输入q就退出
			return
		}
		_, err = conn.Write([]byte(inputInfo)) // 发送数据
		if err != nil {
			return
		}
		buf := [512]byte{}
		n, err := conn.Read(buf[:])
		if err != nil {
			fmt.Println("recv failed, err:", err)
			return
		}
		fmt.Println(string(buf[:n]))
	}
}
```

将上面的代码编译成`client`或`client.exe`可执行文件，先启动server端再启动client端，在client端输入任意内容回车之后就能够在server端看到client端发送的数据，从而实现TCP通信。

### TCP黏包



#### 黏包示例





服务端代码如下：

```go
// socket_stick/server/main.go

func process(conn net.Conn) {
	defer conn.Close()
	reader := bufio.NewReader(conn)
	var buf [1024]byte
	for {
		n, err := reader.Read(buf[:])
		if err == io.EOF {
			break
		}
		if err != nil {
			fmt.Println("read from client failed, err:", err)
			break
		}
		recvStr := string(buf[:n])
		fmt.Println("收到client发来的数据：", recvStr)
	}
}

func main() {

	listen, err := net.Listen("tcp", "127.0.0.1:30000")
	if err != nil {
		fmt.Println("listen failed, err:", err)
		return
	}
	defer listen.Close()
	for {
		conn, err := listen.Accept()
		if err != nil {
			fmt.Println("accept failed, err:", err)
			continue
		}
		go process(conn)
	}
}
```

客户端代码如下：

```go
// socket_stick/client/main.go

func main() {
	conn, err := net.Dial("tcp", "127.0.0.1:30000")
	if err != nil {
		fmt.Println("dial failed, err", err)
		return
	}
	defer conn.Close()
	for i := 0; i < 20; i++ {
		msg := `Hello, Hello. How are you?`
		conn.Write([]byte(msg))
	}
}
```

将上面的代码保存后，分别编译。先启动服务端再启动客户端，可以看到服务端输出结果如下：

```bash
收到client发来的数据： Hello, Hello. How are you?Hello, Hello. How are you?Hello, Hello. How are you?Hello, Hello. How are you?Hello, Hello. How are you?
收到client发来的数据： Hello, Hello. How are you?Hello, Hello. How are you?Hello, Hello. How are you?Hello, Hello. How are you?Hello, Hello. How are you?Hello, Hello. How are you?Hello, Hello. How are you?Hello, Hello. How are you?
收到client发来的数据： Hello, Hello. How are you?Hello, Hello. How are you?
收到client发来的数据： Hello, Hello. How are you?Hello, Hello. How are you?Hello, Hello. How are you?
收到client发来的数据： Hello, Hello. How are you?Hello, Hello. How are you?
```

客户端分10次发送的数据，在服务端并没有成功的输出10次，而是多条数据“粘”到了一起。

#### 为什么会出现粘包



主要原因就是tcp数据传递模式是流模式，在保持长连接的时候可以进行多次的收和发。

“粘包”可发生在发送端也可发生在接收端：

1. 由Nagle算法造成的发送端的粘包：Nagle算法是一种改善网络传输效率的算法。简单来说就是当我们提交一段数据给TCP发送时，TCP并不立刻发送此段数据，而是等待一小段时间看看在等待期间是否还有要发送的数据，若有则会一次把这两段数据发送出去。
2. 接收端接收不及时造成的接收端粘包：TCP会把接收到的数据存在自己的缓冲区中，然后通知应用层取数据。当应用层由于某些原因不能及时的把TCP的数据取出来，就会造成TCP缓冲区中存放了几段数据。

#### 解决办法



出现”粘包”的关键在于接收方不确定将要传输的数据包的大小，因此我们可以对数据包进行封包和拆包的操作。

封包：封包就是给一段数据加上包头，这样一来数据包就分为包头和包体两部分内容了(过滤非法包时封包会加入”包尾”内容)。包头部分的长度是固定的，并且它存储了包体的长度，根据包头长度固定以及包头中含有包体长度的变量就能正确的拆分出一个完整的数据包。

我们可以自己定义一个协议，比如数据包的前4个字节为包头，里面存储的是发送的数据的长度。

```go
// socket_stick/proto/proto.go
package proto

import (
	"bufio"
	"bytes"
	"encoding/binary"
)

// Encode 将消息编码
func Encode(message string) ([]byte, error) {
	// 读取消息的长度，转换成int32类型（占4个字节）
	var length = int32(len(message))
	var pkg = new(bytes.Buffer)
	// 写入消息头
	err := binary.Write(pkg, binary.LittleEndian, length)
	if err != nil {
		return nil, err
	}
	// 写入消息实体
	err = binary.Write(pkg, binary.LittleEndian, []byte(message))
	if err != nil {
		return nil, err
	}
	return pkg.Bytes(), nil
}

// Decode 解码消息
func Decode(reader *bufio.Reader) (string, error) {
	// 读取消息的长度
	lengthByte, _ := reader.Peek(4) // 读取前4个字节的数据
	lengthBuff := bytes.NewBuffer(lengthByte)
	var length int32
	err := binary.Read(lengthBuff, binary.LittleEndian, &length)
	if err != nil {
		return "", err
	}
	// Buffered返回缓冲中现有的可读取的字节数。
	if int32(reader.Buffered()) < length+4 {
		return "", err
	}

	// 读取真正的消息数据
	pack := make([]byte, int(4+length))
	_, err = reader.Read(pack)
	if err != nil {
		return "", err
	}
	return string(pack[4:]), nil
}
```

接下来在服务端和客户端分别使用上面定义的`proto`包的`Decode`和`Encode`函数处理数据。

服务端代码如下：

```go
// socket_stick/server2/main.go

func process(conn net.Conn) {
	defer conn.Close()
	reader := bufio.NewReader(conn)
	for {
		msg, err := proto.Decode(reader)
		if err == io.EOF {
			return
		}
		if err != nil {
			fmt.Println("decode msg failed, err:", err)
			return
		}
		fmt.Println("收到client发来的数据：", msg)
	}
}

func main() {

	listen, err := net.Listen("tcp", "127.0.0.1:30000")
	if err != nil {
		fmt.Println("listen failed, err:", err)
		return
	}
	defer listen.Close()
	for {
		conn, err := listen.Accept()
		if err != nil {
			fmt.Println("accept failed, err:", err)
			continue
		}
		go process(conn)
	}
}
```

客户端代码如下：

```go
// socket_stick/client2/main.go

func main() {
	conn, err := net.Dial("tcp", "127.0.0.1:30000")
	if err != nil {
		fmt.Println("dial failed, err", err)
		return
	}
	defer conn.Close()
	for i := 0; i < 20; i++ {
		msg := `Hello, Hello. How are you?`
		data, err := proto.Encode(msg)
		if err != nil {
			fmt.Println("encode msg failed, err:", err)
			return
		}
		conn.Write(data)
	}
}
```





### UDP协议

UDP协议（User Datagram Protocol）中文名称是用户数据报协议，是OSI（Open System Interconnection，开放式系统互联）参考模型中一种**无连接**的传输层协议，不需要建立连接就能直接进行数据发送和接收，属于不可靠的、没有时序的通信，但是UDP协议的实时性比较好，通常用于视频直播相关领域。

### UDP服务端

使用Go语言的`net`包实现的UDP服务端代码如下：

```go
// UDP/server/main.go

// UDP server端
func main() {
	listen, err := net.ListenUDP("udp", &net.UDPAddr{
		IP:   net.IPv4(0, 0, 0, 0),
		Port: 30000,
	})
	if err != nil {
		fmt.Println("listen failed, err:", err)
		return
	}
	defer listen.Close()
	for {
		var data [1024]byte
		n, addr, err := listen.ReadFromUDP(data[:]) // 接收数据
		if err != nil {
			fmt.Println("read udp failed, err:", err)
			continue
		}
		fmt.Printf("data:%v addr:%v count:%v\n", string(data[:n]), addr, n)
		_, err = listen.WriteToUDP(data[:n], addr) // 发送数据
		if err != nil {
			fmt.Println("write to udp failed, err:", err)
			continue
		}
	}
}
```

### UDP客户端

使用Go语言的`net`包实现的UDP客户端代码如下：

```go
// UDP 客户端
func main() {
	socket, err := net.DialUDP("udp", nil, &net.UDPAddr{
		IP:   net.IPv4(0, 0, 0, 0),
		Port: 30000,
	})
	if err != nil {
		fmt.Println("连接服务端失败，err:", err)
		return
	}
	defer socket.Close()
	sendData := []byte("Hello server")
	_, err = socket.Write(sendData) // 发送数据
	if err != nil {
		fmt.Println("发送数据失败，err:", err)
		return
	}
	data := make([]byte, 4096)
	n, remoteAddr, err := socket.ReadFromUDP(data) // 接收数据
	if err != nil {
		fmt.Println("接收数据失败，err:", err)
		return
	}
	fmt.Printf("recv:%v addr:%v count:%v\n", string(data[:n]), remoteAddr, n)
}
```







Go语言内置的`net/http`包提供了HTTP客户端和服务端的实现。

### HTTP协议

超文本传输协议（HTTP，HyperText Transfer Protocol)是互联网上应用最为广泛的一种网络传输协议，所有的WWW文件都必须遵守这个标准。设计HTTP最初的目的是为了提供一种发布和接收HTML页面的方法。



#### HTTP客户端



#### 基本的HTTP/HTTPS请求



Get、Head、Post和PostForm函数发出HTTP/HTTPS请求。

```go
resp, err := http.Get("http://example.com/")
...
resp, err := http.Post("http://example.com/upload", "image/jpeg", &buf)
...
resp, err := http.PostForm("http://example.com/form",
	url.Values{"key": {"Value"}, "id": {"123"}})
```

程序在使用完response后必须关闭回复的主体。

```go
resp, err := http.Get("http://example.com/")
if err != nil {
	// handle error
}
defer resp.Body.Close()
body, err := ioutil.ReadAll(resp.Body)
// ...
```



#### GET请求示例



使用`net/http`包编写一个简单的发送HTTP请求的Client端，代码如下：

```go
package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
)

func main() {
	resp, err := http.Get("https://www.liwenzhou.com/")
	if err != nil {
		fmt.Printf("get failed, err:%v\n", err)
		return
	}
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Printf("read from resp.Body failed, err:%v\n", err)
		return
	}
	fmt.Print(string(body))
}
```

将上面的代码保存之后编译成可执行文件，执行之后就能在终端打印`liwenzhou.com`网站首页的内容了，我们的浏览器其实就是一个发送和接收HTTP协议数据的客户端，我们平时通过浏览器访问网页其实就是从网站的服务器接收HTTP数据，然后浏览器会按照HTML、CSS等规则将网页渲染展示出来。



#### 带参数的GET请求示例



关于GET请求的参数需要使用Go语言内置的`net/url`这个标准库来处理。

```go
func main() {
	apiUrl := "http://127.0.0.1:9090/get"
	// URL param
	data := url.Values{}
	data.Set("name", "小王子")
	data.Set("age", "18")
	u, err := url.ParseRequestURI(apiUrl)
	if err != nil {
		fmt.Printf("parse url requestUrl failed, err:%v\n", err)
	}
	u.RawQuery = data.Encode() // URL encode
	fmt.Println(u.String())
	resp, err := http.Get(u.String())
	if err != nil {
		fmt.Printf("post failed, err:%v\n", err)
		return
	}
	defer resp.Body.Close()
	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Printf("get resp failed, err:%v\n", err)
		return
	}
	fmt.Println(string(b))
}
```

对应的Server端HandlerFunc如下：

```go
func getHandler(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	data := r.URL.Query()
	fmt.Println(data.Get("name"))
	fmt.Println(data.Get("age"))
	answer := `{"status": "ok"}`
	w.Write([]byte(answer))
}
```



#### Post请求示例



上面演示了使用`net/http`包发送`GET`请求的示例，发送`POST`请求的示例代码如下：

```go
package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"
)

// net/http post demo

func main() {
	url := "http://127.0.0.1:9090/post"
	// 表单数据
	//contentType := "application/x-www-form-urlencoded"
	//data := "name=小王子&age=18"
	// json
	contentType := "application/json"
	data := `{"name":"小王子","age":18}`
	resp, err := http.Post(url, contentType, strings.NewReader(data))
	if err != nil {
		fmt.Printf("post failed, err:%v\n", err)
		return
	}
	defer resp.Body.Close()
	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Printf("get resp failed, err:%v\n", err)
		return
	}
	fmt.Println(string(b))
}
```

对应的Server端HandlerFunc如下：

```go
func postHandler(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	// 1. 请求类型是application/x-www-form-urlencoded时解析form数据
	r.ParseForm()
	fmt.Println(r.PostForm) // 打印form数据
	fmt.Println(r.PostForm.Get("name"), r.PostForm.Get("age"))
	// 2. 请求类型是application/json时从r.Body读取数据
	b, err := ioutil.ReadAll(r.Body)
	if err != nil {
		fmt.Printf("read request.Body failed, err:%v\n", err)
		return
	}
	fmt.Println(string(b))
	answer := `{"status": "ok"}`
	w.Write([]byte(answer))
}
```





#### 自定义Client



要管理HTTP客户端的头域、重定向策略和其他设置，创建一个Client：

```go
client := &http.Client{
	CheckRedirect: redirectPolicyFunc,
}
resp, err := client.Get("http://example.com")
// ...
req, err := http.NewRequest("GET", "http://example.com", nil)
// ...
req.Header.Add("If-None-Match", `W/"wyzzy"`)
resp, err := client.Do(req)
// ...
```



#### 自定义Transport



要管理代理、TLS配置、keep-alive、压缩和其他设置，创建一个Transport：

```go
tr := &http.Transport{
	TLSClientConfig:    &tls.Config{RootCAs: pool},
	DisableCompression: true,
}
client := &http.Client{Transport: tr}
resp, err := client.Get("https://example.com")
```

Client和Transport类型都可以安全的被多个goroutine同时使用。出于效率考虑，应该一次建立、尽量重用。





#### 服务端



#### 默认的Server



ListenAndServe使用指定的监听地址和处理器启动一个HTTP服务端。处理器参数通常是nil，这表示采用包变量DefaultServeMux作为处理器。

Handle和HandleFunc函数可以向DefaultServeMux添加处理器。

```go
http.Handle("/foo", fooHandler)
http.HandleFunc("/bar", func(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, %q", html.EscapeString(r.URL.Path))
})
log.Fatal(http.ListenAndServe(":8080", nil))
```





#### 默认的Server示例



使用Go语言中的`net/http`包来编写一个简单的接收HTTP请求的Server端示例，`net/http`包是对net包的进一步封装，专门用来处理HTTP协议的数据。具体的代码如下：

```go
// http server

func sayHello(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "Hello 沙河！")
}

func main() {
	http.HandleFunc("/", sayHello)
	err := http.ListenAndServe(":9090", nil)
	if err != nil {
		fmt.Printf("http server failed, err:%v\n", err)
		return
	}
}
```

将上面的代码编译之后执行，打开你电脑上的浏览器在地址栏输入`127.0.0.1:9090`回车，此时就能够看到如下页面了。![hello页面](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/hello.png)



#### 自定义Server



要管理服务端的行为，可以创建一个自定义的Server：

```go
s := &http.Server{
	Addr:           ":8080",
	Handler:        myHandler,
	ReadTimeout:    10 * time.Second,
	WriteTimeout:   10 * time.Second,
	MaxHeaderBytes: 1 << 20,
}
log.Fatal(s.ListenAndServe())
```
