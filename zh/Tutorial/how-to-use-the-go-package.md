# SERO GO语言对接说明



## 账户

* #### 私钥

  私钥$sk$一共64个BYTE，由两个32BYTE的大整数组成 $sk=(zsk,vsk) \;\;zsk \in Fr, \; vsk \in Fr $  。

  可以采用 `cpt.Force_Fr` 将一个32 BYTE的整型限制在Fr域内。
  ```go
  zsk := keys.RandUint256()
  vsk := keys.RandUint256()
  zsk = cpt.Force_Fr(&zsk)
  vsk = cpt.Force_Fr(&vsk)
  ```
  其中，$zsk$是签名私钥，$vsk$是跟踪私钥。用来对交易进行签名。
  参考代码：`go-sero/zero/light/sli.go : CreateKr`

* #### 公钥

  公钥$PK$也是64 BYTE，由两个 32 BYTE 的 $ECC_{fp}$ 上的点构成 $PK=(ZPK,VPK)  \; ZPK \in ECC_{fp}, \; VPK \in ECC_{fp}$，可以通过`keys.Sk2Pk`将$sk$转换为$PK$。

  ```go
  PK:=keys.Sk2PK(&sk)
  ```

  $PK$ 用来生成 $PKr$ (收款码)。可以提供$PK$给第三方，第三方通过$PK$生成你的$PKr$(收款码)在给你转账，而自己使用$TK$来跟踪入账情况。但因为安全和性能的关系，不建议外部直接使用，外部转账建议直接使用$PKr$(收款码)。
  参考代码：`go-czero-import/keys/keys.go : Sk2PK`

* #### 跟踪私钥

  跟踪私钥也是64BYTE，由一个32BYTE的$ECC_{fp}$上的点和一个大整数构成，$TK=(ZPK,vsk) \; ZPK \in ECC_{fp},\; vsk \in Fr$，$ZPK$也是$PK$的前32 BYTE，$vsk$是$sk$的后32 BYTE。

  ```go
  tk:=[64]byte{}
  copy(tk[:32],pk[:32])
  copy(tk[32:],sk[32:])
  ```

  $TK$用来提供给可信方进行独立审计，可以跟踪入账和出账，由于导入$TK$需要从头开始分析账户

* #### 收款码

  收款码$PKr$是一个96 BYTE的二进制数据，由三个 32 BYTE 的 $ECC_{fp}$ 上的点构成。$PKr=(ZPKr,VPKr,BASEr) \; ZPKr \in ECC_{fp}, \; VPKr \in ECC_{fp}, \; BASEr \in ECC_{fp}$，可以通过`keys.Addr2PKr`将$PK$和一个随机数转换成$PKr$。

  ```go
  rnd := keys.RandUint256()
  pkr := keys.Addr2PKr(&pk, &rnd)
  ```

  $PKr$ 是UTXO的目标。$SK$和$TK$以及$PK$是一一对应的，但是他们都对应非常多个$PKr$。指向这个$PKr$的UTXO可以由$TK$解密并由$SK$进行签名。

  参考代码：`go-sero/zero/light/sli.go : CreateKr`

* #### 存储形式

  在几个轻钱包的接口中，为了方便，我们统一采用 96 BYTE的二进制数据存储各种类型的秘钥。

  * $sk=(zsk, vsk, 0)$
  * $TK=(ZPK, vsk, 0)$
  * $PKr=(ZPKr, VPKr, BASEr)$





## 离线方法

* #### ZeroInit

  * 作用：初始化算法的各种参数
  * 位置：go-czero-import/cpt/cpt.go

  ```go
  func ZeroInit(
        account_dir string,   //传入""
        netType NetType,      //传入2
       ) error 
  ```

  

* #### DecOuts

  * 作用：解密从sero_getblocksinfo获取的密文utxo
  * 位置：go-sero/zero/light/sli.go

  ```go
  func (self *SLI) DecOuts(
        outs []light_types.Out,      //sero_getblocksinfo获取的密文utxo
        tk *keys.PKr,                //账户的tk
       ) (douts []light_types.DOut)  //解密之后的utxo
  ```

* #### GenTx

  * 作用：生成并签名交易
  * 位置：go-sero/zero/light/sli.go

  ```go
  func (self *SLI) GenTx(
        param *light_types.GenTxParam   //构造交易的参数
       ) (gtx light_types.GTx, e error) //签名后的交易结果
  ```






## 在线方法(JSONRPC)

* `sero_getBlocksInfo(start,end)->blocks,error`
  * 获取$[start,end)$范围的区块信息
* `sero_getAnchor(roots)->witness,error`
  * 获取UTXO在当前区块的Witness (为零知识证明准备的)
* `sero_commitTx(tx)->error`
  * 提交交易，广播到全网





## 对接方案

1. 余额管理

   * 调用sero_getBlocksInfo依次获取区块数据blocks。

   * block中有outs和nils
     * 对于out
       * 判断他的PKr是否为自己所创建，如果是就代表这个out是给自己的。
       * 调用DecOut将Out的明文解出。
       * DecOut同时会给出这个Out的作废码(Nil)，需要保存。
     * 对于Nil
       * 当block中的Nil命中DecOut出来的Nil的时候，说明这个Out被用掉了。

2. 发送交易

   * 获取UTXO的Witness
     * 选取需要发送的UTXO，获取对应的Root。
     * 调用sero_getAnchor获取该UTXO的Witness。
   * 组装交易并生成证明
     * 将获取的信息以及原始交易信息组装成GenTxParam结构。
     * 调用sero_genTx生成最终的Tx，genTx会对交易进行签名和生成证明。
   * 提交交易
     * 调用sero_commitTx提交genTx生成的交易
     * 此时交易被广播到全网