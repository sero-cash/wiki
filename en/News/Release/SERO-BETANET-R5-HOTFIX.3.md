# BETANET-R5-HOTFIX.3 Release Announce



In order for the miners to have a good year, we have improved several issues that have received more feedback from the community in recent days.



## Release Name

BetaNet-R5-HOTFIX.3



## Release Version

v0.5.0-beta.r5-hotfix.3



## New Features

- [x] Improve the speed and connection stability in starting process.
- [x] Add Miner-Mode and optimize the mining power (without analysis of account).
- [x] Add hashrate displayment to the wallet (for estimating the succsessful rate of mining).
- [x] Fix the error of `can not find anchor' In the process of transaction generation.



## Commitment ID

go-sero      35c3fcadeda949fecf6d3b80994df1cdc69b4a29
go-czero-import  dbaf8d616f3b74eefdb5197bd07b6e405f3ea0be
console  b752cb6ba78a052691add8d40876275730f99427
wallet  9614518fd52951a44cbed28cb0955d4a25a3f3ec

## Release Packages

> **The download address of binay packages：**
> [https://github.com/sero-cash/go-sero/releases/tag/v0.5.0-beta.r5-hotfix.3](https://github.com/sero-cash/go-sero/releases/tag/v0.5.0-beta.r5-hotfix.3)
>
> gero-v0.5.0-beta.r5-hotfix.3-darwin-amd64.tar.gz  _macos,  md5:_
> gero-v0.5.0-beta.r5-hotfix.3-linux-amd64-v3.tar.gz  _centos & ubuntu, md5:_
> gero-v0.5.0-beta.r5-hotfix.3-linux-amd64-v4.tar.gz  _for fedora, md5:_
> gero-v0.5.0-beta.r5-hotfix.3-windows-amd64.tar.gz  _windows, md5:_



## Asian Edition Download Address

### DARWIN

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.5.0-beta.r5-hotfix.3/gero-v0.5.0-beta.r5-hotfix.3-darwin-amd64.tar.gz

### LINUX3

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.5.0-beta.r5-hotfix.3/gero-v0.5.0-beta.r5-hotfix.3-linux-amd64-v3.tar.gz



### LINUX4

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.5.0-beta.r5-hotfix.3/gero-v0.5.0-beta.r5-hotfix.3-linux-amd64-v4.tar.gz

### WINDOWS

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.5.0-beta.r5-hotfix.3/gero-v0.5.0-beta.r5-hotfix.3-windows-amd64.zip



## Special Instructions for Wallet Users

### 1. How do you decide whether you want to upgrade or not

** This version does not have to be upgraded. If your program has the following conditions, you can try to upgrade this version. **
* Compared with other machines with the same configuration **the mining efficiency is low**.
* The hard disk is old, IO is too weak to **affect synchronization efficiency**.
* After startup, **time to find node** is too long, **synchronization delay** is too long.
* I hope to see **the computing power** on the wallet.

### 2. How to determine if the current wallet and node version are the latest version

* First find and click the wallet's menu item **[About SERO Wallet]**.

  * Windows: in the top menu [**Help**->**About SERO Wallet**]

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201902//277023-eb709ef0c8c47af1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

  * Mac: in the top menu [**Help**->**About SERO Wallet**]

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201902//277023-011ac37a052914ec.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

* The pop-up dialog box has current wallet version information and node information.

  * For example, in the following example, the wallet version is 0.1.3, while the node version is 0.5.0-beta.r5-hotfix.2, which is lower than the current latest version number.

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201902//277023-469aa09e36dd723e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

  * The difference between a wallet and a node is that the wallet is just your interface, and the real mining is the node program, which is gero.

### 3. If you encounter a pop-up menu that prompts you to upgrade

* Is the dialog shown below

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201902//277023-dff2c76a75d2f6e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  * Miners who **do not want to upgrade** press **[SKIP UPDATE]** on the left.
  * Miners who **want to upgrade** press **[DOWNLOAD NEW VERSION]** on the right.

* There are two points to pay attention to
  * Whether you need to upgrade, refer to the above instructions **[1. Need to upgrade]**.
  * If your wallet **is starting**
    * Clicking "DOWNLOAD NEW VERSION" will immediately download the new gero background.
  * If your wallet **is running**
    * Click upgrade to exit the wallet and start the upgrade process.

### 4. What if there is no pop-up upgrade window and you want to upgrade?

* Check the version number of your current wallet.
* If it is not the current latest version, close and restart the wallet, the upgrade prompt will pop up automatically.
* If the previous step is not successful, you can do the following steps (this is most insurance)
  * Backup keystore files.
  * Uninstall the previous wallet (this step must be done, it may be invalid to overwrite the installation on Windows).
    - Don't worry, uninstalling the wallet will not erase the data and account files.
  * Download and install the latest wallet, the latest node program will be updated after installation.

### 5. How to estimate your own probability of mine a block

* Refer to [how to estimate your own probability of mine a block in solo mode]