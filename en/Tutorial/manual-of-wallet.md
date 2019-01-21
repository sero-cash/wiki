# SERO Wallet Manual



## About SERO Wallet

### Introduction

> SERO Wallet is a full-node client wallet based on the SERO blockchain, which can meet the needs of most users, such as importing wallet accounts, sending transactions, mining, and publishing smart contracts. Windows, MAC and LINUX systems are currently supported.
> SERO wallet has been open source on Github: [SERO Wallet](https://github.com/sero-cash/wallet/)



### Install

- **Client installation package [Click to download](https://github.com/sero-cash/wallet/releases)**

- **Select the installation package corresponding to the system**

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-dbd961324d95ab0a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600) 

- **Install according to the installation method of each type of system. Take the installation on the MAC as an example, in the installation interface, drag SERO Wallet to the Applications folder.**
  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-249e64d50ce40182.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

### Start

- **Find SERO Wallet from the applications.**
  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-3723b412210c1e30.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
- **The first startup will check SERO Node and download the latest version. Please wait patiently.**
  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-6ab808a805e741ec.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
- **Connect to the SERO Node, the wallet will automatically find the nearest node, you can directly click "Start Application" to enter the main wallet interface**
  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-41eefaad986645f0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

### Update

- **If you need to upgrade your wallet, you can click the following button in the menu**
  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-04e69f3668aa8947.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
- **You can also follow the updates of the SERO team at [Github](https://github.com/sero-cash/wallet) and download the installation package directly for upgrade.**

<br/>

## Features

### Sync blocks

> After the wallet is started, the block will be automatically synchronized. The startup interface and the main wallet interface can display the synchronized status.
> ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-6380856e18c12f03.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
> ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-41dc5a187f43c237.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

<br>

### Account

> The account is used to store your SERO coins and other tokens, similar to your bank account, so you need to keep your account safe and suggest making backup.

- #### Create Account

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-7c1dbdb0e9169c5b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
  After the new account is successfully created, the wallet will provide the account file path (.json suffix ) and prompt for backup.
  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-2efbf7eafb9453c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

- #### Import Account

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-6130e99a45d4da47.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

- #### Backup Account

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-56861377fff5b9f9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
  将会打开备份文件目录，你可以把账户文件拷贝到你自己的硬盘或者U盘。

- #### Accounts Overview

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-428d06cd20639ac1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

- #### Unit Conversion of SERO

  > 1 SERO = $10^{18}$ Ta, which means that `Ta` is the smallest conversion unit of SERO.

<br>

### How to Mine⛏️

- #### Apply for Mining License

  The SERO community has opened an application for mining licenses. Please email the account address to [license@sero.vip](mailto:license@sero.vip) and the SERO team will respond within 48 hours.

- #### Import Mining License

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-4360e06128676a16.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

- #### Start Mining

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-b79de8b96eb70976.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

<br>

### Send Transactions

- #### Glossary

  > **FROM**: Address of account transferred out
  > **TO**: Address of account transferred in
  > **AMOUNT**: Number of SERO coins
  > **SELECTFEE**: The transaction fee determines the transaction processing speed. The default transaction fee is: 1Gta

- #### Screenshot of the transaction:

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-648a948dfaa360c8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-6c34a3acf52d17ea.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

- #### Click the "Send" button, a dialog will pop up, and the wallet will estimate the Gas that needs to be consumed.

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-fb7ac55a7622e891.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  Now the wallet main interface can see the transaction record. Since SERO is anonymous currency, the transaction amount will not be displayed in the transaction.

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-c15e6101c5259477.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-7b2c75247b761dd5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

<br>

### Smart Contract

- #### Create Smart Contract

  > Please refer to SERO's official editor for the smart contract code [SC IDE](https://remix.web.sero.cash)
  > aste the source code, the wallet will automatically compile the source code, then select the smart contract that needs to be published and input the relevant parameters.

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-2891a67c70499b99.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  > After clicking Send button, you will see that the smart contract transaction has been created in the main wallet interface.

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-fc07f805cd5ad73d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

- #### Call Smart Contract

  > Open the management interface and we can see the number of coins issued and the unit of 100000000000000000STRA. Note that the smallest unit here is 9 decimal places.

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-f1e5c9a6bde7cb84.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  > We can choose a method, such as: call the transfer method, transfer tokens to other accounts

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-e96badc14215f373.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  > Then the wallet main page will have a record of the execution of the smart contract.

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-26e19110e0494955.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  > When the transaction is confirmed, we see that the account has received the transfered tokens.

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-612df1c6df02c6d9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

<br>

## Other Matters 

- #### SERO Wallet Installation Directory

  ```
  MACOS：~/Library/Application\ Support/SERO Wallet
  LINUX：~/.config/SERO Wallet
  Windows：C:\Users\%username%\AppData\Roaming\SERO Wallet\
  ```

- #### SERO Wallet Data Directory

  ```
  MACOS：~/Library/Sero/
  LINUX：~/.sero/
  Windows：C:\Users\%username%\AppData\Roaming\Sero
  ```

- #### View Log Files:

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-420d9f4924c44f81.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

<br>

**The above is a description of all the functions of the SERO wallet. If you have any questions or problems, you can join the SERO community technology group Gitter [点击加入](https://gitter.im/sero-cash/wallet)。**



<br/>



## Related Links

[SERO Github](https://github.com/sero-cash)
[SERO Website](https://sero.cash)
[SERO Blockchain Explorer](https://explorer.web.sero.cash)