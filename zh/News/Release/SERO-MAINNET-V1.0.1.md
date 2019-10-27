# MAINNET-V1.0.1 发布概要

## 声明

本次发布涉及核心加密协议`SuperZK`由`1.0`升级为`2.0`，因此需要进行软分叉，具体情况：

分叉高度：`1958696` （大约北京时间**2019年10月31日晚上20时**左右）

具体情况请参考：

*  [《SERO v1.0.1版本升级指南》](?file=News/Report/20191020-sip5-3rd-announce)
* [《SERO SuperZK2.0 协议升级指南》](?file=News/Report/20191020-sip5-superzk20-account-update)



## 发布名称

`MainNet-V1.0.1-RC4`



## 版本号

gero:                `v1.0.1-rc4`
mine-pool:      `v0.1.4`
serominer:      `v0.3.0`
js-sero-client:  `v1.0.1`



## 新增特性

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

go-sero                    `9163bb722370d3ebedac4179a854153584cc826a`
go-czero-import     `dac153d3b8ad511934e7e007810bdcef7c11e8cf` 
console                  `df296a4b359ba14f555ab34e35896807581577f9`
mine-pool             `fc3f2af2f261beefbe99b95d89abcb19b0d047f3`
serominer               `a111c98b0b3ba5767ba4a7c2d02c949603ba90a9` 



## 发布包

> **二进制包下载地址:**
> [https://github.com/sero-cash/go-sero/releases/tag/v1.0.1-rc3](https://github.com/sero-cash/go-sero/releases/tag/v1.0.1-rc3)
>
> > gero-v1.0.1-rc3-darwin-amd64.tar.gz  `macos`,  md5 : `b7cbde6fc90e726be1a7d1c17d417049`
> > gero-v1.0.1-rc3-linux-amd64-v3.tar.gz  `centos & ubuntu`, md5: `dfeb7b2f175b8cf75c53cc408127f199`
> > gero-v1.0.1-rc3-linux-amd64-v4.tar.gz  `for fedora`, md5 : `135a679d28d4ca2ae6d7194ecc50e5e6`
> > gero-v1.0.1-rc3-windows-amd64.zip  `windows`, md5 : `b62fe45e14a6ed817bd3130402a78177`



## 亚洲版下载地址

### DARWIN

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.1-rc4/gero-v1.0.1-rc4-darwin-amd64.tar.gz>

### LINUX3

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.1-rc4/gero-v1.0.1-rc4-linux-amd64-v3.tar.gz>

### LINUX4

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.1-rc4/gero-v1.0.1-rc4-linux-amd64-v4.tar.gz>

### WINDOWS

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.1-rc4/gero-v1.0.1-rc4-windows-amd64.zip>