---

[TOC]

---

####  如何联系SERO团队
---
> - 社区链接: [https://gitter.im/sero-cash/wallet](https://gitter.im/sero-cash/wallet)
> - `gitter` 是 github.com 免费的即使通讯工具，跟 `github` 具有很好的集成度，可以通过 github/gitlab/twitter 账号登录。关于wallet的一些重要通知会在这儿发布。

####  如何发送钱包日志
---
> 1. 打开日志文件，如下图：
![image.png](https://upload-images.jianshu.io/upload_images/13141677-4b9642b60df09133.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
> 2. 找到日志文件，node.log 为当前日志，node.log.{x}  为历史日志。

####  钱包中不显示SERO币
---
首先，SERO钱包客户端只是SERO链的可视化桌面工具，要确保钱包运行正常，需要有以下几个过程：
> 1. 钱包已经同步所有区块
> 2. 由于匿名币的特性，钱包的会解析所有账户的状态，该过程在区块同步过程中，所以需要一段时间，请耐心等待
> 3. 完成以上两点后，如果还有问题，请把最新日志发给SERO团队

#### 找不到节点
---
> 1. 请检查你的网络是否正常
> 2. 请检查你的电脑时间是否最新
> 3. 完成以上两点后，如果还有问题，请把最新日志发给SERO团队

####  开启挖矿失败
---
> 1. 请确认是否已申请挖矿许可证，并已导入钱包
> 2. 请确认挖矿的主账号是否和挖矿许可证匹配
> 3. 完成以上两点后，如果还有问题，请把最新日志发给SERO团队

#### 如何删除账号
---
> 1. 为防止账号被误删除的风险，SERO钱包暂时没有设置删除账号的功能。但是你可以手动到区块数据目录下删除对应的文件，注意删除前做好备份或者二次确认。
> 2. 账户目录:
> - Windows `C:\Users\%username%\AppData\Roaming\Sero\keystore`
> - macOS `~/Library/Sero/keystore`
> - Linux `~/.config/Sero/keystore `

#### 是否可以设置数据目录
---
> SERO钱包暂时不支持设置数据目录，但是考虑到windows用户的C盘分区空间不大，后期会开发设置数据目录的功能，请留意钱包的版本更新动态。


