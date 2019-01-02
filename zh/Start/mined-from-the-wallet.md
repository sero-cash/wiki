
# 使用SERO客户端钱包挖矿

### 1. 安装钱包

####  
下载地址 :  [https://github.com/sero-cash/wallet/releases](https://github.com/sero-cash/wallet/releases)

####  安装包
目前仅支持64位系统挖矿,请选择对应系统的安装包进行下载
- Windows :` SERO-Wallet-windows-{version}.exe`
- MacOs : `SERO-Wallet-mac-{version}.dmg`
- Linux : `SERO-Wallet-linux64-{version}.deb`

#### 配置文件夹
钱包数据的文件夹,用于存放钱包配置数据，以及日志文件
- Windows `C:\Users\%username%\AppData\Roaming\SERO Wallet`
- macOS `~/Library/Application\ Support/SERO Wallet`
- Linux `~/.config/SERO Wallet`

区块数据的文件夹,用于存放区块数据，钱包账户文件
- Windows `C:\Users\%username%\AppData\Roaming\Sero`
- macOS `~/Library/Sero`
- Linux `~/.config/Sero`

### 2. 启动钱包
> - 第一次启动钱包，会自动查找节点
![image.png](https://upload-images.jianshu.io/upload_images/13141677-a108c0edffde4003.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
`注意：如果一直停留在“正在查找节点”的状态，请先检查你的PC时间是否为最新。`

> - 点击「使用公测网络(BETANET)」,进入导入账户或License界面
![image.png](https://upload-images.jianshu.io/upload_images/13141677-30b9c6df2ecf7d6c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
`注意：进入钱包主界面后也可以导入，此处非必须操作的步骤`

> - 点击「跳过」进入新建账号目录
![image.png](https://upload-images.jianshu.io/upload_images/13141677-3bc79fcff4cae30d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
`注意：请勿重复创建账号,进入钱包主界面后也可以新建账号，此处非必须操作的步骤`

> - 点击「跳过」或 「下一步」，在你等待下载区块的的时候，可以看看关于Token代码.
![image.png](https://upload-images.jianshu.io/upload_images/13141677-2657fc14b2870235.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

> - 点击「启动应用程序」，进入主界面。你可以看到当前的节点数以及同步区块的进度条。
![image.png](https://upload-images.jianshu.io/upload_images/13141677-1d7efaf9f49555c0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
`注意：请耐心等待区块同步完成，尽量不要中途关闭钱包客户端`

### 3. 新建账户
> - 点击「新增账户」输入密码后，新建账户成功
![image.png](https://upload-images.jianshu.io/upload_images/13141677-9b41928fe9b59ad8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
`注意：如果需要删除账户，请在区块数据目录的keystore文件夹中，找到对应的账户文件并进行删除。删除前请做好备份或者二次确认，以免造成损失。`

> - 标记为“Serobase”的账户为主账户，请用此账户申请License，以及挖矿
![image.png](https://upload-images.jianshu.io/upload_images/13141677-9f69069d07657471.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
`注意：一个钱包只能用一个账户进行挖矿。`

### 4. 导入许可证(License)

接下来我们需要向SERO团队申请许可证，需要进行下面几个步骤：

* ### **加入SERO的gitter社区**
    > **社区的链接是**
    [https://gitter.im/sero-cash/miner](https://gitter.im/sero-cash/miner)
    ![image.png](https://upload-images.jianshu.io/upload_images/277023-fecac3360cd796e6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
    >
    > `gitter` 是 github.com 免费的即使通讯工具，跟 `github` 具有很好的集成度，可以通过 github/gitlab/twitter 账号登录。关于miner的一些重要通知会在这儿发布。

* ### **发申请邮件**
    > 上面已经生成了账户，请将标记`Serobase`的公钥地址通过邮件发送给 [license@sero.vip](license@sero.vip) ，并说明你的情况。
    ![image.png](https://upload-images.jianshu.io/upload_images/277023-e72fcce8a23a8578.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

    `注意：公钥可以作为资产接受地址，提供给第三方生成交易，泄露公钥并不会泄露你在SERO的信息。`

* ### **安装许可证**
> - SERO团队在48小时内会为你生成BetaNet的挖矿许可证，并回信给你。
    ![image.png](https://upload-images.jianshu.io/upload_images/277023-ce2d496f2b656112.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
    **回信中，你的许可证在正文和附件中各有一份，这两份是一致的。**

> - 点击菜单"账户">"导入账户或挖矿License",如下图,打开导入界面，此时只需要将名称为`BLIC.DATA`的文件拖拽到框中。
![image.png](https://upload-images.jianshu.io/upload_images/13141677-205221f5fc604f96.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

### 5. 开启挖矿

> - 点击菜单"开发">"开启挖矿"
![image.png](https://upload-images.jianshu.io/upload_images/13141677-5737bc6f5c3355ce.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

> - 当出现下图，则表示开启挖矿成功
![image.png](https://upload-images.jianshu.io/upload_images/13141677-9bbaafcdd86a9f0f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

### 6. 常见问题 [点击](https://wiki.sero.cash/zh/index.html?file=Start/wallet-trouble-shooting-help)
