# SERO Service Interface (SSI) 接口说明



Gero上开放了SSI服务，使得第三方可以通过rpc/web3连接gero，获得无状态的公链服务。

SSI的使用方式是不维护第三方创建的公私钥，因此，第三方需要自己创建存储公私钥，并在需要的时候提供给SSI。



## CreateKr

创建公私钥对

* Request

```json
  {"id":0,"jsonrpc":"2.0","method":"ssi_createKr","params":null}
```


* Successful Response

```json
  {
    "SKr":"0x5bf7d....a0016", //私钥
    "PKr":"0x904bb....09baa"  //公钥
  }
```





## GetBlocksInfo

用来主动同步区块数据

* Request

```json
  {
    "id":0,
    "jsonrpc":"2.0",
    "method":"ssi_getBlocksInfo",
    "params":[
        "0x0",                //起始块
        "0x5"                 //最多获取多少个块
    ]
  }
```


* Successful Response

```json
  [
      {
         "Num":"0x0",            //块号
         "Hash":"0x2472...2003"  //Block Hash
         "Outs":[
             {
             "Hash":"0x..."              //Tx Hash
             "Root":"0xfa2e8....5a717",  //该Out的Merkle Root
             "PKr": "0xaf630....7ca29"   //该Out的暂存公钥
             }
         ],
         "Nils":["0x...",...]    //作废码
       },
       ...
  ]
```



## Detail

获取对应Out的明文信息

* Request

```json
  {
    "id":1,
    "jsonrpc":"2.0",
    "method":"ssi_detail",
    "params":[
        ["0x...","0x..."],  //需要解出明文的out的root列表，需要有相同的PKr。
        "0x..."             //该Out的PKr对应的SKr
    ]
  }
```


* Successful Response

```json
  {
      "id":1,
      "jsonrpc":"2.0",
      "result":[
          {
              "Asset" :{                       //Out的资产
                  "Tkn" :{                     //Token资产
                      "Currency":"0x...",      //Token的币名
                      "Value":10000000        //Token的金额(bigint)
                  },
                  Tkt:{                     //Ticket资产
                      "Category":"0x...",      //Ticket类型
                      "Value":"0x..."         //Ticket的值
                  }
              },
              Memo:"...",                   //本Out的备注
              Nil:"0x..."                   //本Out的作废码
          },
          ...
      ]
  }
```



## GenTx

创建交易，需要发送方自己配平Out和In，注意In和Out的个数越多，交易生成的时间越长。

* Request

```json
  {
    "id":1,
    "jsonrpc":"2.0",
    "method":"ssi_genTx",
    "params":[{
        Gas: 10000,                       //本次交易的GasLimit
        GasPrice: 1000000000,             //本次交易的GasPrice
        From: {                           //代表发送者的Kr
            SKr:"0x...",
            PKr:"0x..."
        },                    
        Ins: [
            {
               SKr: "0x...",              //输入的UTXO对应的SKr
               Root: "0x..."              //输入的UTXO对应的Root
            },
            ...
        ],
        Outs: [
            {
               PKr: "0x...",              //输出的PKr
               Asset: {...},              //输出的资产，参考Detail
               Memo: "0x....."            //本次输出的备注
            },
            ...
        ]
    }]
  }
```

* Successful Response

```json
  {
      "id":1,
      "jsonrpc":"2.0",
      "result":"0x..."                   //该交易的hash
  }
```

    **注意** 
       * gero会根据当前机器的性能决定并行计算的数量，交易生成时间与引用的UTXO的数量成正比。
       * 一个解决方案是对充值的UTXO进行merge，另外一个是延长接口调用的超时时间。
       * --rpcwritetimeout [SECOND] 启动gero的时候加上这个参数，可以设置gero回写的超时时间，单位是秒。


## CommitTx

提交已经创建的交易

* Request

```json
  {
    "id":1,
    "jsonrpc":"2.0",
    "method":"ssi_commitTx",
    "params":[
        "0x..."                        //之前genTx创建的交易的hash
    ]
  }
```


* Successful Response

```json
  {
      "id":1,
      "jsonrpc":"2.0",
      "result":null
  }
```


## 离线签名
在  github.com/sero-cach/go-sero/zero/light 包里面，其中的sli.go是更底层的离线方法，调用这些方法不需要区块数据。

gtx,err:=light.SLI_Inst.GenTx(param GenTxParam)

param是需要签名的交易，gtx是签名后的交易。

```go
type GIn struct {
	SKr     keys.PKr   //In所有人私钥
	Out     Out        // GetBlocksInfo接口返回的结构
	Witness Witness    // GetAnchor接口返回的结构
}

type GOut struct {
	PKr   keys.PKr
	Asset assets.Asset
	Memo  keys.Uint512
}

type GenTxParam struct {
	Gas      uint64
	GasPrice big.Int
	From     Kr          //发送者公-私钥对
	Ins      []GIn
	Outs     []GOut
}

type T struct {
	Ehash    keys.Uint256   //外部hash
	From     keys.PKr       //发送者暂存公钥
	Fee      assets.Token   //gas费用
	Sign     keys.Uint512   //From签名
	Bcr      keys.Uint256   //Balance Commitment
	Bsign    keys.Uint512   //BCR 签名
	Desc_Z   Desc_Z         //密文输入输出
	Desc_O   Desc_O         //明文输入输出(一般不用)
	Desc_Pkg PkgDesc_Z      //Pkg描述(一般不用)
}

type GTx struct {
	Gas      hexutil.Uint64
	GasPrice hexutil.Big
	Tx       stx.T //交易数据
}
```

## 建议对接方案

1. 用户创建
   1. 为每个用户创建不同的Kr并存储在数据库中 
2. 充值：
   1. 不断的调用GetBlocksInfo获取最新的区块信息 
   2. 查找区块的Out中的PKr是否为自己创建，如果是，就调用Detail解出Out的明文信息以及对应的作废码Nil。
   3. 查找区块中的Nil是否在Detail的时候解出过，如果找到，说明对应的UTXO已经被用掉了。
3. 提现
   1. 获取已经存在的UTXO作为In，并构造出Out，配平后调用GenTx签名生成Tx。
   2. 调用CommitTx提交该Tx。
