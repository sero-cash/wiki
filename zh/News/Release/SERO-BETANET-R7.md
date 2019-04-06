# BETANET-R7 发布公告



## 注意

- 本次更新将于第598567块进行软分叉，**请务必升级全节点(gero)和钱包程序(SERO Wallet)到最新版**。
  - 未更新的全节点和钱包将无法正确同步598567之后的区块。
  - 矿池的全节点程序(gero)需要升级。
  - 矿池程序和矿工程序不用升级


## 发布名称

BetaNet-R7


## 版本号

Gero: v0.7.0-beta.r7

Wallet: 0.1.5



## 新增特性

- [x] 削减共识状态的大小
- [x] 支持Flight钱包
- [x] 开放交易所对接API
- [x] 作弊检查



## 提交ID

go-sero      
go-czero-import  
console  
wallet  



## 发布包

> **二进制包下载地址：**
> [https://github.com/sero-cash/go-sero/releases/tag/v0.7.0-beta.r7](https://github.com/sero-cash/go-sero/releases/tag/v0.7.0-beta.r7)
>
> gero-v0.6.0-beta.r6-darwin-amd64.tar.gz  macos,  md5 :
> gero-v0.6.0-beta.r6-linux-amd64-v3.tar.gz  centos & ubuntu, md5 : 
> gero-v0.6.0-beta.r6-linux-amd64-v4.tar.gz  for fedora, md5 : 
> gero-v0.6.0-beta.r6-windows-amd64.tar.gz  windows, md5 : 



## 亚洲版下载地址

### DARWIN

<>

### LINUX3

<>

### LINUX4

<>

### WINDOWS

<>





## 钱包用户的特别说明

#### 1. 如何判断你是否要升级

**本版必须升级，否则：**
* 无法正确同步598567之后的区块
* 无法支持全节点钱包和Flight钱包互相转账



#### 2. 如何判断当前钱包和节点版本号是否最新版本

- 首先找到并点击钱包的**[关于]**这个菜单项

  - windows：在顶层菜单 [**帮助**->**关于SERO Wallet**]

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-eb709ef0c8c47af1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

  - Mac：在顶层菜单 [**SERO Wallet**->**关于SERO Wallet**]

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-8188131215142e1b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

- 弹出的对话框内有当前钱包版本信息和节点信息

  - 比如下图的例子，钱包的版本是0.1.4，而节点的版本是0.6.0-beta.r6，都低于当前最新的版本号。

  ![image_1d4kvaugfjar18131f5v1hkdm7h9.png-33.3kB](http://static.zybuluo.com/erlenzi-han/69qajk0nmal82z6bpqv5e972/image_1d4kvaugfjar18131f5v1hkdm7h9.png)

  - 钱包和全节点的区别是，钱包只是你的操作界面，而真正挖矿的是全节点程序，也就是gero。



#### 3. 如果你碰到弹出菜单提示你升级

- 就是下图这样的对话框

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-dff2c76a75d2f6e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  - **请点击 [DOWNLOAD NEW VERSION]**

- 有两个要注意的地方
  - 如果你的钱包**正在启动**
    - 点升级会马上下载新的gero后台。
  - 如果你的钱包**正在运行**
    - 点升级后，需要先退出钱包再启动升级程序。



#### 4. 如果没有弹出升级窗口怎么办？

- 检查你当前钱包的版本号
- 如果不是当前最新的版本，关闭并重启钱包，会自动弹出升级提示。
- 如果上一步骤不成功，你可以（这么做最保险）
  - 卸载之前的钱包（这一步一定要做，windows上覆盖安装无效）
    - 放心，卸载钱包不会清除数据和账户文件。
    - 不管如何，请备份好keystore文件夹。
  - 下载安装最新的钱包，安装后启动时自然会更新最新的节点程序。





