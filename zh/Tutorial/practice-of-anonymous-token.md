# 超零协议(SERO)智能合约教程——发行匿名Token实战

标签（空格分隔）： sero-manual

`超零` `sero` `zpk` `零知识证明` `blockchain` `nizk` `匿名币` `super-zk` `zh` `anonymous` `anonymous token`

我们在上篇已经描述了[SERO智能合约发行匿名Token的原理](https://wiki.sero.cash/zh/index.html?file=Tutorial/principle-of-anonymous-token)，那么现在要介绍的是，如何一步一步发行你自己的Token。

<br/>

## 一. SERO的匿名Token能做什么

在目前的区块链公链中，发行匿名Token是SERO的独门绝技，只此一家，别无分号。那么我们能用这门绝技来做一些什么很酷的事情呢？

**利用SERO的匿名Token机制，你可以做到这样的事情：**

1. 向客户承诺你的Token具有和**SERO币同等**的匿名特性。
2. 业务成长后**安全的扩展**你的服务功能，而不用担心之前的智能合约没有提供某些接口。
3. 能用**智能合约编写去中心化交易所**，实现SERO上各种Token的兑换。
4. 向公众**只公开部分**你的运营信息。

> **在Beta-Release版本发布后你还可以**

1. 让访问你业务的客户用你发行的Token缴纳SERO的手续费。
2. 让你业务具有暗标的公正性。

> SERO通过发行匿名Ticket资产，可以提供更加让人惊讶的功能，详细的教程可以等待[《发行匿名Ticket实战》](https://wiki.sero.cash/zh/index.html)。

下面我们从一个假设的例子出发，看一看，如何在SERO上发行匿名的Token资产。

<br/>

## 二. 场景

Alice是一个公益组织的成员，她为了使贫困地区的失学儿童能够读书，打算开展一个募捐活动。公益活动的运作机制往往非常的复杂，下面几点是她非常关注的：

1. 募集到的钱都能真实的用在需要捐助的孩子身上，而不是被挪作它用。
2. 有些真正的慈善人士，捐助就是他们的主要目的，并不想公开他的捐助金额和身份。
3. 她希望这种关怀具有传递效应，让更多的人非常容易的参与进来，共同分担成本，帮助这些失学儿童。

为了运作这样的一个公益活动，Alice设计了一个名为**`明日花朵`**的区块链应用方案。这个方案是筹集善款与使用资金分离。当然，当她准备开始开发智能合约时，她发现，**目前唯一的一个能够满足这样的需求**，并且已经落地的公链，就只有**SERO协议**了。

**Alice的方案是这样的**

![image.png](https://upload-images.jianshu.io/upload_images/277023-edd4b2ba0ad45c85.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

她要开发一个智能合约，这个智能合约提供两种Token，分别是`Assisted Token`和`Helper Token`，这两种Token必须同比例发行(即购买了多少`Heper Token`，就必须对应的生成多少`Assisted Token`)。

* **Assisted Token**

  采用常规方式进行记录的，全程受到银行和公众监管，用来跟踪捐助儿童的情况。Assisted Token根据活动开展的需求和情况进行统一分配，所有最后拿到Token进行失学捐助申请资金的时候，必须完整的汇报资金运作的情况，并记录在区块链上，受到公众的监管。

* **Helper Token**

  用匿名方式来发行，用来进行慈善筹资。购买`Helper Token`的人则可以将Token交易给其他的慈善捐助者，以分担这项行动的成本，同时传递这种温暖的行为。这种行为造成的交易则应该享受相应的社会回报。`Helper Token`的交易也不会透漏捐助者的任何信息，因为它是匿名的。

好了，Alice有了这个可行的方案，虽然它不够完美，但是不妨碍我们将它开发出来。本文主要借助发行`Helper Token`的场景说明如何在SERO上发行匿名的Token资产。

> 本文着重讲述匿名Token的开发过程，Assisted Token是常规的Token发行，由于SERO的智能合约与以太坊是兼容的，公开资产的发行过程与以太坊是一致的，可以参考以太坊发行ERC20代币的方法。

<br/>

## 三. 发行匿名Token的步骤

> 你可以跟着我的步骤来发行一个你自己的匿名Token，如果对一些基本概念不熟悉，建议重温一下[《发行匿名Token原理》](https://wiki.sero.cash/zh/index.html?file=Tutorial/principle-of-anonymous-token)这篇文章。
>
> 另外，因为SERO发布智能合约的主要流程与以太坊是一致的。本文重点将讲述不同之处。

### 第一步. 准备工作

#### SOLIDITY语言

![image.png](https://upload-images.jianshu.io/upload_images/277023-2bdef85e6118d982.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

SERO采用solidity的编程语言进行智能合约的开发，目前兼容v0.5.0及以下的版本。如果对语法有疑问可以参考[《SOLIDITY官方手册》](https://solidity.readthedocs.io/en/v0.5.0/)。

#### SERO智能合约开发环境

![image.png](https://upload-images.jianshu.io/upload_images/277023-e09c65925d1f6783.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

我们建议你采用SERO官方定制的SOLIDITY IDE进行SERO智能合约的开发、编译。目前在它上面集成了发行匿名智能合约最基本的API(serointerface.sol)、一个发行匿名token的例子(token_test.sol)，和一些必须的自动化工作。后续我们会加入匿名资产调试功能。

你可以通过链接：[http://remix.web.sero.cash](http://remix.web.sero.cash)打开SERO的智能合约开发环境。
> 请注意，必须用非加密的方式(http://)，而不是(https://)的方式打开链接才能正常运行。



#### 全节点服务程序(gero)或者SERO客户端钱包(Wallet)

虽然SERO的客户端钱包也可以发布智能合约，但是我们强烈建议你采用全节点服务程序来发布智能合约，这样你可以获得更多的信息和灵活性。

本文采用gero来说明智能合约的发布过程，有关gero的编译和安装，请参考[《SERO轻松入门》](https://wiki.sero.cash/zh/index.html?file=Start/from-the-sourcecode-base-on-centos7)以及[《SERO挖矿教程》](https://wiki.sero.cash/zh/index.html?file=Start/from-the-binary-package)




> 你可以在这个页面获得最新的gero源码和编译好的包
> [https://github.com/sero-cash/go-sero/releases](https://github.com/sero-cash/go-sero/releases)

![image.png](https://upload-images.jianshu.io/upload_images/277023-91763145b4fe8435.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)


关于如何用钱包发布智能合约，请参考[《SERO钱包使用手册》](https://wiki.sero.cash/zh/index.html?file=Tutorial/manual-of-wallet)

> 你可以在这个页面获得最新的wallet的源码和编译好的安装包
> [https://github.com/sero-cash/wallet/releases](https://github.com/sero-cash/wallet/releases)

![image.png](https://upload-images.jianshu.io/upload_images/277023-060fc708d35cdff7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

<br/>

### 第二步. 确定币名
现在我们要发行Helper Token，我们先为这种Token取个名字，比如叫做 **`"TFHCOIN"`** 意为`"明日之花捐助者币"`(Tomorrow Flowers Helper Coin)。

需要注意的是，币名需要通过SERO提供的基础接口注册到SERO共识中，而且它必须满足下面的条件：

> * 不区分大小写
> * 在全局上不能重复
> * 不能超过24个字符
> * 只能采用数字`0-9`大写英文字母`A-Z`和下划线`_`
> * 不能包含`SERO`关键字

因此，你在重复这个例子的时候，可以采用SERO的Dev模式来确保你是第一个使用这个名字的开发者。

<br/>

### 第三步. 在SERO的solidity IDE上编辑智能合约


#### 1. SERO基础接口

SERO IDE的左侧有个名为`serointerface.sol`的文件，这个文件中有个名为`SeroInterface`的基础合约。需要发行匿名Token就必须继承这个合约。本文中这个合约主要用到的接口是这些：

```JavaScript
pragma solidity ^0.4.25;

contract SeroInterface {

  function sero_issueToken(
      uint256 _total,
      string memory _currency
  ) internal returns (bool success) {...}
  
  function sero_balanceOf(
      string memory _currency
  ) internal returns (uint256 amount) {...}
  
  function sero_send_token(
      address _receiver,
      string memory _currency,
      uint256 _amount
  ) internal returns (bool success){...}
  
  ...
  
}
```

* ***`sero_issueToken`*** 有两个作用，第一是注册一个币名`_currency`，第二是生成`_total`个对应的token给智能合约账户。
> **注意:** 当币名已经存在的前提下，只有创建该币名的智能合约能够再次调用次这个方法增发Token。

* ***`sero_balanceOf`***作用是智能合约账户持有币名为`_currency`的Token余额，
> **注意:** 这里的`_currency`可以不是本智能合约发行的币名，甚至可以是`SERO`。也就是说智能合约原生就可以接受任何和普通账户一样的资产。

* ***`sero_send_token`***作用是将智能合约账户中，币名为`_currency`的`_amount`个Token，转账给地址`_receiver`。
> **注意:** 这里的`_receiver`可以是普通账户也可以是智能合约，如果是普通账户，只支持暂存地址`PKr`。如果你向任何公钥地址`PK`转账，Token将转到一个没有人能再次使用的账户中。

<br/>

#### 2. 在IDE中编写一个简单的发行**`"TFHCOIN"`**的智能合约`TFHCoin.sol`

```JavaScript
// TFHCoin.sol
pragma solidity ^0.4.16;
import "./seroInterface.sol";

contract TFHCoin is SeroInterface {
    
    string private _currency="TFHCOIN";
    address private _owner;

    constructor()
          public
    {
        _owner=msg.sender;
        if(!sero_issueToken(
              1000000000*10**9,
              _currency
        )){
            require(false);
        }
    }

    function balanceOf()
          public returns (uint256 amount)
    {
        return sero_balanceOf(_currency);
    }
    
    function transfer(
          address _to,
          uint256 _value
    )
          public returns (bool success)
    {
        require(_owner==msg.sender);
        return sero_send(_to,_currency,_value,'','');
    }

}
```

* 首先我们看看构造方法`constructor`，在方法体中，我们将创建者记为`_owner`，并调用`sero_issueToken`以 $10^9$ 为精度发行10亿币名为`TFHCOIN`的Token，返回值表示是否成功。如果不成功我们就回滚整个交易。

* `balanceOf`方法调用`sero_balanceOf`查询当前智能合约所持有的`TFHCOIN`的余额。

* `transfer`方法先判断调用者是不是`_owner`，然后向暂存地址`_to`转出`_value`个`TFHCOIN`。

> **注意:** `_to`是暂存地址`PKr`，如果使用公钥地址`PK`，这笔Token将不会有任何账户能再次使用。

<br/>

#### 3. 编译 **`TFHCoin.sol`**

* 在IDE的右侧选择`TFHCOIN`智能合约，并点击旁边的`Detail`按钮。

![image.png](https://upload-images.jianshu.io/upload_images/277023-e23b8cb8c9b8e467.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* 在弹出框中找到`WEB3DEPLOY`旁边拷贝的按钮拷贝编译后的内容

![image.png](https://upload-images.jianshu.io/upload_images/277023-34d4e074e8c13375.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

> **注意** `TFHCOIN`的构造方法没有传入参数，如果有传入参数，你需要先将它拷贝到文本编辑器将构造方法的初始化参数设置好。

<br/>

#### 4. 运行gero后台以及命令行控制台

> 对于gero后台以及控制台的运行方法请参考[《SERO轻松入门》](https://wiki.sero.cash/zh/index.html?file=Start/from-the-sourcecode-base-on-centos7)以及[《SERO挖矿教程》](https://wiki.sero.cash/zh/index.html?file=Start/from-the-binary-package)

由于我们是采用Dev模式运行的gero，因此我们需要先创建一个账户，并为他准备一些SERO作为手续费用。
```JavaScript
   > alice_addr=personal.newAccount("1234")
   "2yKtQ7rMHLn1dSSuAFvsi1s7NaLL1zkNysmMv4L51WCubgjHtMtKNwVsDdEMXXH1QvmWQgKTKcyUXBK2RUPoK7mo"
   > sero.accounts
   ["2yKtQ7rMHLn1dSSuAFvsi1s7NaLL1zkNysmMv4L51WCubgjHtMtKNwVsDdEMXXH1QvmWQgKTKcyUXBK2RUPoK7mo"]
   > miner.start();admin.sleepBlocks(1);miner.stop();
   true
   > sero.getBalance(alice_addr)
   {
     tkn: {
       SERO: 24000000000000000000
     }
   }
```

<br/>

#### 5. 安装智能合约

* **然后我们将从IDE拷贝出来的编译后代码粘贴进控制台里面，并回车创建交易。**
   ![image.png](https://upload-images.jianshu.io/upload_images/277023-7510f0afadee18a5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
   智能合约的安装是附带在交易中进行的，交易创建之后可以查看这笔交易的地址。用此地址可在区块浏览器中查询到当前打包的状态。

```JavaScript
   > tfhcoin.transactionHash
   "0x254bbefcbe0eaa3cb5a657377fd49b756880839a1bb69eaa006106a882055f09"
```

* **现在挖出一个区块打包这笔交易，确认成功即代表智能合约被成功安装了。**

   ![image.png](https://upload-images.jianshu.io/upload_images/277023-184f8bc5a3ef536e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

   安装成功后SERO控制台会返回智能合约地址和交易号


* **现在可以查看智能合约地址中的余额。**

```JavaScript
  > sero.getBalance(tfhcoin.address)
  {
        tkn: {
            TFHCOIN: 1000000000000000000
        }
  }
```



目前我们已经生成了以 $10^9$ 为精度，数量是10亿，币名为`TFHCOIN`的Token。

<br/>

#### 6. 向外发行 **`TFHCOIN`**

* 发行`TFHCOIN`的意思是，Alice和她的机构接受捐助者的捐助，并发给捐助者相应数量的`TFHCOIN`，同时将收取的捐助的钱交由监管机构进行监管。

   > 我们可以调用TFHCoin智能合约的`transfer`方法，实现将一定数量的TFHCoin发送给捐助者。

* 为此我们创建一个假的捐助者`helper_addr`来测试这个功能。
```JavaScript
   > helper_addr=personal.newAccount("1234")
   "37NVgL22rksMLK6Euos9eoS2T7prRUrXKzMMXPYr4SfNCaiDgXfvbfe6SmD3EgfhRuZtPekop3BgwGRByWLSeRHg"
```

* 用`account[0]`给这个捐助者发出10个`TFHCOIN`。
```JavaScript
   > tfhcoin.transfer(helper_addr,10*1000000000,{from:sero.accounts[0]})
   "0xbd290e7c1385af11eb8bedbb3c03644dd27bcd7ae12604aac7e40d66597efee0"
   > miner.start();admin.sleepBlocks(1);miner.stop();
   true
   > sero.getBalance(helper_addr)
   {
       tkn: {
         TFHCOIN: 10000000000
       }
   }
   > sero.getBalance(tfhcoin.address)
   {
       tkn: {
         TFHCOIN: 999999990000000000
       }
   }
```

  `transfer`方法调用过之后，可以看到helper_addr的账户中多出了10个`TFHCOIN`，而智能合约地址则少了10个`TFHCOIN`。

  > **注意:** 之前我们说到`transfer`的第一个参数`_to`需要用暂存地址`PKr`。但是在SERO的控制台中，你可以直接使用对方的公钥地址`PK`进行转账。SERO控制台会自动的用`PK`生成`PKr`来构造这笔交易。

<br/>

#### 7. 捐助者卖出**`TFHCOIN`**使其他捐助者和他一起共同分担捐助份额
* 由于我们是Dev账户，`helper_addr`并没有充当交易费的`SERO`币，因此主账户先转10个`SERO`币给`helper_addr`。

```JavaScript
   > sero.sendTransaction({from:alice_addr,to:helper_addr,value:web3.toTa(10)})
   "0x9a5fd4f155254483f62a0cd85341ef8942e8a433b1be903a646740a8debb636f"
   > miner.start();admin.sleepBlocks(1);miner.stop();
   true
   > sero.getBalance(helper_addr)
   {
        tkn: {
          SERO: 10000000000000000000,
          TFHCOIN: 10000000000
        }
   }
```

   我们先来看看这笔SERO交易的构成

```JavaScript
   > sero.getTransaction("0x9a5fd4f155254483f62a0cd85341ef8942e8a433b1be903a646740a8debb636f")
   {
     blockHash: "0x937ddb...1f6120",
     blockNumber: 7,
     gas: 90000,
     gasPrice: 1000000000,
     hash: "0x9a5fd4f...b636f",
     input: "0x",
     nonce: 0,
     stx: {
      Bcr: "0x7b309...0f617",
      Bsign: "0xd38f8a...e2705",
      Desc_O_Ins: [],
      Desc_O_Outs: [],
      Desc_Z_Ins: [{
          Anchor: "0x89ef81...33e2e99",
          AssetCM: "0x795c4...11720",
          Nil: "0x986d5...32afdf",
          Proof: "0x03687c...d0aefc21c",
          Trace: "0x5abf87...04006"
      }],
      Desc_Z_Outs: [
         {
          AssetCM: "0x1eee25e...da8816",
          OutCM: "0x25773...c164ba9",
          PKr: "0x5e4f8b...ec6902",
          Proof: "0x0215c...6a526"
         }, 
         ...
      ],
      Ehash: "0xd8483...14a4",
      Fee: "90000000000000",
      From: "0x568ec...bfb5dd07",
      Sign: "0x95f35...f8b600"
     },
     to: null,
     transactionIndex: 0,
     value: 0
   }
```
   **是不是没有任何泄漏出来的信息，不知来源，不知去处，不知金额！**

<br/>

* 我们创建一个假的其他捐助者`other_helper_addr`接收`helper_addr`的`TFHCOIN`。

```JavaScript
   > other_helper_addr=personal.newAccount("1234")
   "15B2TPeRdE6GwKsE2V7sprk3yYZXuTVaGMGNXZZAUUHRH3U5pW59BZWhXhAud2a8zFxPp9JRBz4akpHwoLx99No"
```

* 现在 `helper_addr` 可以采用匿名的方式转5个`TFHCOIN` 给 `other_helper_addr`

```JavaScript
   > sero.sendTransaction(
      {from:helper_addr,to:other_helper_addr,value:5*1000000000,cy:"TFHCOIN"}
   )
   "0x7024f426f376d188b6980b720d44104fe3f908d25d0d53c3f7e130f30f6d9765"
   > miner.start();admin.sleepBlocks(1);miner.stop();
   true
   > sero.getBalance(helper_addr)
   {
     tkn: {
       SERO: 9999975000000000000,
       TFHCOIN: 5000000000
     }
   }
   > sero.getBalance(other_helper_addr)
   {
     tkn: {
       TFHCOIN: 5000000000
     }
   }
```

   * **我们注意两个个事情:**
     > * 个人给个人发送`TFHCOIN`采用的是与发送`SERO`相同的方式，即SERO的原生转账机制，而不是智能合约`TFHCoin`的方法`transfer`。这说明`TFHCOIN`确实与`SERO`是平等存在在用户账户中的。
     > * 在交易参数中多出一个币名`cy`，其值是`"TFHCOIN"`。



* **然后我们再来看这笔交易的详情:**

```JavaScript
  > sero.getTransaction(
  "0x7024f426f376d188b6980b720d44104fe3f908d25d0d53c3f7e130f30f6d9765"
  )
   {
     blockHash: "0x735bb...17c3a",
     blockNumber: 10,
     gas: 90000,
     gasPrice: 1000000000,
     hash: "0x7024f...d9765",
     input: "0x",
     nonce: 0,
     stx: {
       Bcr: "0x85247...d8a714",
       Bsign: "0x52013f...6df801",
       Desc_O_Ins: [],
       Desc_O_Outs: [],
       Desc_Z_Ins: [
         {
             Anchor: "0xb0aaddf...d856d06",
             AssetCM: "0x2d3cc...89cf62d",
             Nil: "0x30da...bcee20",
             Proof: "0x025eed...da7031b",
             Trace: "0x811f...90b10b"
         },
         ...
       ],
       Desc_Z_Outs: [
         {
             AssetCM: "0xac8f2...e11c3ad",
             OutCM: "0x0a586e...13e2486",
             PKr: "0x875808...14d1c10",
             Proof: "0x036b46...8d100e"
         },
         ...
       ],
       Ehash: "0xf125e7...4809768",
       Fee: "90000000000000",
       From: "0x807dc...d1bb80a",
       Sign: "0xadf77...003702"
     },
     to: null,
     transactionIndex: 0,
     value: 0
   }
```

  **是不是与前面看到的`SERO`转账一样，不知来源，不知去处，不知金额！**


## 四. 总结

有了这个发行`TFHCOIN`的智能合约的原型，Alice可以在之后不断的丰富它以达到她的慈善目的。在智能合约被安装发行之后，由于发行的Token是直接进入了用户账户，而不是由智能合约代持，因此很容易写出另外一个智能合约来接收这种Token，为这种Token增加新的逻辑，就像为`SERO`增加新逻辑一样简单。

当然，Alice要完成她的事业需要很长的路要走，我们也希望SERO能够被用于正确的正义的事业上。
