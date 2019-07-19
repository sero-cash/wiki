#  SERO Exchange Interface (SEI) 接口说明


[TOC]

SEI 接口的对接方式，exchange服务代管用户的 TK，负责追踪用户的 UTXO ，并提供在线和离线的签名方式。

对比 SSI 接口需要对接方自己管理 UTXO，SEI 更加简单、安全、实用。

**[gero v0.7.2-beta.7.2](?file=News/Release/SERO-BETANET-R7.2) 以上的版本才提供SEI接口**



## 请对接用户注意，并认真阅读本文。

1. **因为Seed->SK->TK->PK是一一对应的，一个PK可以通过随机数对应非常多的PKr。**

2. **每个用户通过随机数关联到不同的PKr，再关联到一个唯一的PK上，不需要为每个用户生成一个Seed。**

3. **请经常对账户的UTXO进行Merge，否则转账时过多的UTXO导致签名时间过长，将严重影响用户体验。**



## 账户

账户由 $Seed$、$SK$、$TK$、$PK$、$PKr$ 四种密钥构成，生成关系于下：

```
seed(种子) -> sk(私钥) -> TK(跟踪密钥) -> PK(公钥) -> PKr(收款码)
```

目前提供了**Go**和**JS**两种语言的账户生成库：

**Go**语言版本：
<https://github.com/sero-cash/go-czero-import/keys/keys.go>

**JS**语言版本：

* <https://github.com/sero-cash/js-sero-client>
* 示例：<https://github.com/sero-cash/js-sero-client/blob/master/src/test/test_account.js>
* 安装npm模块

```bash
npm install js-sero-client
```



### seed(种子)

* $seed$ 是32长度的BYTE数组，可以由HASH算法或者助记词生成。拥有了 $seed$ 就可以推出后续所有的密钥，因此必须绝对安全保存。



### sk(私钥)

* 私钥$sk$一共64个BYTE，由两个32BYTE的大整数组成，并且与 $seed$ 一一对应。
  * $sk=(zsk,vsk) \;\;zsk \in Fr, \; vsk \in Fr $
* 私钥用来对交易签名，也需要绝对安全保存。
* 可以由 $seed$ 生成出来
* **Go语言**
```go
  cpt.ZeroInit_OnlyInOuts()    //初始化加密库
  var seed keys.Uint256
  seed=keys.RandUint256()
  sk:=keys.Seed2Sk(&seed)
```
* **JS语言**
```js
  const account = require('js-sero-client').Account
  let seed = Buffer.alloc(
        32,
        'fd1b401d2bbfa09fba577b398b09b5ea075bd8f37773095c6e62271a4b080977',
        'hex'
  )
  let keys = account.NewKeys(seed)            //seed 可以直接用字符串(hex|base58)
  let sk = keys.sk.toString('hex')
  let tk_hex = keys.tk.toString('hex')
  let tk_base58 = keys.tk.ToBase58()
  let pk = keys.pk.toString('hex')
  let pk_base58 = keys.pk.ToBase58()
```



### TK(跟踪密钥)

* $ TK $ 是64长度的BYTE数组，由一个32BYTE的$ECC_{fp}$上的点和一个大整数构成，$ZPK$也是$PK$的前 32 BYTE，$vsk$是$sk$的后32 BYTE。$TK$ 与 $sk$ 一一对应。
  * $TK=(ZPK,vsk) \; ZPK \in ECC_{fp},\; vsk \in Fr$
* $TK$ 只能用来查看属于账户的UTXO的详情，可以提供给可信第三方进行独立审计。
* $TK$ 由 $sk$ 生成
* **Go语言**
```go
  tk:=keys.Sk2Tk(&sk)
```

* **JS语言**
```js
  const account = require('js-sero-client').Account
  let sk = Buffer.alloc(
         64,
         '4e7f432c24d2......e1513eadfef9d1cd604',
        'hex'
  )
  let keys = account.NewKeys(undefined,sk)    //sk 可以直接用字符串(hex|base58)
  let tk_hex = keys.tk.toString('hex')
  let tk_base58 = keys.tk.ToBase58()
  let pk_hex = keys.pk.toString('hex')
  let pk_base58 = keys.pk.ToBase58()
```



#### PK(公钥)

* 公钥$PK$也是64 BYTE，由两个 32 BYTE 的 $ECC_{fp}$ 上的点构成 ，与 $TK$ 也是一一对应的。
  * $PK=(ZPK,VPK)  \; ZPK \in ECC_{fp}, \; VPK \in ECC_{fp}$
* $PK$ 用来生成 $PKr$ (收款码)。可以提供$PK$给第三方，第三方通过$PK$生成你的$PKr$(收款码)再给你转账，而自己使用$TK$来跟踪入账情况。但因为安全和性能的关系，不建议对接方直接使用。
* $PK$ 由 $TK$ 生成。
* **Go语言**
```go
  pk:=keys.Tk2Pk(&tk)
```
* **JS语言**
```js
  const account = require('js-sero-client').Account
  let tk = Buffer.alloc(
         64,
         '6a367411b800be76a9d......1ee1513eadfef9d1cd604',
        'hex'
  )
  let keys = account.NewKeys(undefined,undefined,tk)      //tk 可以直接用字符串(hex|base58)
  let pk_hex = keys.pk.toString('hex')
  let pk_base58 = keys.pk.ToBase58()
```



#### PKr(收款码)

* 收款码 $PKr$ 是一个 96 BYTE的二进制数据，由三个 32 BYTE 的 $ECC_{fp}$ 上的点构成。可以通过`keys.Addr2PKr`将$PK$和一个随机数转换成$PKr$。
  * $PKr=(ZPKr,VPKr,BASEr) \; ZPKr \in ECC_{fp}, \; VPKr \in ECC_{fp}, \; BASEr \in ECC_{fp}$
* $PKr$ 是UTXO的目标。每个 $PK$ 对应非常多个$PKr$。指向这个$PKr$的UTXO可以由$TK$解密，在使用的时候由$sk$签名。
* $PKr$ 由 $PK$ 加入一个 32 BYTE 的随机数生成。
* **Go语言**
```go
rnd:=keys.RandUint256()  
pkr:=keys.Addr2PKr(&pk,&rnd)
```
* **JS语言**
```js
  const account = require('js-sero-client').Account
  let pk = Buffer.alloc(
         64,
         '6a367411b800be......df5fb72aba4019',
        'hex'
  )
  let rnd = account.czero.RandomU32()
  let keys = account.NewKeys(undefined,undefined,undefined,pk)  //pk 可以直接用字符串(hex|base58)
  let pkr = keys.GenPKr(rnd)
  let pkr_hex = pkr.toString("hex")
  let pkr_base58 = pkr.ToBase58()
```

#### gero 控制台中Base58和Hex编码互转

```javascript
> web3.addressToHex(sero.accounts[0])
"0x0dbd9c096......849304201ea6"

> web3.hexToBase58("0x0dbd9c09......9304201ea6")
"GwA94QDTyQ86cE5jcuYCyrQ9Bu9FRcXfq4dxQhryTDzhkahUjYSHcjZ5yFF9bvaZPRMUwR8k5uW4bT3DvPf77a5"
```





## 离线签名

当从全节点程序(gero)，构造了交易之后，需要用sero的客户端进行离线签名。

离线签名程序也分为Go版本和JS版本：

#### Go语言

* 示例程序：<https://github.com/sero-cash/go-sero/blob/v0.7.2-dev/cmd/tx/main.go>
  ```go
import 'github.com/sero-cash/go-sero/zero/light'
param_str:='{"Gas":25000,"GasPrice":1000000000,"From":{"SKr":"0x0 .... }'  //由全节点构造
sk_str:='fd1b401d2bbfa09fba577b398b09b5ea075bd8f37773095c6e62271a4b080977'
//------
var param GenTxParam
json.Unmarshal([]byte(param_str),&param)
bs, _ := hexutil.Decode(sk_str)
sk := keys.Uint512{}
copy(sk[:], bs)
//------可以自己组装SK---------
copy(param.From.SKr[:], sk[:])
for i := range param.Ins {
copy(param.Ins[i].SKr[:], sk[:])
	}
	gtx, _ := light.SLI_Inst.GenTx(param)
//------也可以直接采用这种形式-------
//gtx, _:=light.SignTx(sk,param)
  //------
  tx, _ := json.Marshal(&gtx)
  ```

#### JS语言

* 示例程序：https://github.com/sero-cash/js-sero-client/blob/master/src/test/test_tx.js
  ```js
const account = require('js-sero-client').Account
const tx = require('js-sero-client').Tx
//------
const seedStr = 'fd1b401d2bbfa09fba577b398b09b5ea075bd8f37773095c6e62271a4b080977'
const txParamStr = '{"Gas":25000,"GasPrice":1000000000,"Fro .... }'       //由全节点构造
//------
const seed = Buffer.alloc(32, seedStr, 'hex')
const keys = account.NewKeys(seed)
const skStr = keys.sk.toString('hex')
//------
tx.SignTx(
    txParamStr,
    skStr,                        //字符串 hex|base58
    (err, tx) => {
      if (err) {
        console.error(err)
      } else {
        console.log(tx)
      }
    }
)
  ```



#### 注意

   * 签名程序会根据当前机器的性能决定并行计算的数量，交易生成时间与引用的UTXO的数量成正比。
        * 如果花费的UTXO的个数很多，生成时间会变得非常长。
   * 解决方案
        * 对于在线签名应用
             * 对充值进来的UTXO进行merge。
                  * gero 的 exchange 服务提供了自动 merge 功能，在gero上增加 `—autoMerge` 则可以自动进行UTXO的合并。
             * 可以延长接口调用的超时时间。
                  * `--rpcwritetimeout [SECOND]` 启动gero的时候加上这个参数，可以设置gero回写的超时时间，单位是秒。
        * 并行运行多个签名



## 导入账户

gero有两种导入账户的方式，分别是导入 $seed$ 和导入 $TK$ ，导入 $TK$ 之后的gero只能用来跟踪账户的余额和充值记录或者是产生收款码，产生的交易必须经过离线签名之后才能提交到链上。导入 $seed$ 则可以直接使用gero来签名交易。

* 导入 $seed$ 

  * 利用助记词导入 $seed$，在web3里面：

  ```javascript
  > personal.importMnemonic("uncle frost ex.....ion before","123456")  //助记词,密码
  "GwA94QDTyQ86cE5jcu......aZPRMUwR8k5uW4bT3DvPf77a5"    //公钥PK
  ```

  * 导出seed对应的助记词是

  ```javascript
  > personal.exportMnemonic(sero.accounts[0],"123456")  //公钥PK，密码
  "uncle frost expose ...... salmon champion before"
  ```

  * 直接导入hex编码的 $seed$

  ```javascript
  > personal.importRawKey("ec8bad429641f......0b1ab03d1f","123456")  // Seed，密码
  "GwA94QDTyQ86cE5jc......8k5uW4bT3DvPf77a5"     //公钥PK
  ```

  * 导出hex编码的 $seed$

  ```javascript
  >personal.exportRawKey("GwA94QDTyQ86cE5j....DvPf77a5","123456")  //公钥PK，密码
  ```

  * 然后用accounts可以查看到导入账户的公钥

  ```javascript
  > sero.accounts
  ["GwA94QDTyQ86cE5jcuYCyrQ9Bu9FRcXfq4dxQhryTDzhkahUjYSHcjZ5yFF9bvaZPRMUwR8k5uW4bT3DvPf77a5"]
  ```

  

* 导入 $TK$

  ```javascript
  > personal.importTk("GwA94QDTyQ86cE5......AwUB22sEmQQ1AguYXn")   //TK
  "GwA94QDTyQ86cE5jcuYCyr......bvaZPRMUwR8k5uW4bT3DvPf77a5"   //公钥PK
  ```

  * 查看账户的 $TK$
  ```javascript
  > sero.getTk(sero.accounts[0])                        //公钥PK
  "GwA94QDTyQ86cE5jcuYCy.......AwUB22sEmQQ1AguYXn"      //TK
  ```


* 导入账户之后，exchange服务就会自动分析区块信息，如果是新导入的账户，服务需要一段时间才能分析到最新块。可以通过查看gero的日志看出是否分析完毕。
  * 需要开启 `—exchange` 标记
   ```javascript
   INFO [06-13|15:44:00.016] Exchange indexed                         blockNumber=1031753
   INFO [06-13|15:44:50.007] Exchange indexed                         blockNumber=1031754
   INFO [06-13|15:45:00.007] Exchange indexed                         blockNumber=1031755
   INFO [06-13|15:45:10.007] Exchange indexed                         blockNumber=1031756
   ```
   不管是导入 $seed$ 还是 $TK$ ，`gero` 都会为它生成一个keystore，其中 $seed$ 以密文的形式存储，$TK$ 以明文的形式存储。
  
* **导入账户后，exchange分析会从第1块开始，为了避免exchange分析时间过长，用户可以通过修改keystore文件里面的自动跳过没有必要分析的块数。**

  ```javascript
  {
      "address":"24DidZ7...KWTQtU8",
      "tk":"24Did...BaG84r",
      "crypto":{
            "cipher":"aes-128-ctr",
            "ciphertext":"4e4b3247...adbff2",
            "cipherparams":{"iv":"1d13d245...3f9db2"},
            "kdf":"scrypt",
            "kdfparams":{"dklen":32,"n":262144,"p":1,"r":8,"salt":"e17991a97...b1b7bd"},
            "mac":"b66f0c...2dd7d06"
      },
      "id":"f939...28c",
      "version":1,
      "at":1050000                  //增加at自动，自动跳过之前的 1~1050000 块
  }
  ```

  



## 离线接口的rpc版本 `v0.7.9`

目前离线api接口提供了go和javascript两种语言，其他语言可以通过启动一个不对外连接的gero，通过rpc来使用这些功能。

* **seed 生成 sk**

  ```javascript
  exchange.seed2Sk("0xec8bad429......0b1ab03d1f")    //seed: hex编码
  "0x8fe1c73ac......0d1bc4305"                       //sk: hex 编码
  ```

  

* **sk 生成 TK**

  ```javascript
  exchange.sk2Tk("0x8fe1c7......40d1bc4305")    //sk: hex编码
  "GwA94QDTy......QQ1AguYXn"                    //TK: base58 编码
  ```

  

* **TK 生成 PK**

  ```javascript
  exchange.tk2Pk("GwA94QDTyQ86c......1AguYXn")   //TK: hex或者base58 编码
  "GwA94QDTyQ8......uW4bT3DvPf77a5"              //PK: base58 编码
  ```

  

* **PK 生成 PKr**

  ```javascript
  >  exchange.pk2Pkr(
    "GwA94QDTyQ8......uW4bT3DvPf77a5",            //PK
    "0x000000000......0000110"                    //32 byte 的随机数，为空则自动生成。
  )  // PK,RNG
  "22mZ61am......aevRpWMD89"           //PKr: base58 编码
  ```

  

* **离线签名**

  ```javascript
  > const sk = '0xfd1b401d2bbf......71a4b080977'                            //私钥 SK: hex 编码
  > const txParamObj = {"Gas":25000,"GasPrice":1000000000,.... }       //由全节点构造(不是字符串)
  > var tx=exchange.signTxWithSk(txParamObj,sk)
  ```

  



## 钱包接口

SERO的全节点程序(gero)提供了一套专门为exchange对接的服务，exchange使第三方对接更加简单。对接方可以在只导入账户的 $TK$ 的情况下 ，获取链上跟账户相关余额和记录信息。接口支持`jsonrpc`和`console`两种方式。

#### 开启全节点(gero)的exchange服务

* 关于全节点程序(gero)可以在下面的几个地方了解
  * 代码位置
    * <https://github.com/sero-cash/go-sero>
  * 如何编译源码
    * <https://wiki.sero.cash/zh/index.html?file=Start/from-the-sourcecode-base-on-centos7>
* 二进制程序发布位置
  * **DARWIN (MacOS)**
    * <https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.2-beta.r7.2/gero-v0.7.2-beta.r7.2-darwin-amd64.tar.gz>
  * **WIN32**
    * <https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.2-beta.r7.2/gero-v0.7.2-beta.r7.2-windows-amd64.zip>
  * **LINUX3 (CENTOS 7)**
    * <https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.2-beta.r7.2/gero-v0.7.2-beta.r7.2-linux-amd64-v3.tar.gz>
  * **LINUX4 (UBUNTU 16.04)**
    * <https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.2-beta.r7.2/gero-v0.7.2-beta.r7.2-linux-amd64-v4.tar.gz>
  * 如何运行二进制程序
    * <https://wiki.sero.cash/zh/index.html?file=Start/from-the-binary-package>



* 在启动gero的时候添加 `—exchange` 和 `—mineMode` 以及 `--rpcapi exchange,sero` 三个参数即可开启gero的exchange服务。
  * `--exchange` 开启`exchange`服务
  * `--mineMode` 关闭PC钱包使用的`balance`服务，`balance`服务将被`exchange`服务代替。
  * `--rpcapi sero,exchange` 开启`exchange`和`sero`的jsonrpc接口
  * 其他的`rpc`参数与以太坊一致
  
* 为了在算力大幅度波动的时候确保安全，可以设置确认的区块数量。
  
  * `--confirmedBlock 32`  设置32个块确认交易，默认为12个块。
  
* SERO的rpc有请求大小的限制，默认为512K。
  
  * `--rpcRequestLength 1048576` 可以将限制改为1M
  
* 如果无法在jsonrpc返回值序列化的时候处理bigint类型，可以使jsonrpc以字符串的形式返回数值。
  
  * `--exchangeValueStr` 将使gero的jsonrpc接口返回
  
* gero为了尽可能少的在硬盘上存储数据，目前每10000块或者1小时保存一次快照，因此当gero关闭后，会从最近的1万的整数倍块开始同步。
  
  * `--gcmode archive` 将使gero每一块都保存快照数据，重启的时候不会回滚区块。但是这种方式会耗费更大的硬盘存储。
  
* gero在utxo个数较多的时候签名会消耗较多的时间，因此可以调整gero回写client的超时时间

  * `--rpcwritetimeout [SECOND]` 启动gero的时候加上这个参数，可以设置gero回写的超时时间，单位是秒。

* 启动参数示例

  ```sh
  ./gero --exchange --mineMode --datadir ~/geroData --port 53717 --rpc --rpcport 8545 --rpcapi exchange,sero,net --rpcaddr 127.0.0.1  --rpccorsdomain "*" --keystore ~/keystore --confirmedBlock 32 --rpcwritetimeout 1800 --exchangeValueStr
  ```

  * 对接方可以根据需求修改上面的配置

#### 接口简介

* **SERO提供的`exchange`接口**
  * [`GetBlockByNumber(num)->block`](#GetBLockByNumber) `v7.5`
    * 获取块的基本信息
    * 也可以使用`sero.GetBlockByNumer`获取更详细信息，使用方式跟以太坊兼容
  * [`GetBlocksInfo(start,end)->blocks`](#GetBlocksInfo)`v7.5`
    * 获取`start~end`之间块的详情
  * [`GetPkr(pk,rnd)->pkr`](#GetPKr)
    * 通过公钥  $pk$ 和随机数 $rnd$ 生成收款码 $pkr$
    * `sero.GenPKr(pk)->pkr`可以生成随机的 $pkr$
  * [`GetPkByPkr(pkr)->pk`](#GetPkByPkr)`v7.5`
    - 通过收款码`pkr`反查`pk`
    - `pk`对应的账户必须在`gero`中
  * [`GetBalances(pk)->balances`](#GetBalances)
    * 通过公钥 $pk$ 获取总余额 $balances$
  * [`GetRecords(begin,end,[pk])->[]Utxo`](#GetRecords) `v7.5`
    * 获取账户`pk`在块号$begin$ 到 $end$ 之间的充值进来的 $UTXO$。
  * [`GenTx(preTxParam)->txParam`](#GenTx)
    * 通过`preTxParam`获取可以用来签名的`txParam`。
  * [`GenMergeTx(mergeParam)->txParam`](#GenMergeTx) `v7.5`
    - 根据参数`mergeParam`生成合并的交易参数`txParam`，`txParam`需要离线签名。
  * [`GetTx(txhash)->tx`](#GetTx) `v7.5`
    * 获取交易hash对应的细节
    * 目前只提供入账记录
  * [`GenTxWithSign(preTxParam)->tx`](#GenTxWithSign)
    * 通过`preTxParam`直接生成签名后的tx
    * 账户需要导入`seed`
  * [`CommitTx(tx)->()`](#CommitTx)
    * 将签名好的tx提交给交易池并广播给全网
  * [`GetPkSynced(pk)->pkState`](#GetPkSynced)
    * 获取当前`exchange`的账户分析情况
  * [`Merge(pk,currency)->txhash`](#Merge)
    * 在线签名
    * 自动合并币种`currency`的 $UTXO$
    * 目标值是少于10个 $UTXO$
  * [`ValidAddress(pk|pkr)->bool`](#ValidAddress)
    * 检查PK或者PKr是否合法
  * [`GetLockedBalances(pk)->lockedState`](#GetLockedBalances) ` > v7.3`
    * 检查由于生成交易可能导致的锁定金额
  * [`GetMaxAvailable(pk,currency)->value`](#GetMaxAvailable) `> v7.3`
    * 获取币种`currency`当前能发送的最大的金额
  * [`ClearUsedFlag(pk)->()`](#ClearUsedFlag) `> v7.3`
    * 清除`PK`下 由于发送交易锁定`UTXO`的标记
  * [`ClearUsedFlagForRoot([root,...])->()`](#ClearUsedFlagForRoot) `> v7.4`
    - 清除 `root` 代表的UTXO的锁定标记



### GetBlockByNumber

- 根据块号获取当前块的信息

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_getBlockByNumber",
  	"params": [
      109                  // 块号，空代表获取最新的块。
  	]
  }
  ```

  

  - response

  ```javascript
  {
  	"id": 0,
  	"result": {
      "hash":"0x61de8473709....3172c2225e55"， //块hash
      "number": 109,                           //块号
      "timestamp": 1561398077                  //时间戳
      "TxHashes": [                                        //交易hash列表
        "0xc31c834efe568d56e7b4c60e7aefe2b223e8567244f242c7870ec5cb47cc1000", 
        "0x9123159d7016086ed4e1ec253f575cd38f04cc4dea31ce922d1387c985e336c8"
      ]
  
    }
  	"error": null
  }
  ```

  

- **console**

```javascript
>  exchange.getBlockByNumber(109)
{
    "hash":"0x61de8473709567be5278c2e607915e6f9001f45f51dc94f8792a3172c2225e55"，
    "number": 109, 
    "timestamp": 1561398077,
    "TxHashes": [
      "0xc31c834efe568d56e7b4c60e7aefe2b223e8567244f242c7870ec5cb47cc1000", 
      "0x9123159d7016086ed4e1ec253f575cd38f04cc4dea31ce922d1387c985e336c8"
    ]
}
```



### GetBlocksInfo

- 获取一个范围内的块对UTXO的使用信息

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_getBlocksInfo",
  	"params": [
      108,                  // 开始块号
      109                   // 结束块号
    ]
  }
  ```

  

  - response

  ```javascript
  {
  	"id": 0,
  	"result": {
      [
        {
          BlockHash: "0x42fee36......d82bd53",                  // 块Hash
          Ins: ["0xd85......e0d597"],                      // 本块花费的UTXO的root
          BlockNumber: 108,                                        // 块高度
          Outs: [{
              Currency: "SERO",
              Nil: "0xe1d29......d15d89",
              Num: 108,
              Pkr: "0x842e......950d",
              Root: "0x192717......646d42a",
              TxHash: "0xf8f2269......66d181",
              Value: 70000000000000000000
            },
            ......
          ]
        }
      ]
    }
  	"error": null
  }
  ```

  

- **console**

```javascript
>  exchange.getBlocksInfo(108,109)
{
    [
      {
        BlockHash: "0x42fee36......d82bd53",
        Ins: ["0xd85......e0d597"],
        BlockNum: 108,
        Outs: [{
            Currency: "SERO",
            Nil: "0xe1d29......d15d89",
            Num: 108,
            Pkr: "0x842e......950d",
            Root: "0x192717......646d42a",
            TxHash: "0xf8f2269......66d181",
            Value: 70000000000000000000
          },
          ......
        ]
      }
    ]
  }
```



### GetPkr

* 采用随机数创建PK对应的PKr

* **jsonrpc**

  * request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_getPkr",
  	"params": [
  	  "0x0dbd9c096......32a20849304201ea6",    //PK的hex编码
  	  "0x000000000......00000000000000101"     //32BYTE的随机数，需 > 0x100
  	]
  }
  ```

  

  * response

  ```javascript
  {
  	"id": 0,
  	"result": "0x8423cdaf21db11......d1c76e728630a882a14",    //PKr
  	"error": null
  }
  ```

  

* **console**

```javascript
>  exchange.getPkr(web3.addressToHex(sero.accounts[0]),"0x000000000......00000000000000100")
"0x4546ffe8932.......88efeead5d7a84"
```



### GetPkByPkr

- 获取PKr在gero中对应的PK

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_getPkByPkr",
  	"params": [
  	  "0xa01b191......ad09bf320"    //收款码Pkr的hex编码
  	]
  }
  ```

  

  - response

  ```javascript
  {
  	"id": 0,
  	"result": "0xc3863f5......bce8168a87",    //公钥Pk
  	"error": null
  }
  ```

  

- **console**

```javascript
>  exchange.getPkByPkr("0xa01b191......ad09bf320")
"0xc3863f5......bce8168a87"
```



### GetBalances

* 获取PK代表的账户当前的总余额

* **jsonrpc**

  * request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_getBalances",
  	"params": [
  	  "0x0dbd9c096ca52fa44570......58332a20849304201ea6"       //公钥 PK
  	]
  } 
  ```

  

  * response

  ```javascript
  {
  	"id": 0,
  	"result": {
  		"SERO": 4000000000000000000           //币种名 : 余额
  	},
  	"error": null
  }
  ```

  

* **console**

```javascript
> exchange.getBalances(web3.addressToHex(sero.accounts[0]))
{
  SERO: 169900000000000000000
}
```



### GetRecords

- 获取充值记录

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_getRecords",
  	"params": [
  	  1,                                    // 开始的块号
  	  1000，                                // 结束的块号
      "0x0dbd9c096......849304201ea6",      // 收款码(PKr)|账户公钥(PK)|留空
  	]
  }
  ```

  

  - response

  ```javascript
  {
  	"id": 0,
  	"result": [                                                 //充值的UTXO列表
  	  {
  		"Pkr": "0x67dc2f42a063477a7ef......1fbbfd8707b0cd449994",
  		"Root": "0x13ca7a02c8......8e85b08775a3706b0",              //UTXO的唯一标识
  		"TxHash": "0x000000000000000......00000000000000000000",    //UTXO所在的Tx的hash
  		"Nil": "0x902953f4eaec70e......b09beb8fff798a0d59ec23",     //UTXO的作废码
  		"Num": 1,                                                   //UTXO所在的块高度
      "Currency": "SERO",                                         //币名
  		"Value": 1000000000000000000                                //币的数量
  	 }, 
  	  {
  		"Pkr": "0x291560a9ad4db22df......7bef504d7c7544dbddabcce6e79f0b",
  		"Root": "0xa9623b4c88f53e......09522c831bf508834be8a7",
  		"TxHash": "0x0dd3a111270......7da11af453498",
  		"Nil": "0xa6acfbc53cf68c433......0a1c0b974ad55977048069f",
  		"Num": 2,
  		"Currency": "SERO",                                         //币名
  		"Value": 1000000000000000000                                //币的数量
  	 },
      ......
    ],
  	"error": null
  }
  ```
  
  
  
- **console**

```javascript
> exchange.getRecords(1,3,web3.addressToHex(sero.accounts[0]))
[
  {
    Currency: "SERO",
    Nil: "0x5b3d....b0b328",
    Num: 1,
    Pkr: "0x5e3f88....1ee14",
    Root: "0xd79e00....250bc96",
    TxHash: "0x000000000......00000000000",
    Value: 17600000000000000000
  },
  ......
]

```



### GenTx

* 离线签名版本的交易生成
* SERO对交易的输入和输出个数有限制
  * 明文输出不超过10个，密文输出不超过500个
  * 明文输入不超过2500个，密文输入没有限制
    * 可以通过API `GetMaxAvailable` 获取当前能发送的最大金额
  * 每次调用GenTx，会轮换着使用UTXO，并且将UTXO记下来。
    * `GetLockedBalances`可以查询已经锁定的金额大小

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_genTx",
  	"params": [{
  		"From": "0x0dbd9c0......9304201ea6",                //账户的PK
      "RefundTo": "0x8423cdaf......630a882a14",          //找零收款码(PKr)，为空则自动生成。
  		"Gas": 25000,                                       //最大消耗Gas，最少25000
  		"GasPrice": 1000000000,                             //GasPrice，默认1Gta
  		"Receptions": [{                                    //接受者信息
  			"Addr": "0x8423cdaf......630a882a14",             //接受者PKr|PK，PK会自动转成PKr
  			"Currency": "SERO",                               //币名
  			"Value": 900000000000000000                       //币的数量
  		}],
  		"Roots": []                                         //需要使用哪些UTXO，空值代表自动选择。
  	}]
  }
  ```

  

  - response

  这个方法返回的结构比较复杂，可以直接将 `result` 传给离线客户端进行签名即可。

  ```javascript
  {
  	"id": 0,
  	"result": {
  		"Gas": 25000,
  		"GasPrice": 1000000000,
  		"From": {
  			"SKr": "0x00000000......00000000000",
  			"PKr": "0xb28e17a7......ad09bf320"
  		},
  		"Ins": [{
  			"SKr": "0x00000000......00000000000",
  			"Out": {
  				"Root": "0x13ca7a0......75a3706b0",
  				"State": {
  					"OS": {
  						"Index": 1,
  						"Out_O": {
  							"Addr": "0x67dc2f42a063......b0cd449994",
  							"Asset": {
  								"Tkn": {
  									"Currency": "0x0000000......0000005345524f",
  									"Value": 1000000000000000000
  								},
  								"Tkt": null
  							},
  							"Memo": "0x00000000......0000000000"
  						},
  						"Out_Z": null,
  						"OutCM": "0xedfe90dbc76......c7e2454371e22",
  						"RootCM": "0xe07a24781......1d037f9412c23"
  					},
  					"TxHash": "0x0000000000......000000000000",
  					"Num": 1
  				}
  			},
  			"Witness": {
  				"Pos": "0x1",
  				"Paths": ["0xea8a7fa27d4c......565c0ca6bf7a8", 
                    "0x2e6831a00874......35c4d21d5cd07", 
                    "0x7812d8320911.......1435b58078af", 
                    "0x47f3115ed518.......29feed9d623"
                    ......
          ],
  				"Anchor": "0xa9623b4c88......508834be8a7"
  			}
  		}],
  		"Outs": [{
  			"PKr": "0x8423cdaf21d......630a882a14",
  			"Asset": {
  				"Tkn": {
  					"Currency": "0x000......005345524f",
  					"Value": 900000000000000000
  				},
  				"Tkt": null
  			},
  			"Memo": "0x000000......0000000"
  		}, {
  			"PKr": "0xb28e17a7d1d......4b740ad09bf320",
  			"Asset": {
  				"Tkn": {
  					"Currency": "0x000000......0005345524f",
  					"Value": 99975000000000000
  				},
  				"Tkt": null
  			},
  			"Memo": "0x00000000......000000000"
  		}]
  	},
  	"error": null
  }
  ```

  

- **console**

```javascript
var txParam = exchange.genTx({
	"From":  web3.addressToHex(sero.accounts[0]),
	"Gas": 25000,
	"GasPrice": 1000000000,
	"Receptions": [{
		"Addr": web3.addressToHex(sero.genPKr(sero.accounts[1])),
		"Currency": "SERO",
		"Value": web3.toTa(1)
	}],
	"Roots": []
})
// txParam 与 jsonrpc 的返回结果一致
```



### GenMergeTx

- 离线签名版本的UTXO合并

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_genMergeTx",
  	"params": [{
  		"From": "0x0dbd9c0......9304201ea6",                //账户的PK
      "To": "0x8423cdaf......630a882a14",                 //合并到收款码(PKr)，为空则自动生成。
  		"Currency": "SERO",                                //需要合并的币名
      "Zcount": 100,                                     //最大合并的密文UTXO个数
      "Left": 1                                          //剩下多少个UTXO
  	}]
  }
  ```

  

  - response

    同`genTx`

  

- **console**

```javascript
var txParam = exchange.genMergeTx({
	"From":  web3.addressToHex(sero.accounts[0]),
	"To": "0x8423cdaf......630a882a14",
  "Currency": "SERO", 
  "Zcount": 100, 
  "Left": 1 
})
// txParam 与 jsonrpc 的返回结果一致
```



### GetTx

- 获取交易详情

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_getTx",
  	"params": [
      "0xf8f2269......66d181"           //交易Hash
    ]
  }
  ```

  

  - response

    ```javascript
    {
    	"id": 0,
    	"result": {
        BlockHash: "0x42fee3......d82bd53",         //块Hash
        BlockNumber: 108,                           //块号
        Outs: [
          {                                    //Out列表
            Currency: "SERO",                           //币名
            PK: "0x40aa8......f4d08a96",                //账户公钥
            Pkr: "0x924f6b6c......09bf320",             //收款码
            Value: 4999925000000000000                  //金额
          },
          ......
        ],
        Ins: [                               //交易输入UTXO的Root列表
          "0x0dbd9c0......9304201ea6"
        ],
        TxHash: "0xf8f2269......66d181"      //交易hash
        Fee: 25000000000000,                 //gas费用
        Timestamp: 1561442217                //交易的时间戳
      },
    	"error": null
    }
    ```

    

  

- **console**

```javascript
> exchange.getTx("0xf8f2269......66d181")
{
    BlockHash: "0x42fee3......d82bd53",
    BlockNumber: 108,
    Outs: [
      {
        Currency: "SERO",
        PK: "0x40aa8......f4d08a96",
        Pkr: "0x924f6b6c......09bf320",
        Value: 4999925000000000000
      },
      ......
   ],
   TxHash: "0xf8f2269......66d181"
}
```



### GenTxWithSign

- 在线版本的交易生成

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_genTxWithSign",
  	"params": [{
  		"From": "0x0dbd9c0......9304201ea6",                //账户的PK
      "RefundTo": "0x8423cdaf......630a882a14",          //找零收款码(PKr)，为空则自动生成。
  		"Gas": 25000,                                       //最大消耗Gas，最少25000
  		"GasPrice": 1000000000,                             //GasPrice，默认1Gta
  		"Receptions": [{                                    //接受者信息
  			"Addr": "0x8423cdaf......630a882a14",             //接受者PKr
  			"Currency": "SERO",                               //币名
  			"Value": 900000000000000000                       //币的数量
  		}],
  		"Roots": []                                         //需要使用哪些UTXO，空值代表自动选择。
  	}]
  }
  ```

  

  - response

  签名后的数据可以直接提交给`CommitTx`发送到全网，同时 `GenTx`之后再进行离线签名的结果跟`GenTxWithSign`的`result`是一致的。

  ```javascript
  {
  	"id": 0,
  	"result": {
  		"Gas": "0x61a8",
  		"GasPrice": "0x3b9aca00",
  		"Tx": {
  			"Ehash": "0x59bd488......16a2e2b0",
  			"From": "0xb28e17a7......d09bf320",
  			"Fee": {
  				"Currency": "0x00000000000......05345524f",
  				"Value": 25000000000000
  			},
  			"Sign": "0x7937304f......8fe12d803",
  			"Bcr": "0x576cc80af......fc35a82",
  			"Bsign": "0xea0c7a......2aadcb801",
  			"Desc_Z": {
  				"Ins": null,
  				"Outs": [{
  					"AssetCM": "0x23b24db7363......af614d40861f28",
  					"OutCM": "0x16653600938......cde422f18ac00",
  					"RPK": "0xc5740db4......4efa5411d9",
  					"EInfo": "0x1f0d1dc5f......df00209c22",
  					"PKr": "0x8423cda.......630a882a14",
  					"Proof": "0x030d19322......c16ba7104"
  				}, {
  					"AssetCM": "0x73280eb9......9d6d5f042c",
  					"OutCM": "0x92cace7c......1a5a528c",
  					"RPK": "0x8126a4......06607d0ee",
  					"EInfo": "0x5fa2c37......5101d8f3",
  					"PKr": "0xb28e1......09bf320",
  					"Proof": "0x026a8c617......829600c"
  				}]
  			},
  			"Desc_O": {
  				"Ins": [{
  					"Root": "0x13ca7a0......75a3706b0",
  					"Nil": "0xc179f8......9acf98d",
  					"Sign": "0xa4ef43839......eb19b6a3701"
  				}],
  				"Outs": null
  			},
  			"Desc_Pkg": {
  				"Create": null,
  				"Transfer": null,
  				"Close": null
  			}
  		},
  		"Hash": "0x0dd3a1112......11af453498"      //交易Hash
  	},
  	"error": null
  }
  ```

  

- **console**

```javascript
> personal.unlockAccount(sero.accounts[0],"123456")
true
> var tx = exchange.genTxWithSign({
	"From":  web3.addressToHex(sero.accounts[0]),
	"Gas": 25000,
	"GasPrice": 1000000000,
	"Receptions": [{
		"Addr": "0x4546ffe893......eead5d7a84",
		"Currency": "SERO",
		"Value": web3.toTa(1)
	}],
	"Roots": []
})

//tx 与 jsonrpc 返回的 result 一致
```





### CommitTx

- 提交签名后的交易到交易池
- **jsonrpc**
- request
    - 跟`GenTxWithSign`的输出一致
    
    - response
      - 无错误就说明已经放到交易池，等待`gero`同步到全网。


- **console**

```javascript
> exchange.commitTx(tx)   //tx 是 `GenTxWithSign` 或者离线签名的结果
null
> sero.getTransactionReceipt(tx.Hash)
{
  blockHash: "0x780cb2866......d27218ff8e",
  blockNumber: 107,
  contractAddress: null,
  cumulativeGasUsed: 25000,
  from: "24WSzZB......gkeQJtGP",
  gasUsed: 25000,
  logs: [],
  logsBloom: "0x00000000......000000000",
  root: "0x06414dcf......78ea7c4218",
  status: "0x1",
  to: null,
  transactionHash: "0x1bae9132......7ecd7172d36",
  transactionIndex: 0
}

```



### GetPkSynced

- exchange当前的分析进度

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_getPkSynced",
  	"params": [
  		"0x0dbd9c0......9304201ea6",                //账户的PK
  	]
  }
  ```

  

  - response

  ```javascript
  {
  	"id": 0,
  	"result": {
      'currentBlock': 121,                  //当前块高度
      'currentPKBlock': 121,                //exchange分析到的块高度
      'highestBlock': 121                   //全网当前块高度
      'utxoCount': {
        'SERO':100                          //SERO当前UTXO的数量，需要先调用getBalances
      }
    },
  	"error": null
  }
  ```

  

- **console**

```javascript
> exchange.getPkSynced("0x0dbd9c0....9304201ea6")
{
  currentBlock: 121,
  currentPKBlock: 121,
  highestBlock: 121
}
```





### Merge

- 在线签名版本的UTXO合并

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_merge",
  	"params": [
  		"0x0dbd9c0......9304201ea6",                //账户的PK
      "SERO"																			//Merge的币种
  	]
  }
  ```

  

  - response

  ```javascript
  {
  	"id": 0,
  	"result": {
      "0x1bae9132......7ecd7172d36"              //Merge生成的交易Hash
    },
  	"error": null
  }
  ```

  

- **console**

```javascript
> exchange.merge("0x0dbd9c0......9304201ea6","SERO")
"0x1bae9132......7ecd7172d36"
```



### ValidAddress

- 判断PK或PKr是否有效

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_validAddress",
  	"params": [
  		"0x0dbd9c0......9304201ea6"                 //账户的PK或者PKr
  	]
  }
  ```

  

  - response

  ```javascript
  {
  	"id": 0,
  	"result": {
      true                                        //是否有效
    },
  	"error": null
  }
  ```

  

- **console**

```javascript
> exchange.validAddress("0x0dbd9c0......9304201ea6")
true
```



### GetLockedBalances

- 获取被锁定的金额

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_getLockedBalances",
  	"params": [
  		"0x0dbd9c0......9304201ea6"                 //账户的PK
  	]
  }
  ```

  

  - response

  ```javascript
  {
  	"id": 0,
  	"result": {
      "SERO":7000                                //可能被锁定的金额
    },
  	"error": null
  }
  ```

  

- **console**

```javascript
> exchange.getLockedBalances("0x0dbd9c0......9304201ea6")
{
  "SERO":7000
}
```



### GetMaxAvailable

- 获取当前能转出的最大金额

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_getMaxAvailable",
  	"params": [
  		"0x0dbd9c0......9304201ea6",                 //账户的PK
      "SERO"                                       //币名
  	]
  }
  ```

  

  - response

  ```javascript
  {
  	"id": 0,
  	"result": 700000,                             //最大一次性转出金额
  	"error": null
  }
  ```

  

- **console**

```javascript
> exchange.getMaxAvailable("0x0dbd9c0......9304201ea6", "SERO")
700000
```



### ClearUsedFlag

- 根据pk清除锁定标记

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_clearUsedFlag",
  	"params": [
      "0x0dbd9c0......9304201ea6"                          //账户的PK
    ]
  }
  ```

  

  - response

  ```javascript
  {
  	"id": 0,
  	"result": 3,                       //清除了3个UTXO的标记
  	"error": null
  }
  ```

  

- **console**

```javascript
> exchange.clearUsedFlag("0x0dbd9c0......9304201ea6")
3
```



### ClearUsedFlagForRoot

* 根据UTXO的Root清除锁定标记

- **jsonrpc**

  - request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "exchange_clearUsedFlagForRoot",
  	"params": [
      [
        "0x13ca7a0......75a3706b0",                 //UTXO 的root
        "0x244ae92......976fa00bc"
      ]
    ]
  }
  ```

  

  - response

  ```javascript
  {
  	"id": 0,
  	"result": 2,
  	"error": null
  }
  ```

  

- **console**

```javascript
> exchange.clearUsedFlagForRoot(["0x0dbd9c0......9304201ea6"])
null
```





## 建议对接方案

### 账户管理

* 账户生成
  * 通过离线客户端生成
    * 随机生成一个32bytes的seed，安全保存。
    * 调用`js-sero-client`的account对象生成`TK`、`PK`
  * 通过`gero`生成
    * 在`gero`控制台调用`personal.newAccount`生成新账户
    * 通过`personal.exportRawKey`导出`seed`，安全保存。
      * 也可以保存对应的 `keystore` 文件
    * 通过`sero.getTk`获取账户`TK`。
    * 通过`sero.accounts`获取账户`PK`
* 账户导入
  * 通过`gero`的控制台调用`personal.importTk`导入`TK`
  * 通过日志监测`exchange`服务分析情况。

### 充值监测

* 调用`exchange.GetRecords`根据块号不断同步`PK`新的充值记录。
  * **注意：**SERO是隐私公链，签名交易时对引用的 `UTXO` 需要给出证明，如果交易引用的`UTXO`较多，交易签名时间会非常长。因此需要在日常对充值的`UTXO`进行合并，这样在提现的时候才会让用户有好的体验。
  * SERO提供离线和非离线签名合并`UTXO`交易的生成方法。
    * 离线签名 [`GenMergeTx`](#GenMergeTx)
    * 非离线签名 [`Merge`](#Merge)

### 提现

* 构造`preTxParam`对象(参考`GenTx`的输入)
* 离线签名方式
  * 调用`GenTx`获取`txParam`对象。
  * 调用`js-sero-client`的`txsign`方法签名
  * 获取签名结果`tx`
* 在线签名方式
  * 解锁`gero`的`account`
  * 调用`GenTxWithSign`，生成签名后的交易`tx`
* 保存`tx`的hash值
* 调用`CommitTx`将`tx`提交到全节点
* 调用`sero.getTransactionReceipt`扫描交易完成的情况
* 由于`UTXO`不能重复使用，并且`genTx`会锁定这次使用的`UTXO`，因此生成交易的时候建议
  * 通过`exchange.getMaxAvailable`获取本次最大能发送的金额数。
    * 需要对`utxo`进行merge确保当前能发送的金额较大。
  * 每次生成完交易`exchange.getMaxAvailable`获取的值会发生变化，代表下一次可发送的金额。
    * 循环调用`exchange.getMaxAvailable`和`exchange.genTx|genTxWithSign`直到`exhange.getMaxAvailable`为0。
    * 发送完交易后等待新的`UTXO`生成。
  * 如果有交易失败，除了重复提交交易外，可以通过`exchange.ClearUsedFlag`清除对这些`UTXO`的锁定。

### 自动UTXO合并

如果是在线签名的方式，可以采用

* `exchange`的自动合并功能。
  * 启动`gero`的时候加上`--autoMerge`参数。
  * 当 `pk` 下的账户会定时进行自动的UTXO的合并。
* 在控制台调用`exchange.Merge`方法手动合并。

