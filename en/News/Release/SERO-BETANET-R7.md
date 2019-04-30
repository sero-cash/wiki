# BETANET-R7 Release Announce

## Attention

- This update will be soft forked in block 606006. 

  **Be sure to upgrade the full node (gero) and wallet program (SERO Wallet) to the latest version **

  - Unupdated full nodes and wallets will not be able to properly synchronize blocks after 606006.
  - The full node program (gero) of the mine pool needs to be upgraded.
  - Mine pool program and cminer procedures do not need to be upgraded



## Release Name

BetaNet-R7



## Version Number

Gero: v0.7.0-beta.r7-hotfix.1

Wallet: 0.1.5



## New Features

- [x] Reduce the size of the consensus state
- [x] Support for Flight Wallet
- [x] Open exchange docking API
- [x] Cheating check



## Commit ID

go-sero      87da4e0efb8f80340931cb714bcaa6526faf5d27
go-czero-import  467c7953127b649bfbf90adcb8a4d801d8db2900
console  d3c17dfac206642f03b1ddda4d8bcca9c636bf0e
wallet  fff15b4e5661bdce8165336a9178b2a0d859767c



## Release Packages

> **The download address of binay packages:**
> [https://github.com/sero-cash/go-sero/releases/tag/v0.7.0-beta.r7-hotfix.1](https://github.com/sero-cash/go-sero/releases/tag/v0.7.0-beta.r7-hotfix.1)
>
> gero-v0.7.0-beta.r7-hotfix.1-darwin-amd64.tar.gz  macos,  md5 :ec63681dd59e4aaa96ff241826e2b29f
> gero-v0.7.0-beta.r7-hotfix.1-linux-amd64-v3.tar.gz  centos & ubuntu, md5 : fad4e47b8f547d63d958b9f79d57bdd5
> gero-v0.7.0-beta.r7-hotfix.1-linux-amd64-v4.tar.gz  for fedora, md5 : 0e23b95a87712c53f28a1b48d044e00b
> gero-v0.7.0-beta.r7-hotfix.1-windows-amd64.tar.gz  windows, md5 : 6b564c52a136dac3c6721fcc5d93fca3



## Asian Edition Download Address

### DARWIN

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.0-beta.r7/gero-v0.7.0-beta.r7-hotfix.1-darwin-amd64.tar.gz>

### LINUX3

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.0-beta.r7/gero-v0.7.0-beta.r7-hotfix.1-linux-amd64-v3.tar.gz>

### LINUX4

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.0-beta.r7/gero-v0.7.0-beta.r7-hotfix.1-linux-amd64-v4.tar.gz>

### WINDOWS

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.0-beta.r7/gero-v0.7.0-beta.r7-hotfix.1-windows-amd64.zip>



## Special instructions for full node wallet users

#### 1. How do you decide whether you want to upgrade or not

**This version must be upgraded, otherwise:**
* Unable to correctly synchronize blocks after 598567
* Unable to support full node wallet and Flight wallet to transfer money to each other

#### 2. How to determine if the current full node wallet and gero node version number are the latest version

- First find and click on the wallet's **[about]** menu

  - windows: First find and click on the wallet's **[about]** menu item

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-eb709ef0c8c47af1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

  - Mac: At the top menu [**SERO Wallet**->**About SERO Wallet**]

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-8188131215142e1b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

- The pop-up dialog box has current wallet version information and node information.

  - In the example below, the version of the wallet is 0.1.4, and the version of the node is 0.6.0-beta.r6, which is lower than the current version number.

  ![image_1d4kvaugfjar18131f5v1hkdm7h9.png-33.3kB](http://static.zybuluo.com/erlenzi-han/69qajk0nmal82z6bpqv5e972/image_1d4kvaugfjar18131f5v1hkdm7h9.png)

  - The difference between a wallet and a full node is that the wallet is just your interface, and the real mining is the full-node program, which is gero.

#### 3. If you find the pop-up menu prompts you to upgrade

- Is the dialog box like the one below

  ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-dff2c76a75d2f6e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  - **Please click [DOWNLOAD NEW VERSION]**

- There are two points to pay attention to
  - If your wallet show **is starting**
    - Then click UPGRADE will immediately download the new gero background.
  - If your wallet show **is running**
    - When click UPGRADE, need to exit the wallet and start the upgrade process.

#### 4. What to do if an upgrade window does not pop up?

- Check the version number of your current wallet
- If it is not the current latest version, close and restart the wallet, the upgrade prompt will pop up automatically.
- If the previous step is not successful, you can (this is the most insurance)
  - Uninstall the previous wallet (this step must be done, the windows overwrite installation is invalid)
    - Don't worry, uninstalling the wallet won't erase the data and account files.
    - Regardless, please backup the keystore folder.
  - Download and install the latest wallet, the latest node program will be updated when you start the installation.