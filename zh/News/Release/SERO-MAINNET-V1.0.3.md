# MAINNET-V1.0.3 发布概要

## 声明

1. 本次版本修改了严重影响同步效率的问题，因为涉及选票算法的变化，因此需要进行硬分叉。
   * 分叉高度：`3315000`
   * 预计时间：大约北京时间**2020年5月22日晚上8时**左右
   * 根据POW算力的增减可能会提早或者延迟。

2. 本次更新增加了staking信息查询开关`--stake`，启动时不加这个开关将无法查询最新的staking信息

3. 升级时请先在旧版本控制台运行`admin.close()`再关闭`gero`程序，防止因为缓存原因需要重新同步最近1万块区块数据。


## 发布名称

`MainNet-V1.0.3-RC1`



## 版本号

gero:                `v1.0.3-rc1`
mine-pool:      `v0.1.5`
serominer:      `v0.3.0`
js-sero-client:  `v1.0.2`



## 新增特性

* **RC1**
  - [x] 增加staking信息查询开关 `--staking`
  - [x] 优化同步效率
  - [x] 修改编译脚本在部分系统上的Bug


## 提交 ID

go-sero                    `0ebb1fd8e6941b089a7940395dfd5893d9603dfe`
go-czero-import     `ee0b2040f3bd70ba880a09f4fe0971d288579157` 
console                  `5e28fbd4b1f1ee818a591f5cb4f4e49a3263f702`
mine-pool              `e8f6f5f2ad11210485c18b23cd73604c57bd6fbe`
serominer               `a111c98b0b3ba5767ba4a7c2d02c949603ba90a9`         



## 发布包

* **二进制包下载地址:**  <https://github.com/sero-cash/go-sero/releases/tag/v1.0.3-rc1>
   * gero-v1.0.2-rc1-darwin-amd64.tar.gz  `macos`,  md5 : `8880abe675ab0b949713b7cd60370cf2`
   * gero-v1.0.2-rc1-linux-amd64-v3.tar.gz  `centos & ubuntu`, md5: `7e278858964065e5d0eb1ed4b9943572`
   * gero-v1.0.2-rc1-linux-amd64-v4.tar.gz  `for fedora`, md5 : `0def20738bebf540c5c3b6abe09d9a2b`
   * gero-v1.0.2-rc1-windows-amd64.zip  `windows`, md5 : `960d8e0a1b4898c03e300afd7f403523`



## 亚洲版下载地址

### DARWIN

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.3-rc1/gero-v1.0.3-rc1-darwin-amd64.tar.gz

### LINUX3

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.3-rc1/gero-v1.0.3-rc1-linux-amd64-v3.tar.gz

### LINUX4

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.3-rc1/gero-v1.0.3-rc1-linux-amd64-v4.tar.gz

### WINDOWS

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.3-rc1/gero-v1.0.3-rc1-windows-amd64.zip