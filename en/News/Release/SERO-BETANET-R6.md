# BETANET-R6 Release Announce



## attention

* The R6 version enhances the security level of transactions,**Be sure to upgrade Gero to the latest version.**
  * Gero of R6 version translate the higher-level-security transactions, which can not be scaned by the Gero of the old version. (Transaction is safe, just not display)



## Release Name

BetaNet-R6



## Version Number

Gero: v0.6.0-beta.r6

Wallet: 0.1.4



## New Features

- [x] Improving the security level of transactions
- [x] Supporting for connection to the sero-mine-pool.
- [x] Supporting for connection to the cminer.



## Commit ID

go-sero      d1d65868407f2130a56707ffb986b9318940482f
go-czero-import  6e1fa977c8accd913cea938e17e51e3aa7ac4cc3
console  329b34bb69f55424149d06abe0f0c493a2d7bdfa
wallet  24f8a59fb2ce311c74bde00dc5765d49128e886d



## Release Packages

> **The download address of binay packages：**
> [https://github.com/sero-cash/go-sero/releases/tag/v0.6.0-beta.r6](https://github.com/sero-cash/go-sero/releases/tag/v0.6.0-beta.r6)
>
> gero-v0.6.0-beta.r6-darwin-amd64.tar.gz  _macos,  md5 :_4764db68d59f6b6558c4fa2140c45010
> gero-v0.6.0-beta.r6-linux-amd64-v3.tar.gz  _centos & ubuntu, md5 : 7d924958cdbf4268b9340d83da1b0c2c_
> gero-v0.6.0-beta.r6-linux-amd64-v4.tar.gz  _for fedora, md5 : a482509b5acf25f638524afae0ce9e96_
> gero-v0.6.0-beta.r6-windows-amd64.tar.gz  _windows, md5 : 7ba7417b650b79d6341f34d9b8f95c7a_



## Asian Edition Download Address

### DARWIN

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.6.0-beta.r6/gero-v0.6.0-beta.r6-darwin-amd64.tar.gz>

### LINUX3

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.6.0-beta.r6/gero-v0.6.0-beta.r6-linux-amd64-v3.tar.gz>

### LINUX4

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.6.0-beta.r6/gero-v0.6.0-beta.r6-linux-amd64-v4.tar.gz>

### WINDOWS

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.6.0-beta.r6/gero-v0.6.0-beta.r6-windows-amd64.zip>





## About the sero-mine-pool and the cminer

- The bigger miners can use cminer to connect Gero directly, because cminer is very light, so it will be more stable.
  - Reference [How to connect Gero with cminer for Solo mining](?file=Tutorial/how-to-evaluate-node-hashrate)
- The smaller miners can use cminer to connect the pool, no license required, and balance the benefits from the miners.
  - Reference [How to Connect Pool Mining with cminer](?file=Tutorial/how-to-evaluate-node-hashrate)





## Special Instructions for Wallet Users

### 1. How do you decide whether you want to upgrade or not

** This version does not have to be upgraded. If your program has the following conditions, you can try to upgrade this version. **

- Compared with other machines with the same configuration **the mining efficiency is low**.
- The hard disk is old, IO is too weak to **affect synchronization efficiency**.
- After startup, **time to find node** is too long, **synchronization delay** is too long.
- I hope to see **the computing power** on the wallet.

### 2. How to determine if the current wallet and node version are the latest version

- First find and click the wallet's menu item **[About SERO Wallet]**.

  - Windows: in the top menu [**Help**->**About SERO Wallet**]

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201902//277023-eb709ef0c8c47af1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

  - Mac: in the top menu [**Help**->**About SERO Wallet**]

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201902//277023-011ac37a052914ec.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

- The pop-up dialog box has current wallet version information and node information.

  - For example, in the following example, the wallet version is 0.1.4, while the node version is 0.6.0-beta.r6, which is lower than the current latest version number.

  ![image_1d4kvaugfjar18131f5v1hkdm7h9.png-33.3kB](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201902/image_1d4kvaugfjar18131f5v1hkdm7h9.png)

  - The difference between a wallet and a node is that the wallet is just your interface, and the real mining is the node program, which is gero.

### 3. If you encounter a pop-up menu that prompts you to upgrade

- Is the dialog shown below

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201902//277023-dff2c76a75d2f6e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  - Miners who **do not want to upgrade** press **[SKIP UPDATE]** on the left.
  - Miners who **want to upgrade** press **[DOWNLOAD NEW VERSION]** on the right.

- There are two points to pay attention to

  - Whether you need to upgrade, refer to the above instructions **[1. Need to upgrade]**.
  - If your wallet **is starting**
    - Clicking "DOWNLOAD NEW VERSION" will immediately download the new gero background.
  - If your wallet **is running**
    - Click upgrade to exit the wallet and start the upgrade process.

### 4. What if there is no pop-up upgrade window and you want to upgrade?

- Check the version number of your current wallet.
- If it is not the current latest version, close and restart the wallet, the upgrade prompt will pop up automatically.
- If the previous step is not successful, you can do the following steps (this is most insurance)
  - Backup keystore files.
  - Uninstall the previous wallet (this step must be done, it may be invalid to overwrite the installation on Windows).
    - Don't worry, uninstalling the wallet will not erase the data and account files.
  - Download and install the latest wallet, the latest node program will be updated after installation.




