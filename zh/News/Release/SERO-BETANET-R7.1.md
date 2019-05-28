# BETANET-R7.1 发布公告

### 本次发布目的是将 POW 算法从 SERO-Ethash 切换成 ProgPOW ，并且支持采用 GPU 挖矿。

本次算法将在 **940410** 块高度进行切换，大约是**北京时间2019年5月30日晚上21时**。

- **本次修改对 gero、mine-pool 有影响，请大家尽快更新程序，新版本将自动进行切换。**
- **cminer 在 940410 块之后不可再使用，改为使用 serominer 挖矿，支持 OPENCL/CUDA/CPU 三种方式。**
  - serominer 下载地址为：<https://github.com/sero-cash/serominer/releases>
- **SERO Wallet 会触发自动升级程序，更换后台的 gero 服务。**
- **Flight Wallet 不需要更新。**



### 钱包账户分析过程(state1)优化

随着区块数量的增加，老的用户账户分析程序(state1)已经变得非常的缓慢，本发布废弃state1分析程序，改为balance分析程序，因此：

* 安装新版本之后，账户余额数据需要重新分析，期间账户余额可能显示不正确，这个过程大概2个小时左右。



### 出块奖励调整

请参考：[奖励改进计划](?file=News/Important/sip3-description)



## 发布名称

BetaNet-R7.1



## 版本号

gero: v0.7.1-beta.r7.1
mine-pool: v0.1.2
serominer: v0.3.0
Wallet: 0.1.5



## 新增特性

- [x] 940410块之后切换为progpow算法。
- [x] balance分析程序。
- [x] 出块奖励调整



## 提交ID

go-sero                   64d583253914b3c4c222ef657f054ae15cf97e7e
go-czero-import   c849ba948cc4be144e87d6fcbb94b816d0d7a2e8
console                  ff10381b6a33e1cabee685c5138579b934e6fc67
mine-pool             054ad43ec7a457bdff37b4e7237eac19ff40b431
serominer             0187cd6009a5aa2ff50b803b2d3f8f6bb5b7a917
wallet                     1e62bb9fba017a461a9af3810f8c72feb769be82



## 发布包

> **二进制包下载地址：**
> [https://github.com/sero-cash/go-sero/releases/tag/v0.7.1-beta.r7.1](https://github.com/sero-cash/go-sero/releases/tag/v0.7.1-beta.r7.1)
>
> gero-v0.7.1-beta.r7.1-darwin-amd64.tar.gz  macos,  md5 : 046146b0bc0880e8abda163fc3f42d18
> gero-v0.7.1-beta.r7.1-linux-amd64-v3.tar.gz  centos & ubuntu, md5 : ae609e924d9abce82947e8c21e7e9fdd
> gero-v0.7.1-beta.r7.1-linux-amd64-v4.tar.gz  for fedora, md5 : fcb68e01aff4bd806e597edfa9c7f696
> gero-v0.7.1-beta.r7.1-windows-amd64.zip  windows, md5 : 99669ff4138d288a937fb483e9bc8470



## 亚洲版下载地址

### DARWIN

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.1-beta.r7.1/gero-v0.7.1-beta.r7.1-darwin-amd64.tar.gz>

### LINUX3

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.1-beta.r7.1/gero-v0.7.1-beta.r7.1-linux-amd64-v3.tar.gz>

### LINUX4

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.1-beta.r7.1/gero-v0.7.1-beta.r7.1-linux-amd64-v4.tar.gz>

### WINDOWS

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.1-beta.r7.1/gero-v0.7.1-beta.r7.1-windows-amd64.zip>







