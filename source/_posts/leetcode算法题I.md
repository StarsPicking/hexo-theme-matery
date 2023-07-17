---
title: leetcode算法题I
author: 张大哥
top: true
cover: true
toc: true
mathjax: false
categories: 数据结构与算法
tags:
  - 算法题
  - leetcode
abbrlink: 46634
date: 2022-11-02 00:54:49
img: https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover6.jpg
coverImg: https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/theme/cover6.jpg
summary: 数据结构算法不仅有用,更应该是每个程序员必须掌握的基本功 学习数据结构算法,可以大大拓宽我们的思维模式。掌握了数据结构与算法,我们看待问题的深度、解决问题的角度会大有不同,对于个人逻辑思维的提升,也是质的飞跃
---

<!-- more -->

数据结构算法不仅有用,更应该是每个程序员必须掌握的基本功 学习数据结构算法,可以大大拓宽我们的思维模式。掌握了数据结构与算法,我们看待问题的深度、解决问题的角度会大有不同,对于个人逻辑思维的提升,也是质的飞跃

# 常见算法题



## 求两数之和



> 给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。你可以按任意顺序返回答案。
>

```python
# class Solution:
#     def twoSum(self, nums: List[int], target: int) -> List[int]:
#         #for num in nums:
#         #    other = target - num
#         for i in range(len(nums)):
#             other = target - nums[i]
#             for j in range(i+1, len(nums)):
#                 if nums[j] == other:
#                     return [i, j]
#         return None
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        tmp = dict()
        for index, val in enumerate(nums):
            other = target-val
            if other in tmp:
                return tmp[other], index
            tmp[val] = index
        return None
```

## 无重复最长字串

>  给定一个字符串 `s` ，请你找出其中不含有重复字符的 **最长子串** 的长度。 

```python

# 滑动窗口法
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        l = r = 0
        tmp = set()
        max_num = 0
        for i in range(len(s)):
            # 重复后要去除重复元素以及重复元素之前的，同时l + 1
            if i!=0:
                tmp.remove(s[i-1])
                l += 1
            while r< len(s) and s[r] not in tmp: # 不重复加入
                tmp.add(s[r])
                r+=1
                
            print(tmp)
            max_num = max(r-l, max_num)
        return max_num
```

## z字形变换



> 将一个给定字符串 s 根据给定的行数 numRows ，以从上往下、从左到右进行 Z 字形排列。
>
> 比如输入字符串为 "PAYPALISHIRING" 行数为 3 时，排列如下：
>
> P   A   H   N
> A P L S I I G
> Y   I   R
> 之后，你的输出需要从左往右逐行读取，产生出一个新的字符串，比如："PAHNAPLSIIGYIR"。

```python
def solution(s, rows):

    """

    模拟二维矩阵

    矩阵如何初始化

    如何模拟

    向上取整通用做法 int((a+b -1) /b)
    
    每个周期为 2r -2, 每个周期内的列数为r-1
    """

    n, r = len(s), numRows
    if r <2:
        return s
    t = 2* r-2
    # 根据周期求列数  ，每个周期内的列数为r-1列
    c = (r-1) * int((n +t -1)/t)

    # 初始化数组
    dp = [[""]*c for _ in range(r)]

    x, y = 0, 0
    for index_, ss in enumerate(s):
        dp[x][y] = ss
        if index_%t < r-1:
            x+=1
            else:
                x -= 1
                y += 1
                
    return   "".join([ch for list1 in dp for ch in list1 if ch !=""])

```

## 数字反转



给你一个 32 位的有符号整数 x ，返回将 x 中的数字部分反转后的结果。

如果反转后整数超过 32 位的有符号整数的范围 [−231,  231 − 1] ，就返回 0。

```python
class Solution:
    def reverse(self, x: int) -> int:
        """
        除10每次取证，直到被除数<10为止
        """
        # if x< -(2<<31) or x >(2<<31 - 1):
        #     return 0

        y, res = abs(x), 0

        while y !=0 :
            if res < -(2<<30)/10 or res> (2<<30)/10:
                return 0
            res = res*10 + y%10
            y //=10
        return res if x>=0 else 0-res
```





## 整数转罗马数组



> 罗马数字包含以下七种字符： I， V， X， L，C，D 和 M。
>
> 字符          数值
> I             1
> V             5
> X             10
> L             50
> C             100
> D             500
> M             1000
> 例如， 罗马数字 2 写做 II ，即为两个并列的 1。12 写做 XII ，即为 X + II 。 27 写做  XXVII, 即为 XX + V + II 。
>
> 通常情况下，罗马数字中小的数字在大的数字的右边。但也存在特例，例如 4 不写做 IIII，而是 IV。数字 1 在数字 5 的左边，所表示的数等于大数 5 减小数 1 得到的数值 4 。同样地，数字 9 表示为 IX。这个特殊的规则只适用于以下六种情况：
>
> I 可以放在 V (5) 和 X (10) 的左边，来表示 4 和 9。
> X 可以放在 L (50) 和 C (100) 的左边，来表示 40 和 90。 
> C 可以放在 D (500) 和 M (1000) 的左边，来表示 400 和 900。
> 给你一个整数，将其转为罗马数字。

```python
class Solution:
    def intToRoman(self, num: int) -> str:
    
    	
        list2 = [(1000, 'M'), (900, 'CM'), (500, 'D'), (400, 'CD'), (100, 'C'), (90, 'XC'), (50, 'L'), (40, 'XL'), (10, 'X'), (9, 'IX'), (5, 'V'), (4, 'IV'), (1, 'I')]
        str1 = ""
        for index_,  (n, ch) in enumerate(list2):
            while num >= n:
                v = num // n
                str1 += v*ch
                num = num % n
        return str1
```



## 数字转罗马数字



>罗马数字包含以下七种字符: I， V， X， L，C，D 和 M。

字符          数值
I             1
V             5
X             10
L             50
C             100
D             500
M             1000
例如， 罗马数字 2 写做 II ，即为两个并列的 1 。12 写做 XII ，即为 X + II 。 27 写做  XXVII, 即为 XX + V + II 。

通常情况下，罗马数字中小的数字在大的数字的右边。但也存在特例，例如 4 不写做 IIII，而是 IV。数字 1 在数字 5 的左边，所表示的数等于大数 5 减小数 1 得到的数值 4 。同样地，数字 9 表示为 IX。这个特殊的规则只适用于以下六种情况：

I 可以放在 V (5) 和 X (10) 的左边，来表示 4 和 9。
X 可以放在 L (50) 和 C (100) 的左边，来表示 40 和 90。 
C 可以放在 D (500) 和 M (1000) 的左边，来表示 400 和 900。
给定一个罗马数字，将其转换成整数。

```python
class Solution:
    def romanToInt(self, s: str) -> int:

        list1 = [('M', 1000), ('CM', 900), ('D', 500), ('CD', 400), ('C', 100), ('XC', 90), ('L', 50), ('XL', 40), ('X', 10), ('IX', 9), ('V', 5), ('IV', 4), ('I', 1)]
        num = 0
        for _,(ch, n) in enumerate(list1):
            while s.startswith(ch):
                num += n
                s = s[len(ch):]
        return num

```



## 最长公共前缀





```python
class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:

        first_ch = strs[0]
        j = 0
        res = ""
        while j < len(first_ch):
            ch = first_ch[j]
            tag = True
            for s in strs:
                if len(s)<= j or ch != s[j]:
                    tag = False
            if tag:
                res += ch
            else:
                break
            j +=1 
        return res
```

## 三数之和

> 给你一个整数数组 nums ，判断是否存在三元组 [nums[i], nums[j], nums[k]] 满足 i != j、i != k 且 j != k ，同时还满足 nums[i] + nums[j] + nums[k] == 0 。请
>
> 你返回所有和为 0 且不重复的三元组。
>
> 注意：答案中不可以包含重复的三元组。

**排序+双指针+剪枝**

```python
class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        # 排序， 防止重复
        nums.sort()
        n = len(nums)
        tmp = list()
        for i in range(n):
            
            first = nums[i]
            if i >0 and nums[i] == nums[i-1]:
                continue
            target = -first
            # 前后双指针
            left = i +1
            right = n-1

            while left < right:
                # 如果有重复的则忽略
                second = nums[left]
                third = nums[right]
                if second + third == target:
                    tmp.append([first, second, third])
                    #判断是否有相同的元素，
                    while left < right and nums[left] == nums[left +1]:
                        left +=1
                    while left < right and nums[right] == nums[right -1]:
                        right -= 1
                if second +third > target:
                    right -= 1
                    continue
                if second + third < target:
                    left += 1
                    continue
                left += 1
                right -= 1
        return tmp
```

## 最接近的三数之和-leetcode 16

> 给你一个长度为 n 的整数数组 nums 和 一个目标值 target。请你从 nums 中选出三个整数，使它们的和与 target 最接近。
>
> 返回这三个数的和。
>
> 假定每组输入只存在恰好一个解



**排序+双指针**

```python
class Solution:
    def threeSumClosest(self, nums: List[int], target: int) -> int:

        nums.sort()
        min_num = 10**5
        for i in range(len(nums)-1 ):
            left, right = i +1, len(nums)-1
            
            while left < right:
                cur_target = nums[i] + nums[left] + nums[right]
                if abs(target-cur_target) < abs(target-min_num):
                    min_num = cur_target
                if cur_target == target:
                    return cur_target
                
                elif cur_target < target:
                    left += 1
                else:
                    right -= 1

        return min_num
```



##  两数相除

> 定两个整数，被除数 dividend 和除数 divisor。将两数相除，要求不使用乘法、除法和 mod 运算符。
>
> 返回被除数 dividend 除以除数 divisor 得到的商。
>
> 整数除法的结果应当截去（truncate）其小数部分，例如：truncate(8.345) = 8 以及 truncate(-2.7335) = -2

```python
class Solution:
    # 此方法会超时
    # def divide(self, dividend: int, divisor: int) -> int:
    #     # 由于取值范围是[−2**31,  2**31 − 1] 所以同一使用负数来处理溢出问题
    #     flag = False  # 是否需要加负号
    #     if (dividend >0 and divisor < 0) or (dividend <0 and divisor >0):
    #         flag = True

    #     dividend = abs(dividend)
    #     divisor = abs(divisor)
    #     num = 0
    #     while divisor  <= dividend:
    #         dividend -= divisor
    #         num -=1
    #     if num == (-2)**31:
    #         return 2**31-1
    #     else:
    #         return num if flag else -num
    def divide(self, dividend: int, divisor: int) -> int:
        #     # x << i, 左移相当于 x* 2^i
    	#     # x >> i, 右移相当于 x/ 2^i
        flag = (dividend <0) != (divisor<0)
        print(flag)
        limit = 2**31-1
        dividend = abs(dividend)
        divisor = abs(divisor)
        res,  div , tmp = 0, divisor, 1
        while dividend >=divisor:
            while dividend > (div<<1):
                div <<=1
                tmp <<=1
            dividend -= div
            div = divisor
            res +=tmp
            tmp = 1
            
        if flag:
            res = -res
        print(res, "res")
        
        if res -2**31 <=res <=2**31-1:
            return res
        else:
            return limit
```

## 搜索螺旋排序数组

> 整数数组 nums 按升序排列，数组中的值 互不相同 。
>
> 在传递给函数之前，nums 在预先未知的某个下标 k（0 <= k < nums.length）上进行了 旋转，使数组变为 [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]（下标 从 0 开始 计数）。例如， [0,1,2,4,5,6,7] 在下标 3 处经旋转后可能变为 [4,5,6,7,0,1,2] 。
>
> 给你 旋转后 的数组 nums 和一个整数 target ，如果 nums 中存在这个目标值 target ，则返回它的下标，否则返回 -1 。
>
> 你必须设计一个时间复杂度为 O(log n) 的算法解决此问题。

` 每一次二分查找后，数组都被分为一个有序的和一个无序的， 两种情况分别按照二分查找的方式处理就可以解决此问题`

```python
class Solution:
    def search(self, nums: List[int], target: int) -> int:
        """
        将数组一分为二，其中一定有一个是有序的，另一个可能是有序，也能是部分有序。此时有序部分用二分法查找。无      序部分再一分为二，其中一个一定有序，另一个可能有序，可能无序。就这样循环.
        """
        left, right = 0, len(nums)-1
        while left <=right:
            mid = (left+right)//2
            
            if nums[mid] == target:
                return mid
            if nums[0] <= nums[mid]: # 前半部分有序,
                
                if nums[0] <= target <nums[mid]:  # 判断target是否在上升序列中，如果在，需要移动右指针
                    right = mid -1
                else:
                    left = mid + 1 # 如果不在上升序列中，则舍弃该序列
            else:  #  类无序的一部分
                if nums[mid] < target  <= nums[len(nums)-1]:  # 
                    left = mid +1
                else:
                    right = mid -1
        return -1
                
```

## 在排序数组中查找元素的第一个和最后一个位置-leetcode 34

> 给你一个按照非递减顺序排列的整数数组 nums，和一个目标值 target。请你找出给定目标值在数组中的开始位置和结束位置。
>
> 如果数组中不存在目标值 target，返回 [-1, -1]。
>
> 你必须设计并实现时间复杂度为 O(log n) 的算法解决此问题。
>

```python
class Solution:
    def searchRange(self, nums: List[int], target: int) -> List[int]:

        """
        二分查找寻找左右边界
        """

        def search_left(nums, target):

            left, right = 0, len(nums)-1

            while left <= right:
                mid = (left + right) //2
                print(mid, "mid")
                if nums[mid] == target:
                    right = right -1
                elif nums[mid] > target:
                    right = mid-1
                else:
                    left = mid +1
            
            if nums[left] == target:
                return left
            else:
                return -1

        def search_right(nums, target):
            left, right = 0, len(nums)-1

            while left <= right:
                mid = (left +right) // 2
                if nums[mid] == target:
                    left = mid +1
                elif nums[mid] >target:
                    right = mid -1
                else:
                    left = mid +1

            if nums[right] == target:
                return right
            else:
                return -1
        if not nums or nums[0] > target or nums[-1] < target:
            return [-1, -1]
        l = search_left(nums, target)
        r = search_right(nums, target)
        if all([l != -1, r != -1]):
            return [l, r]

        else:
            return [-1, -1]

```

## 有效的数组 --leetcode 36

```python
from collections import defaultdict
class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        row, col , sqrt = defaultdict(set), defaultdict(set), defaultdict(set)
        for i in range(0, 9):# 行
            for j in range(0, 9):  # 列
                if board[i][j] == ".":
                    continue
                if board[i][j] in row[i]:
                    return False
                if board[i][j] in col[j]:
                    return False
                ## 推导i, j 是在哪个盒子
                if board[i][j] in sqrt[i//3, j//3]:
                    return False
                row[i].add(board[i][j])
                col[j].add(board[i][j])
                sqrt[i//3,j//3].add(board[i][j])
        return True

    
```

## 字符串相乘-leetcode 43

> 给定两个以字符串形式表示的非负整数 num1 和 num2，返回 num1 和 num2 的乘积，它们的乘积也表示为字符串形式。
>
> 注意：不能使用任何内置的 BigInteger 库或直接将输入转换为整数

**模拟乘法运算过程，最后统一处理进位， 注意每次相乘结果对象要加到列表的i+j+1处**

```python
class Solution:
    def multiply(self, num1: str, num2: str) -> str:

        if num1 == "0" or num2 == "0":
            return "0"

        m, n = len(num1), len(num2)
        temp = [0]* (m + n)
        for i in range(0, m):
            for j in range(0, n):
                num = (ord(num1[i]) - ord("0")) * ((ord(num2[j]) - ord("0")))
                temp[i + j +1] = temp[i+j+1] + num
        falg_num = 0
        for n in range(-1, -len(temp) +1, -1):
            
            this_num = (temp[n]) % 10
            falg_num = temp[n]// 10
            temp[n] = this_num
            temp[n-1] += falg_num
        index = 1 if temp[0] == 0 else 0
        ans = "".join([str(i) for i in temp[index:]])
        return ans
```

## 跳跃游戏-leetcode 45

> 给你一个非负整数数组 nums ，你最初位于数组的第一个位置。
>
> 数组中的每个元素代表你在该位置可以跳跃的最大长度。
>
> 你的目标是使用最少的跳跃次数到达数组的最后一个位置。
>
> 假设你总是可以到达数组的最后一个位置。
>

## 无重复字符的最长子串

>  给定一个字符串 `s` ，请你找出其中不含有重复字符的 **最长子串** 的长度 

```python
class Solution:
    """
    可以使用双指针，也可以使用贪心算法，这里使用贪心算法
    
    贪心算法： 要想使字串最长，那么，每个重复字母之间的距离最大，最后的最大距离就是最长字串的长度
     s = "abcabcbb"
    """
    def lengthOfLongestSubstring(self, s: str) -> int:
        
        max_len = 0
        start = 0
        char_index = dict()

        for  i in range(len(s)):
            # 任何字串都不能有重复的，如果获取到的下标小于start 则不更新start， 如果大于等于，则更新start
            if s[i] in char_index and char_index[s[i]]>=start:
                max_len = max(i-start, max_len)
                start = char_index[s[i]] +1 if char_index[s[i]] >= start else start
            char_index[s[i]] = i
        print(max_len, len(s)- start)
        return max(max_len, len(s) - start)
```

## Power(x, n)-leetcode 50

>  实现 [pow(*x*, *n*)](https://www.cplusplus.com/reference/valarray/pow/) ，即计算 `x` 的整数 `n` 次幂函数（即，`x**n` ）



```python
class Solution:
    """
    x ** 89       89//2  +1
    x ** 88 88/2
    """
    def myPow(self, x: float, n: int) -> float:
        def quick_mul(N):
            if N == 0:
                return 1.0
            y = quick_mul(N//2)
            return y *y if N %2 ==0 else y*y *x
        return quick_mul(n) if n>=0 else 1/quick_mul(-n)
```

## 字母异味词分组-leetcode 49

> 给你一个字符串数组，请你将 字母异位词 组合在一起。可以按任意顺序返回结果列表。
>
> 字母异位词 是由重新排列源单词的字母得到的一个新单词，所有源单词中的字母通常恰好只用一次。
>



```python
import collections

class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        dict1 = collections.defaultdict(list)
        for i in range(len(strs)):

            key = tuple("".join(sorted(strs[i])))
            dict1[key].append(strs[i])
        return list(dict1.values())
```

## 螺旋矩阵-leetcode 54



>  给你一个 `m` 行 `n` 列的矩阵 `matrix` ，请按照 **顺时针螺旋顺序** ，返回矩阵中的所有元素。 

```python

'''
对于每层，从左上方开始以顺时针的顺序遍历所有元素。假设当前层的左上角位于 (top,left)，右下角位于 (bottom,right)，按照如下顺序遍历当前层的元素。

从左到右遍历上侧元素，依次为 (top,left) 到(top,right)。
从上到下遍历右侧元素，依次为 (top+1,right) 到 (\textit{bottom}, (bottom,right)。

如果 left<right 且 top<bottom，则从右到左遍历下侧元素，依次为 (bottom,right−1) 到 )(bottom,left+1)，以及从下到上遍历左侧元素，依次为(top+1,left)。

遍历完当前层的元素之后，将 left 和top 分别增加 1，将 right 和 bottom 分别减少 11，进入下一层继续遍历，直到遍历完所有元素为止。
'''

class Solution:

    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        
        if len(matrix)==0:
            return []
        ret = list()
        top, bottom, left, right = 0, len(matrix)-1,  0, len(matrix[0]) -1
        while left <= right and top <= bottom:
            for column in range(left, right +1):
                ret.append(matrix[top][column])
            for row in range(top+1, bottom+1):
                ret.append(matrix[row][right])

            if left < right and top < bottom:
                for column in range(right-1, left, -1):
                    ret.append(matrix[bottom][column])
                for row in range(bottom, top, -1):
                    ret.append(matrix[row][left])
            top +=1
            bottom -= 1
            left += 1
            right -= 1

        return ret

```

## 合并区间

> 以数组 intervals 表示若干个区间的集合，其中单个区间为 intervals[i] = [starti, endi] 。请你合并所有重叠的区间，并返回 一个不重叠的区间数组，该数组需恰好覆盖输入中的所有区间 。



```python
class Solution:
    def merge(self, intervals: List[List[int]]) -> List[List[int]]:
        ret = list()
        intervals = sorted(intervals, key=lambda x: (x[0], x[1]))
        for i in range(len(intervals)):
            if i == 0:
                ret.append(intervals[0])
                continue
            pre_start = ret[-1][0]
            pre_end = ret[-1][1]

            nex_start = intervals[i][0]
            nex_end = intervals[i][1]

            if nex_start <= pre_end:
                ret[-1]=[pre_start, max(pre_end, nex_end)]
            else:
                ret.append(intervals[i])
                
        return ret
```

## 插入区间-leetcode 57

```python
class Solution:
    def insert(self, intervals: List[List[int]], newInterval: List[int]) -> List[List[int]]:

        ret = list()
        start_new, end_new = newInterval
        tag = False
        for start, end in intervals:
            
            # 无相交， 可以直接加入这个元素的左侧
            if start > end_new: 
                if not tag:
                    ret.append([start_new, end_new])
                    tag = True
                ret.append([start, end])
            
            # 有相交，将最小的作为插入的起始，最大的作为插入的结尾
            elif end < start_new:
                ret.append([start, end])
            else:
                # 有相交
                # 不能直接插入////
                start_new = min(start, start_new)
                end_new = max(end, end_new)
                
            
        if not tag:
            ret.append([start_new, end_new])
        return ret
```

## 最后一个单词的长度-leetcode 51

> 给你一个字符串 s，由若干单词组成，单词前后用一些空格字符隔开。返回字符串中 最后一个 单词的长度。
>
> 单词 是指仅由字母组成、不包含任何空格字符的最大子字符串。



```python
class Solution:
    def lengthOfLastWord(self, s: str) -> int:

        # s = s.rstrip(" ")
        # num = 0
        # if len(s) == 1:
        #     return 1
        # for i in range(-1, -len(s)-1, -1):
        #     if s[i] == " ":
        #         break
        #     num += 1
        # return num
        
        # 用内置方法
        return len(s.rstrip(" ").split(" ")[-1].lstrip(" "))
```

## 螺旋矩阵II -leetcode

>  给你一个正整数 `n` ，生成一个包含 `1` 到 `n**2` 所有元素，且元素按顺时针顺序螺旋排列的 `n x n` 正方形矩阵 `matrix` 。 

```python
class Solution:

    """
     模拟方向， 按照顺序填入数字

     [[1,2,3], 
      [9,10,4],
      [8,7,6]]
    """
    def generateMatrix(self, n: int) -> List[List[int]]:

        left = 0
        right = n -1
        top = 0
        bottom = n-1
        board = [["-"]*n for _ in range(n)]

        start = 0
        while top <= bottom and left <= right:

            for col in range(left, right+1):
                start += 1
                board[top][col] = start

            for row in range(top+1, bottom +1):

                start += 1
                board[row][right] = start
            
            if left < right and top < bottom:

                for col in range(right-1, left, -1):
                    start += 1
                    
                    board[bottom][col] = start
     
                for row in range(bottom, top, -1):
                    start+= 1
                    board[row][left] = start
            

            top += 1

            bottom -= 1

            left += 1

            right -= 1
        return board

```

## 排序序列-leetcode-60

> 给出集合 [1,2,3,...,n]，其所有元素共有 n! 种排列。
>
> 按大小顺序列出所有排列情况，并一一标记，当 n = 3 时, 所有排列如下：
>
> "123"
> "132"
> "213"
> "231"
> "312"
> "321"
> 给定 n 和 k，返回第 k 个排列
>
> 

```python
#会超时
class Solution:
    """
    适用回溯法
    """
    def getPermutation(self, n: int, k: int) -> str:

        sums = [i for i in range(1, n+1)]
        print(sums)
        path = []
        result = list()

        def backtracing(startindex, path, depth, used):

            if depth == n:
                result.append(path[:])
                return
            for i in range(0, n):
                if used[i]:
                    continue
                path.append(str(sums[i]))
                used[i] = True
                backtracing(startindex +1 , path, depth + 1, used)
                path.pop()
                used[i] = False


        backtracing(0, path, 0, {i: False for i in range(0, n)})
        return "".join(result[k-1])
```

## 旋转链表

>  给你一个链表的头节点 `head` ，旋转链表，将链表每个节点向右移动 `k` 个位置。 

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    
    """
    1. 计算链表的长度
    2. 找出倒数第k+1 个节点     (len(head) - k) % len(head)
    
    3. 转为循环链表
    4. 在第k+1 个节点处断开
    
    """
    def rotateRight(self, head: ListNode, k: int):
        if k == 0 or not head or not head.next:
            return head

        n = 1

        cur = head
        
        while cur.next:
            cur = cur.next  # 最后一个节点
            n += 1
        # 寻找新链表的结尾位置
        end = (n - k) %n  # 余数即为倒数第k+1个位置
        cur.next = head   # 使链表收尾相连
        if end == n:
            return end()

        while end >0:
            cur = cur.next
            end -= 1

        # 结束循环，此时cur处于循环链表的结尾位置

        ret = cur.next
        cur.next = None  # 将链表断开
        return ret
        

```

## 不同路径-leetcode 62

> 一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为 “Start” ）。
>
> 机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为 “Finish” ）。
>
> 问总共有多少条不同的路径？
>



```python
class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        # dp[i][j] 在ij位置处的所有路径
        # 递推方程 dp[i][j] =dp[i][j] + dp[i-1][j] + dp[i][j-1]

        # 生成dp   初始化， 只有一行，或者只有一列 只有一种走法

        
        dp = [[1] *n] + [[1]+ [0]* (n-1) for _ in range(1, m)]
        for i in range(1, m):

            for j in range(1, n):
                dp[i][j] = dp[i][j] + dp[i-1][j] + dp[i][j-1]

        return dp[-1][-1]
```

## 不同路径II

>  一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为 “Start” ）。
>
> 机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为 “Finish”）。
>
> 现在考虑网格中有障碍物。那么从左上角到右下角将会有多少条不同的路径？
>
> 网格中的障碍物和空位置分别用 1 和 0 来表示。

```python
class Solution:
    def uniquePathsWithObstacles(self, obstacleGrid: List[List[int]]) -> int:
        """
        1. dp[i][j]到达(i)(j)的路径数
        2. 递推公式: dp[i][j] = dp[i][j] + dp[i-1][j] + dp[i][j-1]
                    dp[i][j] = 0  # (i, j) 处有障碍物体
        3. 初始化 
        """
        dp = [[0] * len(obstacleGrid[0]) for _ in range(len(obstacleGrid))]
        for i in range(len(obstacleGrid)):
            for j in range(len(obstacleGrid[0])):

                if i ==0 and j ==0 and obstacleGrid[i][j] !=1:
                    dp[i][j] = 1
                else:
                    if obstacleGrid[i][j] == 0:
                        dp[i][j] = dp[i-1][j] + dp[i][j-1]
        return dp[-1][-1]


```

## 最小路径和 - leetcode 64

> 给定一个包含非负整数的 `*m* x *n*` 网格 `grid` ，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。
>
> **说明：**每次只能向下或者向右移动一步。

```python
class Solution:
    def minPathSum(self, grid: List[List[int]]) -> int:
        """
        dp[i][j] 在（i，j） 处最小数字总和

        dp[i][j] = min(dp[i-1][j], dp[i][j-1]) + grid[i][j]

        """
        for  i in range(1, len(grid)):
            
            grid[i][0] +=  grid[i-1][0]

        for j in range(1, len(grid[0])):
            grid[0][j] += grid[0][j-1]
        
        print(grid)

        for i in range(1, len(grid)):
            for j in range(1, len(grid[0])):

                grid[i][j] = min(grid[i-1][j], grid[i][j-1]) + grid[i][j]
        
        return grid[-1][-1]

```

## 加一 -leetcode 66



> 给定一个由 整数 组成的 非空 数组所表示的非负整数，在该数的基础上加一。
>
> 最高位数字存放在数组的首位， 数组中每个元素只存储单个数字。
>
> 你可以假设除了整数 0 之外，这个整数不会以零开头。
>

```python
class Solution:
    def plusOne(self, digits: List[int]) -> List[int]:

        if not digits:
            return digits
        digits = [0] + digits
        digits[-1] += 1
        flag = 0
        for i in range(-1, -len(digits)-1, -1):            
            num = (digits[i] + flag) % 10
            flag = (digits[i] + flag) // 10
            digits[i] = num
        return digits[1:] if digits[0] == 0 else digits
        
       
```

## 二进制求和

>  给你两个二进制字符串 `a` 和 `b` ，以二进制字符串的形式返回它们的和。 

```python
class Solution:
    def addBinary(self, a: str, b: str) -> str:

        n = max(len(a), len(b))
        a =  "0" + (n - len(a)) * "0" + a
        b = "0" + (n - len(b)) * "0" + b
        flag = 0
        ret = [0] * len(a)
        for i in range(-1, -len(ret)-1, -1):
            num = ord(a[i]) - ord("0") + ord(b[i]) - ord("0") + flag
            cur = num %2 
            flag = num//2
            ret[i] = str(cur)
        if len(ret) == 1:
            return "".join(ret)
        ret = ret[1:] if ret[0] == "0" else ret
        return "".join(ret)
```

## x的平方根 - leetcode 69

> 给你一个非负整数 x ，计算并返回 x 的 算术平方根 。
>
> 由于返回类型是整数，结果只保留 整数部分 ，小数部分将被 舍去 。
>
> 注意：不允许使用任何内置指数函数和算符，例如 pow(x, 0.5) 或者 x ** 0.5
>

```python
class Solution:
    """
    结果向下取整
    """
    def mySqrt(self, x: int) -> int:
        left, right, ans = 0, x, 0

        if x in {0, 1}:
            return x
        while left <=right:

            mid = (left + right) // 2
            if mid * mid <= x and (mid+1)*(mid+1) >x:
                return mid
            elif mid * mid <x:
                left = mid+1
            
            else:
                right = mid-1
        return x


```

## 爬楼梯

> 假设你正在爬楼梯。需要 `n` 阶你才能到达楼顶。
>
> 每次你可以爬 `1` 或 `2` 个台阶。你有多少种不同的方法可以爬到楼顶呢？

```python
class Solution:
    def climbStairs(self, n: int) -> int:
        dp = [1, 2]
        if n in {1, 2}:
            return dp[n-1]
        x = 3
        while x <= n:

            dp.append(dp[-1] + dp[-2])
            x +=1 
        return dp[-1]
        
```

## 简化路径 -leetcode 71



> 给你一个字符串 path ，表示指向某一文件或目录的 Unix 风格 绝对路径 （以 '/' 开头），请你将其转化为更加简洁的规范路径。
>
> 在 Unix 风格的文件系统中，一个点（.）表示当前目录本身；此外，两个点 （..） 表示将目录切换到上一级（指向父目录）；两者都可以是复杂相对路径的组成部分。任意多个连续的斜杠（即，'//'）都被视为单个斜杠 '/' 。 对于此问题，任何其他格式的点（例如，'...'）均被视为文件/目录名称。
>
> 请注意，返回的 规范路径 必须遵循下述格式：
>
> 始终以斜杠 '/' 开头。
> 两个目录名之间必须只有一个斜杠 '/' 。
> 最后一个目录名（如果存在）不能 以 '/' 结尾。
> 此外，路径仅包含从根目录到目标文件或目录的路径上的目录（即，不含 '.' 或 '..'）。
> 返回简化后得到的 规范路径 。

```python
class Solution:
    """
    ./  当前
    ../ 上一级
    /c 能返回
    """
    def simplifyPath(self, path: str) -> str:

        path = path.strip("/")
        paths = path.split("/")
        stack = []
        for cha in paths:

            if cha == "..":
                if stack:
                    stack.pop()
            elif cha and cha != ".":
                stack.append(cha)
        return  '/' + '/'.join(stack)
```

## 矩阵置零 - leetcode 73

>  给定一个 `*m* x *n*` 的矩阵，如果一个元素为 **0** ，则将其所在行和列的所有元素都设为 **0** 。请使用 **[原地](http://baike.baidu.com/item/原地算法)** 算法**。** 

```python
class Solution:
    def setZeroes(self, matrix: List[List[int]]) -> None:
        """
        Do not return anything, modify matrix in-place instead.
        """
        cols = [1] * len(matrix[0])
        rows = [1] * len(matrix)

        for i in range(len(matrix)):
            for j in range(len(matrix[0])):
                if matrix[i][j] == 0:
                    rows[i] = 0
                    cols[j] = 0


        for i in range(len(matrix)):
            for j in range(len(matrix[0])):
                if rows[i] == 0 or cols[j] == 0:
                    matrix[i][j] = 0

```

## 搜索二维矩阵

> 编写一个高效的算法来判断 m x n 矩阵中，是否存在一个目标值。该矩阵具有如下特性：
>
> 每行中的整数从左到右按升序排列。
> 每行的第一个整数大于前一行的最后一个整数。

```python
class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:

        left, right = 0, len(matrix)

        while left <=right and left < len(matrix):

            mid = (left + right) // 2
            if matrix[mid][0]  > target:
                right = mid - 1
                print(right, "right")
            elif matrix[mid][-1] < target:
                left = mid + 1

            else:
                # 二分查找matrix[mid]
                l, r = 0, len(matrix[mid])
                while l<=r:
                    mid_mid = (l + r) // 2

                    if matrix[mid][mid_mid] == target:
                        return True
                    
                    elif matrix[mid][mid_mid] > target:
                        r = mid_mid -1

                    else:
                        l = mid_mid +1
                break
            
        return False

```

## 颜色分类 -leetcode 75



> 给定一个包含红色、白色和蓝色、共 n 个元素的数组 nums ，原地对它们进行排序，使得相同颜色的元素相邻，并按照红色、白色、蓝色顺序排列。
>
> 我们使用整数 0、 1 和 2 分别表示红色、白色和蓝色。
>
> 必须在不使用库的sort函数的情况下解决这个问题。
>

```python
class Solution:
    def sortColors(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        
        def quick_sort(nums, left, right):

            if left< right:
                mid = partition(nums, left, right)
                quick_sort(nums, left, mid-1)
                quick_sort(nums, mid+1, right)
            return nums

        def partition(data, left, right):
            tmp = data[left]
            while left < right:
                while left < right and data[right] >= tmp:
                    right -= 1
                data[left] = data[right]
                while left < right and data[left] <= tmp:
                    left += 1
                data[right] = data[left]

            data[left] = tmp
            return left

        return quick_sort(nums, 0, len(nums)-1)
```

## 组合 -leetcde 77

> 给定两个整数 `n` 和 `k`，返回范围 `[1, n]` 中所有可能的 `k` 个数的组合。
>
> 你可以按 **任何顺序** 返回答案。

```python
class Solution:
    def combine(self, n: int, k: int) -> List[List[int]]:

        result = list()
        path = list()

        def backtracing(start_index, path):

            if len(path) == k:
                result.append(path[:])

            for i in range(start_index, n +1):
                path.append(i)

                backtracing(i +1, path)

                path.pop()
        backtracing(1, path)

        return result
```

## 子集 - leetcode 78

> 给你一个整数数组 `nums` ，数组中的元素 **互不相同** 。返回该数组所有可能的子集（幂集）。
>
> 解集 **不能** 包含重复的子集。你可以按 **任意顺序** 返回解集。

```python
class Solution:
    def subsets(self, nums: List[int]) -> List[List[int]]:
        result = []
        path = list()

        def backtracing(start_index, path):

            result.append(path[:])
            if len(path) == len(nums):
                return
            for i in range(start_index, len(nums)):
                path.append(nums[i])
                
                backtracing(i +1, path)

                path.pop()
        backtracing(0, path)
        return result
```

## 单词搜索 leetcode -79

> 给定一个 m x n 二维字符网格 board 和一个字符串单词 word 。如果 word 存在于网格中，返回 true ；否则，返回 false 。
>
> 单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中“相邻”单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母不允许被重复使用。
>



```python
class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        used = set()

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]  # 对应左右上下四个方向
        def backtracing(i, j, k):

            if board[i][j] !=  word[k]:
                return False

            if k == len(word) - 1:
                return True

            # 如果board[i][j] = word[k]:
            visited.add((i, j))
            result = False
            for di, dj in directions:
                newi, newj = i+di, j + dj

                if 0<=newi<len(board) and 0<=newj<len(board[0]):
                    if (newi, newj) not in visited:
                        if backtracing(newi, newj, k +1):
                            result = True
                            break
            visited.remove((i, j))

            return result

        visited = set()               

        for i in range(len(board)):
            for j in range(len(board[0])):
                if backtracing(i, j, 0):
                    return True

        return False

```

## 删除有序数组中的重复项 leetcode 80



> 给你一个有序数组 nums ，请你 原地 删除重复出现的元素，使得出现次数超过两次的元素只出现两次 ，返回删除后数组的新长度。
>
> 不要使用额外的数组空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。



```python
class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        start, end = 0, 0
        while end <len(nums):
            while nums[start] == nums[end]  and end - start >=2:
            #if end - start >= 2:
                del nums[start]
                end -= 1
                #start += 1
            # 此时两者之间的距离必小于二， 如果不相同， 则说明有了新元素，需要移动起始指针
            if nums[start] != nums[end]:
                start = end
                end += 1
            # 如果相同， 起始不变，end + 1
            else:
                end += 1
```

## 搜索旋转排列数组II -leetcode 81

> 已知存在一个按非降序排列的整数数组 nums ，数组中的值不必互不相同。
>
> 在传递给函数之前，nums 在预先未知的某个下标 k（0 <= k < nums.length）上进行了 旋转 ，使数组变为 [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]（下标 从 0 开始 计数）。例如， [0,1,2,4,4,4,5,6,6,7] 在下标 5 处经旋转后可能变为 [4,5,6,6,7,0,1,2,4,4] 。
>
> 给你 旋转后 的数组 nums 和一个整数 target ，请你编写一个函数来判断给定的目标值是否存在于数组中。如果 nums 中存在这个目标值 target ，则返回 true ，否则返回 false 。
>
> 你必须尽可能减少整个操作步骤。
>

```python
class Solution:
    """
    1. 将数组分为两边
    2. 旋转之前末尾所在的一边，如果最后一个元素不是最大值， 则这一半部分有序，有序的分割点为最大的一个数
    3. 旋转之前末尾不在的一边， 完全有序，可以按照二分查找
    """
    def search(self, nums: List[int], target: int) -> bool:

        # 将数组按照下标分为两边
        left , right = 0, len(nums)
        while left <= right:
            mid = (left + right) // 2

            if nums[mid] == target:
                return True

            if num[0] < nums[mid]:
                if nums[0] <= target< nums[mid]:  # 这半部分有序 处于上升序列中
                    right = mid -1
                else:
                    left = mid +1

            else: # 一半有序，一半部分有序

                if nums[mid] < target <= nums[len(nums) -1]: # 处在有序部分
                    left += 1
                else:
                    right -= 1
        return False
             
```

## 删除排序链表中的重复元素-leecode 81

​	

>  给定一个已排序的链表的头 `head` ， *删除所有重复的元素，使每个元素只出现一次* 。返回 *已排序的链表* 。 

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def deleteDuplicates(self, head: Optional[ListNode]) -> Optional[ListNode]:

        if not head:
            return head
        cur = head

        while cur.next:
            if cur.val == cur.next.val:
                cur.next = cur.next.next
            else:
                cur = cur.next
        return head
```

## 删除排序链表中的重复元素II-leetcode 82

>  给定一个已排序的链表的头 `head` ， *删除原始链表中所有重复数字的节点，只留下不同的数字* 。返回 *已排序的链表* 。 

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:

    """
    有可能头部节点也会删除

    删除条件 head.val = head.next.val 直到找到不相等的进行连接

    """
    def deleteDuplicates(self, head: Optional[ListNode]) -> Optional[ListNode]:
        dummy = ListNode(0, head)

        cur = dummy

        while cur.next and cur.next.next:

            if cur.next.val == cur.next.next.val:
                repeat = cur.next.val

                while cur.next and cur.next.val == repeat:
                    cur.next = cur.next.next

            else:
                cur = cur.next

        return dummy.next

```

## 合并两个有序数组 - leetcode 88

> 给你两个按 非递减顺序 排列的整数数组 nums1 和 nums2，另有两个整数 m 和 n ，分别表示 nums1 和 nums2 中的元素数目。
>
> 请你 合并 nums2 到 nums1 中，使合并后的数组同样按 非递减顺序 排列。
>
> 注意：最终，合并后数组不应由函数返回，而是存储在数组 nums1 中。为了应对这种情况，nums1 的初始长度为 m + n，其中前 m 个元素表示应合并的元素，后 n 个元素为 0 ，应忽略。nums2 的长度为 n 。

```python
class Solution:
    def merge(self, nums1: List[int], m: int, nums2: List[int], n: int) -> None:
        """
        Do not return anything, modify nums1 in-place instead.
        """
        l = 0
        r = 0
        ret = list()
        while l <m and r < n:

            if nums1[l] <= nums2[r]:
                ret.append(nums1[l])
                l += 1
            else:
                ret.append(nums2[r])
                r += 1

        ret = ret + nums1[l:m]
        ret = ret + nums2[r:]
        nums1[:] = ret
```

## 子集II -leetcode 90



> 给你一个整数数组 nums ，其中可能包含重复元素，请你返回该数组所有可能的子集（幂集）。
>
> 解集 不能 包含重复的子集。返回的解集中，子集可以按 任意顺序 排列。
>





```python
class Solution:
    def subsetsWithDup(self, nums: List[int]) -> List[List[int]]:
        
        result = list()
        path = list()
        nums.sort()
        def backtracing(path, start_index):
            result.append(path[:])
            if len(path) >= len(nums):
                return
            for i in range(start_index, len(nums)):
                if i > start_index and nums[i] == nums[i-1]:
                    continue
                path.append(nums[i])
                backtracing(path, i +1)
                path.pop()
        backtracing(path, 0)
        return result

```

## 解码方法 - leetcode 91



> 一条包含字母 A-Z 的消息通过以下映射进行了 编码 ：
>
> 'A' -> "1"
> 'B' -> "2"
> ...
> 'Z' -> "26"
> 要 解码 已编码的消息，所有数字必须基于上述映射的方法，反向映射回字母（可能有多种方法）。例如，"11106" 可以映射为：
>
> "AAJF" ，将消息分组为 (1 1 10 6)
> "KJF" ，将消息分组为 (11 10 6)
> 注意，消息不能分组为  (1 11 06) ，因为 "06" 不能映射为 "F" ，这是由于 "6" 和 "06" 在映射中并不等价。
>
> 给你一个只含数字的 非空 字符串 s ，请计算并返回 解码 方法的 总数 。
>
> 题目数据保证答案肯定是一个 32 位 的整数。
>



```python
class Solution:
    def numDecodings(self, s: str) -> int:

        n = len(s)
        dp = [1] + [0] * n

        for i in range(1, n+1):

            if s[i-1] != "0":
                dp[i] = dp[i]  + dp[i-1]
            
            if i > 1 and s[i-2] != "0" and int(s[i-2:i]) <= 26:
                dp[i] = dp[i] + dp[i-2]
            
        return dp[-1]

```

## 反转链表II -leetcode 92



> 给你单链表的头指针 head 和两个整数 left 和 right ，其中 left <= right 。请你反转从位置 left 到位置 right 的链表节点，返回 反转后的链表 。
>

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None): 
#         self.val = val
#         self.next = next
class Solution:
    def reverseBetween(self, head: Optional[ListNode], left: int, right: int) -> Optional[ListNode]:


        def deverse_node(head):
            
            # 原地逆置法反转链表
            # bag = head
            # end = bag.next
            # while end:
            #     bag.next = end.next
            #     end.next = head
            #     head = end
            #     end = bag.next
            # print(head, 999)
            
            
            # 头插法
            pre = None
            cur = head

            while cur:
                next = cur.next  # 指针指向下一个节点
                # 在pre的头部插入cur节点
                cur.next = pre
                pre = cur
                cur = next
            # 反转后头节点是right_node, 尾节点是left_node


        dummy = ListNode(0)
        dummy.next = head

        pre = dummy

        for _ in range(left -1):  # left 的前一个节点
            pre = pre.next


        right_node = pre

        for _ in range(right - left +1):  # 来到right 节点
            right_node = right_node.next

        # 切断出一个子链表（截取链表）

        left_node = pre.next
        curr = right_node.next
        # 切断连接
        pre.next = None
        right_node.next = None

        # 逆置
        deverse_node(left_node)
        
        # 拼接
        pre.next = right_node
        left_node.next = curr
        return dummy.next
        
```

## 复原ip地址 - leetcode93



> 有效 IP 地址 正好由四个整数（每个整数位于 0 到 255 之间组成，且不能含有前导 0），整数之间用 '.' 分隔。
>
> 例如："0.1.2.201" 和 "192.168.1.1" 是 有效 IP 地址，但是 "0.011.255.245"、"192.168.1.312" 和 "192.168@1.1" 是 无效 IP 地址。
> 给定一个只包含数字的字符串 s ，用以表示一个 IP 地址，返回所有可能的有效 IP 地址，这些地址可以通过在 s 中插入 '.' 来形成。你 不能 重新排序或删除 s 中的任何数字。你可以按 任何 顺序返回答案。

```python
class Solution:
    def restoreIpAddresses(self, s: str) -> List[str]:

        result = list()
        path = list()


        def backtracing(path, startindx):

            if len(path) == 4 and startindx == len(s):
                result.append(".".join(path[:]))
                return
            if startindx == len(s):
                return

            if s[startindx] == "0":
                path.append("0")
                backtracing(path, startindx+1)                        
                path.pop()
            for i in  range(startindx, len(s)):
                end = i +1
                temp = int(s[startindx:end])
                if 0 < temp and temp  <= 255:
                    path.append(str(temp))
                    backtracing(path, end)
                    path.pop()      
                else:
                    break
        backtracing(path, 0)
        return result
```

## 二叉树的中序遍历 - leetcode 94



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def inorderTraversal(self, root: Optional[TreeNode]) -> List[int]:

        def mid_order(root, ret=[]):
            if root is None:
                return []

            mid_order(root.left, ret)
            ret.append(root.val)

            mid_order(root.right, ret)
            return ret
        return mid_order(root, [])
```

## 不同的二叉搜索树 -leetcode 92

> 给你一个整数 `n` ，求恰由 `n` 个节点组成且节点值从 `1` 到 `n` 互不相同的 **二叉搜索树** 有多少种？返回满足题意的二叉搜索树的种数。 

```python
class Solution:

    # 会超时
    # def numTrees(self, n: int) -> int:
    #     def trees(start, end):
        
    #         if start > end:
    #             return [None, ]

    #         all_tress = list()  

    #         for i in range(start, end+1):
    #             left_trees = trees(start, i-1)
    #             right_trees = trees(i+1, end)

    #             for l in left_trees:
    #                 for r in right_trees:

    #                     all_tress.append("_")
    #         return all_tress
    #     return len(trees(1, n))

    def numTrees(self, n: int) -> int:
        """
        dp[i] 表示在i处互不相同的二叉树个数

        G(n) 表示长度为N 的序列组成二叉树的总个数
        F(i, n) 表示以第i个元素为为根， 长度为n的元素组成二叉树的个数

        G(n) = F(1, N) + F(2, n) + .... F(n,n)
        

        F(i, n) = G(i-1)G(n-i)

        G(i) += G(i-1)G(n-i)

        """
        G = [0] * (n+1)

        G[0] = 1
        G[1] = 1
        for i in range(2, n+1):
            for j in range(1, i+1):  # 长度为i 以j 为根的个数的总个数
                G[i] += G[j-1]*G[i-j]
        return G[-1]


```

## 不同的二叉搜索树II - leetcode 95



> 给你一个整数 `n` ，请你生成并返回所有由 `n` 个节点组成且节点值从 `1` 到 `n` 互不相同的不同 **二叉搜索树** 。可以按 **任意顺序** 返回答案。 

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    """
    回溯法
    """
    def generateTrees(self, n: int) -> List[Optional[TreeNode]]:

        def trees(start, end):
            if start > end:
                return [None,]
            allTress = []
            for i in range(start, end+1):            
                # 所有的左子树
                left_trees = trees(start, i -1)
                # 所有的右子树
                
                right_tree = trees(i + 1, end)

                for l in left_trees:

                    for r in right_tree:
                        curr_tree = TreeNode(i)
                        curr_tree.left = l
                        curr_tree.right = r
                        allTress.append(curr_tree)
            return allTress
        return trees(1, n)
```

## 交错字符串 - leetcode 97





>给定三个字符串 s1、s2、s3，请你帮忙验证 s3 是否是由 s1 和 s2 交错 组成的。
>
>两个字符串 s 和 t 交错 的定义与过程如下，其中每个字符串都会被分割成若干 非空 子字符串：
>
>s = s1 + s2 + ... + sn
>t = t1 + t2 + ... + tm
>|n - m| <= 1
>交错 是 s1 + t1 + s2 + t2 + s3 + t3 + ... 或者 t1 + s1 + t2 + s2 + t3 + s3 + ...
>注意：a + b 意味着字符串 a 和 b 连接。



```python
class Solution:
    """
    如果在i 位置是交错则
    s1[0] + s2[0] + s1[1] +  s2[1] + .... s1[i] + s2[i] = s[2i]  or
    s1[0] + s2[0] + s1[1] +  s2[1] + .... s1[i] = s[2i-1]  # 或者先s2再s1

    动态规划：

    1. dp[i][j] = 在s1[0:i] s2[0:j] 处交错组成的字符串是否存在s3的字串 s3[0:i+j]
    2.推导公式        len(s1[i]) + len(s2[j]) = len(s[3])

    判断是否在是s1[i] 处是相交需要看是dp[i-1][j]处是否相交且s[i-1] == s3[i+j-1]

    s2[j]  dp[i][j-1] 且s2[j-1] = s3[i+j-1] 

    

    dp[0][0] = True 表示取空 可以生成s3中的空
    2. 递推公式： 
    """
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        
        
        #dp = [[False] * (len(s2)+1) for _ in range(len(s1)+1)]
        len1 = len(s1)
        len2 = len(s2)
        len3 = len(s3)
        if len1 + len2 != len3:
            return False
            
        dp=[[False]*(len2+1) for _ in range(len1+1)]
        dp[0][0] = True

        # 初始化行列
        # print(dp)
        for i in range(1, len(s2)+1):  # 第一行
            if s2[i-1] == s3[i-1]:
                dp[0][i] = dp[0][i-1]
        # print(dp, "初始化第一行")
        for i in range(1, len(s1)+1 ):  # 第一列
            if s1[i-1] == s3[i-1]:
                dp[i][0] = dp[i-1][0]
    
        for i in range(1, len(s1)+1):
            for j in range(1, len(s2)+1):
                if s1[i-1] == s3[i+j-1]:
                    dp[i][j] = dp[i-1][j]
                if s2[j-1] == s3[i+j-1]:
                    dp[i][j] = dp[i][j] or dp[i][j-1]
        return dp[-1][-1]

```

# 动态规划问题



- dp 数组的定义以及下标的含义dp\[i\]\[j\]

- 递推公式

- dp数组如何初始化
- 遍历顺序
- 打印dp数组

## 动态规划解决斐波那契数

1. dp数组下标以及含义dp\[i\]， 第i个斐波那契数，dp\[i\]表示第i个斐波那契数值
2. 递推公式dp\[i] = dp\[i-1\]  +  dp\[i-1\]

3. 初始化：dp\[0] = 1 dp\[1\] = 1
4. 遍历顺序：从前向后
5. 打印dp数组

```python
def fibonc(n):
    dp = [1, 1]
    #dp[0], dp[1] = 1, 1
    if n ==0 or n ==1:
        return 1
    i = 2
    while i <=n:

        dp.append(dp[i-1] + dp[i-2])
        i+=1
    return dp[i-1]


if __name__ == "__main__":
	fibonc(n)

```

## 动态规划解决上楼梯问题



> n阶台阶，一次可以上一阶或者两阶，到达第n阶有几种方法

1阶   1

2阶  2

3阶 3

4阶 5

动归五部曲

1. dp\[i\]  表示上到第i阶的所有方法
2. 递推公式： dp\[i\]  = dp\[i-1\]  + dp\[i-2\] 
3. 初始化：dp\[0\] = 0, dp[1]=1,  dp[2] = 2
4. 确定遍历顺序： 从头向后
5. 打印dp数组

```python
def solution(n):
    dp = [1, 2]
    if n ==1 or n ==2:
        return 1 if n==1 else 2
    i = 2
    while i <=n:
        dp.append(dp[i-1] + dp[i-2])
        i+=1
    return dp[n]

```



动态规划上楼梯进阶版

> n阶台阶，一次可以上1, ,2, 5 ，到达第n阶有几种方法

`此时状态方程为dp[i]=dp[i-`1] + dp[i-2] + dp[i-5] , 进一步转换dp[i] = dp[i] + dp[j], j in [1, 2, 5]`

dp[i] = dp[i] + dp[j] 由来是因为初始化的时候dp[i] 都为0 

```python
def solution(n):
	steps = [1, 2, 5]
    dp = [0] * n
    for i in range(1, n):
        for j in range(len(steps)):
            step = steps[i]
            if i < step:
                continue
            dp[i] = dp[i] + dp[j]
    return dp[n]
```

## 零钱兑换II-leetcode 518



> 给你一个整数数组 coins 表示不同面额的硬币，另给一个整数 amount 表示总金额。
>
> 请你计算并返回可以凑成总金额的硬币组合数。如果任何硬币组合都无法凑出总金额，返回 0 。
>
> 假设每一种面额的硬币有无限个。

**由于题目要求时求组合数，所以要先遍历物品，再遍历背包， 如果先遍历背包再遍历物品是排列问题**

```python
class Solution:
    def change(self, amount: int, coins: List[int]) -> int:

        """
        dp 当第个时的组合数
        dp[i] = dp[i] + dp[i-1]
        类似于上n 阶台阶， 每次能上[1, 3, 4, 5,]阶，由此推导过来
       
        """

        dp = [0] * (amount+1)
        dp[0] = 1

        for conin in coins:
            for i in range(conin, amount+1):
                dp[i]  += dp[i-conin]
        print(dp)
        return dp[-1]
```

## 零钱兑换-leetcode 322

```
后续补充
```



## 不同路径问题 - leetcode 62



> 一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为 “Start” ）。
>
> 机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为 “Finish” ）。
>
> 问总共有多少条不同的路径？



![路径问题](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221124163848466.png)

```python
class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        # dp[i][j] 在ij位置处的所有路径

        # dp[i][j] = dp[i-1][j] + dp[i][j-1]

        dp = [[1]* n ] + [[1] + [0]*(n-1) for _ in range(m-1)]  # m行 n 列

        for i in range(1, m):
             for j in range(1, n):
                 dp[i][j] = dp[i-1][j] + dp[i][j-1]
        return dp[-1][-1]

```

## 动态规划解决 0-1背包问题



0-1背包， n种物品，每种物品只有一个

完全背包，n种物品，每种物品有无限个

多重背包，n种物品，每种物品个数各不相同



> 01背包
>
> 背包问题含义是N个物品，容量V背包，每件物品仅用一次
>
> 
>
> 有 N件物品和一个容量是 V的背包。每件物品只能使用一次。
>
> 第 i 件物品的体积是 vi，价值是wi。
>
> 求解将哪些物品装入背包，可使这些物品的总体积不超过背包容量，且总价值最大。
> 输出最大价值。



![0-1背包](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221124163942139.png)

动归五部曲：

1. 定义dp数组以及含义dp\[i\]\[j\]   0-i之间的物品任取， 放进容量为j的背包里

2. 递推公式： 不放物品i   dp\[i-1\]\[j\]  放物品i dp[i-1]\[j-weigh(i)\]+ value[i]
3. 初始化dp数组， 



|       | 重量 | 价值 |
| ----- | ---- | ---- |
| 物品0 |      |      |
| 物品1 |      |      |
| 物品2 |      |      |



```python
def solution():

    """
    设定dp数组： dp[i][j] 第i个物品放入容量为j的背包中的最大价值

    推导公式： 当v[i]>j 不放 的dp[i][j] = dp[i-1][j]
                当v[i]<j, 放入，max(dp[i][j] = dp[i-1][j-v[i]] + w[i], dp[i][j]=dp[i-1][j])

    初始化dp数组：当容量为0时，不论物品，最大价值为0
                 当物品为0时，不论背包容量，最大价值为0


    """

    c = 10
    w = [3, 4, 5, 7]
    v = [1, 5, 6, 9]
    n = len(w)

    # 初始化dp数组， n * c 的数组
    dp = [[0]*(c+1) for _ in range(n+1)]

    w.insert(0, 0)
    v.insert(0, 0)
    print(dp)
    for i in range(1, n+1):  # 物体编号
        for j in range(1, c+1):  # 背包容量

            if w[i] <= j:
                dp[i][j] = max(dp[i-1][j], dp[i-1][j-w[i]] + v[i])

            else:
                dp[i][j] = dp[i-1][j]

    print(dp[n][c])
if __name__ == "__main__":

    solution()


                                                                      
```

## 动态规划解决矩阵最小路径之和





>  给定一个矩阵m，从左上角开始每次只能向右走或者向下走，最后达到右下角的位置，路径中所有数字累加起来就是路径和，返回所有路径的最小路径和，如果给定的m如下，那么路径1,3,1,0,6,1,0就是最小路径和，返回12. 



```python
def solution(in_matrix):

    """
    定义dp数组； dp[i][j] 表示从出发点（0，0） 到（i, j）的最短路径为dp[i][j]

    推到公式： 向下走 dp[i][j] = min(dp[i-1][j] + , dp[i][j-11]) + p[i][j]
    初始化dp数组: 当上面为边界时， 值只能从左边来， 当做为边界时，值只能从上边来
    循环方向： 从小到大

    """
    m = len(in_matrix)   # 行数
    n = len(in_matrix[0]) # 列数

    for mm in range(1, m): # 上边界
        in_matrix[mm][0]  += in_matrix[mm-1][0]


    for nn in range(1, n):  # 右边界
        in_matrix[0][nn] += in_matrix[0][nn-1]



    for i in range(1, m):
        for j in range(1, n):
            in_matrix[i][j] = min(in_matrix[i-1][j], in_matrix[i][j-1]) + in_matrix[i][j]


    return in_matrix[m-1][n-1]
if __name__ == "__main__":

    p = [
        [1,3,1],
        [1,5,1],
        [4,2,1]
      ]

    print(solution(p))



```

## 动态规划解决最小路径和经过的路径





```
后续补充
```

## 动态规划解决最长回文字串问题



>  给你一个字符串 `s`，找到 `s` 中最长的回文子串 

- 回文串，去除头尾依旧是回文串



动归五步曲

1. d[i]\[j\]    表示下标为i, 和下标为j 是否为回文字串
2. 递推公式 d[i]\[j\] = True , 则d[i+1]\[j-1\] =True & s[i] = s[j]
3. 初始化对角线元素（即元素相同时，一定事回文串）
4. 遍历顺序，由i+1 是下一行，j-1是上一列，所以i,j 的状态转移依赖做下，所以填表要按照列填
5. 打印dp

```python
def solution(s):

    """

    推到公式：dp[i][j] = True  <====> s[j] == s[j]  and (dp[i+1][j-1]= True or j-i <3)
                                     

    初始化dp数组: 全部初始化为false， 对角线初始化为true
    循环方向：因为dp[i][j] 依赖于左下的元素，所以循环方向 从小到大， 从列到行

    """
    if len(s) <2:
        return len(s)


    begin = 0
    max_len = 0
    dp = [[False] *len(s) for _ in range(len(s))]
    for i in range(len(s)):
        dp[i][i] = True
    print(dp)

    # 循环属  
    for j in range(1, len(s)):
        for i in range(0, i):
            if s[i] == s[j]:
                if j-i<3:
                   dp[i][j] = True

                else:
                    dp[i][j] = dp[i+1][j-1]

            else:
                dp[i][j] = False

            current = j-i+1
            if dp[i][j] and current > max_len:
                max_len = current
                begin = i
    return s[begin: begin+max_len]




if __name__ == "__main__":

    p = "babab"
    print(solution(p), "结果")

```

## 动态规划解决分割数组问题



> 给你一个 **只包含正整数** 的 **非空** 数组 `nums` 。请你判断是否可以将这个数组分割成两个子集，使得两个子集的元素和相等。 

​	

该题等价于， 给你len(nums) 物品，每次从nums中取一个数，是否恰好存在取到的数字和恰好等于数组和的一一半。0-1背包问题



动归五步曲：

1. 定义dp数组  dp[i]\[j\], 表示从数组的0-ii下标中选取若干个数，是否存在一种选取方案，使得被选取数之和恰好等于j

初始时，dp中的所有元素都为false

2. 递推公式： 对于nums[i]      如果选取  dp[i, j] = dp[i-1]\[j\]， 如果不选去 dp[i]\[j\] = dp[i-1]\[j-nums[i]\]

3. 初始化 寻找边界 考虑，如果不取任何数，则被选取的正整数=0， 所以对于所有的d[i]\[0\] = True, 当i == 0时， 只有nums[0]被选取，dp[0]\[nums\[0]\] =  true

4. 确定打印顺序

   

   ```python
   待补充
   ```

# 回溯法

## 组合问题

### 回溯解决组合问题-leetcode77

>  给定两个整数 n 和 k，返回 1 … n 中所有可能的 k 个数的组合 

**改变起始点剪枝**

```python
class Solution:
    def combine(self, n: int, k: int) -> List[List[int]]:

        result = list()
        path = list()

        def backtracking(path, depth, startindex):

            if depth == k:
                result.append(path[:])
                return

            for i in range(startindex, n+1):
                # 同层之间为[1, n]， 起始点每次加1 所以同层肯定不会重复
                path.append(i)
                backtracking(path, depth +1, i +1)   # 数[1, n]为不重复的数字，所以 i+1 坑定不会重复
                path.pop()
        backtracking(path, 0, 1)
        return result
```

### 回溯解决组合总和I（无重复元素，同一元素可以多次选取）leetcode 39

>给你一个 无重复元素 的整数数组 candidates 和一个目标整数 target ，找出 candidates 中可以使数字和为目标数 target 的 所有 不同组合 ，并以列表形式返回。你可以按 任意顺序 返回这些组合。
>
>candidates 中的 同一个 数字可以 无限制重复被选取 。如果至少一个数字的被选数量不同，则两种组合是不同的。 
>
>对于给定的输入，保证和为 target 的不同组合数少于 150 个。

**改变起始点剪枝， 同一元素多次拿取， 剪枝时需要包含自身**

```python
class Solution:
    """
    注意： 每次向后取，所以要记住上一次的起始位置，所以有startindex
    backtracking(path, depath +1, i, total_num) , 应为可以重复放置元素，所以此时startindex为i， 不需要+1
    """
    def combinationSum(self, candidates: List[int], target: int) -> List[List[int]]:
        
        result = list()
        path = list()

        def backtracking(path, depath, startindex, total_num):
            if total_num > target:
                return
            
            if total_num == target:
                result.append(path[:])
                return 
            
            for i in range(startindex, len(candidates)):
                total_num += candidates[i]
                path.append(candidates[i])
                backtracking(path, depath +1, i, total_num) 

                path.pop()
                total_num -= candidates[i]

        backtracking(path, 0,0, 0)
        return result
```

### 回溯法解决组合总和II （有重复元素， 同一元素不可多次选取）-letcode 40

> 给定一个候选人编号的集合 candidates 和一个目标数 target ，找出 candidates 中所有可以使数字和为 target 的组合。
>
> candidates 中的每个数字在每个组合中只能使用 一次 。
>
> 注意：解集不能包含重复的组合。 

**改变起始点， 同层重复元素剪枝**

```python
class Solution:
    """
    注意： 1. 给定的candidates 有重复的元素， 题目要求解集不能包好重复的元素，此时需要对原来的数组排序，然后通过判断i-1 进行剪枝，防止重复
    
    """
    def combinationSum2(self, candidates: List[int], target: int) -> List[List[int]]:
        result = list()
        path = list()
        candidates.sort()
        def backtracking(startindex, total_num):

            if target == total_num:
                result.append(path[:])
                return
            if total_num > target:
                return
            
            for i in range(startindex, len(candidates)):
                if i > startindex and candidates[i] == candidates[i-1]:
                    continue
                path.append(candidates[i])
                total_num += candidates[i]
                backtracking(i+1, total_num)
                path.pop()
                total_num -= candidates[i]
        backtracking(0, 0)

        return result

```

### 回溯法解决组合总和III（无重复， 每个元素不可多次选取）-leetcode 216

> 找出所有相加之和为 n 的 k 个数的组合，且满足下列条件：
>
> 只使用数字1到9
> 每个数字 最多使用一次 
> 返回 所有可能的有效组合的列表 。该列表不能包含相同的组合两次，组合可以以任何顺序返回。

**改变起始位置进行剪枝**

```python
class Solution:
    def combinationSum3(self, k: int, n: int) -> List[List[int]]:

        result = list()
        path = list()
        def backtracking(startindex, total_num):

            if total_num > n or len(path) > k:
                return
            elif total_num == n and  len(path) == k:
                result.append(path[:])
                return
    
            for i in range(startindex, 10):

                path.append(i)
                total_num += i
                backtracking(i+1, total_num)
                path.pop()
                total_num -= i
        backtracking(1, 0)

        return result
```

## 分割问题

### 回溯法解决分割回文串(for 循环里切分字符串)-leetcode 131

>给你一个字符串 `s`，请你将 `s` 分割成一些子串，使每个子串都是 **回文串** 。返回 `s` 所有可能的分割方案。
>
>**回文串** 是正着读和反着读都一样的字符串。

**改变起始位置，依据回文串的特点剪枝，注意需要切割**

```python
class Solution:
    def partition(self, s: str) -> List[List[str]]:

        result = list()
        path = list()

        def backtracking(startindex, path):

            if startindex == len(s):
                result.append(path[:])
                return

            for i in range(startindex, len(s)):
                ch = s[startindex: i+1]
                if ch == ch[::-1]:
                    path.append(s[startindex: i+1])
                    backtracking(i+1, path)
                    path.pop()
                else:
                    continue
        backtracking(0, path)
        return result
                
```

### 拆分字符串使唯一子字符串的数目最大 - leetcode 1593

> 给你一个字符串 s ，请你拆分该字符串，并返回拆分后唯一子字符串的最大数目。
>
> 字符串 s 拆分后可以得到若干 非空子字符串 ，这些子字符串连接后应当能够还原为原字符串。但是拆分出来的每个子字符串都必须是 唯一的 。
>
> 注意：子字符串 是字符串中的一个连续字符序列。



```python
class Solution:
    max_num = 0
    def maxUniqueSplit(self, s: str) -> int:
        path = list()
        result = list()
        def backtracking(startindex, path):
            if startindex == len(s):
                result.append(path[:])
                if self.max_num < len(path):
                    self.max_num = len(path)
                    return
            for i in range(startindex, len(s)):
                ch = s[startindex: i+1]

                if ch in path:
                    continue
                # if i + 1 == len(s) -1 and len(path) + 1 < max_len:
                #     continue
                path.append(ch)
                backtracking(i+1, path)
                path.pop()

        backtracking(0, path)
        return self.max_num
```

### 单词拆分（困难leetcode140）



```
后续补充
```

## 子集问题

### 子集-leetcode 78

> 给你一个整数数组 `nums` ，数组中的元素 **互不相同** 。返回该数组所有可能的子集（幂集）。
>
> 解集 **不能** 包含重复的子集。你可以按 **任意顺序** 返回解集。

```python
class Solution:
    def subsets(self, nums: List[int]) -> List[List[int]]:
        result = []
        path = list()

        def backtracing(startindex, path):
            result.append(path[:])
            for i in range(startindex, len(nums)):

                path.append(nums[i])
                backtracing(i +1, path)

                path.pop()

        backtracing(0, path)
        
        return result
```

### 子集II-leetcode 90 (同层通过排序后和前一个对比进行剪枝)

> 给你一个整数数组 nums ，其中可能包含重复元素，请你返回该数组所有可能的子集（幂集）。
>
> 解集 不能 包含重复的子集。返回的解集中，子集可以按 任意顺序 排列。

```python
class Solution:
    def subsetsWithDup(self, nums: List[int]) -> List[List[int]]:

        result = list()
        tmp = list()
        nums.sort()
        def backtracking(startindex):
            result.append(tmp[:])
            for i in range(startindex, len(nums)):

                if i>startindex and nums[i] == nums[i-1]:
                    continue
                
                tmp.append(nums[i])
                backtracking(i+1)

                tmp.pop()
        backtracking(0)
        return result
```

### 递增子序列 (同层通过set剪枝)-leetcode 491

>
>
>给你一个整数数组 nums ，找出并返回所有该数组中不同的递增子序列，递增子序列中 至少有两个元素 。你可以按 任意顺序 返回答案。
>
>数组中可能含有重复元素，如出现两个整数相等，也可以视作递增序列的一种特殊情况

```python
class Solution:
    def findSubsequences(self, nums: List[int]) -> List[List[int]]:
        result = list()
        path = list()
        
        def backtracing(startindex, path):

            if len(path) >=2:
                result.append(path[:])
            repeat = set()
            for i in range(startindex, len(nums)):

                if len(path) > 0 and path[-1] > nums[i]:
                    continue
                if nums[i] not in repeat:
                    path.append(nums[i])
                    repeat.add(nums[i])
                    backtracing(i+1, path)
                    path.pop()
                    # repeat.remove(nums[i])
        backtracing(0, path)
        return result

```

## 排列问题

### 全排列(回溯法吧标准模板)-leetcode 46



>  给定一个不含重复数字的数组 `nums` ，返回其 *所有可能的全排列* 。你可以 **按任意顺序** 返回答案 

**全排列问题，循环从0开始到len(nums)结束， 通过维护在每一层每个元素的使用情况来进行剪枝**

**不包含重复元素**

```python
class Solution:
    def permute(self, nums: List[int]) -> List[List[int]]:

        result = list()
        path = list()
        nums.sort()
        def backtracking(path, depth, used):

            if depth == len(nums):
                result.append(path[:])
                return
            
            for i in range(0, len(nums)):
                if used[i]:
                    continue
                used[i] = True
                path.append(nums[i])
                backtracking(path, depth +1, used)
                used[i] = False
                path.pop()
        backtracking(path, 0, {index_: False for index_, _ in enumerate(nums)})
        return result
```

### 全排列II-leetcode 47



>  给定一个可包含重复数字的序列 `nums` ，***按任意顺序*** 返回所有不重复的全排列。 

**通过维护每个元素使用情况，对同层元素进行剪枝，避免同层多次选取，由于给定的元素有可能有重复，需要通过排序和下标状态进行剪枝**

```python
class Solution:
    def permuteUnique(self, nums: List[int]) -> List[List[int]]:
        nums.sort()
        result = list()
        path = list()

        def backtracking(path, used):
            
            if len(path) == len(nums):
                result.append(path[:])
                return
            for i in range(0, len(nums)):
                if used.get(i, False):
                    continue
                if i > 0 and nums[i] == nums[i-1] and not used.get(i-1, False):
                     continue
                path.append(nums[i])
                used[i] = True
                backtracking(path, used)
                path.pop()
                used[i] = False
        backtracking(path, { k: False for k in range(0, len(nums))})
        return result
```

### 字符串的排列-剑指offer38

> 输入一个字符串，打印出该字符串中字符的所有排列。
>
> 你可以以任意顺序返回这个字符串数组，但里面不能有重复元素。

```python
class Solution:
    def permutation(self, s: str) -> List[str]:

        result = list()
        path = list()
        tmp = [ss for ss in s]
        tmp.sort()
        s = "".join(tmp)


        def backtracing(startindex, depth, path, used):

            if len(path) == len(s):
                result.append("".join(path))
                return
            for i in range(0, len(s)):

                if i >0 and s[i] == s[i-1] and not used[i-1]:
                    continue
                if used[i]:
                    continue
                used[i] = True
                path.append(s[i])
                backtracing(i+1, depth+1, path, used)
                path.pop()
                used[i] = False

        backtracing(0 , 0, path, {index_: False for index_, _ in enumerate(s)})
        return result

```

### 优美的排列-leetcode 526



>
>
>假设有从 1 到 n 的 n 个整数。用这些整数构造一个数组 perm（下标从 1 开始），只要满足下述条件 之一 ，该数组就是一个 优美的排列 ：
>
>perm[i] 能够被 i 整除
>i 能够被 perm[i] 整除
>给你一个整数 n ，返回可以构造的 优美排列 的 数量 。

```python
class Solution:
    def countArrangement(self, n: int) -> int:
        result = list()
        path = list()

        def backtracking(path, used):
            if len(path) == n:
                result.append(path[:])
                return
            
            for i in range(1, n +1):
                if used.get(i, False):
                    continue
                path.append(i)
                if path[-1] % len(path)==0 or len(path) % path[-1] == 0:
                    used[i] = True
                    backtracking(path, used)
                    

                path.pop()
                used[i] = False
        backtracking(path, {})
        print(result)
        return len(result)

```

## 棋盘问题

### N皇后I -leetcode 51

> 按照国际象棋的规则，皇后可以攻击与之处在同一行或同一列或同一斜线上的棋子。
>
> n 皇后问题 研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。
>
> 给你一个整数 n ，返回所有不同的 n 皇后问题 的解决方案。
>
> 每一种解法包含一个不同的 n 皇后问题 的棋子放置方案，该方案中 'Q' 和 '.' 分别代表了皇后和空位。
>
> 

```python
class Solution:
    def solveNQueens(self, n: int) -> List[List[str]]:
        if not n: return []
        board = [['.'] * n for _ in range(n)]
        res = []
        def isVaild(board,row, col):
            #判断同一列是否冲突
            for i in range(len(board)):
                if board[i][col] == 'Q':
                    return False
            # 判断左上角是否冲突
            i = row -1
            j = col -1
            while i>=0 and j>=0:
                if board[i][j] == 'Q':
                    return False
                i -= 1
                j -= 1
            # 判断右上角是否冲突
            i = row - 1
            j = col + 1
            while i>=0 and j < len(board):
                if board[i][j] == 'Q':
                    return False
                i -= 1
                j += 1
            return True

        def backtracking(board, row, n):
            # 如果走到最后一行，说明已经找到一个解
            if row == n:
                temp_res = []
                for temp in board:
                    temp_str = "".join(temp)
                    temp_res.append(temp_str)
                res.append(temp_res)
            for col in range(n):
                if not isVaild(board, row, col):
                    continue
                board[row][col] = 'Q'
                backtracking(board, row+1, n)
                board[row][col] = '.'
        backtracking(board, 0, n)
        return res

    
    
class Solution:
    def solveNQueens(self, n: int) -> List[List[str]]:
        if not n:
            return []
        board = [["."]*n for _ in range(n)]  #初始化棋盘
        res = []
        # 判断该点是否可以放置Q
        def isValid(board, row, col):

            # 判断同一列是否满足
            for i in range(len(board)):
                if board[i][col] == "Q":
                    return False

            # 判断左上角是否满足
            i = row -1
            j = col -1

            while i >=0 and j >=0:
                if board[i][j] == "Q":
                    return False
                i -= 1
                j -= 1

            # 判断右上是否满足
            i = row -1
            j = col +1

            while i >=0 and j< len(board):
                if board[i][j] == "Q":
                    return False
                i -= 1
                j += 1
            return True

        def backtracing(board, row, n):

            if row == n:
                tmp_res = list()
                for temp in board:
                    tmp_res.append("".join(temp))
                res.append(tmp_res[:])
            	return
            for col in range(n):
                if not isValid(board, row, col):
                    continue

                board[row][col] = "Q"
                backtracing(board, row+1, n)
                board[row][col] = "."
        backtracing(board, 0, n)
        return  res

```

### N皇后II-leetcode 52

> n 皇后问题 研究的是如何将 n 个皇后放置在 n × n 的棋盘上，并且使皇后彼此之间不能相互攻击。
>
> 给你一个整数 n ，返回 n 皇后问题 不同的解决方案的数量。

**本质和N皇后I一样，只不过这个时需要求个数**

```python
class Solution:
    num = 0
    def totalNQueens(self, n: int) -> int:
        if not n:
            return self.num     
        board = [["."] * n for _ in range(n)]
        def isValid(board, row, col):

            """
            判断该点是否可以放置
            """
            # 判断每一列
            for i in range(n):
                if board[i][col] == "Q":
                    return False          
            # 判断左上
            i, j = row-1, col-1

            while i >=0 and j>=0:

                if board[i][j] == "Q":
                    return False
                i -= 1
                j -= 1
            # 判断右上
            i, j = row -1, col + 1
            while i >=0 and j <n:

                if board[i][j] == "Q":
                    return False
                i -= 1
                j += 1
            return True
        def backtracing(board, row, n):

            if  row == n:
                self.num += 1
            for col in range(n):
                if not isValid(board, row, col):
                    continue
                board[row][col] = "Q"
                backtracing(board, row+1, n)
                board[row][col]  = "."
        backtracing(board, 0, n)  
        return self.num

```

## 剪枝技巧总结



总结不完整，后续重新总结

-  一般对数组有要求，必须是有序数组，这点需要保证 

-  标志位 子集II是个例子， 使用标志位used[i]= True or Fasle 进行同层剪枝，使得用过的元素不会重复使用
-  规定起始点
   - 可以重复选择同一个元素，只需要更新起始点就可以了，使得起始点> 上一次使用的索引就可以了。例如leetcode 39
   - 不可以使用重复元素，需要不断更新起始点才可以完成剪枝，例如leetcode 子集
-  跨层剪枝： 全排列ii， 必须传递标志位

# 贪心问题

## 分发饼干-leetcode 455

> 假设你是一位很棒的家长，想要给你的孩子们一些小饼干。但是，每个孩子最多只能给一块饼干。
>
> 对每个孩子 i，都有一个胃口值 g[i]，这是能让孩子们满足胃口的饼干的最小尺寸；并且每块饼干 j，都有一个尺寸 s[j] 。如果 s[j] >= g[i]，我们可以将这个饼干 j 分配给孩子 i ，这个孩子会得到满足。你的目标是尽可能满足越多数量的孩子，并输出这个最大数值。

**这里的贪心策略是，给剩余孩子里最小饥饿度的孩子分配最小的能饱腹的饼干**



```python
class Solution:
    def findContentChildren(self, g: List[int], s: List[int]) -> int:
        """
        给胃口值为g[i]的孩子分配大小为s[j]的饼干，如果饼干过小，那么寻找下一块饼干，直到找到为止
        """
        g.sort()
        s.sort()
        num = 0
        i = j = count = 0

        while i < len(g) and j <len(s):
            while j < len(s) and g[i] > s[j]:
                j += 1

            if j < len(s):
                count += 1

            j += 1
            i += 1
        return count
 

```

## 分发糖果-leetcode 135

> n 个孩子站成一排。给你一个整数数组 ratings 表示每个孩子的评分。
>
> 你需要按照以下要求，给这些孩子分发糖果：
>
> 每个孩子至少分配到 1 个糖果。
> 相邻两个孩子评分更高的孩子会获得更多的糖果。
> 请你给每个孩子分发糖果，计算并返回需要准备的 最少糖果数目 。

```python
class Solution:
    def candy(self, ratings: List[int]) -> int:
        """
        相邻分为左相邻和有相邻
        左相邻规则, 如果i < i+1, 则grade[i+1] = grade[i] +1, 否则， 分配一颗糖果
        右相邻规则：
        """
        nums = [1] * len(ratings)
        
        for i in range(len(ratings) -1):
            
            if ratings[i] < ratings[i+1]:
                nums[i+1] = nums[i] +1
        for i in range(-1, -len(ratings)+1-1, -1):
            if ratings[i] < ratings[i-1]:
                nums[i-1] = max(nums[i]+1, nums[i-1])
        return sum(nums)

```

## 无重叠区间-leetcode 435

> 给定一个区间的集合 intervals ，其中 intervals[i] = [starti, endi] 。返回 需要移除区间的最小数量，使剩余区间互不重叠 。

```python
class Solution:
    def eraseOverlapIntervals(self, intervals: List[List[int]]) -> int:

        """
        在选择要保留区间时，区间的结尾十分重要：选择的区间结尾越小，余留给其他区间的空间就越大，就能保留更多的区间。因此，我们采取的贪心策略为，优先保留结尾小且不相交的区间
        """
        intervals = sorted(intervals, key = lambda x: (x[1],x[0]))
        print(intervals)
        i = del_num = 0
        temp = list()

        while  i < len(intervals)-1:
            if i == 0:
                temp.append(intervals[0])
    
            pre_end = temp[-1][1]
            nex_start=intervals[i+1][0]
            if nex_start < pre_end:
                del_num +=1
                i + 1 
            else:
                temp.append(intervals[i+1])
            i += 1
        return del_num
```

## 跳跃游戏-leetcode 55

```python
class Solution:
    def canJump(self, nums: List[int]) -> bool:
        """
        由于每层最多可以跳A[i]步，也可以跳0步或1步，因此如果能到达最高层，则说明每一层都可以到达。有了这个条件，说明可以用贪心算法
        正向，从0出发，一层一层往上跳，看到最后能不能超过最高层，能超过则说明能到达，否则不能到达
        """
        """
          0  1  2  3  4
        [ 2, 3, 1, 1, 4]
        """
        # 维护最远下标
        last_index = 0
        for i in range(len(nums)):
            if i <= last_index:
                last_index = max(last_index, i + nums[i])
            if last_index >= len(nums) -1:
                return True
        return False
```

## 跳跃游戏II-leetcode 45

> 给你一个非负整数数组 nums ，你最初位于数组的第一个位置。
>
> 数组中的每个元素代表你在该位置可以跳跃的最大长度。
>
> 你的目标是使用最少的跳跃次数到达数组的最后一个位置。
>
> 假设你总是可以到达数组的最后一个位置。

**我们维护当前能够到达的最大下标位置，记为边界。我们从左到右遍历数组，到达边界时，更新边界并将跳跃次数增加 1 **

```python
class Solution:
#     def jump(self, nums: List[int]) -> int:
#         """
#         定义dp数组 dp[i] 表示在i 位置处的最小跳跃次数
#         递推公式： dp[i]= min(dp[i], dp[j] +1)
#         动态规划会超时
#         """
#         size = len(nums)
#         dp = [float("inf") for _ in range(size)]
#         dp[0] = 0

#         for i in range(1, size):
#             for j in range(i):
#                 if j + nums[j] >= i:
#                     dp[i] = min(dp[i], dp[j] + 1)

#         return dp[size - 1]
    def jump(self, nums: List[int]) -> int:
        """
        维护跳至每个下标的最小次数，则，跳至最后一个位置的次数就为最小
        """
        n = len(nums)
        max_pos = 0
        step = 0
        end = 0
        for i in range(n-1):
            if i<=max_pos:
                max_pos = max(max_pos, i + nums[i])
            if i == end:
                step += 1
                end = max_pos
        return step

```

## 股票买卖的最佳时机-leetcode 121

```python
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        """
        假设当天为最高点卖出，只要直到前面的最低点，就可以算法当前的最大利润
        """
        min_p = 0
        max_val = 0
        for i in range(len(prices)):
            if i == 0:
                min_p = prices[i]
                continue
            max_val = max(max_val, prices[i] - min_p)
            min_p = min(min_p, prices[i])
        return max_val
```

## 股票买卖的最佳时机II-leetcode 122

> 给你一个整数数组 prices ，其中 prices[i] 表示某支股票第 i 天的价格。
>
> 在每一天，你可以决定是否购买和/或出售股票。你在任何时候 最多 只能持有 一股 股票。你也可以先购买，然后在 同一天 出售。
>
> 返回 你能获得的 最大 利润 。



```python
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        """
        找到每一个上坡，相加就是最终的结果
        """
        ans = 0
        for i  in range(len(prices)-1):
            if prices[i+1] >prices[i]:
                ans += prices[i+1] - prices[i]
        return ans
```

