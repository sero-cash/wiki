#  SERO 钱包对接说明



## 账户

账户由 Seed、SK、TK、PK、PKr 四种密钥构成，生成关系于下：

```
seed(种子) -> sk(私钥) -> TK(跟踪密钥) -> PK(公钥) -> PKr(收款码)
```

目前提供了Go和JS两种语言的账户生成库：

Go语言版本：
<https://github.com/sero-cash/go-czero-import/keys/keys.go>

JS语言版本：

* <https://github.com/sero-cash/js-sero-client>
* 示例：<https://github.com/sero-cash/js-sero-client/blob/master/src/test/test_account.js>



### seed (种子)

* $seed$ 是32长度的BYTE数组，可以由HASH算法或者助记词生成。拥有了 $seed$ 就可以推出后续所有的密钥，因此必须绝对安全保存。



### sk (私钥)

* 私钥$sk$一共64个BYTE，由两个32BYTE的大整数组成，并且与 $seed$ 一一对应。
  * $sk=(zsk,vsk) \;\;zsk \in Fr, \; vsk \in Fr $
* 私钥用来对交易签名，也需要绝对安全保存。
* 可以由 $seed$ 生成出来
* **Go语言**
```go
  var seed keys.Uint256
  seed=cpt.RandUint256()
  sk:=keys.Seed2SK(&seed)
```
* **JS语言**
```js
  const account = require('js-sero-client').Account
  let seed = Buffer.alloc(
        32,
        'fd1b401d2bbfa09fba577b398b09b5ea075bd8f37773095c6e62271a4b080977',
        'hex'
  )
  let keys = account.NewKeys(seed)
  let sk = keys.sk.toString('hex')
  let tk = keys.tk.toString('hex')
  let pk = keys.pk.toString('hex')
```



### TK (跟踪密钥)

* $ TK $ 是64长度的BYTE数组，由一个32BYTE的$ECC_{fp}$上的点和一个大整数构成，$ZPK$也是$PK$的前 32 BYTE，$vsk$是$sk$的后32 BYTE。$TK$ 与 $sk$ 一一对应。
  * $TK=(ZPK,vsk) \; ZPK \in ECC_{fp},\; vsk \in Fr$
* $TK$ 只能用来查看属于账户的UTXO的详情，可以提供给可信第三方进行独立审计。
* $TK$ 由 $sk$ 生成
* **Go语言**
```go
  tk:=keys.SK2Tk(&sk)
```

* **JS语言**
```js
  const account = require('js-sero-client').Account
  let sk = Buffer.alloc(
         64,
         '4e7f432c24d2......e1513eadfef9d1cd604',
        'hex'
  )
  let keys = account.NewKeys(undefined,sk)
  let tk = keys.tk.toString('hex')
  let pk = keys.pk.toString('hex')
```



#### PK (公钥)

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
  let keys = account.NewKeys(undefined,undefined,tk)
  let pk = keys.pk.toString('hex')
```



#### PKr (收款码)

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
  let keys = account.NewKeys(undefined,undefined,undefined,pk)
  let pkr = keys.GenPKr(rnd)
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
bs, _ := hexutil.Decode(sk)
sk_bytes := keys.Uint512{}
copy(sk_bytes[:], bs)
//------
pk_bytes := keys.Sk2PK(&sk_bytes)
copy(param.From.SKr[:], sk_bytes[:])
copy(param.From.PKr[:], pk_bytes[:])
for i := range param.Ins {
		copy(gtp.Ins[i].SKr[:], sk_bytes[:])
}
gtx, _ := light.SLI_Inst.GenTx(param)
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
  skStr,
  (err, gtx) => {
    if (err) {
      console.error(err)
    } else {
      console.log(gtx)
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
                  * gero 的 exchange 服务提供了自动 merge 功能，在gero上增加 —autoMerge 则可以自动进行UTXO的合并。
             * 可以延长接口调用的超时时间。
                  * --rpcwritetimeout [SECOND] 启动gero的时候加上这个参数，可以设置gero回写的超时时间，单位是秒。
        * 并行运行多个签名



## 钱包接口

