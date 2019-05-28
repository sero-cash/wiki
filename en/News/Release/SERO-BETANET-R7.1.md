# BETANET-R7.1 Release Announce

### The purpose of this release is to switch the POW algorithm from SERO-Ethash to ProgPOW, and to support mining using GPU.

This algorithm will switch at **940410** block height, which is approximately **Beijing time on May 30, 2019 at 21**.

- **This release has an impact on gero and mine-pool. Please update the program as soon as possible. The new version will automatically switch the algorithm.**
- **Cminer no longer be used after 940410 blocks, instead use serominer, which support opencl/cuda/cpu.**
  - the serominer download: <https://github.com/sero-cash/serominer/releases>
- **The sero wallet triggers an automatic upgrade and replaces the gero service.**
- **Flight Wallet does not need to be updated.**



### Optimization of Wallet account Analysis process

With the increase in the number of blocks, the old balance analysis program (state1) has become slow, this release abandoned the state1 analysis program, changed to balance analysis program, so:

- After the new version is installed, the account balance data needs to be reanalyzed, and the account balance may not be displayed correctly during this period, which is about 2 hours.



### Block reward adjustment

Refer to: [Reward Improvement Plan](?file=News/Important/sip3-description)



## Release Name

BetaNet-R7.1



## Version Number

gero: v0.7.1-beta.r7.1
mine-pool: v0.1.2
serominer: v0.3.0
Wallet: 0.1.5



## New Features

- [x] After 940410 blocks, switch to progpow algorithm.
- [x] Balance analysis program optimization.
- [x] Block reward adjustment.



## Commit ID

go-sero                   64d583253914b3c4c222ef657f054ae15cf97e7e
go-czero-import   c849ba948cc4be144e87d6fcbb94b816d0d7a2e8
console                  ff10381b6a33e1cabee685c5138579b934e6fc67
mine-pool             054ad43ec7a457bdff37b4e7237eac19ff40b431
serominer             0187cd6009a5aa2ff50b803b2d3f8f6bb5b7a917
wallet                     1e62bb9fba017a461a9af3810f8c72feb769be82



## Release Packages

> **The download address of binay packages:**
> [https://github.com/sero-cash/go-sero/releases/tag/v0.7.1-beta.r7.1](https://github.com/sero-cash/go-sero/releases/tag/v0.7.1-beta.r7.1)
>
> gero-v0.7.1-beta.r7.1-darwin-amd64.tar.gz  macos,  md5 : 046146b0bc0880e8abda163fc3f42d18
> gero-v0.7.1-beta.r7.1-linux-amd64-v3.tar.gz  centos & ubuntu, md5 : ae609e924d9abce82947e8c21e7e9fdd
> gero-v0.7.1-beta.r7.1-linux-amd64-v4.tar.gz  for fedora, md5 : fcb68e01aff4bd806e597edfa9c7f696
> gero-v0.7.1-beta.r7.1-windows-amd64.zip  windows, md5 : 99669ff4138d288a937fb483e9bc8470



## Asian Edition Download Address

### DARWIN

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.1-beta.r7.1/gero-v0.7.1-beta.r7.1-darwin-amd64.tar.gz>

### LINUX3

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.1-beta.r7.1/gero-v0.7.1-beta.r7.1-linux-amd64-v3.tar.gz>

### LINUX4

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.1-beta.r7.1/gero-v0.7.1-beta.r7.1-linux-amd64-v4.tar.gz>

### WINDOWS

<https://sero-media-1256272584.cos.ap-shanghai.myqcloud.com/gero/v0.7.1-beta.r7.1/gero-v0.7.1-beta.r7.1-windows-amd64.zip>







