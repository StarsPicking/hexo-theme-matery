---
title: groovy数据类型-正则表达式
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: groovy
tags:
  - groovy
abbrlink: 2149
date: 2022-10-28 23:54:23
img:
coverImg:
summary: 其实这部分不足以写一篇文章，不过由于Groovy这方面工作做的很好，让我们使用Groovy处理正则表达式非常简单，所以我还是说说吧。
---

# groovy 正则表达式

*  添加解析器 @NonCPS

## 正则表达式字符串





首先说说斜杠字符串，主要用于正则表达式。在斜杠字符串中不需要转义反斜杠，只有正斜杠需要转义。这让我们编写正则表达式非常方便，不像Java那样需要双斜杠（`\\w+\\s`这样的）。

```groovy
def fooPattern = /.*foo.*/
assert fooPattern == '.*foo.*'
```

还有美元斜杠字符串，其中的所有字符都不会被转义。另外斜杠字符串和美元斜杠字符串都可以跨过多行。它主要也是用于编写更复杂的正则表达式。

```groovy
def dollarSlashy = $/
    Hello $name,
    today we're ${date}.

    $ dollar sign
    $$ escaped dollar sign
    \ backslash
    / forward slash
    $/ escaped forward slash
    $/$ escaped dollar slashy string delimiter
/$
```

## 正则表达式运算符

### 模式运算符

我们可以用`~`用给定的字符串创建`java.util.regex.Pattern`对象。

```groovy
def p = ~/foo/
assert p instanceof Pattern
```

### 查找运算符

我们可以使用`=~`运算符创建一个Matcher对象，然后我们可以将结果放到Groovy的任何布尔判断位置。Groovy会调用`find`方法查找是否存在指定的字符串。

```groovy
def text = "some text to match"
def m = text =~ /match/                                           
assert m instanceof Matcher                                       
if (!m) {                                                         
    throw new RuntimeException("Oops, text not found!")
}
```

### 匹配运算符

匹配运算符`==~`和查找运算符类似，只不过这次直接返回布尔值，判断给定的文本是否和正则表达式匹配。

```groovy
m = text ==~ /match/                                              
assert m instanceof Boolean                                       
if (m) {                                                          
    throw new RuntimeException("Should not reach that point!")
}
```

# 小练习



说了这么多，写个小例子验证一下这里的功能。文本截取自BBC某新闻。用前面的说的语法糖来处理一下文本。整个Groovy文件作为脚本执行。

```groovy
//这次直接当做脚本用
def texts = '''
The Chinese premier described the world's second-largest economy as a butterfly struggling to emerge from a chrysalis.
He said this transformation was filled with promise but also great pain.
He repeatedly paid tribute to Communist Party leader Xi Jinping and said that under the sound leadership of the Party, the Chinese people had the courage and ingenuity to overcome all difficulties.'''

//p开头的单词
def startsWithP = /\b[pP]\w*\b/



def wordsStartsWithP = texts =~ startsWithP
println("p开头的单词")
while (wordsStartsWithP.find()) {
    print("${wordsStartsWithP.group()} ")
}
println()

//以y结尾的单词
def endsWithY = /^.*y$/
def words = ['happy', 'foolish', 'something', 'java','lucky']

def results = words.findAll { it ==~ endsWithY }.join(',')
println("y结尾的单词:$results")
```