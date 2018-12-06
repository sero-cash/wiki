# 从源码开始——基于CENTOS7



## 1. 机器配置
以目前Beta上链的规模，满足以下配置

> CPU 4线程以上
> MEM 4GB以上
> DISK 50G以上

就能很好的运行了。

```sh
#本文中测试机配置
----------------------------
OS  : CENTOS7.3
CPU : Xeon E5-26xx v4 (C2T2)
MEM : 4GB
DISK: 50GB
----------------------------
```



## 2. 准备环境

安装Go语言和Git客户端
```sh
$ sudo yum install golang
$ sudo yum install git
```
`注意，只支持 v1.10.x 以及以下golang版本，v1.11.x 不支持。`

安装需要的C++依赖库
```sh
#安装boost库
$ sudo yum install boost
#可能还需要安装 gmp、libgomp、procps-ng
$ sudo yum install gmp libgomp procps-ng
```



## 3. 获取代码

创建GOPATH目录
```sh
$ pwd
... /root

$ mkdir gopath
$ mkdir gopath/src
$ mkdir gopath/src/github.com
$ mkdir gopath/src/github.com/sero-cash
$ export GOPATH=/root/gopath
$ cd gopath/src/github.com/sero-cash
```

访问go-sero项目链接，克隆代码：<https://github.com/sero-cash/go-sero>
```sh
$ git clone https://github.com/sero-cash/go-sero.git
```

访问go-czero-import项目链接，克隆代码：<https://github.com/sero-cash/go-czero-import>
```sh
$ git clone https://github.com/sero-cash/go-czero-import.git
```



## 4. 编译gero

```sh
$ ls
... go-sero      go-czero-import
$ cd go-sero
$ make all
$ ls build/bin/gero
... build/bin/gero
```
可以见到build/bin下生成了可执行文件gero，如果要重新编译则执行
```
$ make clean
$ make all
```



## 5. 配置

有了gero可执行文件，我们就能运行SERO的后台服务与交互式控制台。

**首先配置运行gero的环境**

创建SERO数据存储目录
```sh
$ mkdir ~/sero-data
```

设置动态库加载路径
```sh
$ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GOPATH/src/github.com/sero-cash/go-czero-import/czero/lib
```



## 6. 启动后台服务

用gero可执行程序，目前可以启动四种不同类型的模式：

#### 启动dev模式

```sh
$ build/bin/gero  --dev --datadir "~/sero-data" --ipcpath "~/sero-data/gero.ipc" > ~/sero-data/debug.log
```
>  在这种模式下只能通过手工连接其他的dev节点，挖矿难度非常小，且无限制。

#### 启动alpha模式

```sh
$ build/bin/gero  --alpha --datadir "~/sero-data" --ipcpath "~/sero-data/gero.ipc" > ~/sero-data/debug.log
```
> 这种模式下会自动链接AlphaNet网络，并开始同步数据，AlphaNet网络是SERO内部测试网，挖矿需要许可证，如果有测试需求，可以发邮件给<gordon@sero.vip>申请 `挖矿许可证` 或者 `测试用SERO币` 。

#### 启动beta模式

```sh
$ build/bin/gero --datadir "~/sero-data" --ipcpath "~/sero-data/gero.ipc" > ~/sero-data/debug.log
```
> 这种模式下会自动链接BetaNet网络，并开始同步数据，BetaNet网络是SERO团队提供给社区公测用的网络，挖矿同样需要许可证，如果有测试需求，可以发邮件给<gordon@sero.vip>申请 `挖矿许可证` 或者 `测试用SERO币` 。

#### 启动Main模式

> 此模式目前不支持，当主网络上线时，才会提供出来 ...

#### 结果输出
![](https://upload-images.jianshu.io/upload_images/277023-30b8b21ac13b66ad.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

> 只要看到`IPC endpoint opened`那句，就说明服务启动已经成功，现在可以启动控制台来连接后台服务。



## 7. 启动控制台

当加入attach参数时，gero可以作为控制台启动。

```sh
#后台启动gero服务
$ nohup build/bin/gero  --dev --datadir "~/sero-data" --ipcpath "~/sero-data/gero.ipc" > ~/sero-data/gero.log &
#启动控制台
$ build/bin/gero --datadir "~/sero-data" attach
```

attach会让gero启动一个JS虚拟机驱动的交互式控制台
![](https://upload-images.jianshu.io/upload_images/277023-d8afed3845219ab1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

在其中可以运行复杂的js控制程序，退出控制台的指令是

```javascript
> exit
```



## 8. 账户管理

#### 创建账户指令
```javascript
> personal.newAccount("[PASSWORD]")
... "[PK]"
```
其中 `[PASSWORD]` 是这个账户的密码，因为SERO不会直接存储用户的私钥，当5分钟没有任何操作，账户会被锁定，这时要用该账户进行转账，则需要用此密码对账户解锁。创建用户指令会返回该用户公钥。这个公钥可以作为转账地址。

#### 查看所有公钥
```javascript
> sero.accounts
... ["[PK0]","[PK1]",...,"[PKn]"]
```
这个属性返回当前钱包中所有账户的公钥。


#### 解锁账户
```javascript
> personal.unlockAccount("[PK]","[PASSWORD]")
```
其中`[PK]`是该用户公钥

#### 获取账户资产余额
```javascript
> sero.getBalance("[PK]")
... {tkn:{...},tkt:{...}}
```
其中`tkn`按分类显示账户所有`Token`余额，`tkt`按分类显示账户所有持有的`Ticket`。



## 9. 挖矿

#### 启动挖矿

```javascript
> miner.start()
```

#### 停止挖矿

```javascript
> miner.stop()
```

#### 控制台休眠

```javascript
> admin.sleepBlocks(num)
```
参数`num`是需要休眠的区块数，这个方法一定要在挖矿开启的情况下调用，否则将一直阻塞系统。

需要说明的是，挖矿所获得的奖励，默认条件下，会进入`sero.accounts`的第0个账户的 _公钥_ 生成的 _暂存地址(PKr)_ 中。



## 10. 生成交易

当`accounts[0]`中已经有挖矿所得的奖励的时候，既可以转账给其他账户。

#### 转账指令

```javascript
sero.sendTransaction({
  from:"[SRC_PK]",
  to:"[TARGET_PK]",
  value:[NUM_OF_TA]
})
... "[TX_ID]"
```

> 其中[SRC_PK]是资金发出方公钥，[TARGET_PK]是资金接受方公钥，[NUM_OF_TA]是最小单位的金额，SERO的最小单位是TA，换算单位是 `1 SERO = 10^18 TA`。返回值[TX_ID]是生成交易的ID。

![](https://upload-images.jianshu.io/upload_images/277023-bd6cbeca950950fe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

交易生成之后，将同步给当前网络的其他节点，等待打包进区块中。在打包进区块之后，可以用下面的指令查询交易的详情。



## 11. 获取交易详情

```javascript
> sero.getTransaction("[TX_ID]")
...[TX_DETAIL]
```

![](https://upload-images.jianshu.io/upload_images/277023-010374c16c87687c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

其中[TX_DETAIL]主要格式于下：

```javascript
{
  from: "[SENDER PKr]",
  stx: {
    Desc_Z_Ins: [{
        Anchor: "[MERKLE AUTH ROOT]",
        AssetCM: "[ASSET COMMITMENT]",
        Nil: "[NULLIFIER ID]",
        Trace: "[TRACE ID]"
        Proof: "[ZKP PROOF]"
    }],
    Desc_Z_Outs: [{
        AssetCM: "[ASSET COMMITMENT]",
        OutCM: "[OUTPUT COMMITMENT]",
        PKr: "[RECIVER PKr]",
        Proof: "[ZKP PROOF]"
    }],

  }
}
```



## 12. 发布智能合约

SERO发布智能合约与以太坊的步骤是相似的。

#### 编译智能合约

使用SERO自己的智能合约编辑器，我们打开下面的链接：

<http://remix.web.sero.cash>

![](https://upload-images.jianshu.io/upload_images/277023-95affedbc7d4344c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

加载完毕后可以看到其中有一个发行匿名货币的例子`seroToken.sol`。

![](https://upload-images.jianshu.io/upload_images/277023-3dfd4bce37a5e244.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

右上角选择`seroToken`,并点击`Details`。

![](https://upload-images.jianshu.io/upload_images/277023-5731e92c7ab7ab0c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

点击弹出框`WEB3DEPLOY`旁边的拷贝按钮。

#### 修改初始化参数

![](https://upload-images.jianshu.io/upload_images/277023-1d6cdfa4e62f6416.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在文本编辑器中修改初始化变量。

#### 安装智能合约

![](https://upload-images.jianshu.io/upload_images/277023-2eee55bef93eac35.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1024)

然后整个粘贴到控制台中，并回车，控制台立即会发送一笔交易来安装此智能合约。

#### 查看智能合约账户
![](https://upload-images.jianshu.io/upload_images/277023-c88beb87ad21a616.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

交易成功后，既可以通过`sero.getBalance`查看该智能合约所发行的token。

#### 调用智能合约
![](https://upload-images.jianshu.io/upload_images/277023-7b8f8c2fce9b7081.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

用智能合约本身定义的`transfer`方法，可以将智能合约的匿名币发送给个人账户中。

#### 转发匿名资产

现在`HELLOCOIN`的Token已经在`account[0]`的账户中，`account[0]`可以用普通的交易将它发送给其他的账户。但是一定记住必须在参数中指定币名`cy:"HELLOCOIN"`

```javascript
sero.sendTransaction({from:sero.accounts[0],to:sero.accounts[1],value:500,cy:"HELLOCOIN"})
```

![image.png](https://upload-images.jianshu.io/upload_images/277023-f1706217106739bc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

最后在accounts[1]的账户中可以看到他收到了500个`HELLOCOIN`的资产。

![image.png](https://upload-images.jianshu.io/upload_images/277023-af79f0c27be00fbe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

这笔交易也是匿名的。



## 12. 最后

入门课先上到这儿，接下来我们会详细的讲解SERO跟以太坊在使用方式最主要的差异，以及Token和Ticket两种匿名资产在智能合约调用中的使用方式。

如果对SERO的原理和零知识证明算法感兴趣，可以在SERO的[官网](https://sero.cash)下载我们的白皮书。有任何建议也可以发送电子邮件到 [gordon@sero.vip](gordon@sero.vip) 咨询。

欢迎加入SERO的[gitter社区](https://gitter.im/sero-cash/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link)，一起将SERO变得更好。

--
[[官网] https://sero.cash](https://sero.cash)
[[白皮书 V1.0.6] http://sero-media.s3-website-ap-southeast-1.amazonaws.com/Sero_ENG_V1.06.pdf](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/Sero_ENG_V1.06.pdf)
[[Twitter] https://twitter.com/SEROdotCASH](https://twitter.com/SEROdotCASH)
[[Telegram] https://t.me/SeroOfficial](https://t.me/SeroOfficial)
[[Github] https://github.com/sero-cash/go-sero](https://github.com/sero-cash/go-sero)
[[Gitter Community] https://gitter.im/sero-cash/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link](https://gitter.im/sero-cash/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link)
[[SERO区块浏览器]  https://explorer.web.sero.cash/blocks.html](https://explorer.web.sero.cash/blocks.html)
[[SERO智能合约编辑器]  https://remix.web.sero.cash/](https://remix.web.sero.cash/)
[[SERO介绍视频] https://v.qq.com/x/page/s0792e921ok.html](https://v.qq.com/x/page/s0792e921ok.html)
[[SERO vs Zcash加密速度对比] https://v.qq.com/x/page/r0796jotef8.html](https://v.qq.com/x/page/r0796jotef8.html)