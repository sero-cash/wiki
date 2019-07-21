# How to start SERO Staking on gero ?



> The `Staking` feature is supported by full-node programs running `v1.0.0` or above.
>
> This article is mainly provided for users of full-node background program. Users of the wallet with a graphical interface, please wait for the subsequent documentation.
>
> **Staking function will be effective after the height of block `1300000`**



## A brief description of the process of Staking

* POS miners can buy voting shares in the shares pool.
  * Shares have a pool of shares with no upper limit.
  * The price of the shares is dynamically adjusted according to the size of the shares pool.
  * The share price change within the pool size of 326592 is relatively balanced.
  * After the stock pool size exceeded 326,592, the share price rose sharply.

* After the POW miner calculates the block HASH, he need to randomly select 3 shares in the shares pool and broadcast the ballot information.
* After receiving the ballot information of their own, the POS miner immediately broadcasts the voting information with his signature.
* After receiving the voting information of the POS miner, the POW miner puts the signature into the block header information.
* If more than 2 votes are correctly voted, the POW miner will broadcast the block and complete the block process.
* POS miner can choose SOLO voting or StakingNode proxy voting.
* Each block reward are divided into POW rewards and POS rewards.
  * The ratio of POW rewards to POS rewards is 4 : 4
  * The amount of POW rewards and POS rewards varies independently of each difficulty.

* POS rewards are divided into Solo voting and StakingNode proxy voting.
  * The income ratio of Solo voting and StakingNode proxy voting is 3 : 4

* After the voting process is completed, the reward and principal will be returned within the latest payment cycle (about 1 week).



## SOLO Staking

You should have a full-node program (gero) and have a certain number of SERO tokens to make a SOLO vote and get a proportion of 3 POS rewards.

### Prerequisites for SOLO

1. A continuously running full-node program (gero), which has completed the block synchronously.
2. There is a certain amount of SERO coins in the account.

### Steps

### 1. Summary of steps

1. Confirm that there are enough SERO coins to buy shares.
   * **The principal will also be returned when the proceed is released or the share is expired**
2. Create a voting account.
3. Enable automatic voting function (unlock voting account).。
4. Buy shares in the shares pool.
5. View current share status.
6. Confirm revenue.

> **Note: the account key must be backed up. Ordinary users can copy the keystore for backup or export mnemonics:**

>
> ```javascript
> > personal.exportMnemonic(sero.accounts[0])
> export account mnemonic 5bEgN9YL......Xrpti4zeamkdD16C
> Passphrase: 1234                             // Password
> "casino crys ... ... en unaware route"
> ```
>
> The mnemonics can be imported like this:
>
>
> ```javascript
> > personal.importMnemonic("casino cry ... ... re route","1234")  //1234 is password
> ```

#### 2. Confirm the asset account

For safety, SERO's asset account and voting account are separated, principal and reward will only be handled by asset account, and we now confirm the asset account.

```javascript
> sero.accounts[0]
"5bEgN9YLqC......4zeamkdD16C"   // PK
> web3.fromTa(sero.getBalance(sero.accounts[0]).tkn.SERO)
10               //20 SERO coins
```

#### 3. Create a voting account

The voting account does not process assets and is only used for voting signatures.

```javascript
> personal.newAccount("1234")
"2tuxyM5uL4......Ce5xNPokr"
> sero.accounts[1]
"2tuxyM5uL4......Ce5xNPokr"    // PK
```

**The voting account needs to be permanently unlocked so that voting can be conducted quickly after being drawn.**

```javascript
> personal.unlockAccount(sero.accounts[1],"1234",0)
```

**Note: SOLO Staking needs to ensure the stability of the entire node network, otherwise the vote may MISS.**
****

### 4. View the shares pool status

* The interfaces related to staking are in the stake object.

  ```javascript
  > stake
  {
    sharePoolSize: "0x0",               // Current size of the shares pool
    sharePrice: "0x1bc16d674ec80000",   // Current share price
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

* View the current shares pool information

  ```javascript
  > web3.fromTa(web3.toDecimal(stake.sharePrice))
  "2"     // The current share price is 2 SERO
  > web3.toDecimal(stake.sharePoolSize)
  0       // There are 0 shares in the current shares pool.
  ```

### 5. Subscribe for shares

* Estimate the number of shares that can be purchased

  * Since the share price increases linearly with the size of the pool, it is necessary to estimate the number of shares that can be purchased first.
  
  ```javascript
  > stake.estimateShares({
        from:sero.accounts[0],        //Asset account
        vote:sero.accounts[1],        //Voting account
        value:web3.toTa(20)           //Total amount that can be staked
  })
  {
    avPrice: "0x1bc6ab6c2dfe1734",          //Average share price
    basePrice: "0x1bc16d674ec80000",        //Base share price
    total: "0x9"                            //Purchasable quantity
  }
  ```
  
* Subscription，from: Asset account, vote: voting account, value: subscription fund

  ```javascript
  >   stake.buyShare({from:sero.accounts[0],vote:sero.accounts[1],value:web3.toTa(20)})
  "0xac137baf4cd195....17c1fcb3edae4d25"
  > sero.getTransactionReceipt("0xac137baf4....cb3edae4d25")
  {
    ....
    poolId: null,
    shareId: "0xb5b01116f......71015afc6f",   //ID of Purchased shares
    ....
  }
  ```

* Check the status of the shares purchase

  ```javascript
  > stake.getShare("0xb5b01116f......71015afc6f")
  {
    addr: "5bEgN9YLq......4zeamkdD16C",
    id: "0xb5b01116f3e8......2a08b28171015afc6f",      // ID of Purchased
    missed: 0,
    num: 1,
    price: 2001844456911510800,                       // The average price
    returnAmount: 20814755655292090000,               // Amount refunded
    status: 0,
    total: 9,                                         // Number of shares
    tx: "0x47a87164f......13e422efee",
    voteAddr: "2tuxyM5uL4ZDk......4xdTPCe5xNPokr"     // Collection code of voting account
  }
  ```

* View my total shares

  ```javascript
  > stake.myShare("5bEgN9YLqCBN9......pti4zeamkdD16C")
  [{
      addr: "5bEgN9YLqCB......rpti4zeamkdD16C",
      expired: 0,                                // Number of expired shares
      missed: 0,                                 // Vote miss number
      pools: null,
      remaining: 10,                             // The remaining number of shares
      shareIds: [                                // List of shares IDs I own
        "0x3f2ae......a0c656d9b7b7",
        "0x58395b1......cfa4141d",
        "0xb5b011......171015afc6f"
      ],
      total: 30,                                 // My total number of shares
      voteAddr: ["2tuxyM5uL4ZDkfp......Vtw4xdTPCe5xNPokr"]    // My vote ID
  }]
  ```

### 6. View account balance

```javascript
> web3.fromTa(sero.getBalance(sero.accounts[0]).tkn.SERO)   // Asset account
339.980079865355683522
> sero.getBalance(sero.accounts[1])    //Voting account
{}
```



## How to create a Staking Node

Due to unstable personal network, or unable to open the full-node continuously, then it is possible to entrust `Staking Node` to vote on behalf of them.

Here's how to create a `Staking Node` for voting.

### Precondition

1. Have a continuous online full-node program (gero).
2. Have an account with a 200,000 SERO balance.
3. Have a good network environment.

### Steps

#### 1. Step summary

1. Confirm that there are 200,000 SERO coins used for pledge.
   * When the Node is closed, the principal will be returned.
2. Create a proxy voting account.
3. Turn on the automatic voting function (unlock the voting account).
4. Pledge SERO coins to open Staking Node
5. View the current node delegation status.
6. Confirm revenue.

#### 2. Confirm asset account

```javascript
> sero.accounts[0]
"5bEgN9YLqC......4zeamkdD16C"
> web3.fromTa(sero.getBalance(sero.accounts[0]).tkn.SERO)
200000.980079865355683522
```

#### 3. Create a proxy voting account

```javascript
> personal.newAccount("1234")
"2tuxyM5uL4......w4xdTPCe5xNPokr"
> sero.accounts[1]
"2tuxyM5uL4......Ce5xNPokr"
```

#### 4. Enable automatic voting function (unlock the voting account)

**Voting accounts need to be permanently unlocked so that they can be voted quickly after being drawn.**

```javascript
> personal.unlockAccount(sero.accounts[1],"1234",0)
```

**Note:** StakingNode needs to ensure that the entire node network is stable, otherwise it may lead to voting MISS, and the vote of MISS may lead to an increase in the principal locking time of StakingNode.

#### 5. Register Staking Node by pledging SERO coins

The client needs to connect more than 10 `peers` to open the command to register the staking node.

```javascript
> admin.peers.length
15
```

Start registering `StakingNode`, note that in this example `accounts[0]` has 200,000 SERO coins, which is a asset account.

```javascript
> stake.registStakePool({
      from:sero.accounts[0],        //asset account
      vote:sero.accounts[1],        //voting account
      value:web3.toTa(200000),      //Registered fund
      fee:web3.toHex(2500)          
// Draw, 7500 represents 75%, 2500 represents 25%, and the maximum draw is 75%.
})
"0xecb3b5b235....8d35d7d1651"       //Register generated transaction hash
```

You can view the `ID` of the registered `StakingNode` by viewing the transaction receipt.

```javascript
> sero.getTransactionReceipt("0xecb3b5b....7d1651")
{
  ......
  poolId: "0xb1e20b74......2b35888176d",          //StakingNode ID
  shareId: null,
  ......
}
```

**Note:**`StakingNode` 
The pledge of the principal needs to be locked for 1 months before it can be unlocked, but it must be closed after closing the staking node and no shares point to the staking node.

#### 6. View current node delegation status and revenue

The status of `StakingNode` can be viewed via the `poolState` method.

```java
> stake.poolState("0xb1e20b......88176d")
{
  choicedNum: "0x0",    // Number of shares selected
  closed: false,        // Is Staking Node closed?
  createAt: "0x11",     // Staking Node created time
  expireNum: "0x0",     // Number of expired entrusted shares of Staking Node
  fee: "0xfa0",         // Withdrawal of Staking Node
  id: "0xb1e20b7......88176d",  //Staking Node的ID
  idPkr: "2E7uXmU9......GeQyGBzSvWE",
  lastPayTime: "0x0",   // Lastest payment time
  missedNum: "0x0",     // Missed votes
  own: "5bEgN9YLqC......4zeamkdD16C",                    
  shareNum: "0x0",      // Total number of shares
  tx: "0xecb3b5b......d1651",
  voteAddress: "2tuxyM5uL4......w4xdTPCe5xNPokr",
  wishVoteNum: "0x0",
  profit: "0x100"
}
```



## How to select Staking Node as a voting proxy to vote for yourself

Ordinary users only need to specify the Staking Node when they purchase the shares, so they can enjoy the convenient voting service without deploying the full-node program.

#### 1.Query the Staking Node list of the whole network

```javascript
> stake.stakePools()
[{
    choicedNum: "0x0",                          // Number of shares selected
    closed: false,                              // Whether to be closed
    createAt: "0x0",
    expireNum: "0x0",                           // Number of expired shares
    fee: "0xfa0",                               // Draw proportion
    id: "0xb1e20b7......2b35888176d",           // StakingNode ID
    idPkr: "2E7uXm......yGBzSvWE",
    lastPayTime: "0x0",
    missedNum: "0x0",                           // Missed votes
    own: "4ujQrFsaYq......WZzxtnqgTsL",
    shareNum: "0x0",                            // Number of shares
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

#### 2. When buying shares, choose to vote on behalf of a staking node.

```javascript
> stake.buyShare({
      from:sero.accounts[0],
      vote:sero.accounts[0],
      pool:"0xc48e45......af708a",    // Select StakingNode ID
      value:web3.toTa(2000)
})
"0xb524ec5......b8d511b0b"

> sero.getTransactionReceipt("0xb524e......8d511b0b")
{
  ......
  shareId: "0x9e415fa4......94e4eef",        // Share ID purchased
  ......
}
```



#### 3. Status of Staking Node confirming a share

```javascript
> stake.getShare("0x9e415f......94e4eef")
{
  addr: "4ujQrFsaY......zxtnqgTsL",
  id: "0x9e415f......994e4eef",
  missed: 0,
  num: 723,
  pool: "0xc48e4557......ec62af708a",       // StakingNode ID selected by this share
  price: 2739073884442371600,
  returnAmount: 23602264528913793000,       // Income
  status: 0,
  total: 730,
  tx: "0xb524ec5......b8d511b0b",
  voteAddr: "4ujQrFsaYq......qWZzxtnqgTsL"
}
```



## Return of principal

* The design of SERO's Staking will not confiscate or destroy the SERO coins of any user.
* When the following happens, the principal of the shares will be returned
  * The shares that complete the voting process will be returned at the same time as the block award is given.
  * If the shares have not been selected by any miners for more than one month, the principal will be refunded.
  * Shares that were selected but did not respond(MISS) will be returned in the third month.
* When the following conditions are all met, the StakingNode principal will be returned.
  * StakingNode is closed by the owner
  * StakingNode registration completed for one month
  * There are no more shares in the shares pool entrusted to StakingNode
