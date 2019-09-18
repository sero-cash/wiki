# SERO Flight Interface (SFI) 接口说明 `v1.0.0-rc7`

SFI接口是SSI的升级版，支持jsonrpc和console调用，并支持以下特点：

* gero不维护任何秘钥
* 提供离线签名方案
* 用户自主管理UTXO
* 分为离线接口(local)和在线接口(flight)



## 对接方案

* 账户方案(离线)
  1. 在线下生成随机的32byte的seed (可以通过`local_genSeed`接口生成)
  2. 通过`local_seed2Sk`生成一个私钥`sk`离线保存。
  3. 通过`local_sk2Tk`生成一个跟踪秘钥 `TK`提供给在线部分系统。
  4. 通过`local_tk2Pk`生成一个公钥`PK`，提供给在线部分系统。
  5. 通过`local_pk2Pkr`以及随机数，为每一个用户绑定一个收款码`PKr`。
* 充值检测方案(在线)
  1. 不断迭代的调用`flight_getBlocksInfo`获取区块信息
  2. 判断`block.Outs[i].State.OS.Out_O.Addr`或者`block.Outs[i].State.OS.Out_Z.PKr`是否属于绑定用户。
     * 如果属于绑定用户做下面几个事情
       1. 将`block.Outs[i]`以及跟踪秘钥`TK`作为参数调用`local_decOut`解出明文的UTXO数据
       2. 从解出的`UTXO`数据获取作废码列表`Nils`
       3. 将`UTXO`和`Nils`关联保存
       4. 将`UTXO`的资产数据入账
  3. 判断作废码`block.Nils`是否已经存在于之前保存的`UTXO`表中，如果存在，表明这个`UTXO`已经被用掉。
* 发送交易（在线和离线）
  1. 选择需要转账的`UTXO`以及相关转账信息构造的参数调用`flight_genTxParam`，生成`txParam`。
  2. 以`txParam`和私钥`sk`为参数调用离线签名方法`local_signTxWithSk`，生成待广播`tx`，并记录`txhash`。
  3. 记录`local_signTxWithSk`的结果中的keys。
  4. 以`tx`为参数调用`flight_commitTx`广播到全网。
  5. 不断的以`txhash`为参数调用`flight_getTxReceipt`,获取到打包块号。
  6. 确认32个块之后，还能从`flight_getTxReceipt`获取到数据则为成功交易。
  7. 遇到纠纷的时候，可以拿出keys，调用`local_confirmOutZ`来解出明文数据。



## Local 接口

`local` 接口是离线性质的`jsonrpc`接口，虽然需要启动gero程序，但是除了rpc服务，gero不需要对外连接和同步数据。因此可以采用下面的参数启动`gero`服务。

```sh
./gero --mineMode --datadir ~/geroData --nodiscover --rpc --rpcport 8545 --rpcapi local,sero --rpcaddr 127.0.0.1 --rpccorsdomain "*" --exchangeValueStr
```
### 账户管理

> 账户的原理和构成细节请参考 <https://wiki.sero.cash/zh/index.html?file=Tutorial/sero-exchange-interface#账户>

* **随机生成seed**
  
   seed需离线保存
   
  * request
  ```javascript
  {
    	"id": 0,
     	"jsonrpc": "2.0",
    	"method": "local_genSeed",
     	"params": []
   }
  ```
  
  * response
  ```javascript
  {
  	"id": 0,
  	"result": "0xc0bdec98290c5a2895e357a6f96f4f7f98b6750d37e77971a055579e7246c403"   //随机生成的seed，32byte的hex编码。
  	"error": null
  }
  ```

* **由seed生成sk**

   私钥需离线使用

   * request

   ```javascript
   {
     	"id": 0,
     	"jsonrpc": "2.0",
     	"method": "local_seed2Sk",
     	"params": [
         "0xc0bdec98290c....79e7246c403"     //种子 seed
       ]
   }
   ```

   * response

   ```javascript
   {
   	"id": 0,
   	"result": "0x1657f2f6f8a743......595f96be89b4f03"   //私钥 sk，64byte的hex编码。
   	"error": null
   }
   ```

   

* **由sk生成tk**

   跟踪秘钥TK无法对交易进行签名，因此可以在线使用。

   * request

   ```javascript
   {
     	"id": 0,
     	"jsonrpc": "2.0",
     	"method": "local_sk2Tk",
     	"params": [
         "0x1657f2f6f8....95f96be89b4f03"      //私钥 sk
       ]
   }
   ```

   * response

   ```javascript
   {
   	"id": 0,
   	"result": "tu1nEPYcBwBZm......r5Y1cXNAs8Ht4z"   //跟踪秘钥 tk，64byte 的 base58 编码。
   	"error": null
   }
   ```

   

* **由tk生成PK**

   PK是公钥，因此可以在线使用。

   * request

   ```javascript
   {
     	"id": 0,
     	"jsonrpc": "2.0",
     	"method": "local_tk2Pk",
     	"params": [
         "tu1nEPYcBwBZ...1cXNAs8Ht4z"      //跟踪秘钥 TK, 可以是 hex 或 base58 编码。
       ]
   }
   ```

   * response

   ```javascript
   {
   	"id": 0,
   	"result": "tu1nEPYcBwBZm......cZojp6obBD87N"   //公钥 PK，64byte 的 base58 编码。
   	"error": null
   }
   ```

   

* **由PK生成PKr**

   PKr是收款码，可以在线使用，用来标识用户。

   * request

   ```javascript
   {
     	"id": 0,
     	"jsonrpc": "2.0",
     	"method": "local_pk2Pkr",
     	"params": [
         "tu1nEPYcBwBZ......cZojp6obBD87N",      //公钥 PK, 可以是 hex 或 base58 编码
         "0xd7a8cc1c7a1d09575950ca8004e3409ab7a6505b39a8e29783338e5016d8e7d1" //32 byte 随机数
       ]
   }
   ```

   * response

   ```javascript
   {
   	"id": 0,
   	"result": "26fUeqrEbq4qZU......MP9ehQLV5frg"   //收款码 PKr， 96byte 的 base58 编码
   	"error": null
   }
   ```

   

### UTXO解析

从`flight_getBlocksInfo`获取的区块信息中，可以获得新增的`UTXO`，`UTXO`是密文的，因此需要用跟踪秘钥`TK`进行解析，解析的方法`local_decOut`也是离线的。

* request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "local_decOut",
  	"params": [
  		[{                          //参数1：需要解析的UTXO列表，来自flight_getBlocksInfo
  			Root: "0x7b30cc8....510fbb122e",
  			State: {
  				Num: 28,
  				OS: {
  					Index: 31,
  					Out_O: {                                //明文的Out，与Out_Z只会存在一个
  						Addr: "0x7c02a05...ba6ac83a8",
  						Asset: {...},
  						Memo: "0x0000......0000"
  					},
  					Out_Z: {                               //密文的Out
  						AssetCM: "0xa2a0f......745a9",
  						EInfo: "0x68a9e......b74ecfc493",
  						OutCM: "0xc90dc......90ff58f",
  						PKr: "0x9364f11......14406a3",       //收款码PKr的hex编码
  						Proof: "0x0341d67......f941b0d",
  						RPK: "0x6230d4......02b51c2"
  					},
  					RootCM: "0xff107b......ebdae30a2"
  				},
  				TxHash: "0x921b8......be44829"
  			}
  		}],
  		"tu1nEPYcBwB......5Y1cXNAs8Ht4z"       //参数2：该UTXO对应的TK
  	]
  }
  ```

  

* response

  ```javascript
  {
  	"id": 0,
  	"result": [{
  		Asset: {
  			Tkn: {
  				Currency: "0x00000......005345524f",           //币种名
  				Value: "1000000000000000000"                   //金额
  			},
  			Tkt: null                                       //Ticket资产，交易所可以忽略
  		},
  		Memo: "0x0000000......0000000000",                //附带信息
  		Nils: [                                           //该UTXO的作废码
        "0x5f2324......dda85393",                            //只要在getBlocksInfo时碰到，该
        "0x661f10......90a6a720"                             //UTXO即被作废
      ]
  	}],
  	"error": null
  }
  ```


下面是Go语言版的UTXO解析

  ```go
import 'github.com/sero-cash/go-sero/zero/txtool/flight'
import 'github.com/sero-cash/go-sero/zero/txtool'
import 'github.com/sero-cash/go-czero-import/cpt'
//---------
outs_str := '[{Root:"0x7b30cc8....510fbb122e",....,TxHash:"0x921b8......be44829"}}]'
tk_str := '0xfd1b401d2bbfa09fba577b398b09b5ea075bd8f37773095c6e62271a4b080977'
//---------
cpt.ZeroInit_OnlyInOuts() //初始化
//---------
var outs []txtool.Out
json.Unmarshal([]byte(outs_str),&outs)
//---------
bs, _ := hexutil.Decode(tk_str)
tk := keys.Uint512{}
copy(tk[:], bs)
//---------
douts,_=flight.DecOut(&tk,outs)
  ```

> **由于Go语言引用了C++库(libczero.so)，因此需要:**
>
> 1. 下载最新的go-czero-import工程，并跟go-sero工程放在相同的路径上。
>    * <https://github.com/sero-cash/go-czero-import>
> 2. 设置环境变量 LD_LIBRARY_PATH 指向 go-czero-import/czero/lib_[XXXX]
>    * XXXX 根据自己的系统进行选择

### 离线签名

在调用`flight_genTxParam`组装交易签名参数之后，可以传入私钥`sk`调用离线签名的方法`local_signTxWithSk`生成最终交易。生成最终交易之后，可以调用`flight_commitTx`，广播到全网。

* request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "local_signTxWithSk",
  	"params": [
      {        // flight_genTxParam 的结果 txParam
  		  "Cmds": {},
  		  "Fee": {},
  		  "From": {},
  		  "Gas": 25000,
        "GasPrice": 1000000000,
  		  "Ins": [{}],
  		  "Outs": [{},{}]
  	  },
      "0x1657f2f6......f96be89b4f03"    //私钥SK
    ]
  }
  ```

  

* response

  ```javascript
  {
  	"id": 0,
  	"result": {    //最终交易，可以通过flight_commitTx广播到全网
  		"Gas": "0x61a8",
  		"GasPrice": "0x3b9aca00",
  		"Hash": "0x813f69b7d60fe694ddfd6bec36e2adcba773a4518ee02354bd8f2f339f004a2e",
      "Keys": [    //密文UTXO解析秘钥，不会提交到链上，可以保存作为确认证据。
        "0x8e27d9fd65a178569b852cf71e476073b68c2f241074bbd7be712f145b84ee32", 
        "0x6d83ce881db4fd68876c9a84f354124a01f94d53e702facb4db8071bc6ae146f"
      ],
      "Bases": [    //密文In解析秘钥，不会提交到链上，可以用flight_trace2Root提取Root。
        "0x0000000000000000000000000000000000000000000000000000000000000000""
      ],
  		"Tx": {}
  	},
  	"error": null
  }
  ```


也可以使用Go语言版的离线签名

  ```go
  import 'github.com/sero-cash/go-sero/zero/txtool/flight'
  import 'github.com/sero-cash/go-sero/zero/txtool'
  import 'github.com/sero-cash/go-czero-import/cpt'
  param_str:='{"Gas":25000,"GasPrice":1000000000,"From":{"SKr":"0x0 .... }'  //由全节点构造
  sk_str:='0xfd1b401d2bbfa09fba577b398b09b5ea075bd8f37773095c6e62271a4b080977'
  //------
  cpt.ZeroInit_OnlyInOuts() //初始化
  //------
  var param txtool.GTxParam
  json.Unmarshal([]byte(param_str),&param)
  bs, _ := hexutil.Decode(sk_str)
  sk := keys.Uint512{}
  copy(sk[:], bs)
  //------可以自己组装SK---------
  gtx, _:=flight.SignTx(sk,param)
  //------
  tx, _ := json.Marshal(&gtx)
  ```



### 确认UTXO

在交易签名的时候，会为每个Desc_Z中的Out生成一个Key，用这个Key可以通过接口`local_confirmOutZ`反解出这个的UTXO的明文。

- request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "local_confirmOutZ",
  	"params": [
  		"0x8e27d9fd65a17....7be712f145b84ee32",    //Key 解密秘钥，签名的时候返回出来。
  		{                                          //
  			AssetCM: "0xb5c26....7bcdaf0425",
  			EInfo: "0x589fa119....741e562c1",
  			OutCM: "0xb1908....3e48c14",
  			PKr: "0x1da430a....27b0126",
  			Proof: "0x03eed61....b24ad9b2a",
  			RPK: "0xc80da39....3263c2"
  		}
  	]
  }
  ```

- response

  ```javascript
  {
  	"id": 0,
  	"result": {
  		Asset: {
  			Tkn: {
  				Currency: "0x000000000....0000005345524f",
  				Value: "1000"
  			},
  			Tkt: null
  		},
  		Memo: "0x0000000....00000000",
  		Nils: null
  	},
  	"error": null
  }
  ```



### 币名接口

币种Id是一个32byte的数组，将所有前面的`\0`去掉之后可以转换为字符串。离线方法也提供了方便的互相转换的方法。

* **币名转币种Id**

  * request

    ```javascript
    {
      	"id": 0,
      	"jsonrpc": "2.0",
      	"method": "local_currencyToId",
      	"params": [
          "SERO"     //币名字符串
        ]
    }
    ```

    

  * response

    ```javascript
    {
    	"id": 0,
    	"result": "0x00000000....000005345524f",    //币种Id
    	"error": null
    }
    ```

    

* **币种Id转币名**

  * request

    ```javascript
    {
      	"id": 0,
      	"jsonrpc": "2.0",
      	"method": "local_idToCurrency",
      	"params": [
          "0x00000000....000005345524f"     //币种Id
        ]
    }
    ```

    

  * response

    ```javascript
    {
    	"id": 0,
    	"result": "SERO",    //币名
    	"error": null
    }
    ```

    

## Flight 接口

启动flight接口的gero需要同步最新的区块，提供的是在线功能。

启动方式是：

```sh
./gero --mineMode --datadir ~/geroData --port 53717 --rpc --rpcport 8545 --rpcapi flight,sero --rpcaddr 127.0.0.1  --rpccorsdomain "*" --keystore ~/keystore --confirmedBlock 32 --rpcwritetimeout 1800 --exchangeValueStr
```



### 扫描区块

扫描区块可以获得区块中的新增UTXO和UTXO作废信息，但不管明文还是密文的UTXO都需要调用`local_decOut`解密才能获取更多的细节。

* request

  ```javascript
  {
    	"id": 0,
    	"jsonrpc": "2.0",
    	"method": "flight_getBlocksInfo",
    	"params": [
        15,      //起始区块高度
        1        //最大获取区块数
      ]
  }
  ```

  

* response

  ```javascript
  {
  	"id": 0,
  	"result": [{                                //高度为15的区块对象
  		"Hash": "0x33e2cb9.....42e836e3b6b5",     //区块hash        
  		"Nils": [                                 //该区块作废UTXO的作废码列表
  			"0x020d0....fc504a5",
  			"0x09f76....fe482a6",
  			"0xd2d8ff3....c5b4da6",
  			"0x51991f8....e4380a"
  		],
  		"Num": "0xf",                             //本区块高度
  		"Outs": [                                 //该区块新生成的UTXO列表
      {                                         //第1个UTXO
  			"Root": "0x3f89df0c....300e3572d",      //该UTXO的Root
  			"State": {
  				"Num": 15,
  				"OS": {
  					"Index": 15,
  					"Out_O": null,
  					"Out_Z": {                                //本UTXO是匿名的
  						"AssetCM": "0x3defeb....fbe1ec80",
  						"EInfo": "0x218271e....190115c0",
  						"OutCM": "0x2920....ad5faa5",
  						"PKr": "0xe1f....09b23",                //UTXO指向的收款码 PKr
  						"Proof": "0x03d8b7e....5c88c2e06",
  						"RPK": "0x44231e....96841"
  					},
  				},
  				"TxHash": "0x482a2....bd0a5c2"
  			}
  		}, 
      {                                                 //第2个UTXO
  			"Root": "0x8d98fe0....fe5bc71f",
  			"State": {
  				"Num": 15,
  				"OS": {
  					"Index": 16,
  					"Out_O": {                                   //本UTXO是明文的
  						"Addr": "0x7c02a0....ba6ac83a8",           //UTXO指向的收款码 PKr
  						"Asset": {
  							"Tkn": {
  								"Currency": "0x00000000....000005345524f",
  								"Value": "1000025000000000000"
  							},
  							"Tkt": null
  						},
  						"Memo": "0x0000000....00000000"
  					},
  					"Out_Z": null
  				},
  				"TxHash": "0x0000000....00000001"
  			}
  		}
      ],
  		"Pkgs": null                                       //Package 资产，交易所可以忽略
  	}],
  	"error": null
  }
  ```

  

### 获取区块额外信息

本接口可以获取最新的或指定区块的额外信息。

* request

  ```javascript
  {
    	"id": 0,
    	"jsonrpc": "2.0",
    	"method": "flight_getBlockByNumber",
    	"params": [
        15      //区块高度，为空则是获取当前最新区块
      ]
  }
  ```

  

* response

  ```javascript
  {
  	"id": 0,
  	"result": {
      BlockHash: "0x33e2cb....e3b6b5",               //块Hash
      BlockNumber: 15,                               //块号
      Timestamp: 1565153901,                         //时间戳
      TxHashes: ["0x482a2....1bd0a5c2"]              //交易Hash列表
    },
  	"error": null
  }
  ```

  

### 获取某个UTXO详情

通过UTXO的root获取UTXO详情

* request

  ```javascript
  {
    	"id": 0,
    	"jsonrpc": "2.0",
    	"method": "flight_getOut",
    	"params": [
        "0x0x7b30cc8....510fbb122e"      //某个UTXO的Root
      ]
  }
  ```

  

* response

  ```javascript
  {
  	"id": 0,
  	"result": {                                    //UTXO 详情
  			Root: "0x7b30cc8....510fbb122e",            
  			State: {
  				Num: 28,
  				OS: {
  					Index: 31,
  					Out_O: {                                //明文的Out，与Out_Z只会存在一个
  						Addr: "0x7c02a05...ba6ac83a8",
  						Asset: {...},
  						Memo: "0x0000......0000"
  					},
  					Out_Z: {                               //密文的Out
  						AssetCM: "0xa2a0f......745a9",
  						EInfo: "0x68a9e......b74ecfc493",
  						OutCM: "0xc90dc......90ff58f",
  						PKr: "0x9364f11......14406a3",       //收款码PKr的hex编码
  						Proof: "0x0341d67......f941b0d",
  						RPK: "0x6230d4......02b51c2"
  					},
  					RootCM: "0xff107b......ebdae30a2"
  				},
  				TxHash: "0x921b8......be44829"           //交易Hash
  			}
  		},
  	"error": null
  }
  ```

  

### 获取原始交易详情

通过交易hash获取原始交易报文，即签名后的交易结构，这个交易结构不可作为最后入账的依据。

* request

  ```javascript
  {
    	"id": 0,
    	"jsonrpc": "2.0",
    	"method": "flight_getTx",
    	"params": [
        "0x482a2f......1bd0a5c2"      //某个交易的hash
      ]
  }
  ```

  

* response

  ```javascript
  {
  	"id": 0,
  	"result": {                                     //原始交易信息
  		"Gas": "0x15f90",
  		"GasPrice": "0x3b9aca00",
  		"Hash": "0x482a2......d0a5c2",
  		"Tx": {
  			"Bcr": "0x3334c5......9ffe532e",
  			"Bsign": "0xa9045b3......03d3c4503",
  			"Desc_Cmd": {                               //执行命令描述，交易所可忽略
  				"BuyShare": null,
  				"ClosePool": null,
  				"Contract": null,
  				"RegistPool": null
  			},
  			"Desc_O": {
  				"Ins": [{                                 //明文的输入
  					"Nil": "0x020d0......c504a5",
  					"Root": "0x09f765......5fe482a6",
  					"Sign": "0xcde0ef......c05e1b3b02"
  				}],
  				"Outs": []                                //明文输出，只用于智能合约，交易所忽略
  			},
  			"Desc_Pkg": {
  				"Close": null,
  				"Create": null,
  				"Transfer": null
  			},
  			"Desc_Z": {
  				"Ins": [],                                   //密文输入
  				"Outs": [{                                   //密文输出
  					"AssetCM": "0x3defeb7......afbe1ec80",
  					"EInfo": "0x218271ed71......4190115c0",
  					"OutCM": "0x29201d......1ad5faa5",
  					"PKr": "0xe1f915......f09b23",
  					"Proof": "0x03d8b......8c2e06",
  					"RPK": "0x44231......f196841"
  				}]
  			},
  			"Ehash": "0xe0624......fb4b00c",
  			"Fee": {                                           //手续费
  				"Currency": "0x0000000......00005345524f",       //币种，可以用local_hexToCurrency翻译
  				"Value": "90000000000000"                        //金额
  			},
  			"From": "0x3fb451......42be2a0",                   //发送方收款码，也是多余gas退回的地址。
  			"Sign": "0x5fdd91......d98405"
  		}
  	},
  	"error": null
  }
  ```

  

### 获取交易收据

获取交易的结果，如果请求成功，说明交易已经成功打包进区块。

* request

  ```javascript
  {
    	"id": 0,
    	"jsonrpc": "2.0",
    	"method": "flight_getTxReceipt",
    	"params": [
        "0x482a2f......1bd0a5c2"      //某个交易的hash
      ]
  }
  ```

  

* response

  ```javascript
  {
  	"id": 0,
  	"result": {
  		BHash: "0x33e2cb......e836e3b6b5",          //打包区块Hash
  		BNum: 15,                                   //打包区块高度
  		Nils: [                                     //交易的作废码列表
        "0x09f765a......d55fe482a6",
        "0x51991f8e......6fe2dfe4380a"
      ],
  		Outs: [                                     //交易生成的UTXO的Root列表
        "0x3f89df0c......e14a300e3572d", 
        "0x3f9e217......94fdabde70a7", 
        "0x1d87a74a3......2d725144d6cd15"
      ],
  		Pkgs: null,
  		PoolId: null,
  		ShareId: null,
  		State: 1,                                    //智能合约运行是否成功
  		TxHash: "0x482a2f219d......a11bd0a5c2"       //交易Hash
  	},
  	"error": null
  }
  ```

  

### 组装交易签名参数

对接人需要自己选择要使用的UTXO来组装交易，组装时需要在线提供跟踪秘钥TK，`flight_genTxParam`方法会获取当前区块见证，并自动产生找零的Out来配平交易的金额。输出的结果可以用`local_signTxWithSk`进行签名。

* request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "flight_genTxParam",
  	"params": [{    //参数1：预组装交易结构
  		"From": "0xb8d01......143099",           //找零收款码PKr，需要与TK配套。
  		"Gas": 25000,                            //最大Gas消耗
  		"GasPrice": 1000000000,                  //Gas价格，最小为1Gta
  		"Ins": ["0x7b30c......0fbb122e"],        //输入UTXO的Root列表，需要确保是TK下面的UTXO。
  		"Outs": [{                               //输出
  			"Asset": {                             //资产对象
  				"Tkn": {                                     //Token对象（同质化通证）
  					"Currency": "0x00000......005345524f",     //币种Id，去掉0之后就是ASCII字符串 "SERO"
  					"Value": "500000000000000000"              //币种金额
  				}
  			},
  			"PKr": "0x3b78d......4603daa"          //输出的收款码PKr
  		}]
  	},
    "tu1nEPY......As8Ht4z"   //参数2：跟踪秘钥TK
    ]
  }
  ```

  

* response

  ```javascript
  {
  	"id": 0,
  	"result": {
  		"Cmds": {                                //交易命令
  			"BuyShare": null,
  			"ClosePool": null,
  			"Contract": null,
  			"PkgClose": null,
  			"PkgCreate": null,
  			"PkgTransfer": null,
  			"RegistPool": null
  		},
  		"Fee": {                                //交易费用
  			"Currency": "0x0000000......0005345524f",
  			"Value": "25000000000000"
  		},
  		"From": {                               //Gas找回收款码PKr
  			"PKr": "0xb8d018f2......58143099",
  			"SKr": "0x00000......00000"
  		},
  		"Gas": 25000,                           //最大gas消耗
      "GasPrice": 100000000,                  //Gas价格
  		"Ins": [{                               //输入列表
  			"Out": {
  				"Root": "0x7b30cc81......10fbb122e",
  				"State": {
  					"Num": 28,
  					"OS": {
  						"Index": 31,
  						"OutCM": null,
  						"Out_O": null,
  						"Out_Z": {
  							"AssetCM": "0xa2a0f0......03745a9",
  							"EInfo": "0x68a9ed......cfc493",
  							"OutCM": "0xc90dc......0ff58f",
  							"PKr": "0x9364f......4406a3",
  							"Proof": "0x0341d6......57f941b0d",
  							"RPK": "0x6230d427......02b51c2"
  						},
  						"RootCM": "0xff107b......dae30a2"
  					},
  					"TxHash": "0x921b8......e44829"
  				}
  			},
  			"SKr": "0x0000000......000000",
  			"Witness": {
  				"Anchor": "0xde09cc......463503",
  				"Paths": [
            "0x1777ebb......b3cf9c2c", 
            ......
            "0x3edc6......be382"
          ],
  				"Pos": "0x1f"
  			}
  		}],
  		"Outs": [{                                //输出列表
  			"Asset": {
  				"Tkn": {
  					"Currency": "0x00000000......000005345524f",
  					"Value": "500000000000000000"
  				},
  				"Tkt": null
  			},
  			"Memo": "0x00000000......0000000000",
  			"PKr": "0x3b78dd......4603daa"
  		}, {                                     //自动配平的找零输出
  			"Asset": {
  				"Tkn": {
  					"Currency": "0x0000000......00005345524f",
  					"Value": "499975000000000000"
  				},
  				"Tkt": null
  			},
  			"Memo": "0x0000000......0000000",
  			"PKr": "0xb8d018......143099"
  		}]
  	},
  	"error": null
  }
  ```

  

### 广播交易

在调用`local_signTxWithSk`进行签名之后，输出的交易可以调用`flight_commitTx`广播到全网。

* request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "flight_commitTx",
  	"params": [{    //local_signTxWithSk的输出
  		"Gas": "0x61a8",
  		"GasPrice": "0x3b9aca00",
  		"Hash": "0x813f69b7d60fe694ddfd6bec36e2adcba773a4518ee02354bd8f2f339f004a2e",
  		"Tx": {...}
  	}]
  }
  ```

  

* response

  ```javascript
  {
  	"id": 0,
  	"result": null,    //成功返回null
    "error": null,
  }
  ```

  

### 通过 TK 和 Trace 提取对应的Root

在交易签名的时候，会为每个Desc_Z中的In生成一个Base，通过Base、Trace、TK三个值用`flight_trace2Root`可以提取该In对应的UTXO的Root。

- request

  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "flight_trace2Root",
  	"params": [
      "0xbb793767f......070f62f05",  //TK 跟踪秘钥
      "0x0207f1a29......e7652eda1",  //Trace 原始Desc_Z.Ins 中的Trace字段
      "0x000000000......000000000"   //签名之后对应的Base值
    ]
  }
  ```

  

- response

  ```javascript
  {
  	"id": 0,
  	"result": "0x51182a6775......f07d1e49a095",    //Root值
    "error": null,
  }
  ```

  