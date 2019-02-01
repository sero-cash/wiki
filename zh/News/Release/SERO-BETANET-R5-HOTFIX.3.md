# BETANET-R5-HOTFIX.3 喜迎春节优化版



为了让矿工们过个好年，我们对这几天社区反馈较多的几个问题进行了改进。



## 发布名称

BetaNet-R5-HOTFIX.3



## 版本号

Gero: v0.5.0-beta.r5-hotfix.3

Wallet: 0.1.4



## 新增特性

- [x] 提高启动时查询节点的速度和连接稳定程度。
- [x] 增加矿工模式优化算力（不分析账户状态）。
- [x] 在钱包界面增加hashrate的展示（估算出块概率用的）。
- [x] 修复交易生成时`can not find anchor`的错误。



## 提交ID

go-sero      35c3fcadeda949fecf6d3b80994df1cdc69b4a29
go-czero-import  dbaf8d616f3b74eefdb5197bd07b6e405f3ea0be
console  b752cb6ba78a052691add8d40876275730f99427
wallet  9614518fd52951a44cbed28cb0955d4a25a3f3ec



## 发布包

> **二进制包下载地址：**
> [https://github.com/sero-cash/go-sero/releases/tag/v0.5.0-beta.r5-hotfix.3](https://github.com/sero-cash/go-sero/releases/tag/v0.5.0-beta.r5-hotfix.3)
>
> gero-v0.5.0-beta.r5-hotfix.3-darwin-amd64.tar.gz  _macos,  md5:_
> gero-v0.5.0-beta.r5-hotfix.3-linux-amd64-v3.tar.gz  _centos & ubuntu, md5:_
> gero-v0.5.0-beta.r5-hotfix.3-linux-amd64-v4.tar.gz  _for fedora, md5:_
> gero-v0.5.0-beta.r5-hotfix.3-windows-amd64.tar.gz  _windows, md5:_



## 亚洲版下载地址

### DARWIN

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.5.0-beta.r5-hotfix.3/gero-v0.5.0-beta.r5-hotfix.3-darwin-amd64.tar.gz

### LINUX3

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.5.0-beta.r5-hotfix.3/gero-v0.5.0-beta.r5-hotfix.3-linux-amd64-v3.tar.gz



### LINUX4

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.5.0-beta.r5-hotfix.3/gero-v0.5.0-beta.r5-hotfix.3-linux-amd64-v4.tar.gz

### WINDOWS

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.5.0-beta.r5-hotfix.3/gero-v0.5.0-beta.r5-hotfix.3-windows-amd64.zip





## 钱包用户的特别说明

### 1. 如何判断你是否要升级

**本版非必须升级，如果你的程序存在下面几个情况，可以尝试升级此版本。**

* 对比其他相同配置的机器**挖矿效率低**的。
* 磁盘老旧，IO太弱以至于**影响同步效率**的。
* 启动后**查找节点时间**过长，**同步延时**较长的。
* 希望在钱包上看到**本节点算力**的。



### 2. 如何判断当前钱包和节点版本号是否最新版本

* 首先找到并点击钱包的**[关于]**这个菜单项

  * windows：在顶层菜单 [**帮助**->**关于SERO Wallet**]

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-eb709ef0c8c47af1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

  * Mac：在顶层菜单 [**SERO Wallet**->**关于SERO Wallet**]

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-8188131215142e1b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

* 弹出的对话框内有当前钱包版本信息和节点信息

  * 比如下图的例子，钱包的版本是0.1.3，而节点的版本是0.5.0-beta.r5-hotfix.2，都低于当前最新的版本号。

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-469aa09e36dd723e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

  * 钱包和节点的区别是，钱包只是你的操作界面，而真正挖矿的是节点程序，也就是gero。



### 3. 如果你碰到弹出菜单提示你升级

* 就是下图这样的对话框

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-dff2c76a75d2f6e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

  * **不想升级**的矿工按左侧的 **[SKIP UPDATE]**
  * **想要升级**的矿工按右侧的 **[DOWNLOAD NEW VERSION]**

* 有两个要注意的地方
  * 自己需不需要升级，参考上面的说明 **[1. 需要升级的情况]**
  * 如果你的钱包**正在启动**
    * 点升级会马上下载新的gero后台。
  * 如果你的钱包**正在运行**
    * 点升级会先退出钱包再启动升级程序。



### 4. 如果没有弹出升级窗口又想要升级怎么办？

* 检查你当前钱包的版本号
* 如果不是当前最新的版本，关闭并重启钱包，会自动弹出升级提示。
* 如果上一步骤不成功，你可以（这么做最保险）
  * 卸载之前的钱包（这一步一定要做，windows上有覆盖安装无效）
    - 放心，卸载钱包不会清楚数据和账户文件。
    - 不管如何，请备份好keystore文件夹。
  * 下载安装最新的钱包，安装后自然会更新最新的节点程序。



### 5. 如何估算自己的出块概率

* 参考 [SOLO模式下如何估算自己的出块概率](?file=Tutorial/how-to-evaluate-node-hashrate)

