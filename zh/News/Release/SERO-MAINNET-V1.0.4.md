# MAINNET-V1.0.4 发布概要

## 声明

1. 本次版本修改智能合约相关的功能和指令，因此需要进行硬分叉。
   * 分叉高度：`4339090`
   * 预计时间：大约北京时间**2020年10月26日凌晨0点左右**左右
   * 根据POW算力的增减可能会提早或者延迟。

2. 升级时请先在旧版本控制台运行`admin.close()`再关闭`gero`程序，防止因为缓存原因需要重新同步最近1万块区块数据。

3. linux版本统一使用v3版本升级

4. 本次发布为稳定版本发布

## 发布名称

`MainNet-V1.0.4`



## 版本号

gero:                `v1.0.4`
mine-pool:      `v0.1.5`
serominer:      `v0.3.0`
js-sero-client:  `v1.0.2`



## 新增特性

 - [x] 增加自动注册智能合约地址功能
 - [x] 优化智能合约指令，智能合约代缴Gas
 - [x] 提升同步性能
 - [x] 优化挖矿打包逻辑

## 提交 ID

go-sero             b955313922cafe2255f2176afad58aa2f2d0f55a

go-czero-import     14648dbeb62a4c99a5421dfa157967a0fcbce827

console             5e28fbd4b1f1ee818a591f5cb4f4e49a3263f702

mine-pool           e8f6f5f2ad11210485c18b23cd73604c57bd6fbe

serominer           a111c98b0b3ba5767ba4a7c2d02c949603ba90a9    



## 发布包

* **二进制包下载地址:**  <https://github.com/sero-cash/go-sero/releases/tag/v1.0.4>

   * gero-v1.0.4-darwin-amd64.tar.gz  `macos`,  md5 : `d126e30dfc586a20a80bbf14d40c1310`
   * gero-v1.0.4-linux-amd64-v3.tar.gz  `centos & ubuntu`, md5: `4cbf20a5143676563a07654111b0fa55`
   * gero-v1.0.4-windows-amd64.zip  `windows`, md5 : `9b2ff9a7401b4b7868bfbddd21715dc7`



## 亚洲版下载地址

### DARWIN

<https://sero-1259797294.file.myqcloud.com/gero/v1.0.4/gero-v1.0.4-darwin-amd64.tar.gz>

### LINUX3

<https://sero-1259797294.file.myqcloud.com/gero/v1.0.4/gero-v1.0.4-linux-amd64-v3.tar.gz>

### WINDOWS

<https://sero-1259797294.file.myqcloud.com/gero/v1.0.4/gero-v1.0.4-windows-amd64.zip>
