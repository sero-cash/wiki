# 匿名Token发行原理

`超零` `sero` `zpk` `零知识证明` `blockchain` `nizk` `匿名币` `super-zk` `zh`



SERO是全球首个支持图灵完备智能合约的隐私区块链系统，既然是支持智能合约，当然不可能是简单的智能合约+匿名币。SERO深度整合了两者的优点：智能合约的开放性、隐私系统的封闭性。在这两种特性的支持下，SERO的智能合约具有非常令人兴奋的特性，可以做到一些神奇的事情。

本文主要讲解SERO提供的 `匿名 Token API` 在智能合约的应用，并在开篇简要的介绍一下匿名Token的生成原理。需要编译安装SERO的可以参考[SERO轻松入门](http://sero.cash)，加入我们[SERO开发者社区](https://gitter.im/sero-cash/developer?utm_source=share-link&utm_medium=link&utm_campaign=share-link)，在社区中可以问任何与SERO开发相关的问题。

作为基础，本文认为读者对区块链系统与原理有一个大致的了解。



## 一、UTXO和ACCOUNT

了解区块链构成的读者应该都知道，区块链是一个分布式账本，每个账本包含多笔交易`Tx`，而每笔交易又包含有多个记录。账本最小的单位是记录，每一笔帐记录一个账户资产的流入或者流出。但从实际的实现方式看，根据资产流出记录方式的不同，区块链系统演化出两种不同的记账实现，我们分别称之为UTXO模式和ACCOUNT模式。这两种模式分别对应比特币和以太坊的模式。而SERO则采用更为复杂的混合模式。

### 基于UTXO的交易

![image.png](https://upload-images.jianshu.io/upload_images/277023-d4f32a0a0768aca8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如上图，UTXO模式的记录有两种，对交易发起者来说就是`Input`和`Output`，这个`Output`在交易接受方看来就是`未花费输出(UTXO)`，直到交易接受者再发起一个交易，指定一个`Input`将这个`UTXO`作废掉。交易中的记录始终在链接各种输入和输出。在这种模式下，`ACCOUNT`作为一种状态摘要，不是必须的。

例如在上图中，Alice之前收到过一个交易`Tx 0`，这笔交易有一个输出`UTXO 0`，`UTXO 0`中有V个SERO币，她的账户上可以记录 [+V SERO,BALANCE=V]。而之后她将这V个SERO币转给Bob，那么她生成一个交易`Tx 1`，这个交易有一个`Input`将`UTXO 0`作废掉，那么Alice的`ACCOUNT`就应该记录[-V SERO,BALANCE=0]。而对于Bob，他就增加了一个价值为V个SERO的`UTXO 1`，如果他的`ACCOUNT`之前的`BALANCE`是0，它账户上就可以记录[+V SERO,BALANCE=V]。

**这种模式有两个优点：**

1. UTXO模式每笔交易是相互独立的，这意味着只要能处理好双花的问题，一个账户下的交易都可以并行处理，能充分应用多核CPU的能力。
2. UTXO本质上来说就是基于历史的记录形式，既是过程，也是结果，因此在一些需要生成见证证明的应用场合下，具有非常大的优势。这也是为什么具有隐私特性的区块链系统基本都是UTXO模式的。

### 基于ACCOUNT的交易

![image.png](https://upload-images.jianshu.io/upload_images/277023-0ee97ccbafff9d07.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

之前UTXO模式说到了每个账户可以生成一个临时的`ACCOUNT`作为状态摘要，在UTXO模式中，这个账户是临时的，不是必须的。而ACCOUNT模式中，交易中的每个资产流入流出记录都引用`ACCOUNT`而不是`UTXO`，记录`Input`表示增加这个`ACCOUNT`的资产，而记录`Output`表示减少一个账户的资产。在这种模式下，`ACCOUNT`实体是必须的，没有这个`ACCOUNT`，所有的记录都没有了意义。

跟上面一样，例如，Alice之前收到过一个交易`Tx 0`，这个交易有一个资产值为V个SERO的输出`Output 0`，她的`ACCOUNT`将增加V个SERO。这时她要给Bob转出V个SERO币，那么她发起一笔交易，交易的`Input`指向她的`ACCOUNT`，价值为V SERO币，`Output 1`指向Bob的`ACCOUNT`，价值也是V SERO币，那么这笔交易被系统处理的时候，将直接加减双方的`ACCOUNT`中的资产。在这种模式下，Alice并不能区分这个`Input`究竟是使用的`Output 0`输入的SERO币还是之前就已经存放在`ACCOUNT`的SERO币。

**ACCOUNT模式也有两个优势**

1. ACCOUNT模式直接增减一个独立账户中的资产，只需一个记录就可以增减一个账户的任意数量的资产。因此，生成的记录大小比同样情况下UTXO生成的记录要小很多。
2. ACCOUNT模式本质上是基于状态的，`Input`和`Output`是过程，`ACCOUNT`是结果，因此它天然就容易将图灵机引进来，这也是为什么支持图灵完备智能合约的区块链系统多采用ACCOUNT模式的原因。

### SERO的混合模式

![image.png](https://upload-images.jianshu.io/upload_images/277023-00dcc847debac203.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

SERO将UTXO和ACCOUNT模式混合应用，在需要支持隐私保护的地方采用UTXO模式，在需要运行智能合约的地方采用ACCOUNT模式。SERO通过交易、共识、以及Pedersen Commitment算法，将这两种模式无缝的整合到一起，使智能合约能发挥令人惊讶的能力。

> _本文所提到的`智能合约`，在SERO的白皮书中，对应 `链上运行智能合约` 这个概念_



## 二、匿名交易结构

在BetaNet网络中，SERO的普通交易是强制匿名的。因为如果可以允许任意非匿名交易，那么想要使用匿名功能的用户的隐私安全在关联交易中将得不到保证。另外，如果想要公示自己的资产等信息，建议使用智能合约，有限度的公开部分信息。

> 在MainNet发布时，SERO通过选择隐私级别来获得隐私性和生成速度的平衡。

### 交易 `Tx`

![image.png](https://upload-images.jianshu.io/upload_images/277023-9c52fb6586e6ba0e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

SERO的匿名交易`Tx`拥有一个匿名的输入集合`Z ins`，一个匿名输出集合`Z outs`，一个普通输出集合`O outs`，和一个名为`From`的暂存地址。`Z ins`完全是匿名的，让第三方观察者无法得知来源和内容，`Z outs`是完全匿名的`UTXO`，只有接收者能查看和使用它的内容，`O outs`携带的内容是非隐藏的，它指向的接受者有两种情况：一种是指向智能合约地址，一种是指向一个暂存地址。`From`代表着交易发送者，同样也是一个暂存地址。因此整个`Tx`无法让人确定真实的用户是谁，其中携带的资产等信息也最大程度被隐藏起来。

### 输入 `Z ins`

![image.png](https://upload-images.jianshu.io/upload_images/277023-52d7661f96f8479b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


在SERO交易的输入集合`Z ins`中，每个输入都是匿名的，包括来源`UTXO`的Id以及携带的资产信息。每个输入都通过采用零知识证明`ZKP`生成的`Proof`，指向一个被隐藏在巨大的`UTXO`序列中特定的某个`UTXO`，这个序列是SERO历史的一部分，所有的细节信息被`Proof`隐藏起来。验证者在不知道细节信息的情况下，通过`Proof`能确认这个输入是否合法。这种方式跟环签很像，不过我们的`Proof`自身的大小要比环签小很多，而且在零知识证明下，用来隐匿UTXO的集合的范围比环签也要大得多。

### 两种不同的输出 `outs`

![image.png](https://upload-images.jianshu.io/upload_images/277023-01ae40ec8cdfb86f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

SERO交易中包含的输出分为两种形式，零知识输出`Z out`和普通输出`O out`。

**Z out**
`Z out`指向的是暂存地址`PKr`，暂存地址只有接受者能解密出身份。由于每个暂存地址都不一样，所以，没有第三方能够识别`Z out`的指向。`Z out`还携带了资产的加密信息`Encrypt Info`，只有持有接受者私钥的人才能解密这些信息。而`OutCM`是输出承诺，只有交易的双方才能够复现`OutCM`的计算过程。`OutCM`在证明 “`Z out`被`ins`引用” 这一过程起到至关重要的作用。

**O out**
`O out`指向的PKr有两种形式，一种是由智能合约发起的，指向普通账户的暂存地址。另一种是由普通账户发起的，指向智能合约的地址。由于暂存地址的随机性，第三方无法得知接受者的身份，`O out`携带的资产信息是公开的。


### 输入和输出的平衡 `Balance`

![image.png](https://upload-images.jianshu.io/upload_images/277023-f95d65efdd4e239d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

`Tx`将`ins`、`Z outs`、`O outs`打包到一起，如何防止恶意攻击者篡改里面的数据并确保资产安全呢，我们通过引入**perdesen commitment**，它的同态加密特性使验证者在不知道信息细节的情况下，可以确认Balance一定是平衡的，即输入等于输出。

另外，为了防止恶意攻击者对`O outs`的篡改，我们利用**perdesen commitment**的随机特性，以`Balance`的随机部分对`Tx Hash`进行签名。如此以来，各个输入输出都可以独立进行计算，然后通过`B-Sign`打包到一起。

### 交易发送者 `From`
当交易的输出是指向智能合约时，智能合约有时根据编写的规则，需要将资源给输出到给定的账户。这时暂存地址`From`就是承接输出资源的地方。`From`在交易生成的时候就被确定，并且只使用一次，除了交易发送者外，其他人无法定位发送者的身份。



## 三、发行匿名Token的原理

#### Token资产
Token又称之为“同质化通证”，是SERO系统内部承认的一种资产形式。相同种类的Token可以任意的分割和混合，具体来说就是所谓的“币”。SERO币作为SERO系统的第一个币种，本质上也是一种Token。对于Token资产，除了手续费规定只能以SERO币缴纳外，在SERO系统的内部是同一对待的，由共识确保其隐私和安全性。

> 与以太坊中的Token概念不同，以太坊中的Token只是智能合约内部记录的一个符号，而ETH才是以太坊内部真正运行的Token资产。

####币名
每种Token都有一个币名，SERO系统初始化后，默认只有一个被注册的币名`SERO`。在智能合约发行匿名Token的时候，必须向SERO系统注册一个全局唯一的字符串作为该Token的币名。币名可以极大的提高你发行资产的可读性。

#### 匿名Token资产

![image.png](https://upload-images.jianshu.io/upload_images/277023-dad514ff5a2f031e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

SERO的智能合约有一个非常强大的功能，那就是可以任意发行`匿名Token`。当然，前提是你需要一个从未注册过的币名。一旦匿名Token发行成功，智能合约可以将Token以普通交易的形式发送到某个普通账户的暂存地址`PKr`，这时这些被发送的Token将以UTXO的形式脱离智能合约账户，并且与SERO币一样，进入用户的个人账户中，从而被SERO的隐私机制所保护。

> SERO币的发行是由矿工实现的，过程与智能合约发行匿名Token的机制类似，是SERO内建的Token发行功能。