# 如何使用矿工程序(cminer)连接矿池挖矿

**注意：** 

* 使用cminer在矿池挖矿的矿工 **不需要** 申请挖矿许可证。
* 请务必将钱包升级到最新的**R6以上的版本**，否则矿池发出的酬劳在钱包端可能无法显示。
  * 请参考  [BetaNet-R6 发布公告](?file=News/Release/SERO-BETANET-R6)



## 一、挖矿基本流程

1. 生成钱包地址
2. 下载挖矿软件
3. 连接矿池
4. 查看机器状态和收益
5. 常见问题



## 二、安装全节点钱包并生成账户

**注意：** 已经安装好钱包并拥有账户得用户可略过这些步骤。

##### 下载全节点钱包

下载SERO全节点钱包 https://github.com/sero-cash/wallet/releases

例如：发文是钱包的版本为 **Release 0.1.4** ,选择对应操作系统版的钱包下载

![wallet-relase.jpg-328kB][1]

##### 配置文件夹

钱包数据的文件夹,用于存放钱包配置数据，以及日志文件
> - Windows `C:\Users\%username%\AppData\Roaming\SERO Wallet`
> - macOS `~/Library/Application\ Support/SERO Wallet`
> - Linux `~/.config/SERO Wallet`

区块数据的文件夹,用于存放区块数据，钱包账户文件
> - Windows `C:\Users\%username%\AppData\Roaming\Sero`
> - macOS `~/Library/Sero`
> - Linux `~/.config/Sero`

##### 启动钱包

> - 第一次启动钱包，会自动查找节点
>   ![image.png](https://upload-images.jianshu.io/upload_images/13141677-a108c0edffde4003.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
>   `注意：如果一直停留在“正在查找节点”的状态，请先检查你的PC时间是否为最新。`

> - 点击「使用公测网络(BETANET)」,进入导入账户或License界面
>   ![image.png](https://upload-images.jianshu.io/upload_images/13141677-30b9c6df2ecf7d6c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
>   `注意：进入钱包主界面后也可以导入，此处非必须操作的步骤`

> - 点击「跳过」进入新建账号目录
>   ![image.png](https://upload-images.jianshu.io/upload_images/13141677-3bc79fcff4cae30d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
>   `注意：请勿重复创建账号,进入钱包主界面后也可以新建账号，此处非必须操作的步骤`

> - 点击「跳过」或 「下一步」，在你等待下载区块的的时候，可以看看关于Token代码.
>   ![image.png](https://upload-images.jianshu.io/upload_images/13141677-2657fc14b2870235.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

> - 点击「启动应用程序」，进入主界面。你可以看到当前的节点数以及同步区块的进度条。
>   ![image.png](https://upload-images.jianshu.io/upload_images/13141677-1d7efaf9f49555c0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
>   `注意：请耐心等待区块同步完成，尽量不要中途关闭钱包客户端`

##### 创建账户
> - 点击「新增账户」输入密码后，新建账户成功
>   ![image.png](https://upload-images.jianshu.io/upload_images/13141677-9b41928fe9b59ad8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
>   `注意：如果需要删除账户，请在区块数据目录的keystore文件夹中，找到对应的账户文件并进行删除。删除前请做好备份或者二次确认，以免造成损失。`

> - 可以用钱包里的任意地址配置到矿池挖矿软件进行挖矿
>   ![image.png](https://upload-images.jianshu.io/upload_images/13141677-9f69069d07657471.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

##### 拷贝账户地址

安装好钱包，打开钱包创建钱包账户。红色框中就是钱包地址，复制到软件地址处。

![wallet_address.jpg-158.4kB][2]



## 三、下载挖矿软件

#### Windows版本安装C++运行库

去微软官网这个页面下载安装：https://www.microsoft.com/zh-cn/download/details.aspx?id=48145

#### 下载cminer

* ##### 下载办法1

github地址：https://github.com/sero-cash/cminer/releases

* ##### 下载办法2

网盘地址：
windows版本:https://pan.baidu.com/s/1R7RhQH34NDC-BB6VunXZgg  密码:00h1
Mac版本:<https://pan.baidu.com/s/1mPmHQb6iwkDQNAMb2JEsMA>  密码:ik8v
Linux版本:<https://pan.baidu.com/s/1b1PyugXd4Us6aEABtUZ2cw>  密码:s5e2



## 四、连接矿池

当前挖矿客户端版本为0.1.0-beta.1
解压缩cminer的压缩包

* ###  windows版本

![w-c.jpg-89.4kB][3]
**右键单击“start.bat”，点击编辑，如下图：**



![w_s.jpg-243.9kB][4]

* ### Mac版本

![image_1d4feefmll9iv52drql5mebn39.png-23.4kB][5]



**右键单击“start.command”，打开编辑，如下图：**

![m_s.jpg-145.2kB][6]



**红色：** 矿池地址，需要替换。当前测试版本地址为：http://129.204.197.105:9999   , 矿工可以自行选择矿池。
**蓝色：** 矿工钱包地址，需要替换。
**绿色：** 矿工机器标识，不能超过8个字符，需要替换，用户自己定义
**黄色：** 设置使用挖矿线程数，设为0将挖矿线程数设为cpu线程数减1。矿工可以自行设置挖矿线程数，数值不要超过cpu最大线程数。

修改完启动脚本后，双击就可以开启cpu挖矿。



* ### 运行界面

  * **机器的CPU线程数和挖矿线程数如下图：**![c_t.jpg-68.9kB][7]**黄色：**当前CPU最大线程数
    **红色：**当前挖矿线程数

  * **挖矿算力展示**

    ![image_1d4flc8fb1re74ela7h10jmnfm9.png-147.9kB][14]

    **红色：** 总算力，单位是(HashRate)。

    **蓝色：** 线程cp0贡献的算力，单位和总算力一致。

    **黄色：** 从矿池获取到任务



#### 在浏览器查看机器状态和收益

1. 在电脑浏览器（谷歌浏览器）打开矿池主页：http://203.195.255.129:8082 (测试版本)
2. 在中间搜索框输入钱包地址回车
   ![pool-serach.jpg-253.8kB][8]
3. 打开后图片如下：
   ![miner.jpg-300.3kB][9]

#### 查看收益：

![miner-amount.jpg-315.5kB][10]
**绿色：** 未确定未支付金额
**蓝色：** 已确定待支付金额
**红色：** 累计已确定已支付总金额

#### 查看机器状态
![mac.jpg-282kB][11]
**红色：** 当前钱包账户下矿工数量
**蓝色：** 30分钟内的平均算力
**绿色：** 3小时内的平均算力
**黄色：** 该钱包账户下矿工总算力占矿池算力的比例（最近3小时的数据统计）
**灰色：** 当前钱包账户下的矿工编号，如果15分钟内没有体提交，该记录的背景将变成浅黄色警告，该机器存在掉线的风险。

### 常见问题
1. **为什么查询不到矿工记录**
   刚刚挖矿的矿工请注意，可能需要半个小时以后才能在网页中查看到算力统计，耐心等到就好。

   

2. **矿池转账周期**
   矿池首页有提示，如下图，仅供参考，以实际发布的矿池分成周期为准：
   ![home.jpg-119.3kB][12]

   

3. **矿池的抽成比例**
   矿池首页有提示，如下图，仅供参考，以实际发布的矿池抽成比例为准：
   ![home-fee.jpg-102.7kB][13]

   

4. **矿池的分成模式**
   矿池采用PPLNS方式,在挖出一块之后，按照矿工最近3小时内贡献算力(shares)的比例分成。

   

5. **什么地方可以找到SERO的矿池**

   * 目前的矿池是SERO团队搭建的试用矿池，只会运营一段时间。
   * 矿池程序是开源的，所以有相应技术能力的公会和个人都可以搭建矿池，供社区使用。



[1]: http://static.zybuluo.com/erlenzi-han/xbcort74b65ltq4ot8fdw25o/wallet-relase.jpg
[2]: http://static.zybuluo.com/erlenzi-han/01z4im278qsy43b8la0afoj0/wallet_address.jpg
[3]: http://static.zybuluo.com/erlenzi-han/cogd2qoejpx99yzlt0j2y376/w-c.jpg
[4]: http://static.zybuluo.com/erlenzi-han/gktys0p12mdlkqyj3dv87ess/w_s.jpg
[5]: http://static.zybuluo.com/erlenzi-han/qjz0g269toxb7wwzpl3yriat/image_1d4feefmll9iv52drql5mebn39.png
[6]: http://static.zybuluo.com/erlenzi-han/ceu9tw9b0qiva0jaud4avw1t/m_s.jpg
[7]: http://static.zybuluo.com/erlenzi-han/rrptmffhy0c1iz10ma1c32x7/c_t.jpg
[8]: http://static.zybuluo.com/erlenzi-han/9987edgor92b10y48uqzqwq8/pool-serach.jpg
[9]: http://static.zybuluo.com/erlenzi-han/wjs6n45ak7deyi4xu1kwy3e5/miner.jpg
[10]: http://static.zybuluo.com/erlenzi-han/dyiivwrsxm7bmr8gvwmrawj7/miner-amount.jpg
[11]: http://static.zybuluo.com/erlenzi-han/uif7u0351rqd4a39aux6tb2s/mac.jpg
[12]: http://static.zybuluo.com/erlenzi-han/7q5z8wepeq3somei3k1itizy/home.jpg
[13]: http://static.zybuluo.com/erlenzi-han/gct76u6iz05zbkcnac8h9yrk/home-fee.jpg
[14]: http://static.zybuluo.com/erlenzi-han/j96ni2266at3wm98a5ztsu4r/image_1d4flc8fb1re74ela7h10jmnfm9.png
