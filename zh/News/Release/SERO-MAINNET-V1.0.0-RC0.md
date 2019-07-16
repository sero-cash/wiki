# MAINNET-V1.0.0-RC0 发布概要

## 声明

本次更新为 BetaNet 无缝切换 MainNet ，相关的信息于下：

* 将在 1290000 块切换到POW+POS共识。
  * 各用户和交易所大概有6天多时间进行全节点程序更新以及技术升级。
  * 1290000 块之后将
    * 开启股份池接受认购股份的功能。
    * 开启投票程序。
    * 开启创建 Staking Node 的功能。
    * 开启POS奖励。
  * 在投票的miss率小于25%之后，每个出块必须得到POS节点的验证。

* 需要升级的程序
  * 全节点用户
    * 升级全节点程序 (gero)
  *  PC端钱包用户
    * 会触发自动升级。
  * 矿池
    * 升级全节点程序 (gero)
    * 矿池程序 (支持新的奖励规则)
  * 交易所
    * 升级全节点程序(gero)
    * 升级js-sero-client离线签名客户端（如果使用的话）



关于Staking相关的功能可以参考：[《如何在gero上进行Staking》](?file=Tutorial/how-to-staking-using-gero)



## 发布名称

MainNet-V1.0.0-RC0



## 版本号

gero: v1.0.0-rc0
mine-pool: v0.1.3
serominer: v0.3.0
Wallet: 0.1.5
js-sero-client: 0.1.8





## 新增特性

- [x] Staking 功能
- [x] 去中心化轻钱包RPC接口
- [x] 区块同步性能优化



## 提交 ID

go-sero                   076117a5591b9ff1f8a6acb6c33ed3894718253a
go-czero-import   538e15c8905e38700ab1440d2055da11d2e7e9c4
console                  928bfe93a696cbb99886b6eb978d8046025ce32e
mine-pool             42e2fe71281d8180eef3d29f7675b29585376bba
serominer             a111c98b0b3ba5767ba4a7c2d02c949603ba90a9
wallet                     1e62bb9fba017a461a9af3810f8c72feb769be82



## 发布包

> **二进制包下载地址:**
> [https://github.com/sero-cash/go-sero/releases/tag/v1.0.0-rc0](https://github.com/sero-cash/go-sero/releases/tag/v1.0.0-rc0)
>
> > gero-v1.0.0-rc0-darwin-amd64.tar.gz  macos,  md5 : e3c6a83eb4985d3e6f7103198703c94d
> > gero-v1.0.0-rc0-linux-amd64-v3.tar.gz  centos & ubuntu, md5: ce51ce5d4f2fc63d07a3eabe1580c8cd
> > gero-v1.0.0-rc0-linux-amd64-v4.tar.gz  for fedora, md5 : a298a931e2667aa3af7dc902cde01f99
> > gero-v1.0.0-rc0-windows-amd64.zip  windows, md5 : 96ce0dee3fd99898e0e1570faf5a3b81



## 亚洲版下载地址



### DARWIN

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.0-rc0/gero-v1.0.0-rc0-darwin-amd64.tar.gz>

### LINUX3

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.0-rc0/gero-v1.0.0-rc0-linux-amd64-v3.tar.gz>

### LINUX4

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.0-rc0/gero-v1.0.0-rc0-linux-amd64-v4.tar.gz>

### WINDOWS

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.0-rc0/gero-v1.0.0-rc0-windows-amd64.zip>