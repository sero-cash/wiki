# MAINNET-V1.0.4 Release Announce

## Attention

1. This version modifies the functions and instructions related to the smart contract, so a hard fork is required.
   * Fork height: `4339090`
   * Estimated time: Approximately Beijing time **around 0:00 am on October 26, 2020**
   * Depending on the increase or decrease of POW computing power, it may be early or delayed.

2. When upgrading, please run ʻadmin.close()` on the console of the old version before closing the `gero` program to prevent the need to resynchronize the latest 10,000 blocks of data due to caching.

3. The linux version is upgraded with v3 version

4. This release is a stable version

## Release name

`MainNet-V1.0.4`



## version number

gero: `v1.0.4`
mine-pool: `v0.1.5`
serominer: `v0.3.0`
js-sero-client: `v1.0.2`



## New features

 -[x] Added the function of automatically registering smart contract addresses
 -[x] Optimize smart contract instructions, smart contract pays for Gas
 -[x] Improve synchronization performance
 -[x] Optimize mining packaging logic

## Submit ID

go-sero b955313922cafe2255f2176afad58aa2f2d0f55a

go-czero-import 14648dbeb62a4c99a5421dfa157967a0fcbce827

console 5e28fbd4b1f1ee818a591f5cb4f4e49a3263f702

mine-pool e8f6f5f2ad11210485c18b23cd73604c57bd6fbe

serominer a111c98b0b3ba5767ba4a7c2d02c949603ba90a9



## Publish package

* **Binary package download address:** <https://github.com/sero-cash/go-sero/releases/tag/v1.0.4>

   * gero-v1.0.4-darwin-amd64.tar.gz `macos`, md5: `d126e30dfc586a20a80bbf14d40c1310`
   * gero-v1.0.4-linux-amd64-v3.tar.gz `centos & ubuntu`, md5: `4cbf20a5143676563a07654111b0fa55`
   * gero-v1.0.4-windows-amd64.zip `windows`, md5: `9b2ff9a7401b4b7868bfbddd21715dc7`
