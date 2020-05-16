# MAINNET-V1.0.3 Release Announce

## Attention

1. This version has been modified the bug which seriously affect the synchronization efficiency, because it involves a change in the vote algorithm, so it needs to be hard-forked.
   * At height：`3315000`
   * Estimated time：about **20: 00 on May 22, 2020**, Beijing time
   * It may be early or delayed according to the hashrate changing.

2. The staking information query switch `--stake` has been added to this update, the latest staking information will not be queried without setting this flag.

3. When upgrading, run command `admin.close()` in the console before closing the older 'gero' program，prevent the resyncing of last 10k blocks.

## Release Name

`MainNet-V1.0.3-RC1`



## Version Number

gero:                `v1.0.3-rc1`
mine-pool:      `v0.1.5`
serominer:      `v0.3.0`
js-sero-client:  `v1.0.2`



## New Feature

* **RC1**
  - [x] Staking Information query switch `--stake`
  - [x] Optimizing synchronization efficiency
  - [x] Fix the bug of the compiled script for some OS

## Commit ID

go-sero                    `0ebb1fd8e6941b089a7940395dfd5893d9603dfe`
go-czero-import     `ee0b2040f3bd70ba880a09f4fe0971d288579157`
console                  `5e28fbd4b1f1ee818a591f5cb4f4e49a3263f702`
mine-pool              `e8f6f5f2ad11210485c18b23cd73604c57bd6fbe`
serominer               `a111c98b0b3ba5767ba4a7c2d02c949603ba90a9`         



## Release Package

* **Download Urls:**  <https://github.com/sero-cash/go-sero/releases/tag/v1.0.3-rc1>
  * gero-v1.0.2-rc1-darwin-amd64.tar.gz  `macos`,  md5 : `8880abe675ab0b949713b7cd60370cf2`
  * gero-v1.0.2-rc1-linux-amd64-v3.tar.gz  `centos & ubuntu`, md5: `7e278858964065e5d0eb1ed4b9943572`
  * gero-v1.0.2-rc1-linux-amd64-v4.tar.gz  `for fedora`, md5 : `0def20738bebf540c5c3b6abe09d9a2b`
  * gero-v1.0.2-rc1-windows-amd64.zip  `windows`, md5 : `960d8e0a1b4898c03e300afd7f403523`



## Asian version download address

### DARWIN

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.3-rc1/gero-v1.0.3-rc1-darwin-amd64.tar.gz

### LINUX3

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.3-rc1/gero-v1.0.3-rc1-linux-amd64-v3.tar.gz

### LINUX4

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.3-rc1/gero-v1.0.3-rc1-linux-amd64-v4.tar.gz

### WINDOWS

https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v1.0.3-rc1/gero-v1.0.3-rc1-windows-amd64.zip