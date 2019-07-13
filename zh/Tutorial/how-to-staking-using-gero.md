# 如何在gero上进行Staking



## SOLO Staking

你拥有一个全节点程序(gero)，并且拥有一定数量的 SERO 代币，既可进行SOLO，获取POS奖励部分比例为 3 的奖励。



### SOLO 的前提条件

1. 一个可以持续运行的全节点程序(gero)，并且已经同步完成区块。
2. SERO链上账户中拥有一定数量的 SERO 代币。



### 步骤

### 0. 步骤概要

1. 确认拥有购买股份的SERO代币。
2. 创建投票账户。
3. 开启自动投票功能（解锁投票账户）。
4. 在股份池中购买股份。
5. 查看当前股份情况。
6. 确认收益。



#### 1. 确认资产账户

为了安全，SERO 的资产账户和投票账户是分离的，本金和奖励只会由资产账户处理，我们现在确认资产账户。

```javascript
> sero.accounts[0]
"5bEgN9YLqCBN99S7e2TJ22RAFZSDkos6jnJWTrEpn4ybYyxNo31FJUGvhfScCVfrXNPDo6Z9Xrpti4zeamkdD16C"
> sero.getBalance(sero.accounts[0])
{
  tkn: {
    SERO: 10000000000000000000
  }
}
> web3.fromTa(sero.getBalance(sero.accounts[0]).tkn.SERO)
10
```



#### 2. 创建投票账户

投票账户里面不处理资产，只用来进行投票签名。

```javascript
> personal.newAccount("1234")
"2tuxyM5uL4ZDkfpKAFDP3z6LTPPpXyFxLwjqK9H4WADZ7X7oxUNPYu8QPprF8RiMEKqo84qVtw4xdTPCe5xNPokr"
> sero.accounts[1]
"2tuxyM5uL4ZDkfpKAFDP3z6LTPPpXyFxLwjqK9H4WADZ7X7oxUNPYu8QPprF8RiMEKqo84qVtw4xdTPCe5xNPokr"
```

**投票账户需要永久解锁，以便于被抽中后可以快速的进行投票。**

```javascript
> personal.unlockAccount()
```

**注意：SOLO Staking 需要确保全节点网络稳定，否则可能导致投票被 MISS**



### 3. 查看股份池状态

* 跟staking有关的接口都在stake对象里面

  ```javascript
  > stake
  {
    sharePoolSize: "0x0",
    sharePrice: "0x1bc16d674ec80000",
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
  "2"     // 当前票价是 2 SERO
  > web3.toDecimal(stake.sharePoolSize)
  0       // 当前股份池里面是 0 个股份
  ```

  

### 4. 认购股份

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
    id: "0xb5b01116f3e8......2a08b28171015afc6f",
    missed: 0,
    num: 1,
    price: 2001844456911510800,
    returnAmount: 20814755655292090000,
    status: 0,
    total: 9,
    tx: "0x47a87164f......13e422efee",
    voteAddr: "2tuxyM5uL4ZDk......4xdTPCe5xNPokr"
  }
  ```

  

* 查看我的总股份情况

  ```javascript
  > stake.myShare("5bEgN9YLqCBN9......pti4zeamkdD16C")
  [{
      addr: "5bEgN9YLqCB......rpti4zeamkdD16C",
      expired: 0,
      missed: 0,
      pools: null,
      remaining: 10,
      shareIds: ["0x3f2ae......a0c656d9b7b7", "0x58395b1......cfa4141d", "0xb5b011......171015afc6f"],
      total: 30,
      voteAddr: ["2tuxyM5uL4ZDkfp......Vtw4xdTPCe5xNPokr"]
  }]
  ```


### 5. 查看账户余额



## 如何创建 Staking Node

由于个人网络不稳定，或者是无法持续的开启全节点，那么就可以委托给 `Staking Node` 代为投票。

下面说明如何创建代为投票的 `Staking Node`

