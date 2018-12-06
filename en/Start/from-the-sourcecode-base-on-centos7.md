# From Source Code -- base on CentOS7

This article will cover following subjects :

1) Creating Accounts.
1) Mining SERO coins.
2) Generating transactions.
3) Deploying smart contract on SERO.
4) Doing anonymous transaction to another accounts using the coins issued by the smart contract.

and much more!



## 1. Hardware Requirements

With the current scale of the Beta network, the recommended requirements is:
> Processor: CPU with 2 threads or more(4 threads will run more smoothly)
> RAM: 4GB
> Disk space: 10G

```sh
#Hardware information of test machine in this document
#----------------------------
# OS         : CENTOS7.3
# Processor  : Xeon E5-26xx v4 (C2T2)
# RAM        : 4GB
# Disk space : 50GB
#----------------------------
```



## 2. Environment preparation

Install the GO and GIT client

```sh
$ sudo yum install golang
$ sudo yum install git
```

`Note that only v1.10.x and the older golang versions are supported, not supported by v1.11.x yet.`

Install the required C++ dependency library

```sh
$ sudo yum install gmp libgomp
```



## 3. Get the source code

Create the GOPATH directory

```sh
$ pwd
... /root
$ mkdir gopath
$ mkdir gopath/src
$ mkdir gopath/src/github.com
$ mkdir gopath/src/github.com/sero-cash
$ export GOPATH=/root/gopath
$ cd gopath/src/github.com/sero-cash
```

Visit the go-sero project webpage to clone the code: <https://github.com/sero-cash/go-sero>

```sh
$ git clone https://github.com/sero-cash/go-sero.git
```

Visit the go-czero-import project webpage to clone the code: <https://github.com/sero-cash/go-czero-import>

```sh
$ git clone https://github.com/sero-cash/go-czero-import.git
```



## 4. Compile gero

```sh
$ ls
... go-sero      go-czero-import
$ cd go-sero
$ make all
$ ls build/bin/gero
... build/bin/gero
```

You can see that the executable program `gero` is generated under the path build/bin, and if you want to recompile it, use the command:

```sh
$ make clean
$ make all
```



## 5. Configuration

With the executable program `gero`, you can run SERO's backend service and interactive console.

**First, configure the environment running gero**

Create the SERO data storage directory

```sh
$ mkdir ~/sero-data
```

Set the dynamic library importing path

```sh
$ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GOPATH/src/github.com/sero-cash/go-czero-import/czero/lib
```



## 6. Start the background service

With the executable program `gero`, you can now launch four different types of modes:

#### Start dev mode

```sh
$ build/bin/gero  --dev --datadir "~/sero-data" --ipcpath "~/sero-data/gero.ipc" > ~/sero-data/debug.log
```

> In this mode, you should connect other dev nodes manually. Mining difficulty is very easy and unlimited.

#### Start alpha mode


```sh
$ build/bin/gero --alpha --datadir "~/sero-data" --ipcpath "~/sero-data/gero.ipc" > ~/sero-data/debug.log
```

> In this mode, the AlphaNet is automatically linked and start synchronizing data. The AlphaNet is the internal test network of SERO. The mining requires a license. If there is a test requirement, you can send an email to [license@sero.vip](license@sero.vip) to apply for a "mining license" or "SERO token for test".

#### Start beta mode

```
$ build/bin/gero --datadir "~/sero-data" --ipcpath "~/sero-data/gero.ipc" > ~/sero-data/debug.log
```

> In this mode, the BetaNet network is automatically linked and start synchronizing data. The BetaNet is the beta test network of SERO. The mining requires a license also. If there is a test requirement, you can send an email to [license@sero.vip](license@sero.vip) to apply for a "mining license" or "SERO token for test".

#### Start Main mode

​    This mode is not currently supported and will be provided when the main network is online...

#### Result output

![](https://upload-images.jianshu.io/upload_images/277023-30b8b21ac13b66ad.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

> As long as you see the terminal output "IPC endpoint opened", it means that the service startup has been successful. Now you can start the gero console to connect to the background service.



## 7. Start the gero console

When adding the attach parameter, gero can be started as a console.

```sh
#Start the gero service in the background
$ nohup build/bin/gero  --dev --datadir "~/sero-data" --ipcpath "~/sero-data/gero.ipc" > ~/sero-data/gero.log &
#Start the console
$ build/bin/gero --datadir "~/sero-data" attach
```

> The attach parameter will let gero launch a interactive console based on JS virtual machine.

![](https://upload-images.jianshu.io/upload_images/277023-d8afed3845219ab1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

In which you can run complex Javascript interactive commands, the command to exit the console is

```sh
> exit
```



## 8. Accounts management

#### Create account

```javascript
> personal.newAccount("[PASSWORD]")
... "[PK]"
```

Where `[PASSWORD]` is the password for this account, because SERO does not store the user's private key. If there is no operation for 5 minutes, the account will be locked. In this case, to transfer the account, you need to use this password to unlock the accout. The command of create user will returns the user's public key. This public key can be used as a transfer address.

#### View all public keys

```javascript
> sero.accounts
... ["[PK0]","[PK1]",...,"[PKn]"]
```

This command returns the public keys of all accounts in the current wallet.

#### Unlock account

```javascript
> personal.unlockAccount("[PK]","[PASSWORD]")
```

`[PK]` is the user's public key

#### Get account balance

```javascript
> sero.getBalance("[PK]")
... {tkn:{...},tkt:{...}}
```

`tkn` shows all the `Tokens` balances of the account by category, and `tkt` shows all the `Tickets` held by the account by category.



## 9. Mining

#### Start mining

```javascript
> miner.start()
```

#### Stop mining

```javascript
> miner.stop()
```

#### Console sleep 

```javascript
> admin.sleepBlocks(num)
```

The parameter `num` is the number of blocks that need to sleep. This method must be invoked when the mining is started, otherwise the system will be blocked constantly. It should be noted that the reward obtained by the mining, by default, will enter the _ public address _ generated _ temporary address (PKr)_ of the 0th account of `sero.accounts`.

## 10.Perform transactions
When there is already a reward for mining in `accounts[0]`, it can be transferred to another account.

#### Transaction command

```javascript
sero.sendTransaction({
  from:"[SRC_PK]",
  to:"[TARGET_PK]",
  value:[NUM_OF_TA]
})
... "[TX_ID]"
```

> Where [SRC_PK] is the public key of the sender, [TARGET_PK] is the public key of the recipient, [NUM_OF_TA] is the minimum unit amount, the minimum unit of the SERO is TA, and the conversion unit is `1 SERO = 10^18 TA`. The return value [TX_ID] is the ID of the generated transaction.

![](https://upload-images.jianshu.io/upload_images/277023-bd6cbeca950950fe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

After the transaction is generated, it will be synchronized to other nodes in the current network, waiting to be packaged into the block. After packing into the block, you can use the following command to get the details of the transaction.

## 11. Get transaction details

```javascript
> sero.getTransaction("[TX_ID]")
...[TX_DETAIL]
```

![](https://upload-images.jianshu.io/upload_images/277023-010374c16c87687c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

The main formation of [TX_DETAIL] is as follows:

```javascript
{
  from: "[SENDER PKr]",
  stx: {
    Desc_Z_Ins: [{
        Anchor: "[MERKLE AUTH ROOT]",
        AssetCM: "[ASSET COMMITMENT]",
        Nil: "[NULLIFIER ID]",
        Trace: "[TRACE ID]"
        Proof: "[ZKP PROOF]"
    }],
    Desc_Z_Outs: [{
        AssetCM: "[ASSET COMMITMENT]",
        OutCM: "[OUTPUT COMMITMENT]",
        PKr: "[RECIVER PKr]",
        Proof: "[ZKP PROOF]"
    }],

  }
}
```


## 12. Deploy smart contracts

SERO's methods of deploy smart contracts are similar to those of Ethereum.

#### Compile smart contracts

Open the following link to using SERO's smart contract editor:
<http://remix.web.sero.cash>

![](https://upload-images.jianshu.io/upload_images/277023-95affedbc7d4344c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

After loading, you can see an example of `sero token. sol` issuing anonymous tokens.

![](https://upload-images.jianshu.io/upload_images/277023-3dfd4bce37a5e244.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Select `seroToken` in the upper right corner and click `Details`.

![](https://upload-images.jianshu.io/upload_images/277023-5731e92c7ab7ab0c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

Click the copy button in the upper left corner of the pop-up box `WEB3DEPLOY`.

#### Modify initialization parameters

![](https://upload-images.jianshu.io/upload_images/277023-1d6cdfa4e62f6416.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Modify the initialization variables in a text editor.

#### Deploy smart contract

![](https://upload-images.jianshu.io/upload_images/277023-2eee55bef93eac35.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1024)

Then paste all of the text into the console and press Enter. The console will immediately send a transaction to deylpy this smart contract.

#### View smart contract account
![](https://upload-images.jianshu.io/upload_images/277023-c88beb87ad21a616.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

After the transaction is successfully executed, the token issued by the smart contract can be viewed through the command `sero.getBalance`.

#### Call the smart contract
![](https://upload-images.jianshu.io/upload_images/277023-7b8f8c2fce9b7081.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

The anonymous tokens issued by the smart contract can be sent to the personal account using the `transfer` method defined by the smart contract.

#### Send anonymous tokens

Now the tokens of `HELLOCOIN` is already in the account of `account[0]`, `account[0]` can sent the tokens to other accounts with normal transactions command. But be sure to remember that the token name `cy:"HELLOCOIN"` must be specified in the parameter.

```javascript
sero.sendTransaction({from:sero.accounts[0],to:sero.accounts[1],value:500,cy:"HELLOCOIN"})
```

![image.png](https://upload-images.jianshu.io/upload_images/277023-f1706217106739bc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

Finally, in the accounts of accounts[1], you can see that it has received 500 tokens of `HELLOCOIN`.

![image.png](https://upload-images.jianshu.io/upload_images/277023-af79f0c27be00fbe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

The transaction is also confidential transaction.

## 13. The end

The introductory document ends here now. Next document we will explain in detail the main differences between SERO and Ethereum, and how `Tokens` and `Tickets` are used in smart contracts.

If you are interested in the principles of SERO and the zero-knowledge proofs algorithms, you can download our white paper from SERO's [official website] (https://sero.cash). Any suggestions can also be sent to [gordon@sero.vip] (gordon@sero.vip).

Welcome to SERO's [Gitter Community] (https://gitter.im/sero-cash/Lobby) to make SERO better.





--
[[Website] https://sero.cash](https://sero.cash)
[[White paper V1.0.6] http://sero-media.s3-website-ap-southeast-1.amazonaws.com/Sero_ENG_V1.06.pdf](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/Sero_ENG_V1.06.pdf)
[[Twitter] https://twitter.com/SEROdotCASH](https://twitter.com/SEROdotCASH)
[[WIKI]https://wiki.sero.cash/en/index.html](https://wiki.sero.cash/en/index.html)
[[Telegram] https://t.me/SeroOfficial](https://t.me/SeroOfficial)
[[Github] https://github.com/sero-cash/go-sero](https://github.com/sero-cash/go-sero)
[[Gitter Community] https://gitter.im/sero-cash/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link](https://gitter.im/sero-cash/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link)
[[SERO Blockchain Browser]  https://explorer.web.sero.cash/blocks.html](https://explorer.web.sero.cash/blocks.html)
[[SERO Smart Contract Editor]  https://remix.web.sero.cash/](https://remix.web.sero.cash/)
[[SERO Introduction Video] https://www.youtube.com/watch?v=lqFUhXskgNg](https://www.youtube.com/watch?v=lqFUhXskgNg)
[[SERO vs Zcash Video] https://www.youtube.com/watch?v=bc6yHTLSl5M](https://www.youtube.com/watch?v=bc6yHTLSl5M)