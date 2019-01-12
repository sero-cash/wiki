# SERO客户端钱包故障排除和帮助

####  如何联系SERO团队？
---
> - 社区链接: [https://gitter.im/sero-cash/wallet](https://gitter.im/sero-cash/wallet)
> - `gitter` 是 github.com 免费的即使通讯工具，跟 `github` 具有很好的集成度，可以通过 github/gitlab/twitter 账号登录。关于wallet的一些重要通知会在这儿发布。

####  如何查看钱包日志？
---
> 1. 打开日志文件，如下图：
![image.png](https://upload-images.jianshu.io/upload_images/13141677-4b9642b60df09133.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
> 2. 找到日志文件，node.log 为当前日志，node.log.{x}  为历史日志。

####  为什么钱包中不显示SERO币？
---
首先，SERO钱包客户端只是SERO链的可视化桌面工具，要确保钱包运行正常，需要有以下几个过程：
> 1. 钱包已经同步所有区块
> 2. 由于匿名币的特性，钱包的会解析所有账户的状态，该过程在区块同步过程中，所以需要一段时间，请耐心等待
> 3. 完成以上两点后，如果还有问题，请把最新日志发给SERO团队

#### 为什么找不到节点？
---
> 1. 请检查你的网络是否正常
> 2. 请检查你的电脑时间是否最新
> 3. 完成以上两点后，如果还有问题，请把最新日志发给SERO团队

####  为什么开启挖矿失败？
---
> 1. 请确认是否已申请挖矿许可证，并已导入钱包
> 2. 请确认挖矿的主账号是否和挖矿许可证匹配
> 3. 完成以上两点后，如果还有问题，请把最新日志发给SERO团队

#### 如何删除账号？
---
>问：我创建账号的时候多创建/导入了账号，能否删除多余的账号？
>答：
> 1. 为防止账号被误删除的风险，SERO钱包暂时没有设置删除账号的功能。不过你可以手动到区块数据目录下删除对应的文件，注意删除前做好备份或者二次确认。
> 2. 账户目录:
> - Windows `C:\Users\%username%\AppData\Roaming\Sero\keystore`
> - macOS `~/Library/Sero/keystore`
> - Linux `~/.sero/keystore `

#### Windows是否可以设置数据目录？
---
> 问：钱包的数据目录模式在C盘下，但是我的系统盘设置很小，能否把数据目录设置到其他盘？
>答：Windows在安装的时候，可以选择数据目录进行安装。注意：请用快捷方式启动，因为数据目录的配置是写在快捷方式的启动文件里面。

#### 是否可以手动配置node？
---
>问：我启动钱包的时候，钱包会自动检测更新。但是有时候网络不好，会导致提示文件hash不正确。能否手动配置node？
>答：可以手动配置node。

1. 首先请下载最新的配置文件，
> - 下载地址：
[http://sero-media.s3-website-ap-southeast-1.amazonaws.com/clients/clientBinaries.json](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/clients/clientBinaries.json)
> - 下载完成后，覆盖配置文件:
> - Windows `C:\Users\%username%\AppData\Roaming\SERO Wallet\clientBinaries.json`
> - macOS `~/Library/Application\ Support/SERO Wallet/clientBinaries.json`
> - Linux `~/.config/SERO Wallet/clientBinaries.json`

2. 下载对应系统的gero压缩包，
> - 下载地址请见sero发布的github.
[https://github.com/sero-cash/go-sero/releases](https://github.com/sero-cash/go-sero/releases)
> - 下载完成后，拷贝文件到下面目录，并命名为 archive.zip|tar , 例如windows为 archive.zip。然 后解压缩到unpacked目录。
> - 解压后正确的目录结构如下：
> - Windows `C:\Users\%username%\AppData\Roaming\SERO Wallet\binaries\gero\unpacked\geropkg`
> - macOS `~/Library/Application\ Support/SERO Wallet/binaries/gero/unpacked/geropkg`
> - Linux `~/.config/SERO Wallet/binaries/gero/unpacked/geropkg`

3. 拷贝gero可执行文件
> - Windows `拷贝./unpacked/geropkg/bin/gero.exe 文件到 ./unpacked/ 目录`
> - macOS `拷贝./unpacked/geropkg/bin/gero 文件到 ./unpacked/ 目录`
> - Linux `拷贝./unpacked/geropkg/bin/gero 文件到 ./unpacked/ 目录`
`注意: ./unpacked/ 下面应该有一个 gero可执行文件 和 geropkg 文件夹`

4. 重启钱包。
