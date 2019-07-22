# 如何估算自己的出块概率



## 第一步、粗略估算`全网的算力`

- 看最新的两个块之间的时间间隔，比如158411块和158410块之间相差11s。

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-4e30c774bdbd2edb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

- 看最新的块的难度，比如最新的158411块的难度是135亿

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-1f5bb3f33fa6f7c2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

- 用`难度`除以`时间间隔`，可以得出`全网的算力(HashRate)`
  - $13570021803/11=1,233,638,345.72727 (H/S)$ 
  - 也就是每秒全网所有节点一共计算12.33亿次Hash值。
- 当然这是初略估计，精确的话需要截取一段时间的数据，取平均值。



## 第二步、获取自己节点的算力值

- 这是最新的0.1.4版本之后的钱包程序提供的功能，需要这个功能，请下载最新的钱包程序。
- 找到并点击钱包的菜单项 **[开发->算力统计]**

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-4be4eeca6360a80a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

- 算力统计窗口

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-106a62e4b73d8a6f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

- 算力统计窗口会显示出本节点算力，表示一秒钟进行多少次Hash运算。
  - 需要运行一段时间，等数值稳定后才是正确的算力值。
  - 经验上，每一个物理线程大致是34000H/S（随主频变化）
- 算力统计会轻微的影响挖矿效率，统计完成后建议点击关闭按钮。



## 第三步、估算出块概率

* 假设场景
  * 一台i5处理器的mac pro算力是：102000
  * 我有两台这样的笔记本，那我的算力就是：204000
* 可以估算我的出块概率
  * `总体出块概率`=`你的节点算力总和`/`全网算力总和`
  * 我的**总出块概率**是：204000/1233638345=0.0001653645096

* 而且我大概一天多一点的时间以内可以挖到一个块
  * 大概6000块就有一个块是你的
    * $(1 / 0.0001653645096)=6,047.2467892157$
  * 6000块是一天多一点的时间
    * 我们按照每分钟4块算，一天内整个链可以产生5760块。
* 当然上面的结论是建立在你运气一般的情况下。