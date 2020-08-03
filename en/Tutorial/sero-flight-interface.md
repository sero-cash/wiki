# SERO Flight Interface (SFI) Interface Description `v1.0.0-rc7`

The SFI interface is an upgraded version of SSI, supports jsonrpc and console calls, and supports the following features:

* gero does not maintain any keys
* Provide offline signature scheme
* User manages UTXO
* Divided into offline interface (local) and online interface (flight)

## Project Docking Solution

* Account Plan (offline)

   1. Generate random 32byte seeds offline (can be `local_genSeed` generated through the interface)
   2. Save offline by `local_seed2Sk` generating a private key `sk`.
   3. By `local_sk2Tk` generating a tracking keys `TK` provided to the online portion of the system.
   4. By `local_tk2Pk` generating a public key `PK`, it is provided to some online systems.
   5. Pass `local_pk2Pkr` and random numbers, bind a collection code for each user `PKr`.

* Deposit Detection Program (online)

   1. Continuously iterative calls to `flight_getBlocksInfo` obtain block information
   2. Determine `block.Outs[i].State.OS.Out_O.Addr` or `block.Outs[i].State.OS.Out_Z.PKr` whether it belongs to the bound user.
      * If it belongs to the bound user, do the following things
         1. Use `block.Outs[i]` and track the secret key `TK` as a parameter to call `local_decOut` out the UTXO data in plain text
         2. `UTXO` Obtain a list of obsolete codes from the extracted data `Nils`
         3. Save `UTXO` and `Nils`
         4. The `UTXO` asset recorded data
   3. Note that the `Root` of the `UTXO` obtained by `getBlocksInfo` or `getTx` before 32 confirmation blocks may change because of the fork, so it can only be used as a prompt and cannot be stored, and the `getTx` needs to be called again to get the latest data after 32 confirmation blocks before it can be finally stored.
   4. Determine whether the obsolete code `block.Nils` already exists in the previously saved `UTXO` table. If it exists, it indicates that it `UTXO` has been used.

* Send transactions (online and offline)

   1. Select `UTXO` the parameters that need to be transferred and the related transfer information structure to call `flight_genTxParam` and generate `txParam`.
   2. The offline signature method is called with the `txParam` private key `sk` as the parameter `local_signTxWithSk`, generated to be broadcast `tx`, and recorded `txhash`.
   3. Record the keys in the result of `local_signTxWithSk`
   4. Call `flight_commitTx` with `tx` as the parameter to broadcast to the whole network.
   5. To continue `txhash` as a parameter to call `flight_getTxReceipt`, to get packed block number.
   6. After confirming 32 blocks, the `flight_getTxReceipt` data can be obtained from the successful transaction.
   7. In case of disputes, you can take out the keys and call `local_confirmOutZ` to solve the plaintext data.
   
### Local Interface

The `local` interface is an offline `jsonrpc` interface. Although the gero program needs to be started, in addition to the rpc service, gero does not need to connect externally and synchronize data. Therefore, the following parameters can be used to start the `gero` service.

```sh
./gero --offline --mineMode --datadir ~ / geroData --nodiscover --rpc --rpcport 8545 --rpcapi local, sero --rpcaddr 127.0.0.1 --rpccorsdomain " * " --exchangeValueStr
```

> * In addition, Local interfaces can also be invoked through the Go language, need to rely on `github.com/sero-cash/go-seroand` and `github.com/sero-cash/go-czero-import` two libraries.
> > **Since the Go language refers to the C ++ library (libczero.so), you need to:**
> > 1. Download the latest go-czero-import project and place it on the same path as the go-sero project.
> >    * <https://github.com/sero-cash/go-czero-import>
> > 2. Set the environment variable LD_LIBRARY_PATH to point to go-czero-import/czero /lib_[XXXX]
> >    * XXXX chooses according to its own system

### Account Management

> Please refer to <https://wiki.sero.cash/zh/index.html?file=Tutorial/sero-exchange-interface#> for account principles and structure details

* **Randomly generated seed**

  seed needs to be saved offline

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
	"id": 0 , 
	"result": "0xc0bdec98290c5a2895e357a6f96f4f7f98b6750d37e77971a055579e7246c403"    // The randomly generated seed, 32byte hex code 
	"error": null
  }
  ```

  * go language
  ```go
  seed:=c_type.RandUint256()
  ```
* **Generate sk from seed**
  
  Private key needs to be used offline
  * request
  ```javascript
  { 
  	"id": 0 , 
  	"jsonrpc": "2.0" , 
  	"method": "local_seed2Sk" , 
  	"params": [ 
      "0xc0bdec98290c .... 79e7246c403" ,      // seed seed 
      1                                    // SuperZK version, 1: 1.0 2: 2.0, default is 1 
    ] 
  }
  ```
  * response
  ```javascript
  { 
	"id": 0 , 
	"result": "0x1657f2f6f8a743 ...... 595f96be89b4f03"    // Private key sk, 64byte hex encoding. 
	"error": null
  }
  ```

  * go language
  ```go
  sk:=superzk.Seed2Sk (
    &seed,
    1             // superzk protocol version 1: 1.0 2: 2.0 
  )
  ```

* **Generate tk from sk**

  The tracking key TK cannot sign transactions, so it can be used online.

  * request
  ```javascript
  {
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "local_sk2Tk",
  	"params": [
      "0x1657f2f6f8....95f96be89b4f03"      //Private Key sk
    ]
  }
  ```
  * response
  ```javascript
  { 
	"id": 0 , 
	"result": "tu1nEPYcBwBZm ...... r5Y1cXNAs8Ht4z"    // Tracking key tk, 64byte base58 encoding. 
	"error": null
  }
  ```

  * Go language
  ```go
  tk:=superzk.Sk2Tk(&sk)
  ```

* **Generate PK from tk**

  PK is a public key, so it can be used online.

  * request
  ```javascript
  { 
  	"id": 0 , 
  	"jsonrpc": "2.0" , 
  	"method": "local_tk2Pk" , 
  	"params": [ 
      "tu1nEPYcBwBZ ... 1cXNAs8Ht4z"       // Tracking key TK, which can be hex or base58 encoding. 
    ] 
  }
  ```

  * response
  ```javascript 
  { 
	"id": 0 , 
	"result": "tu1nEPYcBwBZm ...... cZojp6obBD87N"    // Public key PK, 64byte base58 encoding. 
	"error": null
  }
  ```

  * Go language
  ```go
  pk:=superzk.Tk2Pk(&tk)
  ```

* **Generate PKr from PK**
  PKr is a collection code, which can be used online to identify users.
  * request
  ```javascript
  { 
  	"id": 0 , 
  	"jsonrpc": "2.0" , 
  	"method": "local_pk2Pkr" , 
  	"params": [ 
      "tu1nEPYcBwBZ ...... cZojp6obBD87N" ,       // Public key PK, which can be hex or base58 Code 
      "0xd7a8cc1c7a1d09575950ca8004e3409ab7a6505b39a8e29783338e5016d8e7d1"  // 32 byte random number 
    ] 
  }
  ```

  * response
  ```javascript
  { 
	"id" : 0 , 
	"result" : "26fUeqrEbq4qZU ...... MP9ehQLV5frg"    // Receiving code PKr, 96byte base58 encoding 
	"error" : null
  }
  ```

  * Go language
  ```go
  pkr:=superzk.Pk2PKr(&pk)
  ```

### UTXO Analysis

From the `flight_getBlocksInfo` obtained block information, you can get the new one `UTXO`, which `UTXO` is ciphertext, so you need to use the tracking key `TK` for analysis. The analysis method `local_decOut` is also offline.

* request
```javascript
{ 
    "id": 0, 
    "jsonrpc": "2.0", 
    "method": "local_decOut", 
    "params": [ 
			[{  // Parameter 1: UTXO list to be parsed, from flight_getBlocksInfo 
				Root: "0x7b30cc8 ... .510fbb122e ", 
				State: { 
					Num: 28, 
					OS: { 
						Index: 31, 
						Out_O: {  // Out of plain text, and Out_Z will only have one 
							Addr: " 0x7c02a05 ... ba6ac83a8 ",
							Asset: {...}, 
							Memo: "0x0000 ...... 0000" 
						} , 
						Out_Z: {  // Out of ciphertext
							AssetCM in ciphertext: "0xa2a0f ...... 745a9", 
							EInfo: "0x68a9e ..... .b74ecfc493 " , 
							OutCM: " 0xc90dc ...... 90ff58f ", 
							PKr: " 0x9364f11 ...... 14406a3 ",     // hex code of payment code PKr 
							Proof: " 0x0341d67 ...... f941b0d ", 
							RPK: " 0x6230d4 ...... 02b51c2 " 
						    } , 
						    RootCM: " 0xff107b ...... ebdae30a2 "
					    } , 
					TxHash: "0x921b8 ...... be44829" 
				} 
			}] , 
			"tu1nEPYcBwB ...... 5Y1cXNAs8Ht4z"    // Parameter 2: TK corresponding to this UTXO 
		] 
}
```

* response
```javascript
{ 
    "id": 0, 
	"result": [ { 
		    Asset: { 
        		Tkn: { 
		            Currency: "0x00000 ...... 005345524f",            // Currency Name 
					Value: "1000000000000000000"                    // Amount 
				} , 
				Tkt: null                                        // Ticket assets, the exchange can ignore it 
			} , 
			Memo: "0x0000000 ...... 0000000000" ,                 // Information 
			Nils: [                                            // The UTXO obsolete code 
                "0x5f2324 ...... dda85393",                           / / As long as it is encountered during getBlocksInfo, the
                "0x661f10 ...... 90a6a720"                              // UTXO is invalid 
            ] 
    } ] ,
    "error": null
}
```

The following is the Go language version of UTXO analysis

```go
import 'github.com/sero-cash/go-sero/zero/txtool/flight'
import 'github.com/sero-cash/go-sero/zero/txtool'
import 'github.com/sero-cash/go-czero-import/cpt'
//---------
outs_str := '[{Root:"0x7b30cc8....510fbb122e",....,TxHash:"0x921b8......be44829"}]'
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

### Offline Signature
After calling the `flight_genTxParam` assembly transaction signature parameters, the private key can be passed in to `sk` call the offline signature method to local_signTxWithSk generate the final transaction. After the final transaction is generated, it can be called `flight_commitTx` and broadcast to the entire network.

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
		  	"Outs": [{}, {}],
        "Z": true //need to be sent anonymously
		  }, 
	    "0x1657f2f6 ...... f96be89b4f03"     // private key SK 
	  ] 
}
```

*	response
```javascript
{ 
	"id": 0, 
  "result": {     // final transaction, the entire network to be broadcast by flight_commitTx 
    "Gas": "0x61a8" , 
    "GasPrice": "0x3b9aca00", 
    "Hash": "0x813f69b7d60fe694ddfd6bec36e2adcba773a4518ee02354bd8f2f339f004a2e", 
    "Keys": [     // The ciphertext UTXO parses the secret key and will not be submitted to the chain. It can be saved as confirmation evidence. 
      "0x8e27d9fd65a178569b852cf71e476073b68c2f241074bbd7be712f145b84ee32",  
      "0x6d83ce881db4fd68876c9a84f354124a01f94d53e702facb4db8071bc6ae146f" 
	  ], 
	  "Bases":
      ["0x0000000000000000000000000000000000000000000000000000000000000000""
      ],
		"Tx": {}
  },
	"error": null
}
```

You can also use Go language offline signature

```go
import 'github.com/sero-cash/go-sero/zero/txtool/flight'
import 'github.com/sero-cash/go-sero/zero/txtool'
import 'github.com/sero-cash/go-czero-import/cpt'
param_str := '{"Gas" : 25000, "GasPrice": 1000000000, "From": {" SKr": "0x0  ...."}}'   // configured by a full node
sk_str := '0xfd1b401d2bbfa09fba577b398b09b5ea075bd8f37773095c6e62271a4b080977'
//------ 
cpt.ZeroInit_OnlyInOuts() // Initialization 
//---- 
var param txtool.GTxParam 
json.Unmarshal([] byte(param_str), &stop
bs, _ :=  hexutil.Decode(sk_str)
sk :=  keys.Uint512{}
copy(sk[:], bs)
// --------- You can assemble SK --------- 
gtx, _ := flight.SignTx(sk , param)
// ------ 
tx, _ := json.Marshal (&gtx)
```

### Confirm Out_Z

When signing a transaction, a key will be generated for each Out in Desc_Z, and this Key can be used to `local_confirmOutZ` reverse the clear text of this UTXO through the interface.
-	request
```javascript
{ 
  "id": 0, 
  "jsonrpc": "2.0", 
  "method": "local_confirmOutZ", 
  "params": [ 
    "0x8e27d9fd65a17 .... 7be712f145b84ee32",     // Key decryption key, which is returned when signing. 
    {                                           // Content of 
      Out_Z AssetCM: "0xb5c26 .... 7bcdaf0425", 
      EInfo: "0x589fa119 .... 741e562c1", 
      OutCM: "0xb1908 .... 3e48c14", 
      PKr: "0x1da430a .... 27b0126", 
      Proof: "0x03eed61 ..
      "0xc80da39....3263c2"
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

* Go language
```go
dec_out,err:=flight.ConfirmOutZ(&key,&outz)
```

### Confirm Out_C

When signing a transaction, a key will be generated for each Out_C in Tx1, and this key can be used to `local_confirmOutC`reverse the clear text of this UTXO through the interface.

- request
```javascript
{ 
  "id": 0, 
  "jsonrpc": "2.0", 
  "method": "local_confirmOutC", 
  "params": [ 
    "0x8e27d9fd65a17 .... 7be712f145b84ee32",     // Key decryption key, which is returned when signing. 
    {                                             // Content of 
      Out_C AssetCM: "0xb5c26 .... 7bcdaf0425", 
      EInfo: "0x589fa119 .... 741e562c1", 
      PKr: "0x1da430a .... 27b0126", 
      Proof: "0x03eed61 .... b24ad9b2a", 
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

*	Go language
```go
dec_out,err:=flight.ConfirmOutC(&key,&outc)
```

### Currency name interface

Currency Id is a 32-byte array, `\0` which can be converted to a string after removing all the previous ones. The offline method also provides a convenient method of mutual conversion.

** *Currency name to currency Id*

* request
```javascript
{
  	"id": 0,
  	"jsonrpc": "2.0",
  	"method": "local_currencyToId",
  	"params": [
      "SERO"     // Currency name string
    ]
```

* response

```javascript
{
	"id": 0,
	"result": "0x00000000....000005345524f",    // Currency Id
	"error": null
}
```

* Go language
```go
currency_id:=flight.CurrencyToId(currency_str)
```

* **Currency Id transfer name**

* request
```javascript
{
	"id": 0,
	"jsonrpc": "2.0",
	"method": "local_idToCurrency",
	"params": [
    "0x00000000....000005345524f"     // Currency Id
  ]
}
```

* response

```javascript
{
	"id": 0,
	"result": "SERO",    // Currency name
	"error": null
}
```

*	Go language
```go
currency_str:=flight.IdToCurrency(currency_id)
```

## Flight interface

The gero that starts the flight interface needs to synchronize the latest block, which provides online functions.  

The startup method is:  

```sh
./gero --mineMode --datadir ~/geroData --port 53717 --rpc --rpcport 8545 --rpcapi flight,sero --rpcaddr 127.0.0.1  --rpccorsdomain "*" --keystore ~/keystore --confirmedBlock 32 --rpcwritetimeout 1800 --exchangeValueStr
```

### Scan blocks
Scan the block to get the new UTXO and UTXO obsolete information in the block, but UTXO in both plain text and cipher text needs to call `local_decOut` decryption to get more details.

* request
```javascript
{ 
  	"id": 0, 
  	"jsonrpc": "2.0", 
  	"method": "flight_getBlocksInfo", 
  	"params": [ 
      15,       // start block height 
      1         // get how many subsequent blocks 
    ] 
}
```

* response
```javascript
{ 
	"id": 0 , 
	"result": [{                                 // Block object with height 15 
		"Hash": "0x33e2cb9 ..... 42e836e3b6b5",      // Block hash         
		"Nils": [                                  // The area Block invalidation UTXO obsolete code list 
			"0x020d0 .... fc504a5", 
			"0x09f76 .... fe482a6", 
			"0xd2d8ff3 .... c5b4da6", 
			"0x51991f8 .... e4380a" 
		], 
		"Num": "0xf ",                              // The height of this block 
		" Outs ": [                                  // The newly generated UTXO list in this block 
    {                                          // The first UTXO 
			" Root ": "0x3f89df0c....300e3572d",      // The UTXO's Root 
			"State": { 
				"Num": 15, 
				"OS": { 
					"Index": 15, 
					"Out_O": null, 
					"Out_Z": {                                 // This UTXO is an anonymous 
						"AssetCM": "0x3defeb .... fbe1ec80", 
						"EInfo": "0x218271e .... 190115c0", 
						"OutCM": "0x2920 .... ad5faa5", 
						"PKr": "0xe1f .... 09b23",                 // The UTXO point to the payment code PKr 
						"Proof":"0x03d8b7e....5c88c2e06",
						"RPK": "0x44231e....96841"
					},
          "Out_P": null,         // The plain text UTXO for the SuperZK2.0
          "Out_C": null,         // The ciphertext UTXO for the SuperZK2.0
				},
				"TxHash": "0x482a2....bd0a5c2"
			}
		}, 
    {                                                 // 2nd UTXO
			"Root": "0x8d98fe0....fe5bc71f",
			"State": {
				"Num": 15,
				"OS": {
					"Index": 16,
					"Out_O": {                                   // This UTXO is in plain text
						"Addr": "0x7c02a0....ba6ac83a8 ", //The UTXO point to the payment code PKr           
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
		"Pkgs": null                                       // Package assets, the exchange can ignore
	"error": null
}
```

### Get extra information about the block

This interface can obtain the latest or specified additional information of the block.

* request

```javascript
{
  "id": 0,
  "jsonrpc": "2.0",
  "method": "flight_getBlockByNumber",
  "params": [
    15      // Block height, empty is to get the latest block
  ]
}
```

* response

```javascript
{ 
	"id": 0, 
	"result": { 
    BlockHash: "0x33e2cb .... e3b6b5",                // Block Hash 
    BlockNumber: 15 ,                                // Block Number 
    Timestamp: 1565153901 ,                          // Timestamp 
    TxHashes: [ "0x482a2 .. ..1bd0a5c2 " ]               // Transaction Hash List 
  }, 
	" error": null
}
```

### Get details of a UTXO

Get UTXO details through UTXO's root

* request
```javascript
{
	"id": 0,
	"jsonrpc": "2.0",
	"method": "flight_getOut",
	"params": [
    "0x0x7b30cc8....510fbb122e"      // Root of a UTXO
  ]
}
```
* response

```javascript
{ 
	"id": 0, 
	"result": {                                     // UTXO details 
		Root: "0x7b30cc8 .... 510fbb122e",             
		State: { 
			Num: 28, 
			OS: {                             // There will only be one Out_O / Out_Z / Out_P / Out_C below
				Index: 31, 
				Out_O: {                                 //SUPERZK1.0 plain text Out 
					Addr: "0x7c02a05 ... ba6ac83a8",             // hex code 
					Asset collection code PKr: { ... }, 
					Memo: "0x0000 .. .... 0000 " 
				}, 
				Out_Z: {                                // Out 
					AssetCM in SUPERZK1.0 ciphertext: "0xa2a0f ...... 745a9", 
					EInfo: "0x68a9e ...... b74ecfc493", 
					OutCM: "0xc90dc ...... 90ff58f ", 
					PKr: " 0x9364f11 ...... 14406a3 ",            // hex code of payment code PKr 
					Proof: " 0x0341d67 ...... f941b0d ", 
					RPK: " 0x6230d4 ...... 02b51c2 " 
				}, 
        Out_P: {                                //SUPERZK2.0 plain text Out 
          Asset: { ... } , 
          Memo:" 0x00000 .... 000000", 
          PKr: "0x77305 .... 6bce36e"                  // hex code of payment code PKr 
        }, 
        Out_C: {                                //SUPERZK2.0 ciphertext Out 
          AssetCM: "0xd3be8490 .... 12904aa09 ", 
          EInfo: " 0xd42e33 .... b46e1cd3 ", 
        PKr: " 0xcc0c3b71 .... d7fcbd3 ",             // hex code of receipt code PKr 
          Proof: " 0x02a04a89 .... ede4dca72f ", 
          RPK: " 0x855ba .. ..352e88021 " 
        }, 
				RootCM: " 0xff107b ...... ebdae30a2 " 
		}, 
		TxHash:"0x921b8......be44829"           // Transaction Hash			}
		},
	"error": null
}
```

### Get original transaction details

Obtain the original transaction message through the transaction hash, that is, the signed transaction structure. This transaction structure cannot be used as the basis for final entry.

* request

```javascript
{
	"id": 0,
	"jsonrpc": "2.0",
	"method": "flight_getTx",
	"params": [
    "0x482a2f......1bd0a5c2"      //Transaction Hash
  ]
}
```

* response

```javascript
{ 
	"id": 0, 
	"result": {                                      // raw transaction information 
		"Gas": "0x15f90", 
		"GasPrice": "0x3b9aca00", 
		"Hash": "0x482a2 ...... d0a5c2", 
		"Tx": { 
			"Bcr": "0x3334c5 ...... 9ffe532e", 
			"Bsign": " 0xa9045b3 ...... 03d3c4503", 
			"Desc_Cmd": {                                // Execution command description, the exchange can ignore 
				"BuyShare": null, 
				"ClosePool": null,
				"Contract": null,
				"RegistPool": null
			} , 
			"Desc_O": { 
				"Ins": [ {                                  // clear input 
					"Nil": "0x020d0 ...... c504a5", 
					"Root": "0x09f765 ...... 5fe482a6 ", 
					" Sign ": " 0xcde0ef ...... c05e1b3b02 " 
				}] , 
				"Outs": [ ]                                 // Clear text output, only used for smart contracts, exchange ignores 
			} , 
			"Desc_Pkg": { 
			  "Close": null, 
				"Create": null,
				"Transfer": null
			},
			"Desc_Z": {
				"Ins": [],                                   // Cipher text input
				"Outs": [{                                   // Cipher text output
					"AssetCM": "0x3defeb7......afbe1ec80",
					"EInfo": "0x218271ed71......4190115c0",
					"OutCM": "0x29201d......1ad5faa5",
					"PKr": "0xe1f915......f09b23",
					"Proof": "0x03d8b......8c2e06",
					"RPK": "0x44231......f196841"
				}]
			},
			"Ehash": "0xe0624......fb4b00c", 
			"Fee": {                                            // Handling fee 
				"Currency": "0x0000000 ...... 00005345524f",        // Currency, you can use local_hexToCurrency to translate 
				"Value": "90000000000000"                         // Amount 
			} , 
			"From": "0x3fb451 ...... 42be2a0",                    // The sender's collection code is also the address where excess gas is returned. 
			"Sign": "0x5fdd91 ...... d98405", 
      "Tx1": {                                      //SuperZK2.0 transaction content 
        "Ins_C": [{...}] ,                           // ciphertext input 
        "Ins_P": [],                               //SuperZK1.0-2.0 conversion input 
        "Outs_C": [{...}] ,                          // ciphertext output 
        "Outs_P": [{...}]                           // plaintext output 
      } 
		} 
	} , 
	" error": null
}
```

### Get a transaction receipt

Get the result of the transaction. If the request is successful, it means that the transaction has been successfully packed into the block.

* request

```javascript
{
  "id": 0,
  "jsonrpc": "2.0",
  "method": "flight_getTxReceipt",
  "params": [
    "0x482a2f......1bd0a5c2"      // Hash of a transaction
  ]
}
```

* response

```javascript
{ 
	"id": 0, 
	"result": { 
		BHash: "0x33e2cb ...... e836e3b6b5",           // Packed block Hash 
		BNum: 15 ,                                    // Packed block height 
		Nils: [                                      // The invalid code of the transaction List 
      "0x09f765a ...... d55fe482a6", 
      "0x51991f8e ...... 6fe2dfe4380a" 
    ], 
		Outs: [                                      // Root list of UTXO generated by the transaction 
      "0x3f89df0c ...... e14a300e3572d",  
      "0x3f9e217. ..... 94fdabde70a7 ",  
      " 0x1d87a74a3 ...... 2d725144d6cd15 " 
    ], 
		Pkgs: null,
		PoolId: null, 
		ShareId: null, 
		State: 1,                                     // Whether the smart contract runs successfully 
		TxHash: "0x482a2f219d ...... a11bd0a5c2"        // Transaction Hash 
	} , 
	"error": null
}
```

### Assembly transaction signature parameters

The listing person needs to select the UTXO to be used to assemble the transaction. The assembly needs to provide the tracking key TK online, the `flight_genTxParam` method will obtain the current block witness, and automatically generate a change Out to balance the transaction amount. The output can be used `local_signTxWithSk` to sign.

* request

```javascript
{ 
	"id": 0, 
	"jsonrpc": "2.0", 
	"method": "flight_genTxParam", 
	"params": [{     // Parameter 1: Pre-assembled transaction structure 
		"From": "0xb8d01 ...... 143099 ",            // Change the payment code PKr, it needs to be matched with TK. 
		"Gas": 25000,                             // Max Gas consumption 
		"GasPrice": 1000000000,                   // Gas price, the minimum is 1Gta 
		"Ins": ["0x7b30c ...... 0fbb122e"],         // Enter the root list of UTXO, Need to make sure it is UTXO under TK. 
		"Outs": [{ 
			"Asset": {                              // Asset object 
				"Tkn": {                                      // Token object (homogenization token) 
					"Currency": "0x00000 ...... 005345524f",      // Currency Id, after removing 0 ASCII string "SERO" 
					"Value": "500000000000000000"               // currency amount 
				} 
			}, 
			"PKr": "0x3b78d ...... 4603daa"           // output receipt code PKr 
		}]
	}, 
  "tu1nEPY. ..... As8Ht4z "    // Parameter 2: Tracking key TK 
  ] 
}
```

* response

```javascript
{
	"id": 0,
	"result": {
		"Cmds": {                                // Trading order
			"BuyShare": null,
			"ClosePool": null,
			"Contract": null,
			"PkgClose": null,
			"PkgCreate": null,
			"PkgTransfer": null,
			"RegistPool": null
		},
		"Fee": {                                // transaction fee
			"Currency": "0x0000000......0005345524f",
			"Value": "25000000000000"
		},
		"From": {                                // Gas finds the recovery code PKr 
			"PKr": "0xb8d018f2 ...... 58143099", 
			"SKr": "0x00000 ...... 00000"} , 
		"Gas": 25000,                            // Max gas consumption 
    "GasPrice": 100000000,                   // Gas price 
		"Ins": [{                              // Input list 
			"Out": {
				"Root": "0x7b30cc81 ...... 10fbb122e", 
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
		"Outs": [{                                // Output list
			"Asset": {
				"Tkn": {
					"Currency": "0x00000000......000005345524f",
					"Value": "500000000000000000"
				},
				"Tkt": null
			},
			"Memo": "0x00000000......0000000000",
			"PKr": "0x3b78dd......4603daa"
		  "Asset": {// Automatically balanced change output{,}                                      
		  	"Tkn": {
		  		"Currency": "0x0000000......00005345524f",
		  		"Value": "499975000000000000"
		  	},
				"Tkt": null
		  },
		"Memo": "0x0000000......0000000",
		"PKr": "0xb8d018......143099"
		}],
    "Z":true //if true, sign & send the tx anonymously
	},
	"error": null
}
```

### Broadcast transaction

After the call `local_signTxWithSk` is signed, the output transaction can be called and `flight_commitTx` broadcast to the whole network.

* request

```javascript
{
	"id": 0,
	"jsonrpc": "2.0",
	"method": "flight_commitTx",
	"params": [{    // output of local_signTxWithSk
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
	"result": null,    // Successfully return null
  "error": null,
}
```

### Extract the corresponding Root through TK and Trace

When the transaction is signed, a Base is generated for each In in In_Z or In_C, and `flight_trace2Rootthe` root of UTXO corresponding to the In can be extracted through the three values of Base, Trace/NIL, and TK.

*	request

```javascript
{ 
	"id": 0, 
	"jsonrpc": "2.0", 
	"method": "flight_trace2Root", 
	"params": [ 
    "0xbb793767f ...... 070f62f05",   // TK tracking key 
    "0x0207f1a29 ... ... e7652eda1",   // Trace original Trace field in Desc_Z.Ins 
    " 0x000000000 ...... 000000000"    // Base value after signature 
  ] 
}
```

* response

```javascript
{
	"id": 0,
	"result": "0x51182a6775......f07d1e49a095",    // Root value
  "error": null,
}
```