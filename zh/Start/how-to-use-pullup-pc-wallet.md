# 如何使用PC端去中心化轻钱包

[TOC]

>  `Pullup钱包` 需要连接 `v1.0.0-rc2` 版本以上的全节点（gero），并且需要确保全节点启动参数中包含 `--lightNode` 以及 `--rpcapi sero,stake,light`。

> **Pullup钱包只支持购买委托StakingNode投票的股份，暂不支持购买SOLO投票的股份。**



### 确认您的系统环境安装了 Chrome 浏览器，否则Pullup钱包无法使用。

* 官方下载页面：<https://www.google.cn/intl/zh-CN/chrome/>



## 注意

* Pullup钱包和PC全节点钱包的关系
  * 彼此之间账户不要互相导入，账户文件不能混用。
  * 可以采用收款码向彼此发送资产。
  * 两者均可接受交易所或者Flight钱包的提款（采用收款码）





## 下载

Pullup钱包是在github上开源的，可以通过访问下面的链接来下载最新的Pullup钱包：

<https://github.com/sero-cash/pullup/releases>





## 安装

* MAC下安装
  * 解压 pullup-mac-x.x.x.tar.gz 为 pullup 文件。
  * 将 pullup 拷贝到【应用程序】文件夹中。
  * 即可从启动面板里面启动 Pullup 钱包。
  * 如果被系统阻止，需要进入【偏好设置->安全性与隐私】，点击【仍要打开】
* Windows下安装
  * 目前仅支持64位win7.1以上的系统。
  * 解压 pullup-windows-x.x.x.zip 为 pullup 文件夹
  * 可将 pullup 放置于任何位置下
  * 进入文件夹中双击pullup.exe即可启动Pullup钱包
    * 不要改变pullup.exe在文件夹中的路径
  * 如果系统弹出防火墙拦截通知，点击【允许】





## 全节点选择

在钱包的首页有一个名为`节点`的卡片。

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-f4a44c0339b71fa1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

点击卡片上的双向箭头，就可以弹出节点选择器，你可以选择默认的节点`http://129.204.197.105:8545`，也可以选择自己或者他人搭建的节点，不管选择那一种，都是安全的，因为钱包不会上传任何用户隐私信息到节点上。

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-ba2866aa1f6da3fd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

> 如果是选择自己或者他人搭建的 gero 节点，请确保其 gero 的版本号大于 `v1.0.0-rc2`，并且开启了 `--lightNode --rpcapi sero,stake,light` 服务。

> 另外的选项是：
>
> * Personal Rpc
>   * 设置第三方的全节点ip和端口





## 账户管理

### 创建新账户

* Pullup钱包用助记词管理账户，创建账户可以点击首页最下方的按钮【创建账户】。

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-5eac38ad56db462e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)



* 输入两次至少8位的任意字符密码

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-834d8389b6439235.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* 备份助记词

  * 助记词就相当于你的私钥，一定要保管好，泄漏助记词，相当于将账户掌控权交给其他人。

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-9ddc22d908a10ed1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* 进入首页后就能看到刚刚创建的账户

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-5bd3b6ecc24fd16a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)



### 备份助记词

* Pullup钱包以助记词为媒介备份账户，因此你可以点击首页中需要备份的账户方块进入账户页面。

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-ca98c6acc58e7a75.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* 弹出助记词页面后，请尽快记下来，然后关闭窗口，记住千万 **安全保存，不可泄漏**。

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-e0b664b9fc79c8aa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)



### 导入助记词

* 在创建账户的页面点击下方的【使用助记词导入】按钮

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-a4511fbe5196f333.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* 钱包弹出助记词输入页面，在页面中填入正确的助记词，并设置密码。

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-23ffaff7038a664e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)



## 交易发送和接受

### 发送交易

点击【发送】Tab按钮，进入发送交易页面，按照页面要求填写表单。

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-f787ad6927c4e0b6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* 收款地址必须填写`收款码(collect address)`，收款码是一串base58编码的数字，主要来源于下
  * 交易所 `充值地址`
  * Pullup钱包 的`主地址`或`收款码`
  * Flight钱包`充值地址`
  * 全节点钱包账户页`红色`的那行`收款码`
  * gero 中`sero.genPKr`或者`exchange.getPkr`的输出地址

* 点击【发送】后即会在后台进行`交易组装`已经`签名`一系列工作最后广播到全网。

### 接收交易

* Pullup 钱包的地址分为主地址和收款码地址，这两种地址都可以作为发送地址使用。
  * ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-638b0e8a5cf32ee3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
  * 主地址是一种特殊的收款码，可以多次使用不会发生变化。
  * 收款码在每次被使用之后都会发生变化。
  * 矿池挖矿时只能使用主地址。
  * 这两种地址都能使用于其他任何的情况：
    * 交易所提现
    * Flight钱包提现
    * 全节点钱包转账
    * Pullup钱包转账
    * 智能合约转账目标

* 以前全节点钱包最大的问题是不能显示资产转入记录，而Pullup钱包则可以展示转入转出交易。

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-bd8d26c61925b17b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/800)





## 权益池（StakingNode）

**SERO的权益池是去中心化权益池，130万块之后才能使用，在130万块之前注册权益池会提示`Stx Verify Error`。**

在轻钱包里面可以进行下面三种POS挖矿中的活动：

* 注册权益池
* 购买由权益池代为投票的股份
* 查看我的投票收益

具体各项数据的说明请参考：[如何使用gero进行Staking](?file=Tutorial/how-to-staking-using-gero)

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-0a03a9533292bc4f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

### 权益池页面

点击【权益池】Tab即可进入权益池页面

* 其中【我的股份】展示钱包内账户所有股份收益概要

* 点击右上角【查看详情】可以看到每个股份的详细情况
* ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-666032bdf1a6ae86.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* 其中【权益池】下面展示全网所有权益池列表以及统计情况
* 点击【注册权益池】进行权益池的注册
* 点击【买票】可以在买票的同时授权给某个权益池进行代投票。
* ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-d0f67df26b37c40d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

### 注册权益池

* 权益池注册你首先必须在全节点注册一个投票账户。
  * 具体如何注册请参考[如何使用gero进行Staking](?file=Tutorial/how-to-staking-using-gero)。
  * 投票账户必须永久解锁。
* 在Pullup钱包中拥有200001个SERO，然后点击【注册权益池】，进入注册表单。
  * 200000 SERO用来质押创建权益池，权益池服务期结束后会自动归还。
  * 1个SERO用来付注册权益池所发交易的gas费用，实际使用的gas费用比这个值小得多。
* 在注册表单中有几个事情需要注意
  * 投票地址需要填写投票账户的任意一个收款码。
    * 收款码可以通过命令行`sero.genPKr`获取。
  * 费率必须是`[25,75]`范围内的数字（最小抽成`25%（即权益池的1/4份额）`，最大抽成75%）
  * 账户需要选择大于20万SERO的那个账户。
  * ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-c855b47b3b1acffc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
  * 点击【下一步】之后输入密码再点击【确定】，钱包后台会创建并发送交易，在链上注册权益池。
* 注册完成的权益池在32个确认块之后将会展示在权益池列表中。

### 购买股份

光有权益池是不够的，不能挣得任何投票奖励，需要有用户在权益池中购买股份，权益池才能在区块产生的时候，以一定机率获得投票权。当你通过对比获得你认为的最佳权益池的时候，可以点击他后面的【购买份额】按钮购买股份。

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-bbcb274b0c6e0df0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

购买的时候需要注意几个事情：

* 账号需要选择拥有资产的资金账户
* 原则上购买股份的用户不需要选择投票地址，因为权益池会替他投票。
  * 但存在一种情况，那就是权益池恶意罢工。
  * 这时就可以用自己设置的投票账户进行SOLO投票，减少自己的损失。
* 购买金额需要选择自己能够承受的最大金额，系统会自动以当前票价帮你购买份额。
* 每个交易一次最多购买1000个股份。

![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-2fce062755465e2f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* 点击【下一步】输入密码然后点击【确定】之后，在账户详情页可以看到这笔交易。
* ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-bf81536ccb2d659b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
* 大约32个确认块之后可以看到这笔交易确认，并且可以看到权益池里面更新的数据。
* ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-f85093508acd185b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
