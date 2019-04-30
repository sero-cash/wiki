# SERO客户端钱包使用手册



## 关于SERO钱包

### 介绍

> SERO钱包是基于SERO主链研发的一款全节点客户端钱包，可以满足大部分用户的需求，比如：导入钱包账户、发送交易、挖矿、发布智能合约。目前已支持Mac , Linux ,Windows。
> SERO钱包已在Github上开源 : [SERO Wallet](https://github.com/sero-cash/wallet/)



### 安装

* **客户端安装包 [点击下载](https://github.com/sero-cash/wallet/releases)**

* **选择系统对应的安装包**

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-dbd961324d95ab0a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600) 

* **安装界面,将SERO Wallet拖拽到Applications文件夹中**
    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-249e64d50ce40182.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

### 启动

* **从应用程序中找到SERO Wallet**
    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-3723b412210c1e30.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
    
* **第一次启动会检查SERO Node并下载最新版本，文件大小大概80M左右，如果网络环境好，大概1分钟左右，请耐心等待。**
    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-6ab808a805e741ec.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
    
* **连接SERO Node，钱包会自动检查节点，钱包会自动寻找就近节点，你可以直接点击“启动应用”进入钱包主界面**
    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-41eefaad986645f0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

### 版本更新

* **如果需要升级钱包，可以点击菜单的以下按钮**
    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-04e69f3668aa8947.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
    
* **你也可以关注SERO团队在[Github](https://github.com/sero-cash/wallet)上的更新，直接下载安装包进行升级。**

<br/>

## 功能介绍

### 同步区块

> 钱包启动后会自动同步区块，启动页和钱包主界面都可以看到同步的状态 
> ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-6380856e18c12f03.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
> ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-41dc5a187f43c237.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

<br>

### 账户

> 账户用于存储你的SERO币和其他Token，类似你的银行账户，所以你需要妥善保管好你的账户以及密码，建议做好备份。

* #### 新建账户

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-7c1dbdb0e9169c5b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
    新建账户成功后，钱包会提供账户文件路径(`.JSON`后缀)，并且提示备份
    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-2efbf7eafb9453c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* #### 导入账户

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-6130e99a45d4da47.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* #### 备份账户

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-56861377fff5b9f9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
    将会打开备份文件目录，你可以把账户文件拷贝到你自己的硬盘或者U盘。

* #### 账户详情

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-428d06cd20639ac1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* #### SERO的单位换算

    > 1 SERO = $10^{18}$ Ta,也就是说`Ta`是`SERO`的最小换算单位

<br>

### 如何挖矿⛏️

* #### 申请挖矿许可证

    SERO社区已开放申请挖矿许可证，请把账户地址发邮件到 [license@sero.vip](mailto:license@sero.vip)，SERO团队将会在48小时内给到回复。

* #### 导入挖矿许可证

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-4360e06128676a16.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* #### 开启挖矿

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-b79de8b96eb70976.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

<br>

### 发送交易

* #### 名词解释

    > **FROM**：转出的账户地址
    > **TO**：转入的账户地址
    > **AMOUNT**：数字货币数量，单位SERO
    > **SELECTFEE**：交易费的高低，决定交易处理速度，默认交易费为:1Gta

* #### 交易截图：

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-648a948dfaa360c8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-6c34a3acf52d17ea.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* #### 点击“发送”按钮,将会弹出对话框，此时钱包会估算大概需要消耗的Gas

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-fb7ac55a7622e891.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

    现在钱包主界面可以看到交易记录，由于SERO是匿名币交易，不会在交易中显示交易金额。

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-c15e6101c5259477.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-7b2c75247b761dd5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

<br>

### 智能合约

* #### 创建智能合约

    > 智能合约代码请参考SERO官方发布的编辑器 [SC IDE](https://remix.web.sero.cash)
    > 贴入源码，钱包将自动编译源码，然后选择需要发布的智能合约，输入相关参数。

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-2891a67c70499b99.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

    > 点击发送后，在钱包主界面将看到智能合约的交易已创建

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-fc07f805cd5ad73d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* #### 调用智能合约

    > 点开“管理页面”,我们可以看到 发币的数量和单位 100000000000000000 STRA，注意这里最小单位，发布的是9位小数。

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-f1e5c9a6bde7cb84.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

    > 我们可以选择一个方法，比如：调用转账(Transfer)方法，把钱转到其他账户

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-e96badc14215f373.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

    > 此时钱包主页面会有一条智能合约执行的记录

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-26e19110e0494955.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

    > 当交易被确认后，我们看到账户已收到转账金额

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-612df1c6df02c6d9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

<br>

## 其他

* #### SERO钱包安装目录

    ```
    MACOS：~/Library/Application\ Support/SERO Wallet
    LINUX：~/.config/SERO Wallet
    Windows：C:\Users\%username%\AppData\Roaming\SERO Wallet
    ```

* #### SERO钱包的数据目录

    ```
    MACOS：~/Library/Sero/
    LINUX：~/.sero/
    Windows：C:\Users\%username%\AppData\Roaming\Sero
    ```

* #### 查看日志文件：

    ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201904/277023-420d9f4924c44f81.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

<br>

**以上是SERO钱包所有功能介绍，如有疑问或者遇到问题，可以加入SERO社区技术交流群    Gitter[点击加入](https://gitter.im/sero-cash/wallet)。**



<br/>



## 相关链接

[SERO Github](https://github.com/sero-cash)
[SERO 官方网站](https://sero.cash)
[SERO 区块链浏览器](https://explorer.web.sero.cash)