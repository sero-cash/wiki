# 如何在gero上进行Staking

> `Staking` 功能需要运行`v1.0.0-rc0`以上版本的全节点程序才能支持。
>
> 本文主要为全节点后台程序使用者提供，界面钱包的使用者请静待后续说明文档。
>
> **Staking 功能需要在 `1300000`的高度之后才生效**



进行Staking需要开启gero的exchange服务，启动时可以加入`--exchange --mineMode`两个参数：

```sh
./gero --exchange --mineMode --datadir ~/datadir
```



## Staking 过程简要描述

* POS 矿工可以在股份池里面购买投票的股份
  * 股份设有股份池，无上限。
  * 股份的价格根据股份池大小动态调整。
  * 股份池大小 326592 以内股份价格的变化比较平衡。
  * 股份池大小超过 326592 后股份价格急剧上升。
* POW 矿工计算出区块 HASH 之后，将随机在股份池中选择 3 个股份，并广播选票信息。
* POS 矿工收到属于自己的选票信息之后，立即广播自己签名后的投票信息。
* POW 矿工在收到 POS 矿工的投票信息之后，将签名放入区块头部信息中。
* 如果正确的投票超过 2 个，POW 矿工将广播区块，完成出块过程。
* POS 矿工可以选择 SOLO 投票或 StakingNode 代投票。
* 每个区块奖励分为 POW 奖励和 POS 奖励
  * POW 奖励和 POS 奖励的比例为 4 : 4
  * POW 奖励和 POS 奖励的大小随各自难度独立变化。
* POS 奖励分为 Solo 投票和 StakingNode 代投票两种情况
  * Solo 奖励和代投票奖励的比例为 3 : 4
* 完成投票过程后，所涉及的奖励和本金会在最近的一个支付周期（大约1周）内退回。



## Share 的生命周期

![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/277023-2ec741ac26b57a57.png)

* 用户选择一定的价格购买股份后，本金即进入锁定状态**(Lock)**，股份进入当前的股份池中 **(InPool)**。
* POW矿工在出块时随机选择3份股份，被选中的股份进入待投票状态 **(Lottery)**
  * 至少获得两个投票才能完成出块过程。
* POS矿工在接收到待投票消息后，成功将投票信息广播给POW矿工完成出块，股份进入完成状态**(Votted)**
  * 进入完成状态的股份会在一个支付周期(一周)内归还本金和奖励，同时释放股份。
* 当区块只有两份成功投票的情况下，另外一份股份则进入错失状态**(Missed)**。
  * 作为惩罚，进入错失状态的股份将会在连续锁定3个月后释放本金。
* 在股份池中没有被成功选中的股份一个月后过期**(Expire)**
  * 过期时会释放本金。



## StakingNode的生命周期

![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/277023-c92bcb3bb1712720.png)

* 运营者通过锁定20万SERO币可以获得运营StakingNode 的权利。
* StakingNode在运营一个月后才能进入关闭状态 **(Close)**
  * 关闭之后将不允许新的股份代投申请。
  * 同时运营者有义务完成现在StakingNode中已有的股份。
* StakingNode在同时满足下面两个条件下将归还本金进入结束状态**(Finish)**：
  * 所有代投股份本金全部释放
  * 进入关闭状态



## SOLO Staking

你拥有一个全节点程序(gero)，并且拥有一定数量的 SERO 代币，既可进行SOLO，获取POS奖励部分比例为 3 的奖励。



### SOLO 的前提条件

1. 一个可以持续运行的全节点程序(gero)，并且已经同步完成区块。
2. SERO链上账户中拥有一定数量的 SERO 代币。



### 步骤

### 1. 步骤概要

1. 确认拥有购买股份的SERO代币。
   * **发放收益或者股份过期的时候本金也会一起退回**
2. 创建投票账户。
3. 开启自动投票功能（解锁投票账户）。
4. 在股份池中购买股份。
5. 查看当前股份情况。
6. 确认收益。



> **注意：一定要备份好账户密钥，普通用户可以拷贝keystore进行备份，也可以导出助记词：**
> 
> ```javascript
> > personal.exportMnemonic(sero.accounts[0])
> export account mnemonic 5bEgN9YL......Xrpti4zeamkdD16C
> Passphrase: 1234                             //密码
> "casino crys ... ... en unaware route"
> ```
> 
> 可以这样导入助记词：
> 
> ```javascript
> > personal.importMnemonic("casino cry ... ... re route","1234")  //1234 是密码
> ```





#### 2. 确认资产账户

为了安全，SERO 的资产账户和投票账户是分离的，本金和奖励只会由资产账户处理，我们现在确认资产账户。

```javascript
> sero.accounts[0]
"5bEgN9YLqC......4zeamkdD16C"   //账户公钥PK
> web3.fromTa(sero.getBalance(sero.accounts[0]).tkn.SERO)
10               //20 个SERO
```



#### 3. 创建投票账户

投票账户里面不处理资产，只用来进行投票签名。

```javascript
> personal.newAccount("1234")
"2tuxyM5uL4......Ce5xNPokr"
> sero.accounts[1]
"2tuxyM5uL4......Ce5xNPokr"    //账户公钥PK
```

**投票账户需要永久解锁，以便于被抽中后可以快速的进行投票。**

```javascript
> personal.unlockAccount(sero.accounts[1],"1234",0)
```

**注意：SOLO Staking 需要确保全节点网络稳定，否则可能导致投票被 MISS**



### 4. 查看股份池状态

* 跟staking有关的接口都在stake对象里面

  ```javascript
  > stake
  {
    sharePoolSize: "0x0",                    //股份池当前大小
    sharePrice: "0x1bc16d674ec80000",        //当前股份价格
    buyShare: function(),
    closeStakePool: function(),
    getShare: function(),
    getSharePoolSize: function(callback),
    getSharePrice: function(callback),
    modifyStakePoolFee: function(),
    modifyStakePoolVote: function(),
    myShare: function(),
    poolState: function(),
    registStakePool: function(),
    stakePools: function()
  }
  ```

  

* 查看当前股份池的情况

  ```javascript
  > web3.fromTa(web3.toDecimal(stake.sharePrice))
  "2"     // 当前股份价各是 2 SERO
  > web3.toDecimal(stake.sharePoolSize)
  0       // 当前股份池里面是 0 个股份
  ```

  

### 5. 认购股份

* 估算能购买的股份数

  * 因为股份价格随股份池的大小线性增加，所以需要先估算可购买的股份数。
  
  ```javascript
  > stake.estimateShares({
        from:sero.accounts[0],        //资金账户
        vote:sero.accounts[1],        //投票账户
        value:web3.toTa(20)           //可出的总金
  })
  {
    avPrice: "0x1bc6ab6c2dfe1734",          //平均股份价格
    basePrice: "0x1bc16d674ec80000",        //基础股份价格
    total: "0x9"                            //可购买数量
  }
  ```
  
  
  
* 认购，from 资金账户，vote 是投票账户，value是本次认购资金

  ```javascript
  >   stake.buyShare({from:sero.accounts[0],vote:sero.accounts[1],value:web3.toTa(20)})
  "0xac137baf4cd195....17c1fcb3edae4d25"
  > sero.getTransactionReceipt("0xac137baf4....cb3edae4d25")
  {
    ....
    poolId: null,
    shareId: "0xb5b01116f......71015afc6f",   //购买到的股份ID
    ....
  }
  ```



* 查看本次股份购买的情况

  ```javascript
  > stake.getShare("0xb5b01116f......71015afc6f")
  {
    addr: "5bEgN9YLq......4zeamkdD16C",
    id: "0xb5b01116f3e8......2a08b28171015afc6f",      //你的股份ID
    missed: 0,
    num: 1,
    price: 2001844456911510800,                       //平均价格
    returnAmount: 20814755655292090000,               //已归还金额
    status: 0,
    total: 9,                                         //股份数
    tx: "0x47a87164f......13e422efee",
    voteAddr: "2tuxyM5uL4ZDk......4xdTPCe5xNPokr"     //投票账户的收款码
  }
  ```

  

* 查看我的总股份情况

  ```javascript
  > stake.myShare("5bEgN9YLqCBN9......pti4zeamkdD16C")
  [{
      addr: "5bEgN9YLqCB......rpti4zeamkdD16C",
      expired: 0,                                //股份过期数量
      missed: 0,                                 //投票miss数量
      pools: null,
      remaining: 10,                             //剩下的股份数
      shareIds: [                                //我拥有的股份ID列表
        "0x3f2ae......a0c656d9b7b7",
        "0x58395b1......cfa4141d",
        "0xb5b011......171015afc6f"
      ],
      total: 30,                                 //我的总股份数
      voteAddr: ["2tuxyM5uL4ZDkfp......Vtw4xdTPCe5xNPokr"]    //我的投票ID
  }]
  ```

### 6. 查看账户余额

```javascript
> web3.fromTa(sero.getBalance(sero.accounts[0]).tkn.SERO)   //资金账户
339.980079865355683522
> sero.getBalance(sero.accounts[1])    //投票账户
{}
```





## 如何创建 Staking Node

由于个人网络不稳定，或者是无法持续的开启全节点，那么就可以委托给 `Staking Node` 代为投票。

下面说明如何创建代为投票的 `Staking Node`

### 前提

1. 拥有一个持续在线的全节点程序(gero)。
2. 拥有一个包含 20万 SERO 余额的链上账户。
3. 拥有良好的网络环境。

### 步骤

#### 1. 步骤概要

1. 确认拥有用来质押的 20 万SERO代币。
   * Node 关闭的时候本金会退回
2. 创建代投票账户。
3. 开启自动代投票功能（解锁代投票账户）。
4. 质押SERO币开通 Staking Node
5. 查看当前节点委托情况情况。
6. 确认收益。

#### 2. 确认资产账户

```javascript
> sero.accounts[0]
"5bEgN9YLqC......4zeamkdD16C"
> web3.fromTa(sero.getBalance(sero.accounts[0]).tkn.SERO)
200000.980079865355683522
```



#### 3. 创建代投票账户

```javascript
> personal.newAccount("1234")
"2tuxyM5uL4......w4xdTPCe5xNPokr"
> sero.accounts[1]
"2tuxyM5uL4......Ce5xNPokr"
```



#### 4. 开启自动代投票功能（解锁代投票账户）

**投票账户需要永久解锁，以便于被抽中后可以快速的进行投票。**

```javascript
> personal.unlockAccount(sero.accounts[1],"1234",0)
```

**注意：** StakingNode 需要确保全节点网络稳定，否则可能导致投票被 MISS，Miss的投票可能会导致StakingNode 本金锁定时间增加。



#### 5. 质押SERO币注册 Staking Node

客户端需要连接有10个以上的`peer`才能开启注册权益池的指令

```javascript
> admin.peers.length
15
```

开始注册`StakingNode`，注意在本例中`accounts[0]`拥有20万SERO币，是资金账户。

```javascript
> stake.registStakePool({
      from:sero.accounts[0],        //资金账户
      vote:sero.accounts[1],        //投票账户
      value:web3.toTa(200000),      //注册资金
      fee:web3.toHex(2500)    //抽成，最高7500代表抽成75%，最低2500代表抽成25%
})
"0xecb3b5b235....8d35d7d1651"       //注册生成的交易hash
```

可以通过查看交易收据查看本次注册的`StakingNode`的`ID`。

```javascript
> sero.getTransactionReceipt("0xecb3b5b....7d1651")
{
  ......
  poolId: "0xb1e20b74......2b35888176d",          //StakingNode ID
  shareId: null,
  ......
}
```

**注意：**`StakingNode` 质押的本金需要锁定3个月之后才能解锁，但是必须在关闭权益池并且没有指向权益池的股份后才能回收。

#### 6. 查看当前节点委托情况情况以及收益

可以通过 `poolState` 方法查看`StakingNode`的状态。

```java
> stake.poolState("0xb1e20b......88176d")
{
  choicedNum: "0x0",                                     //被选中的股份数量
  closed: false,                                         //Staking Node是否关闭
  createAt: "0x11",                                       //Staking Node创建的时间
  expireNum: "0x0",                                      //Staking Node过期委托股份数
  fee: "0xfa0",                                          //Staking Node的抽成
  id: "0xb1e20b7......88176d",                           //Staking Node的ID
  idPkr: "2E7uXmU9......GeQyGBzSvWE",
  lastPayTime: "0x0",                                    //最后一次支付时间
  missedNum: "0x0",                                      //错失的票数
  own: "5bEgN9YLqC......4zeamkdD16C",                    
  shareNum: "0x0",                                       //总股份数
  tx: "0xecb3b5b......d1651",
  voteAddress: "2tuxyM5uL4......w4xdTPCe5xNPokr",
  wishVoteNum: "0x0",
  profit: "0x100"
}
```





## 如何选中 Staking Node 为自己代投票

普通用户只需要在购买股份的时候指定代投的Staking Node，即可不用部署全节点，享受方便的代投票服务。

#### 1.查询全网Staking Node列表

```javascript
> stake.stakePools()
[{
    choicedNum: "0x0",                          //被选中的股份数
    closed: false,                              //是否关闭
    createAt: "0x0",
    expireNum: "0x0",                           //过期股份数
    fee: "0xfa0",                               //抽成费用
    id: "0xb1e20b7......2b35888176d",           //StakingNode ID
    idPkr: "2E7uXm......yGBzSvWE",
    lastPayTime: "0x0",
    missedNum: "0x0",                           //丢失票数
    own: "4ujQrFsaYq......WZzxtnqgTsL",
    shareNum: "0x0",                            //总股份数
    tx: "0xecb3b5b......35d7d1651",
    voteAddress: "21F6gyEUw......zMZ5VtGL2",
    wishVoteNum: "0x0"
}, {
    choicedNum: "0xac",
    closed: false,
    createAt: "0x0",
    expireNum: "0x30d",
    fee: "0x123b",
    id: "0xc48e455......2af708a",
    idPkr: "2WCHu3......jbFrXWE",
    lastPayTime: "0x12b404",
    missedNum: "0x60",
    own: "2WCHu3bM......jbFrXWE",
    shareNum: "0x4fe",
    tx: "0xb9a0a......dc0212",
    voteAddress: "JyRPyD8n......bucfZbRH",
    wishVoteNum: "0x0"
}]
```



#### 2. 在购买股份的时候选择代投票Staking Node

```javascript
> stake.buyShare({
      from:sero.accounts[0],
      vote:sero.accounts[0],
      pool:"0xc48e45......af708a",    //选择 StakingNode ID
      value:web3.toTa(2000)
})
"0xb524ec5......b8d511b0b"

> sero.getTransactionReceipt("0xb524e......8d511b0b")
{
  ......
  shareId: "0x9e415fa4......94e4eef",        //购买的股份ID
  ......
}
```



#### 3. 确认票的Staking Node的情况

```javascript
> stake.getShare("0x9e415f......94e4eef")
{
  addr: "4ujQrFsaY......zxtnqgTsL",
  id: "0x9e415f......994e4eef",
  missed: 0,
  num: 723,
  pool: "0xc48e4557......ec62af708a",       //本股份选择的StakingNode ID
  price: 2739073884442371600,
  returnAmount: 23602264528913793000,       //收益
  status: 0,
  total: 730,
  tx: "0xb524ec5......b8d511b0b",
  voteAddr: "4ujQrFsaYq......qWZzxtnqgTsL"
}
```



## 本金退回的情况

* Staking的设计不会没收或者销毁任何用户的本金。
* 发送下面几种情况的时候，股份的本金会退回
  * 完成投票过程的股份，在发放奖励的同时退回本金。
  * 股份超过1个月没有被任何矿工选中，会退回本金。
  * 被选中但没有回应的股份，在第3个月的时候被退回。
* 同时发生下面几种情况的时候，StakingNode本金会被退回
  * StakingNode被所有者关闭
  * StakingNode注册完成满一个月
  * 票池中已经没有委托该StakingNode的股份
