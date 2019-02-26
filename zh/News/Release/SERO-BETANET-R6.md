# BETANET-R6 发布公告



## 注意

* R6版增强交易的安全级别，**请务必升级gero到最新版**。
  * R6版本gero所发的更高安全级别交易，旧版本gero不可见。（交易安全，只是不显示而已）



## 发布名称

BetaNet-R6



## 版本号

Gero: v0.6.0-beta.r6

Wallet: 0.1.4



## 新增特性

- [x] 提高交易安全级别。
- [x] 支持连接到矿池。
- [x] 支持连接矿工程序(cminer)挖矿。



## 提交ID

go-sero      d1d65868407f2130a56707ffb986b9318940482f
go-czero-import  6e1fa977c8accd913cea938e17e51e3aa7ac4cc3
console  329b34bb69f55424149d06abe0f0c493a2d7bdfa
wallet  24f8a59fb2ce311c74bde00dc5765d49128e886d



## 发布包

> **二进制包下载地址：**
> [https://github.com/sero-cash/go-sero/releases/tag/v0.6.0-beta.r6](https://github.com/sero-cash/go-sero/releases/tag/v0.6.0-beta.r6)
>
> gero-v0.6.0-beta.r6-darwin-amd64.tar.gz  _macos,  md5 :_4764db68d59f6b6558c4fa2140c45010
> gero-v0.6.0-beta.r6-linux-amd64-v3.tar.gz  _centos & ubuntu, md5 : 7d924958cdbf4268b9340d83da1b0c2c_
> gero-v0.6.0-beta.r6-linux-amd64-v4.tar.gz  _for fedora, md5 : a482509b5acf25f638524afae0ce9e96_
> gero-v0.6.0-beta.r6-windows-amd64.tar.gz  _windows, md5 : 7ba7417b650b79d6341f34d9b8f95c7a_



## 亚洲版下载地址

### DARWIN

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.6.0-beta.r6/gero-v0.6.0-beta.r6-darwin-amd64.tar.gz>

### LINUX3

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.6.0-beta.r6/gero-v0.6.0-beta.r6-linux-amd64-v3.tar.gz>

### LINUX4

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.6.0-beta.r6/gero-v0.6.0-beta.r6-linux-amd64-v4.tar.gz>

### WINDOWS

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.6.0-beta.r6/gero-v0.6.0-beta.r6-windows-amd64.zip>



## 关于矿池和矿工程序

- 算力大的矿工可以采用cminer直接连接gero挖矿，因为cminer非常轻，所以会很稳定。
  - 参考 [如何用矿工程序(cminer)连接gero进行SOLO挖矿](?file=Start/how-to-connect-gero-using-cminer)
- 算力较小的矿工可以采用cminer连接矿池挖矿，由矿池平衡收益。
  - 参考 [如何用矿工程序(cminer)连接矿池挖矿](?file=Start/mined-in-the-mine-pool)





## 钱包用户的特别说明

#### 1. 如何判断你是否要升级

**本版非必须升级，如果你的程序存在下面几个情况，可以尝试升级此版本。**

- 对比其他相同配置的机器**挖矿效率低**的。
- 磁盘老旧，IO太弱以至于**影响同步效率**的。
- 启动后**查找节点时间**过长，**同步延时**较长的。
- 希望在钱包上看到**本节点算力**的。



#### 2. 如何判断当前钱包和节点版本号是否最新版本

- 首先找到并点击钱包的**[关于]**这个菜单项

  - windows：在顶层菜单 [**帮助**->**关于SERO Wallet**]

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-eb709ef0c8c47af1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

  - Mac：在顶层菜单 [**SERO Wallet**->**关于SERO Wallet**]

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-8188131215142e1b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

- 弹出的对话框内有当前钱包版本信息和节点信息

  - 比如下图的例子，钱包的版本是0.1.4，而节点的版本是0.6.0-beta.r6，都低于当前最新的版本号。

  ![image_1d4kvaugfjar18131f5v1hkdm7h9.png-33.3kB](http://static.zybuluo.com/erlenzi-han/69qajk0nmal82z6bpqv5e972/image_1d4kvaugfjar18131f5v1hkdm7h9.png)

  - 钱包和节点的区别是，钱包只是你的操作界面，而真正挖矿的是节点程序，也就是gero。



#### 3. 如果你碰到弹出菜单提示你升级

- 就是下图这样的对话框

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-dff2c76a75d2f6e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  - **不想升级**的矿工按左侧的 **[SKIP UPDATE]**
  - **想要升级**的矿工按右侧的 **[DOWNLOAD NEW VERSION]**

- 有两个要注意的地方

  - 自己需不需要升级，参考上面的说明 **[1. 需要升级的情况]**
  - 如果你的钱包**正在启动**
    - 点升级会马上下载新的gero后台。
  - 如果你的钱包**正在运行**
    - 点升级会先退出钱包再启动升级程序。



#### 4. 如果没有弹出升级窗口又想要升级怎么办？

- 检查你当前钱包的版本号
- 如果不是当前最新的版本，关闭并重启钱包，会自动弹出升级提示。
- 如果上一步骤不成功，你可以（这么做最保险）
  - 卸载之前的钱包（这一步一定要做，windows上有覆盖安装无效）
    - 放心，卸载钱包不会清楚数据和账户文件。
    - 不管如何，请备份好keystore文件夹。
  - 下载安装最新的钱包，安装后自然会更新最新的节点程序。






