# MAINNET-V1.0.1 发布概要

## 声明

本次发布涉及核心加密协议`SuperZK`由`1.0`升级为`2.0`，因此需要进行软分叉，具体情况：

分叉高度：`1958696` （大约北京时间**2019年10月31日晚上20时**左右）

具体情况请参考：

*  [《SERO v1.0.1版本升级指南》](?file=News/Report/20191020-sip5-3rd-announce)
* [《SERO SuperZK2.0 协议升级指南》](?file=News/Report/20191020-sip5-superzk20-account-update)



## 发布名称

`MainNet-V1.0.1-RC5`



## 版本号

gero:                `v1.0.1-rc5`
mine-pool:      `v0.1.4`
serominer:      `v0.3.0`
js-sero-client:  `v1.0.1`



## 新增特性

* **RC5**
  - [x] 修改花费UTXO时签名算法的Bug
* **RC4**
  - [x]  为离线状态的gero增加了 --offline 参数
* **RC3**
  * [x] 修改了 Seed2Sk 的 JSONRPC 接口的兼容性 Bug
  * [x] 修改了可能导致链分叉的一个潜在Bug
* **RC2**
  * [x] 修改了一些兼容性的Bug
* **RC1**
  * [x] SuperZK2.0 加密协议
  * [x] 去中心化轻钱包交互接口
  * [x] 去除POW许可证
  * [x] 优化数据同步和生成交易证明的性能



## 提交 ID

go-sero `f8258f9679abe3c6dbb265e70d622246e2fc3646`
go-czero-import `a0271a3c40f1b6a31c74e5835cd80c8cdab2f1d2`
console `df296a4b359ba14f555ab34e35896807581577f9`
mine-pool `fc3f2af2f261beefbe99b95d89abcb19b0d047f3`
serominer `a111c98b0b3ba5767ba4a7c2d02c949603ba90a9`



## 发布包

> **二进制包下载地址:**  https://github.com/sero-cash/go-sero/releases/tag/v1.0.1-rc5
> 
>> gero-v1.0.1-rc5-darwin-amd64.tar.gz `macos`, md5 : 2115738c800b7ba517ac50e374cb1835
> > gero-v1.0.1-rc5-linux-amd64-v3.tar.gz `centos & ubuntu`, md5: d74f879f2e99f0823acc0b5f64b16810
> > gero-v1.0.1-rc5-linux-amd64-v4.tar.gz `for fedora`, md5 : 201843938296440f2679dc9b9f318d10
> > gero-v1.0.1-rc5-windows-amd64.zip `windows`, md5 : 828ce8e2ff0b3ea1fffe9476ed8f7128



## 亚洲版下载地址

### DARWIN

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.1-rc5/gero-v1.0.1-rc5-darwin-amd64.tar.gz

### LINUX3

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.1-rc5/gero-v1.0.1-rc5-linux-amd64-v3.tar.gz

### LINUX4

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.1-rc5/gero-v1.0.1-rc5-linux-amd64-v4.tar.gz

### WINDOWS

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.1-rc5/gero-v1.0.1-rc5-windows-amd64.zip