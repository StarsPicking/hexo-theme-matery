---
title: leetcode算法题II
author: 张大哥
top: false
cover: false
toc: true
mathjax: false
categories: 数据结构与算法
tags:
  - 算法题
  - leetcode
abbrlink: 45160
date: 2022-11-24 23:59:21
img:
coverImg:
summary: 数据结构算法不仅有用,更应该是每个程序员必须掌握的基本功 学习数据结构算法,可以大大拓宽我们的思维模式。掌握了数据结构与算法,我们看待问题的深度、解决问题的角度会大有不同,对于个人逻辑思维的提升,也是质的飞跃
---







# 前言

> 时间复杂度与空间复杂度分析作为数据结构与算法的第一课，看多少便都不过分，建议多看看，这里推荐两篇文章

- [保姆级教学！彻底学会时间复杂度和空间复杂度 (qq.com)](https://mp.weixin.qq.com/s?__biz=MzI0NjAxMDU5NA==&mid=2475918746&idx=1&sn=3fe42234a1f07fb084d11fe06fb24893&chksm=ff22e217c8556b019b9052f9d4805174385ba4c8c099216fa226dbd1b033a9a49782579e4b75&token=1996171232&lang=zh_CN#rd)
- [时间复杂度o(1), o(n), o(logn), o(nlogn) - 别先生 - 博客园 (cnblogs.com)](https://www.cnblogs.com/biehongli/p/11672380.html)



# 数组



> 数组是一种基础的**线性数据结构**，它是用**连续的一段内存空间，来存储相同数据类型**数据的集合
>
> 两个重点：
>
> - 连续内存空间
> - 相同数据类型

![image-20221130225923967](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221130225923967.png)



## 解决数组问题常用的双指针和快慢指针

{%r%}

 快慢指针是双指针的一种，快慢指针通常是从同侧开始

不强调是哪种类型的双指针，一般left 以左边为起始， right以右边为起始，两侧向中间靠拢的方式

{%endr%}

## [27.移除元素](https://leetcode.cn/problems/remove-element/)

>给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。



方法一： 双指针

```python
class Solution:
    def removeElement(self, nums: List[int], val: int) -> int:
        n = len(nums) -1
        left, right = 0, n
        while left <= right:
            if nums[left] == val:
                while left<= right <= n:
                    if nums[right] !=val:
                        nums[left], nums[right] = nums[right], nums[left]
                        print(left, right, nums)
                        break
                    else:
                        nums.pop()
                        right -= 1
            left += 1
```



方法二：快慢指针

```python
class Solution:
    def removeElement(self, nums: List[int], val: int) -> int:
        n = len(nums)
        left, right = 0, 0
        while right<n:
            if nums[right] != val:
                nums[left] = nums[right]
                left += 1
            right += 1
        return left
        

```

## [59. 螺旋矩阵 II](https://leetcode.cn/problems/spiral-matrix-ii/)

> 给你一个正整数 `n` ，生成一个包含 `1` 到 `n2` 所有元素，且元素按顺时针顺序螺旋排列的 `n x n` 正方形矩阵 `matrix` 。

![image-20221201011720285](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221201011720285.png)



```python
class Solution:
    def generateMatrix(self, n: int) -> List[List[int]]:

        left, right ,top, bottom  = 0, n-1, 0, n-1
        result = list()
        board = [["-"] * n for _ in range(n)]
        start = 1
        while left <= right and top<= bottom:
            
            for col in range(left, right+1):
                print(col)
                # result.append(start)
                board[top][col] = start
                start += 1
            for row in range(top+1, bottom):
                # result.append(start)
                board[row][right] = start
                start += 1

            if left < right:
                for col in range(right, left, -1):
                    # result.append(start)
                    board[bottom][col] = start
                    start += 1
            if top < bottom:
                for row in range(bottom, top, -1):
                    # result.append(start)
                    board[row][left] = start
                    start += 1
            left += 1
            right -= 1
            top += 1
            bottom -= 1
        return board

```

## [209. 长度最小的子数组](https://leetcode.cn/problems/minimum-size-subarray-sum/)



> 给定一个含有 n 个正整数的数组和一个正整数 target 。
>
> 找出该数组中满足其和 ≥ target 的长度最小的 连续子数组 [numsl, numsl+1, ..., numsr-1, numsr] ，并返回其长度。如果不存在符合条件的子数组，返回 0 。
>
> 



![image-20221201012100898](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221201012100898.png)



```python
class Solution:
    def minSubArrayLen(self, target: int, nums: List[int]) -> int:
        """
        滑动窗口
        """
        n = len(nums)

        left, right = 0, 0
        min_len = n+1
        total = 0
        while left <= right< n:
            total += nums[right]
            while left <= right and total>= target:
                min_len = min(right- left +1, min_len)
                print(min_len, right, left)
                total -= nums[left]
                left += 1
            right +=1
        return 0 if min_len == n+1 else min_len
```

## [977. 有序数组的平方](https://leetcode.cn/problems/squares-of-a-sorted-array/)

>给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。
>
> 
>
>示例 1：
>
>输入：nums = [-4,-1,0,3,10]
>输出：[0,1,9,16,100]
>解释：平方后，数组变为 [16,1,0,9,100]
>排序后，数组变为 [0,1,9,16,100]
>示例 2：
>
>输入：nums = [-7,-3,2,3,11]
>输出：[4,9,9,49,121]

双指针：

```python
class Solution:
    def sortedSquares(self, nums: List[int]) -> List[int]:
        """
        可以平方后归并排序
        这里采用双指针的方式
        """
        left, right, result = 0, len(nums)-1, []
        while left <= right:
            if nums[left] ** 2 < nums[right] ** 2:
                result.insert(0, nums[right]**2)
                right -= 1
            else:
                result.insert(0, nums[left]**2)
                left += 1
        return result

```



分类+合并有序列表：

```pythoon

class Solution:
    def sortedSquares(self, nums: List[int]) -> List[int]:

        # 分情况讨论
        neg = []
        non_neg = []
        for num in nums:
            if num < 0:
                neg.append(num * num)
            else:
                non_neg.append(num * num)
        neg.reverse()

        # 合并有序列表
        m, n = len(neg), len(non_neg)
        i = j = 0
        ans = []
        while i < m and j < n:
            if neg[i] < non_neg[j]:
                ans.append(neg[i])
                i += 1
            else:
                ans.append(non_neg[j])
                j += 1
        ans += neg[i:]
        ans += non_neg[j:]
        return ans

```





# 链表

## 链式结构的存储

![链式存储结构](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221130204840602.png)

- 用一种任意存储单元存储数据元素

- 各个存储单元在内存中可以不用连续
- 通过指针的形式链接起来



## 单项链表



- 多个节点相连
- 每个节点中包含一个指针域
- 单链表的指针域指向的是下一个节点的地址
- 把指向下个节点的指针叫做后继指针

![image-20221130205630113](C:\Users\zhangtq\AppData\Roaming\Typora\typora-user-images\image-20221130205630113.png)



- 单链表的第一个节点的存储位置叫做头指针，最后一个节点的后继指针为空

![image-20221130210123345](C:\Users\zhangtq\AppData\Roaming\Typora\typora-user-images\image-20221130210123345.png)



- 此外，有时候为了操作，我们会在第一个节点前面添加一个节点，称为头节点



![添加头节点的链表](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221130210704820.png)





- 头指针和和头节点

- > 头指针是指向链表第一个节点的指针，头指针在链表中必须存在，因为我们要通过头指针直到链表的位置在哪里
  >
  > 如果存在头节点，那么头指针就是指向头节点的指针，其实和上面一样，有头节点的话，第一个节点必是头指针

- > 头节点不具有实际意义，头节点中不存储数据元素，只是我们在删除或者插入时，为了统一头节点的操作专门设定的



## 单向链表的插入操作

- 单项链表插入操作



![单向链表插入](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221130212139357.png)



- 如上图，如果将t节点插入到s节点后需要
  - 将t节点的后继节点指向s节点的后继节点
  - 将s节点的后继节点指向节点t
- 单项链表的删除操作

![image-20221130213205047](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221130213205047.png)



- 由图可见，删除操作的本质其实是绕过要删除的节点，这里指t节点
- 具体操作是将节点s的后继指针指向节点t的后继指针

## 双向链表

- 双向链表，有两个方向，相对于单向链表，多了一个前驱指针prev,指向前驱节点
- 双向链表可以向前走，也可以向后

![双向链表](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221130223251256.png)



- 双向链表用了空间换时间，会更快

## 单项链表和双向链表操作对比

### 链表的插入的两种前置条件

- 在data域的某个特定值的节点前后插入新的节点

- 在给定的节点前后插入新的节点

- 针对第一种情况，两种链表的复杂度相近

    - 第一步显示表里链表找到值为特定值的节点，两种都是从头开始遍历复杂度O(n)

  ![找到特定值节点](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221130224227799.png)

  

    - 第二步是插入操作
      - 如果是向后插入，那么两种链表时间复杂度基本一直
      - 如果是向前插入，单链表慢，因为单链表还需要再遍历一次链表找到特定值节点的前驱节点这个时间又是O(n)，但是双向链表可以直接找到前驱节点

  ![image-20221130224740974](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221130224740974.png)

- 针对第二种情况，和第一种类似，已经知道节点的情况下如果向后插入，单链表和双链表没有区别 都是O(1)
- 针对第二种情况，如果向前插入，单链表需要循环链表，找到先找到前驱节点，而双向链表可以直接插入

### 两种链表的删除操作

### 两种前置条件

	- 在某个data域值等于特定值前后删除
	- 在某个节点前后删除

 - 对于情况一
   - 第一步，需要在data域值找到特定值节点，这一步两种链表相同
   - 如果是向前删除，那么单向链表需要再遍历一次链表，找到特定值节点的前驱节点，而双向链表可以直接删除
   - 如果是向后删除，两者时间复杂度相似
 - 针对情况二：
   - 如果是向前删除，单向链表需要遍历，找到前驱节点才可以删除，双向链表可以直接利用prev指针
   - 如果是向后删除，两者时间复杂度相似



## [19. 删除链表的倒数第 N 个结点](https://leetcode.cn/problems/remove-nth-node-from-end-of-list/)

> 给你一个链表，删除链表的倒数第 `n` 个结点，并且返回链表的头结点。

![image-20221201182026892](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221201182026892.png)



> ```
> 输入：head = [1,2,3,4,5], n = 2
> 输出：[1,2,3,5]
> ```



方法一：找到要删除的前驱节点，直接删除，注意处理第一个节点，认为添加一个头节点

```python
class Solution:
    def removeNthFromEnd(self, head, n: int):
        """
        倒数第n个节点，也就是删除正向的第len-n +1 个节点
        链表是没有len 方法的，需要先找到链表的长度
        为了让第一个节点能操作一致， 添加一个头节点
        new-head.next 为真正的头节点
        """

        dummary = ListNode(0, head)
        length = 0
        while head:
            head = head.next
            length += 1
        cur = dummary
        for i in range(1, length - n +1):
            cur = cur.next
        cur.next = cur.next.next
        return dummary.next

```



方法二：借助栈的特性

```python
class Solution:
    def removeNthFromEnd(self, head, n: int):
		"""
		利用找的特性
		则出栈找到要删除前N个节点，出栈
		此时，stack[-1] 即栈顶就是要删除的前驱节点
		找到前驱节点后，根据链表的删除方法，删除节点就可以了
		"""
        # 方法二， 借助栈
        dummy = ListNode(0, head)
        stack = list()
        cur = dummy
        while cur:
            stack.append(cur)
            cur = cur.next
        
        for i in range(n):
            stack.pop()
        
        # 前驱节点
        prev_node = stack[-1]

        prev_node.next = prev_node.next.next
        return dummy.next

```



## [24. 两两交换链表中的节点](https://leetcode.cn/problems/swap-nodes-in-pairs/)

> 给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改节点内部的值的情况下完成本题（即，只能进行节点交换）。





![image-20221201212729257](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221201212729257.png)

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def swapPairs(self, head):
        
        dummy = ListNode(0, head)
        cur = dummy
        while cur.next and cur.next.next:
            node1 = cur.next
            node2 = cur.next.next
            cur.next = node2
            node1.next = node2.next
            node2.next = node1
            cur = node1
        return dummy.next   
```

## [25. K 个一组翻转链表（需补充解题方法）](https://leetcode.cn/problems/reverse-nodes-in-k-group/)

> 给你链表的头节点 head ，每 k 个节点一组进行翻转，请你返回修改后的链表。
>
> k 是一个正整数，它的值小于或等于链表的长度。如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。
>
> 你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。
>



```python
pass
# 困难题，后续补充
```

## [141. 环形链表](https://leetcode.cn/problems/linked-list-cycle/)

> 给你一个链表的头节点 head ，判断链表中是否有环。
>
> 如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。注意：pos 不作为参数进行传递 。仅仅是为了标识链表的实际情况。
>
> 如果链表中存在环 ，则返回 true 。 否则，返回 false 。
>



![image-20221202013620665](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221202013620665.png)



```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    # 哈希set的方式
    def hasCycle(self, head: Optional[ListNode]) -> bool:
        viewed = set()

        while head:
            if head in viewed:
                return True
            viewed.add(head)
            head = head.next
        return False
    
    
    # 快慢指针
    def hasCycle(self, head: Optional[ListNode]) -> bool:
        if not head:
            return False
        slow = fast = head
        while fast.next and fast.next.next:
            slow = slow.next
            fast = fast.next.next
            if slow is fast:
                return True
        return False
```





## [142. 环形链表 II](https://leetcode.cn/problems/linked-list-cycle-ii/)

> 给定一个链表的头节点  head ，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。
>
> 如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。如果 pos 是 -1，则在该链表中没有环。注意：pos 不作为参数进行传递，仅仅是为了标识链表的实际情况。
>
> 不允许修改 链表。



- 数学推导+快慢指针法



![image-20221202142358917](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221202142358917.png)



{%y%}   

设链表的总长度为a+b ，其中a为头节点到入口处的距离，b为环形的长度

现在假设有两个人开始跑步，一个人的速度是另一个人的两倍，他们们在相遇点相遇，此时我们看看他们走过的距离关系

第一次相遇

1. 令slow的走过的距离为slow = s  --->fast = 2s
2.  由于是在环内相遇，可知fast一定是套圈slow了，且快的人比慢的人在圈里多跑了n圈，即nb, 由于慢的人走了s， 所有快的人走了fast = s + nb (具体n是几未知)
3.  有1式 减2可得s = nb
4. 可以再看， 每次经过入口点得距离k = a + nb
5. 由于s已经搜了nb步， 所以只需要再走a步就是入口点，如何得到a步呢

第二次相遇

	1. 由上面推导我们可得slow 再走a步就是入口点，
	1. 此时让快得人去起始点，保持和慢得人一致得速度，当两人相遇时，恰好走了a步

{%endy%}

```python
class Solution:
    
    def detectCycle(self, head: Optional[ListNode]) -> Optional[ListNode]:
        fast = slow = head
        if not head:
            return None
        while fast.next and fast.next.next:
            fast = fast.next.next  # 走两步
            slow = slow.next
            if fast is slow:  # 首次相遇:
                fast = head
                while fast is not slow:
                    fast = fast.next
                    slow = slow.next
                    #if fast is slow:
                    #    return slow
                return fast
        return None

```



## [160. 相交链表](https://leetcode.cn/problems/intersection-of-two-linked-lists/)

> 给你两个单链表的头节点 headA 和 headB ，请你找出并返回两个单链表相交的起始节点。如果两个链表不存在相交节点，返回 null 。
>
> 图示两个链表在节点 c1 开始相交：





![image-20221202201030405](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221202201030405.png)



> 题目数据 保证 整个链式结构中不存在环。
>
> 注意，函数返回结果后，链表必须 保持其原始结构 。
>
> 自定义评测：
>
> 评测系统 的输入如下（你设计的程序 不适用 此输入）：
>
> intersectVal - 相交的起始节点的值。如果不存在相交节点，这一值为 0
> listA - 第一个链表
> listB - 第二个链表
> skipA - 在 listA 中（从头节点开始）跳到交叉节点的节点数
> skipB - 在 listB 中（从头节点开始）跳到交叉节点的节点数
> 评测系统将根据这些输入创建链式数据结构，并将两个头节点 headA 和 headB 传递给你的程序。如果程序能够正确返回相交节点，那么你的解决方案将被 视作正确答案 。



![image-20221202201321823](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221202201321823.png)



- 采用hash 表的方式，看是否存在hash表中

```python
class Solution:
    def getIntersectionNode(self, headA: ListNode, headB: ListNode) -> Optional[ListNode]:

        viewed = set()

        while headA:
            viewed.add(headA)
            headA = headA.next
        while headB:
            if headB in viewed:
                return headB
            headB = headB.next
        return None
```



## [143. 重排链表](https://leetcode.cn/problems/reorder-list/)

> 给定一个单链表 L 的头节点 head ，单链表 L 表示为：
>
> L0 → L1 → … → Ln - 1 → Ln
> 请将其重新排列后变为：
>
> L0 → Ln → L1 → Ln - 1 → L2 → Ln - 2 → …
> 不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。
>



![image-20221202143938115](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221202143938115.png)



方法一： 栈+ 计算中间节点得前驱节点+链表原地插入

```python
class Solution(object):
    def reorderList(self, head):
        """
        :type head: ListNode
        :rtype: None Do not return anything, modify head in-place instead.
        """
        if not head: return None        
        stack = []
        cur = head
        while cur:
            stack.append(cur)
            cur = cur.next

        n = len(stack)

        middle = (n-1) //2
        cur = head
        while middle:
            tmp = stack.pop()

            # 将栈中得元素插入到head中
            tmp.next = cur.next
            cur.next = tmp
            cur = cur.next.next
            middle -= 1
        stack.pop().next = None

```



方法二：反转链表 + 链表中点 + 链表拼接

```python
class Solution(object):
    def reorderList(self, head):
        """
        :type head: ListNode
        :rtype: None Do not return anything, modify head in-place instead.
        """
        if not head or not head.next:
            return head
        def middle_node(head):
            slow = fast = head
            while fast.next and fast.next.next:
                slow = slow.next
                fast = fast.next.next
            return slow

        def reverse_link(head):
            """
            原地逆置法
            初始化两个三个指针，一个指向头节点，一个指向第一个节点，一个指向第二个节点
            """
            beg= head
            end = head.next
            while end:
                beg.next = end.next
                end.next = head
                head = end
                end = beg.next
            return head

        def mergeList(l1, l2):
            while l1 and l2:
                l1_next = l1.next
                l2_next = l2.next

                l1.next = l2
                l1 = l1_next

                l2.next = l1
                l2 = l2_next

        node = middle_node(head)
        right = node.next #右半部链表
        node.next = None  # 注意一定要断链

        # 逆置链表
        right = reverse_link(right)
        # 合并两个链表
        mergeList(head, right)
```



## [876. 链表的中间结点](https://leetcode.cn/problems/middle-of-the-linked-list/)



> 给定一个头结点为 `head` 的非空单链表，返回链表的中间结点。
>
> 如果有两个中间结点，则返回第二个中间结点。



## 常见反转链表的方法



### 头插法

- 所谓头插法，是指在原有链表的基础上，依次将位于链表头部的节点摘下，然后采用从头部插入的方式生成一个新链表，则此链表即为原链表的反转版

![image-20221201234143662](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221201234143662.png)



- 新建一个头指针指向空的节点
- 将原链表的节点插入新节点的头部
- 重复上面操作，每次插入头部，这样最终就实现了逆置



```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseList(self, head: Optional[ListNode]) -> Optional[ListNode]:

        """
        头插法
        原地逆置法
        """
        new_head = None
        while head:
            next = head.next
            head.next = new_head
            new_head = head
            head = next
        return new_head
```





### 原地逆置法

头插法需要建立新的链表，而原地逆置法是在原来链表的基础上直接进行修改。此时需要借助两个指针

- 初始状态下， head 指向头节点， beg指向第一个节点，end 指向第二个节点
- 第一轮交换，将end 节点摘出来， 然后添加至链表的头部
- 将end指向bed.next节点，然后将end指向的节点从链表中摘除，然后将end节点添加至头部
- 依次重复最后完成反转链表



{%y%} 注意边界条件以及初始化beg和end指针{%endy%}



![image-20221202002039580](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221202002039580.png)



```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseList(self, head: Optional[ListNode]) -> Optional[ListNode]:

        """
        原地逆置法
        """
        if not head or not head.next:
            return head
        # 初始化两个指针
        beg = head
        end = head.next
        while end:
            #beg = head
            #end = head.next
            beg.next = end.next
            end.next = head
            head = end
            end = beg.next
        return head
```





# 堆、栈、队列

## [225. 用队列实现栈](https://leetcode.cn/problems/implement-stack-using-queues/)



> 请你仅使用两个队列实现一个后入先出（LIFO）的栈，并支持普通栈的全部四种操作（push、top、pop 和 empty）。
>
> 实现 MyStack 类：
>
> void push(int x) 将元素 x 压入栈顶。
> int pop() 移除并返回栈顶元素。
> int top() 返回栈顶元素。
> boolean empty() 如果栈是空的，返回 true ；否则，返回 false 。





```python
class MyStack:

    def __init__(self):
        self.queue1 = collections.deque()
        self.queue2 = collections.deque()

    def push(self, x: int) -> None:
        self.queue2.append(x)
        while self.queue1:
            self.queue2.append(self.queue1.popleft())
        self.queue1, self.queue2 = self.queue2, self.queue1

    def pop(self) -> int:
        return self.queue1.popleft()

    def top(self) -> int:
        return self.queue1[0]

    def empty(self) -> bool:
        return True if len(self.queue1) ==0 else False

```





## [346. 数据流中的移动平均值](https://leetcode.cn/problems/moving-average-from-data-stream/)

> 给定一个整数数据流和一个窗口大小，根据该滑动窗口的大小，计算其所有整数的移动平均值。
>
> 实现 MovingAverage 类：
>
> MovingAverage(int size) 用窗口大小 size 初始化对象。
> double next(int val) 计算并返回数据流中最后 size 个值的移动平均值。
>



![image-20221204091756212](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221204091756212.png)



```python
class MovingAverage:

    def __init__(self, size: int):
        self.size = size
        self.queue = collections.deque()
        self.total = 0
    def next(self, val: int) -> float:
        if len(self.queue) >=self.size:
            self.queue.popleft()
        self.queue.append(val)
        return sum(self.queue) / len(self.queue)

```





## [281. 锯齿迭代器](https://leetcode.cn/problems/zigzag-iterator/)

> 给出两个一维的向量，请你实现一个迭代器，交替返回它们中间的元素。
>
> 示例:
>
> 输入:
> v1 = [1,2]
> v2 = [3,4,5,6] 
>
> 输出: [1,3,2,4,5,6]
>
> 解析: 通过连续调用 next 函数直到 hasNext 函数返回 false，
>      next 函数返回值的次序应依次为: [1,3,2,4,5,6]。
>



```python
class ZigzagIterator:
    """
    通过tag标记下次是取数据的队列
    """
    def __init__(self, v1: List[int], v2: List[int]):
        self.queue1 = v1[::-1]
        self.queue2 = v2[::-1]
        self.tag = 1 if self.queue1 else 2

    def next(self) -> int:
        if self.queue1 and self.tag == 1:
            
            if self.queue2:
                self.tag = 2
            return self.queue1.pop()

        if self.queue2 and self.tag == 2:
            if self.queue1:
                self.tag = 1
            return self.queue2.pop()
            
    def hasNext(self) -> bool:
        return True if self.queue1 or self.queue2 else False
```

## [54. 螺旋矩阵](https://leetcode.cn/problems/spiral-matrix/)



> 给你一个 `m` 行 `n` 列的矩阵 `matrix` ，请按照 **顺时针螺旋顺序** ，返回矩阵中的所有元素。



![image-20221206110053748](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20221206110053748.png)





```python
class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        if not matrix:
            return []
        m = len(matrix)
        n = len(matrix[0])
        result = list()
        left, right, top, bottom = 0, n-1, 0, m-1
        while left <= right and top <= bottom:
            for col in range(left, right+1):
                result.append(matrix[top][col])

            for row in range(top+1, bottom+1):
                result.append(matrix[row][right])

            if left < right and top < bottom:
                for col in range(right-1, left, -1):
                    result.append(matrix[bottom][col])
                for row in range(bottom, top, -1):
                    result.append(matrix[row][left])
            left += 1
            right -= 1
            top += 1
            bottom -= 1
        return result

```





## [362. 敲击计数器](https://leetcode.cn/problems/design-hit-counter/)



> 设计一个敲击计数器，使它可以统计在过去 5 分钟内被敲击次数。（即过去 300 秒）
>
> 您的系统应该接受一个时间戳参数 timestamp (单位为 秒 )，并且您可以假定对系统的调用是按时间顺序进行的(即 timestamp 是单调递增的)。几次撞击可能同时发生。

```python
class HitCounter:
    """
    相当于一个固定大小的窗口，再窗口内找到合适数据
    """

    def __init__(self):
        self.queue1 = collections.deque()
        self.queue2 = collections.deque()

    def hit(self, timestamp: int) -> None:
        self.queue1.append(timestamp)
        while self.queue1 and timestamp - self.queue1[0]>=300:
            self.queue1.popleft()


    def getHits(self, timestamp: int) -> int:
        while self.queue1 and timestamp - self.queue1[0]>=300:
            self.queue1.popleft()      
        return len(self.queue1)


# Your HitCounter object will be instantiated and called as such:
# obj = HitCounter()
# obj.hit(timestamp)
# param_2 = obj.getHits(timestamp)
```





## [155. 最小栈](https://leetcode.cn/problems/min-stack/)



> 设计一个支持 push ，pop ，top 操作，并能在常数时间内检索到最小元素的栈。
>
> 实现 MinStack 类:
>
> MinStack() 初始化堆栈对象。
> void push(int val) 将元素val推入堆栈。
> void pop() 删除堆栈顶部的元素。
> int top() 获取堆栈顶部的元素。
> int getMin() 获取堆栈中的最小元素。

```python
class MinStack:

    def __init__(self):
        self.min = list()
        self.stack = list()

    def push(self, val: int) -> None:
        #self.min = val if not self.min  else min(self.min, val)
        if not self.min:
            self.min.append(val)
        else:
            if self.min[-1] >= val:
                self.min.append(val)
        self.stack.append(val)

    def pop(self) -> None:
        num = self.stack.pop()
        if self.min and self.min[-1] == num:
            self.min.pop()
        return num

    def top(self) -> int:
        return self.stack[-1]

    def getMin(self) -> int:
        return self.min[-1]


# Your MinStack object will be instantiated and called as such:
# obj = MinStack()
# obj.push(val)
# obj.pop()
# param_3 = obj.top()
# param_4 = obj.getMin()
```



## [232. 用栈实现队列](https://leetcode.cn/problems/implement-queue-using-stacks/)

> 请你仅使用两个栈实现先入先出队列。队列应当支持一般队列支持的所有操作（push、pop、peek、empty）：
>
> 实现 MyQueue 类：
>
> void push(int x) 将元素 x 推到队列的末尾
> int pop() 从队列的开头移除并返回元素
> int peek() 返回队列开头的元素
> boolean empty() 如果队列为空，返回 true ；否则，返回 false
> 说明：
>
> 你 只能 使用标准的栈操作 —— 也就是只有 push to top, peek/pop from top, size, 和 is empty 操作是合法的。
> 你所使用的语言也许不支持栈。你可以使用 list 或者 deque（双端队列）来模拟一个栈，只要是标准的栈操作即可。
>



```python
class MyQueue:

    def __init__(self):
        self.stack1 = []
        self.stack2 = []

    def push(self, x: int) -> None:
        self.stack1.append(x)
    def pop(self) -> int:
        if self.stack2:
            return self.stack2.pop()
        else:
            while self.stack1:
                self.stack2.append(self.stack1.pop())
            return self.stack2.pop()
    def peek(self) -> int:
        if self.stack2:
            return self.stack2[-1]
        else:
            while self.stack1:
                self.stack2.append(self.stack1.pop())
            return self.stack2[-1]
    def empty(self) -> bool:
        return  False if (self.stack1 or self.stack2) else True
```

## [150. 逆波兰表达式求值](https://leetcode.cn/problems/evaluate-reverse-polish-notation/)

> 根据 逆波兰表示法，求表达式的值。
>
> 有效的算符包括 +、-、*、/ 。每个运算对象可以是整数，也可以是另一个逆波兰表达式。
>
> 注意 两个整数之间的除法只保留整数部分。
>
> 可以保证给定的逆波兰表达式总是有效的。换句话说，表达式总会得出有效数值且不存在除数为 0 的情况。







```python
class Solution:
    def evalRPN(self, tokens: List[str]) -> int:
        stack = list()

        set1 = {"/", "+", "-","*"}
        for chr in tokens:
            if chr not in set1:
                stack.append(int(chr))
            else:
                num1 = stack.pop()
                num2 = stack.pop()
                if chr == "/":
                    temp = int(num2 /  num1)
                elif chr == "*":
                    temp = num1 * num2
                elif chr == "+":
                    temp =num1 + num2
                else:
                    
                    temp = num2 - num1
                stack.append(temp)
        return stack[-1]
```

## [20. 有效的括号](https://leetcode.cn/problems/valid-parentheses/)



> 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。
>
> 有效字符串需满足：
>
> 左括号必须用相同类型的右括号闭合。
> 左括号必须以正确的顺序闭合。
> 每个右括号都有一个对应的相同类型的左括号。
>





```python
class Solution:
    def isValid(self, s: str) -> bool:
        stack = list()
        dict1 = {")": "(", "}": "{",  "]": "["}

        for ss in s:
            if ss in dict1:
                if stack and stack[-1] == dict1.get(ss):
                    stack.pop()
                else:
                    return False
            else:
                stack.append(ss)
        
        return True if not stack else False
```





## [1472. 设计浏览器历史记录](https://leetcode.cn/problems/design-browser-history/)

>你有一个只支持单个标签页的 浏览器 ，最开始你浏览的网页是 homepage ，你可以访问其他的网站 url ，也可以在浏览历史中后退 steps 步或前进 steps 步。
>
>请你实现 BrowserHistory 类：
>
>BrowserHistory(string homepage) ，用 homepage 初始化浏览器类。
>void visit(string url) 从当前页跳转访问 url 对应的页面  。执行此操作会把浏览历史前进的记录全部删除。
>string back(int steps) 在浏览历史中后退 steps 步。如果你只能在浏览历史中后退至多 x 步且 steps > x ，那么你只后退 x 步。请返回后退 至多 steps 步以后的 url 。
>string forward(int steps) 在浏览历史中前进 steps 步。如果你只能在浏览历史中前进至多 x 步且 steps > x ，那么你只前进 x 步。请返回前进 至多 steps步以后的 url 。





```python
class BrowserHistory:

    def __init__(self, homepage: str):
        self.stack = [homepage]
        self.pos = 0

    def visit(self, url: str) -> None:
        
        self.stack = self.stack[:self.pos+1]
        self.stack.append(url)
        self.pos = len(self.stack) -1
        return url
        
    def back(self, steps: int) -> str:

        if steps >= self.pos:
            self.pos = 0
            return self.stack[self.pos]      
        else:
            self.pos = self.pos-steps

            return self.stack[self.pos]


    def forward(self, steps: int) -> str:

        if len(self.stack) - (self.pos+1) < steps:
            self.pos = len(self.stack)-1
            return self.stack[-1]
        else:
            self.pos = self.pos + steps
            return self.stack[self.pos]


```





## [735. 行星碰撞](https://leetcode.cn/problems/asteroid-collision/)

>给定一个整数数组 asteroids，表示在同一行的行星。
>
>对于数组中的每一个元素，其绝对值表示行星的大小，正负表示行星的移动方向（正表示向右移动，负表示向左移动）。每一颗行星以相同的速度移动。
>
>找出碰撞后剩下的所有行星。碰撞规则：两个行星相互碰撞，较小的行星会爆炸。如果两颗行星大小相同，则两颗行星都会爆炸。两颗移动方向相同的行星，永远不会发生碰撞。







```python
class Solution:
    def asteroidCollision(self, asteroids: List[int]) -> List[int]:
        stack = [asteroids[0]]
        asteroids = asteroids[1:]

        for i in range(len(asteroids)):
            need_insert= True
            while stack:
                # print(stack[-1], asteroids[i])
                if (stack[-1] >0 and asteroids[i]) >0 or (stack[-1] <0 and asteroids[i] <0):
                    stack.append(asteroids[i])
                    need_insert = False
                    break
                # 下面为不通向的逻辑

                # 前数向左，后数向右
                elif stack[-1] <0 and asteroids[i] > 0:
                    need_insert = False
                    stack.append(asteroids[i])
                    break
                # 相撞， 后大于前
                elif abs(stack[-1]) < abs(asteroids[i]):
                    # 插入后需要判断和原有的stack中的大小
                    stack.pop()
                elif abs(stack[-1]) == abs(asteroids[i]):
                    stack.pop()
                    need_insert = False
                    break
                else:
                    need_insert = False
                    break
            if not stack and need_insert:
                stack.append(asteroids[i])
        return stack

```



## [删除字符串中的所有相邻重复项 II](https://leetcode.cn/problems/remove-all-adjacent-duplicates-in-string-ii/)

>
>
>给你一个字符串 s，「k 倍重复项删除操作」将会从 s 中选择 k 个相邻且相等的字母，并删除它们，使被删去的字符串的左侧和右侧连在一起。
>
>你需要对 s 重复进行无限次这样的删除操作，直到无法继续为止。
>
>在执行完所有删除操作后，返回最终得到的字符串。
>
>本题答案保证唯一





```python
class Solution:
    def removeDuplicates(self, s: str, k: int) -> str:


        # 方法一：会超时
        # result = list()
        # for ss in s:
        #     # 不足k-1个直接加入
        #     if len(result) < k-1:
        #         result.append(ss)
        #     else:
        #         # 检测后k-1各元素是否相同并且同为ss
        #         is_valid = False
        #         result.append(ss)
        #         for i in range(-1, -k-1, -1):
        #             if result[i] != ss:
        #                 is_valid = True
        #                 break
        #         if not is_valid:
        #             result = result[:len(result)-k]
        # return "".join(result)

        # 方法二 利用栈
        stack = list()
        for ss in s:
            if stack:
                if ss == stack[-1][0] and stack[-1][1]+1 < k:
                    stack[-1][1] += 1
                elif ss == stack[-1][0] and stack[-1][1]+1 >=k:
                    stack.pop()

                else:
                    stack.append([ss, 1])
            else:
                stack.append([ss, 1])
        result = list()
        for chr, num in stack:
            result.append(chr*num)
        return "".join(result)
```

## [1249. 移除无效的括号](https://leetcode.cn/problems/minimum-remove-to-make-valid-parentheses/)



> 给你一个由 '('、')' 和小写字母组成的字符串 s。
>
> 你需要从字符串中删除最少数目的 '(' 或者 ')' （可以删除任意位置的括号)，使得剩下的「括号字符串」有效。
>
> 请返回任意一个合法字符串。
>
> 有效「括号字符串」应当符合以下 任意一条 要求：
>
> 空字符串或只包含小写字母的字符串
> 可以被写作 AB（A 连接 B）的字符串，其中 A 和 B 都是有效「括号字符串」
> 可以被写作 (A) 的字符串，其中 A 是一个有效的「括号字符串」





```python
class Solution:
    def minRemoveToMakeValid(self, s: str) -> str:
        stack1 = list()
        s= list(s)
        for i in range(len(s)):
            if s[i] == "(":
                stack1.append(i)
            elif s[i] == ")":
                if stack1:
                    stack1.pop()
                else:
                    s[i] = "0"
            else:
                pass
        while stack1:
            s[stack1.pop()]="0"
        s = "".join(s)
        s= s.replace("0", "")
        return s

```





# 哈希(hashmap/hashset)

## [1. 两数之和](https://leetcode.cn/problems/two-sum/)



> 给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。
>
> 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。
>
> 你可以按任意顺序返回答案。

```python
class Solution:

    # # 方法一 借助hashmap
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        
        hashdict= dict()

        for i in range(len(nums)):

            temp = target - nums[i]

            if temp in hashdict:
                return [i, hashdict.get(temp)]
            hashdict[nums[i]]= i

    # 暴力解法
    # def twoSum(self, nums: List[int], target: int) -> List[int]:

    #     for i in range(len(nums)):
    #         for j in range(i+1, len(nums)):
    #             if nums[i] + nums[j] == target:
    #                 return i, j
    
```



## [146. LRU 缓存](https://leetcode.cn/problems/lru-cache/)

>请你设计并实现一个满足  LRU (最近最少使用) 缓存 约束的数据结构。
>实现 LRUCache 类：
>LRUCache(int capacity) 以 正整数 作为容量 capacity 初始化 LRU 缓存
>int get(int key) 如果关键字 key 存在于缓存中，则返回关键字的值，否则返回 -1 。
>void put(int key, int value) 如果关键字 key 已经存在，则变更其数据值 value ；如果不存在，则向缓存中插入该组 key-value 。如果插入操作导致关键字数量超过 capacity ，则应该 逐出 最久未使用的关键字。
>函数 get 和 put 必须以 O(1) 的平均时间复杂度运行。
>
>





**hashmap + 双端队列**

> hashmap 中按照对应的key存储节点信息，在节保存key和value

```python
class LinkedNode:
    
    def __init__(self, key=None, value=None, prev=None, nex=None):
        self.key = key
        self.value = value
        self.prev = prev
        self.nex = nex


class LRUCache:

    def __init__(self, capacity: int):
        self.capacity= capacity
        self.lru = dict()
        #  初始化两个节点作为首尾节点，并连接起来
        self.head = LinkedNode()
        self.tail = LinkedNode()
        self.head.nex = self.tail
        self.tail.prev = self.head

    def get(self, key: int) -> int:
        if key in self.lru:
            node = self.lru.get(key)

            self.node_to_tail(node)
            return node.value
        else: 
            return -1

    def put(self, key: int, value: int) -> None:

        if key in self.lru:  # to linkednode tail
            node = self.lru.get(key)
            node.value = value
            self.node_to_tail(node)
            return

        if len(self.lru) == self.capacity:
            
            # remove head
            node = self.head.nex
            del self.lru[node.key]
            print(self.head.nex.value, self.head.nex.value)
            self.remove_head_node(node)

        node = LinkedNode(key=key, value=value)
        self.lru[key] = node
        self.add_tail_node(node)
    def remove_head_node(self, node):
        """
        去除某个节点
        """
        # 开始移除
        
        node_prev = node.prev
        node_nex = node.nex
        node_prev.nex = node_nex
        node_nex.prev = node_prev


    def add_tail_node(self, node):
        """
        添加至末尾，此时需要保持尾节点不变
        """
        self.tail.prev.nex = node
        node.prev = self.tail.prev
        node.nex = self.tail
        self.tail.prev = node


    def node_to_tail(self, node):
        """
        将任意节点移动到尾部
        """
        self.remove_head_node(node)
        self.add_tail_node(node)

# Your LRUCache object will be instantiated and called as such:
# obj = LRUCache(capacity)
# param_1 = obj.get(key)
# obj.put(key,value)
```





## [128. 最长连续序列](https://leetcode.cn/problems/longest-consecutive-sequence/)

> 给定一个未排序的整数数组 nums ，找出数字连续的最长序列（不要求序列元素在原数组中连续）的长度。
>
> 请你设计并实现时间复杂度为 O(n) 的算法解决此问题。



- 借助hashmap

```python
class Solution:
    """
    借助hashmap来实现
    """
    def longestConsecutive(self, nums: List[int]) -> int:

        if not nums:
            return 0
        max_len = 0
        nums_set = set(nums)
        
        for num in nums_set:
            pre_num = num -1

            
            if pre_num not in nums_set:
                temp_len = 1
                cur = num

                while cur+ 1 in nums_set:
                    cur +=1
                    temp_len += 1
                max_len = max(temp_len, max_len)
            
        return max_len
        
```



- 动态规划解法

```python
class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        res = 0
        hash_dict = dict()
        for num in nums:
            if num not in hash_dict:
                left = hash_dict.get(num-1, 0)
                right = hash_dict.get(num+1, 0)
                cur_lenght = left + right +1
                res = max(cur_lenght, res)
                hash_dict[num] = cur_lenght
                hash_dict[num-left]= cur_lenght
                hash_dict[num+right] = cur_lenght
        return res
```

## [73. 矩阵置零](https://leetcode.cn/problems/set-matrix-zeroes/)

> 给定一个 `*m* x *n*` 的矩阵，如果一个元素为 **0** ，则将其所在行和列的所有元素都设为 **0** 。请使用 **[原地](http://baike.baidu.com/item/原地算法)** 算法**。**



```python
class Solution:
    def setZeroes(self, matrix: List[List[int]]) -> None:
        """
        Do not return anything, modify matrix in-place instead.
        """

        need_zero_raw = set()
        need_zero_col = set()
        for i in range(len(matrix)):
            for j in range(len(matrix[0])):
                if matrix[i][j] == 0:
                    need_zero_raw.add(i)
                    need_zero_col.add(j)
        
        for row in need_zero_raw:
            for j in range(len(matrix[0])):
                matrix[row][j] = 0

        for col in need_zero_col:
            for i in range(len(matrix)):
                matrix[i][col] = 0

```



{%g%}



一种改进方法是用矩阵得第一行和第一列来记录需要置为0得行列，如果某行得第一个元素为0则改行置为0，同理设置列

注意这样会改变行列得值，所以要提前判断第一行和第一列是否为0就可以了

{%endg%}



## [380. O(1) 时间插入、删除和获取随机元素](https://leetcode.cn/problems/insert-delete-getrandom-o1/)

>  实现RandomizedSet 类：
>
>  RandomizedSet() 初始化 RandomizedSet 对象
>  bool insert(int val) 当元素 val 不存在时，向集合中插入该项，并返回 true ；否则，返回 false 。
>  bool remove(int val) 当元素 val 存在时，从集合中移除该项，并返回 true ；否则，返回 false 。
>  int getRandom() 随机返回现有集合中的一项（测试用例保证调用此方法时集合中至少存在一个元素）。每个元素应该有 相同的概率 被返回。
>  你必须实现类的所有函数，并满足每个函数的 平均 时间复杂度为 O(1) 。







```python

class RandomizedSet:

    # def __init__(self):
    #     self.data = set()

    # def insert(self, val: int) -> bool:
    #     if val not in self.data:
    #         self.data.add(val)
    #         return True
    #     else:
    #         return False

    # def remove(self, val: int) -> bool:
    #     if val in self.data:
    #         self.data.remove(val)
    #         return True
    #     else:
    #         return False

    # def getRandom(self) -> int:
    #     # 此方法list（）时间复杂度是O(n)
    #     return random.choice(list(self.data))
    def __init__(self):
        self.data = dict()
        self.end_index = -1
        self.nums = list()

    def insert(self, val: int) -> bool:
        if val not in self.data:
            self.end_index += 1
            self.data[val]= self.end_index
            self.nums.append(val)
            return True
        else:
            return False

    def remove(self, val: int) -> bool:
        if val in self.data:
            index = self.data.get(val)
            end_num = self.nums[self.end_index]

            # 不能执行删除， 需要执行交换，将最后一个元素换到index 位置，然后删除最后一个元素
            # 将end_index    -1
            self.nums[index] = end_num
            self.data[end_num] = index
            self.nums.pop()
            del self.data[val]
            self.end_index -= 1
            return True
        else:
            return False
    def getRandom(self) -> int:
        return random.choice(self.nums)
# Your RandomizedSet object will be instantiated and called as such:
# obj = RandomizedSet()
# param_1 = obj.insert(val)
# param_2 = obj.remove(val)
# param_3 = obj.getRandom()
```





## [49. 字母异位词分组](https://leetcode.cn/problems/group-anagrams/)



> 给你一个字符串数组，请你将 字母异位词 组合在一起。可以按任意顺序返回结果列表。
>
> 字母异位词 是由重新排列源单词的字母得到的一个新单词，所有源单词中的字母通常恰好只用一次。
>
> 
>
> 来源：力扣（LeetCode）
> 链接：https://leetcode.cn/problems/group-anagrams
> 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。



```python
class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        """
        使用hashmap
        """
        hashmap = collections.defaultdict(list)
        for str_ in strs:
            key= sorted(str_)
            key = "".join(key)
            hashmap[key].append(str_)
        return [val for _,val in hashmap.items()]
```

 

## [299. 猜数字游戏](https://leetcode.cn/problems/bulls-and-cows/)



>你在和朋友一起玩 猜数字（Bulls and Cows）游戏，该游戏规则如下：
>
>写出一个秘密数字，并请朋友猜这个数字是多少。朋友每猜测一次，你就会给他一个包含下述信息的提示：
>
>猜测数字中有多少位属于数字和确切位置都猜对了（称为 "Bulls"，公牛），
>有多少位属于数字猜对了但是位置不对（称为 "Cows"，奶牛）。也就是说，这次猜测中有多少位非公牛数字可以通过重新排列转换成公牛数字。
>给你一个秘密数字 secret 和朋友猜测的数字 guess ，请你返回对朋友这次猜测的提示。
>
>提示的格式为 "xAyB" ，x 是公牛个数， y 是奶牛个数，A 表示公牛，B 表示奶牛。
>
>请注意秘密数字和朋友猜测的数字都可能含有重复数字。
>
>来源：力扣（LeetCode）
>链接：https://leetcode.cn/problems/bulls-and-cows
>著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

```python
class Solution:
    def getHint(self, secret: str, guess: str) -> str:
        a = b = 0

        secret_dict = collections.defaultdict(int)
        guess_dict = collections.defaultdict(int)
        for s, g in zip(secret, guess):
            # 公牛
            if s == g:
                a += 1

            else:
                secret_dict[s] += 1
                guess_dict[g] += 1
        # 统计母牛得个数
        for g in guess_dict:
            temp_num = min(guess_dict.get(g) , secret_dict.get(g,0))
            b += temp_num
            
        return "{a}A{b}B".format(a=a, b=b)

```





# 排序



## 冒泡排序

> 以第一个数为起点，与后面得数一次比较，如果比基数大就交换，这样每一趟结束都会将未排序中最大得数放在已排序得开头



```python
def bubble(nums):
    n = len(nums)
	for i in range(n-1):
        for j in range(n-1-i):
            if num[i] < nums[j]:
                nums[i], nums[j] = nums[j], nums[i]
    return nums

def bubble_sort2(nums):
    n = len(nums)
    for i in range(n-1):
        exchange = False
        for i in range(n-1-i):
            if nums[i] < nums[j]:
                nums[i], nums[j] = nums[j], nums[i]
                exchange = True
        if not exchange:
            break
    return nums
                
```

## 选择排序



> 设定第一个元素得坐标为基准下标，然后用这个元素与无序数组中得元素做比较，找出此时得最小下标
>
> 每一轮循环，都会将无序中得最小元素交换至有序数组得末尾

```python
def select_sort(nums):
	
    n = len(nums-1)
    for i in range(n):
        basic = nums[i]
        for j in range(i+1, n):
            
    
```





# 二分法



## [34. 在排序数组中查找元素的第一个和最后一个位置](https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/)

> 给你一个按照非递减顺序排列的整数数组 nums，和一个目标值 target。请你找出给定目标值在数组中的开始位置和结束位置。
>
> 如果数组中不存在目标值 target，返回 [-1, -1]。
>
> 你必须设计并实现时间复杂度为 O(log n) 的算法解决此问题。
>
> 来源：力扣（LeetCode）
> 链接：https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array
> 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。



- 方法一： 二分+双指针

```python
class Solution:
    """
    先用二分查找找到第一个出现得位置，然后找出左右边界
    """
    def searchRange(self, nums: List[int], target: int) -> List[int]:

        left, right = 0, len(nums) -1  # left 代表最左边，right最右边
        while left <= right:
            mid = (left+right)//2
            if nums[mid]== target:
                left = right = mid
                while left>=0 and nums[left] == target:
                    left -=1
                while right <= len(nums)-1 and nums[right] == target:
                    right += 1 
                return [left+1, right-1]
            elif nums[mid] > target:
                right = mid -1
            else:
                left = mid +1
            
        return [-1, -1]
```

- 方法二： 二分+分别寻找左右边界



```python
class Solution:
    def searchRange(self, nums: List[int], target: int) -> List[int]:

        def searchleft(nums: List[int], target:int):
            
            left, right = 0, len(nums) -1

            while left <= right:

                mid = (left + right)//2

                if nums[mid] == target:
                    right -= 1
                elif nums[mid] > target:
                    right = mid -1

                else:
                    left = mid + 1
            return left if nums[left] == target else -1

        def searchright(nums:List[int], target: int):

            left, right = 0, len(nums) -1
            while left <= right:

                mid = (left + right)//2

                if nums[mid] == target:
                    left += 1
                elif nums[mid] > target:
                    right = mid -1

                else:
                    left = mid + 1
            return right if nums[right]== target else -1
        if not nums or nums[0]> target or nums[len(nums)-1] <target:
            return [-1, -1]
        left, right = searchleft(nums, target), searchright(nums, target)
        return [left, right]

```



## [33. 搜索旋转排序数组](https://leetcode.cn/problems/search-in-rotated-sorted-array/)



> 整数数组 nums 按升序排列，数组中的值 互不相同 。
>
> 在传递给函数之前，nums 在预先未知的某个下标 k（0 <= k < nums.length）上进行了 旋转，使数组变为 [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]（下标 从 0 开始 计数）。例如， [0,1,2,4,5,6,7] 在下标 3 处经旋转后可能变为 [4,5,6,7,0,1,2] 。
>
> 给你 旋转后 的数组 nums 和一个整数 target ，如果 nums 中存在这个目标值 target ，则返回它的下标，否则返回 -1 。
>
> 你必须设计一个时间复杂度为 O(log n) 的算法解决此问题。
>
> 来源：力扣（LeetCode）
> 链接：https://leetcode.cn/problems/search-in-rotated-sorted-array
> 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。



```python
class Solution:
    def search(self, nums: List[int], target: int) -> int:

        left, right = 0, len(nums) -1
        
        while left <=right:
            mid = (left + right)//2
            #有序部分
            if nums[mid] == target:
                return mid

            if nums[0] <= nums[mid]:  # 再递减序列里
                if nums[0]<=target< nums[mid]:  
                    right = mid -1
                else:
                    left = mid +1

            else: #  一半升序，一半降序，前半部分>后半部分

                if nums[mid] < target<=nums[len(nums) -1]:
                    left = mid +1
                else:
                    right = mid - 1
        return -1
```

## [852. 山脉数组的峰顶索引](https://leetcode.cn/problems/peak-index-in-a-mountain-array/)

>
>
>符合下列属性的数组 arr 称为 山脉数组 ：
>arr.length >= 3
>存在 i（0 < i < arr.length - 1）使得：
>arr[0] < arr[1] < ... arr[i-1] < arr[i]
>arr[i] > arr[i+1] > ... > arr[arr.length - 1]
>给你由整数组成的山脉数组 arr ，返回任何满足 arr[0] < arr[1] < ... arr[i - 1] < arr[i] > arr[i + 1] > ... > arr[arr.length - 1] 的下标 i 。
>
> 
>
>来源：力扣（LeetCode）
>链接：https://leetcode.cn/problems/peak-index-in-a-mountain-array
>著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

```python
class Solution:
    def peakIndexInMountainArray(self, arr: List[int]) -> int:

        left, right = 0, len(arr) -1

        while left < right:
            mid = (left + right) //2

            if arr[mid] > arr[mid+1] and arr[mid-1] < arr[mid]:
                return mid
            elif arr[mid] < arr[mid+1]:
                left = mid
            else:
                right = mid


```

## [162. 寻找峰值](https://leetcode.cn/problems/find-peak-element/)

> 峰值元素是指其值严格大于左右相邻值的元素。
>
> 给你一个整数数组 nums，找到峰值元素并返回其索引。数组可能包含多个峰值，在这种情况下，返回 任何一个峰值 所在位置即可。
>
> 你可以假设 nums[-1] = nums[n] = -∞ 。
>
> 你必须实现时间复杂度为 O(log n) 的算法来解决此问题。
>
> 来源：力扣（LeetCode）
> 链接：https://leetcode.cn/problems/find-peak-element
> 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

```python
class Solution:
    """
    target = nums[mid-1]<numd[mid]> nums[mid+1]
    """
    def findPeakElement(self, nums: List[int]) -> int:
        
        left, right = 0, len(nums)-1

        while left+1<=right:
            mid = (left +right)//2
            if nums[mid] > nums[mid+1]:
                right = mid
            else:
                left = mid +1
        return (left +right)//2
```





## [278. 第一个错误的版本](https://leetcode.cn/problems/first-bad-version/)

> 你是产品经理，目前正在带领一个团队开发新的产品。不幸的是，你的产品的最新版本没有通过质量检测。由于每个版本都是基于之前的版本开发的，所以错误的版本之后的所有版本都是错的。
>
> 假设你有 n 个版本 [1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。
>
> 你可以通过调用 bool isBadVersion(version) 接口来判断版本号 version 是否在单元测试中出错。实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。
>
> 来源：力扣（LeetCode）
> 链接：https://leetcode.cn/problems/first-bad-version
> 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。



```python
# The isBadVersion API is already defined for you.
# def isBadVersion(version: int) -> bool:

class Solution:
    def firstBadVersion(self, n: int) -> int:
        left, right = 1, n

        while left<right:
            
            mid = (left + right)//2

            tag1 = isBadVersion(mid)
            if tag1:
                right = mid
            else:
                left = mid +1
            
        return right

```









## [74. 搜索二维矩阵](https://leetcode.cn/problems/search-a-2d-matrix/)

> 编写一个高效的算法来判断 m x n 矩阵中，是否存在一个目标值。该矩阵具有如下特性：
>
> 每行中的整数从左到右按升序排列。
> 每行的第一个整数大于前一行的最后一个整数。
>
> 来源：力扣（LeetCode）
> 链接：https://leetcode.cn/problems/search-a-2d-matrix
> 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。



![image-20230109131318316](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230109131318316.png)



```python
class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:


        m = len(matrix) -1
        n = len(matrix[0]) -1

        # TODO 先用二分查找判断在哪一行
        top, buttom = 0, m
        possible_row = -1
        while top<=buttom:
            mid = (top+buttom)// 2

            if matrix[mid][0]>target:
                buttom = mid -1
            elif matrix[mid][n]<target:
                top = mid+1
            elif matrix[mid][0] <=target <= matrix[mid][n]:
                if matrix[mid][0] == target or matrix[mid][n] == target:
                    return True
                possible_row = mid
                break
        # 没有找到合适的区间行，返回false
        if possible_row == -1:
            return False
        # TODO 用二分查找是否是在这一行里
        left, right = 0, n
        row = matrix[possible_row]
        while left <= right:

            mid = (left +right)//2

            if row[mid] == target:
                return True

            elif row[mid] > target:
                right =mid-1
            else:
                left = mid +1
        return False


```





## [240. 搜索二维矩阵 II](https://leetcode.cn/problems/search-a-2d-matrix-ii/)



> 编写一个高效的算法来搜索 m x n 矩阵 matrix 中的一个目标值 target 。该矩阵具有以下特性：
>
> 每行的元素从左到右升序排列。
> 每列的元素从上到下升序排列。
>
> 来源：力扣（LeetCode）
> 链接：https://leetcode.cn/problems/search-a-2d-matrix-ii
> 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。



![image-20230109134725241](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230109134725241.png)



```python

class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        if not matrix:
            return False
        m = len(matrix)-1
        n = len(matrix[0])-1
        
        # 每一行中进行二分查找
        for i in range(m+1):

            row = matrix[i]

            left, right = 0, n

            while left <= right:
                mid = (left + right)//2

                if row[mid] == target:
                    return True
                elif row[mid] < target:
                    left = mid +1
                else:
                    right = mid -1
        return False
```





## [69. x 的平方根 ](https://leetcode.cn/problems/sqrtx/)

> 给你一个非负整数 x ，计算并返回 x 的 算术平方根 。
>
> 由于返回类型是整数，结果只保留 整数部分 ，小数部分将被 舍去 。
>
> 注意：不允许使用任何内置指数函数和算符，例如 pow(x, 0.5) 或者 x ** 0.5 。
>
> 来源：力扣（LeetCode）
> 链接：https://leetcode.cn/problems/sqrtx
> 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

```python

class Solution:
    def mySqrt(self, x: int) -> int:

        # x：为正整数   求数平方根 结果向下取整

        left, right = 0, x
        
        while left <=right:
            mid = (left + right)//2
            if (mid+1) * (mid+1) > x and mid * mid <= x :
                return mid
            elif mid * mid < x:
                left = mid +1
            else:
                right = mid -1
```



## [540. 有序数组中的单一元素](https://leetcode.cn/problems/single-element-in-a-sorted-array/)

>给你一个仅由整数组成的有序数组，其中每个元素都会出现两次，唯有一个数只会出现一次。
>
>请你找出并返回只出现一次的那个数。
>
>你设计的解决方案必须满足 O(log n) 时间复杂度和 O(1) 空间复杂度。
>
>来源：力扣（LeetCode）
>链接：https://leetcode.cn/problems/single-element-in-a-sorted-array
>著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

```python
class Solution:

    """

    当 \textit{mid}mid 是偶数时，mid + 1 = mid^1；

    当 \textit{mid}mid 是奇数时，mid - 1 = mid^1。
    """
    def singleNonDuplicate(self, nums: List[int]) -> int:
        low, high = 0, len(nums) - 1
        while low < high:
            mid = (low + high) // 2
            if nums[mid] == nums[mid ^ 1]:
                low = mid + 1
            else:
                high = mid
        return nums[low]

```



## [528. 按权重随机选择](https://leetcode.cn/problems/random-pick-with-weight/)

> 给你一个 下标从 0 开始 的正整数数组 w ，其中 w[i] 代表第 i 个下标的权重。
>
> 请你实现一个函数 pickIndex ，它可以 随机地 从范围 [0, w.length - 1] 内（含 0 和 w.length - 1）选出并返回一个下标。选取下标 i 的 概率 为 w[i] / sum(w) 。
>
> 例如，对于 w = [1, 3]，挑选下标 0 的概率为 1 / (1 + 3) = 0.25 （即，25%），而选取下标 1 的概率为 3 / (1 + 3) = 0.75（即，75%）。
>
> 来源：力扣（LeetCode）
> 链接：https://leetcode.cn/problems/random-pick-with-weight
> 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

![image-20230110183654906](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230110183654906.png)



```python
后续补充
```





# 双指针



**基础知识：常见双指针算法分为三类，同向（即两个指针都相同一个方向移动），背向（两个指针从相同或者相邻的位置出发，背向移动直到其中一根指针到达边界为止），相向（两个指针从两边出发一起向中间移动直到两个指针相遇）**

## 背向双指针



### [409. 最长回文串](https://leetcode.cn/problems/longest-palindrome/)

> 给定一个包含大写字母和小写字母的字符串 s ，返回 通过这些字母构造成的 最长的回文串 。
>
> 在构造过程中，请注意 区分大小写 。比如 "Aa" 不能当做一个回文字符串。
>
> 来源：力扣（LeetCode）
> 链接：https://leetcode.cn/problems/longest-palindrome
> 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。



![image-20230110185049415](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230110185049415.png)

```python
class Solution:
    def longestPalindrome(self, s: str) -> int:

        ans = 0
        count = collections.Counter(s)

        for v in count.values():

            ans += v//2 * 2

            if v%2 ==1 and ans %2 ==0:
                ans += 1
        return ans
        
```







## [125. 验证回文串](https://leetcode.cn/problems/valid-palindrome/)

> 如果在将所有大写字符转换为小写字符、并移除所有非字母数字字符之后，短语正着读和反着读都一样。则可以认为该短语是一个 回文串 。
>
> 字母和数字都属于字母数字字符。
>
> 给你一个字符串 s，如果它是 回文串 ，返回 true ；否则，返回 false 。
>
> 来源：力扣（LeetCode）
> 链接：https://leetcode.cn/problems/valid-palindrome
> 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。



![image-20230110200409992](https://zhangtq-blog.oss-cn-hangzhou.aliyuncs.com/content_picture/image-20230110200409992.png)





```python
class Solution:
    def isPalindrome(self, s: str) -> bool:
        ss = re.findall(r'[a-zA-Z0-9]', s)
        
        left, right = 0, len(ss) - 1
        while left < right:
            if ss[left].lower() == ss[right].lower():
                left += 1
                right -= 1
            else:
                return False
        return True
        
        
```







## [5. 最长回文子串](https://leetcode.cn/problems/longest-palindromic-substring/)

> 给你一个字符串 `s`，找到 `s` 中最长的回文子串。
>
> 如果字符串的反序与原始字符串相同，则该字符串称为回文字符串。



```python
```





# 二叉树



## 二叉树遍历



### 前中后序遍历



### 层次遍历



## 二叉搜索树



## 平衡二叉树



# KMP算法



# 贪心算法



# 动态规划



# 0-1背包



# 完全背包



# 回溯

# 深度优先和广度优先



# 字典树



# 位运算



# 并查集







