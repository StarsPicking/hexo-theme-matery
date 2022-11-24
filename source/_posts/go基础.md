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

# 基本语法

## 变量的定义方式

### var 声明单个变量



```go
var name string
var age int
var isOk bool

```

### var 批量声明变量



```go
var {
	name strig
	age int
	isOk bool	
}
```

### 列表推导式声明变量



```go
var name = "张三"
var age = 18
var isOk = bool
```

### 函数内使用简短变量



```go
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



## 常量

### 常量的定义

- 常量： 定义了之后不能修改， 在程序运行期间不会改变的值

  

### 声明常量



```go
const(
	statusok = 200
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

## 字符串类型

- Go 语言里的字符串的内部实现使用 UTF-8 编码。


### 字符串的表示

- 字符串的值为双引号(")中的内容，可以在 Go 语言的源码中直接添加非 ASCII 码字符

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



