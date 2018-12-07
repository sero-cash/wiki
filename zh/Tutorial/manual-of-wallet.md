# SERO客户端钱包使用手册



## 关于SERO钱包

### 介绍

> SERO钱包是基于SERO主链研发的一款全节点客户端钱包，可以满足大部分用户的需求，比如：导入钱包账户、发送交易、挖矿、发布智能合约。目前已支持MAC和LINUX系统，WINDOWS版本即将推出，敬请期待。
> SERO钱包已在Github上开源 : [SERO Wallet](https://github.com/sero-cash/wallet/)



### 安装

* **客户端安装包 [点击下载](https://github.com/sero-cash/wallet/releases)**

* **选择系统对应的安装包**
    ![image_1ctd0ndog1q0e1dbk1rte28t6j7g.png-73kB][1]
    
* **安装界面,将SERO Wallet拖拽到Applications文件夹中**
    ![image_1ctd0s8gu2rpd381tun179p1boqt.png-56.7kB][2]

### 启动

* **从应用程序中找到SERO Wallet**
    ![image_1ctd12da6q2t10ak1r9ruqsqmc1n.png-24.7kB][3]
    
* **第一次启动会检查SERO Node并下载最新版本，文件大小大概80M左右，如果网络环境好，大概1分钟左右，请耐心等待。**
    ![image_1ctd1pebh12dutb824l13ij1n054d.png-118.4kB][4]
    
* **连接SERO Node，钱包会自动检查节点，钱包会自动寻找就近节点，你可以直接点击“启动应用”进入钱包主界面**
    ![image_1ctfio5ekrlb1m90ahi29okdc2t.png-120.4kB][5]

### 版本更新

* **如果需要升级钱包，可以点击菜单的以下按钮**
    ![image_1ctd0vevj1d3785r1ajafkd17bn1a.png-96.6kB][6]
    
* **你也可以关注SERO团队在[Github](https://github.com/sero-cash/wallet)上的更新，直接下载安装包进行升级。**

<br/>

## 功能介绍

### 同步区块

> 钱包启动后会自动同步区块，启动页和钱包主界面都可以看到同步的状态 
> ![image_1ctd27r0v1sjdpjp19ot7olho06q.png-123kB][7]
> ![image_1ctd29jnm4mn1t101sar85h1d3k77.png-31.8kB][8]

<br>

### 账户

> 账户用于存储你的SERO币和其他Token，类似你的银行账户，所以你需要妥善保管好你的账户以及密码，建议做好备份。

* #### 新建账户

    ![image_1ctd2fsnj43k1r8h1ji21rcj1him81.png-132kB][9]
    新建账户成功后，钱包会提供账户文件路径(`.JSON`后缀)，并且提示备份
    ![image_1ctd2p2dl8lp1217uls145a39ub8.png-114.6kB][10]

* #### 导入账户

    ![image_1ctd2hhe7jpb1regqskebifo38e.png-227.5kB][11]

* #### 备份账户

    ![image_1ctd2q8i7f47as71t8m19erqc7bl.png-98.9kB][12]
    将会打开备份文件目录，你可以把账户文件拷贝到你自己的硬盘或者U盘。

* #### 账户详情

    ![image_1ctd34sbge43mqf1pbtaa21bvcf.png-96.1kB][13]

* #### SERO的单位换算

    > 1 SERO = $10^18$ Ta,也就是说`Ta`是`SERO`的最小换算单位

<br>

### 如何挖矿⛏️

* #### 申请挖矿许可证

    SERO社区已开放申请挖矿许可证，请把账户地址发邮件到 [license@sero.vip](license@sero.vip)，SERO团队将会在48小时内给到回复。

* #### 导入挖矿许可证

    ![image_1ctd2hhe7jpb1regqskebifo38e.png-227.5kB][14]

* #### 开启挖矿

    ![image_1ctd2mb8i1ck61iivpit18d38hj8r.png-163.7kB][15]

<br>

### 发送交易

* #### 名词解释

    > **FROM**：转出的账户地址
    > **TO**：转入的账户地址
    > **AMOUNT**：数字货币数量，单位SERO
    > **SELECTFEE**：交易费的高低，决定交易处理速度，默认交易费为:1Gta

* #### 交易截图：

    ![image_1ctd3422jhef1vvk33q1vmmjegc2.png-96.9kB][16]

    ![image_1ctd3d2eu2aal7djj47ikn0ncs.png-164.7kB][17]

* #### 点击“发送”按钮,将会弹出对话框，此时钱包会估算大概需要消耗的Gas

    ![image_1ctd3gsf614dc19973q33hq1v8ud9.png-266.9kB][18]

    现在钱包主界面可以看到交易记录，由于SERO是匿名币交易，不会在交易中显示交易金额。

    ![image_1ctd3lf1v168t1ndv1sku1tqiej8dm.png-141kB][19]

    ![image_1ctd4e1nf4863ms13pm15to1a3le3.png-159.9kB][20]

<br>

### 智能合约

* #### 创建智能合约

    > 智能合约代码请参考SERO官方发布的编辑器 [Remix](https://remix.web.sero.cash)
    > 贴入源码，钱包将自动编译源码，然后选择需要发布的智能合约，输入相关参数。

    ![image_1ctf5pi6b15224lp1ii8180l18qeg.png-247.8kB][21]

    > 点击发送后，在钱包主界面将看到智能合约的交易已创建

    ![image_1ctf7g92g1f021dni1utk1m0pf3bet.png-164.7kB][22]

* #### 调用智能合约

    > 点开“管理页面”,我们可以看到 发币的数量和单位 100000000000000000 STRA，注意这里最小单位，发布的是9位小数。

    ![image_1ctfi1isf5f31ubg6kj1oe9i0r9.png-147.9kB][23]

    > 我们可以选择一个方法，比如：调用转账(Transfer)方法，把钱转到其他账户

    ![image_1ctfi7hfv1jiq1kadv2915nis4qm.png-187.2kB][24]

    > 此时钱包主页面会有一条智能合约执行的记录

    ![image_1ctfi9slj1nttkf3vongmm19ao13.png-166.9kB][25]

    > 当交易被确认后，我们看到账户已收到转账金额

    ![image_1ctfibf3p16mfr7k1cre14db12mm1g.png-130.5kB][26]

<br>

## 其他

* #### SERO钱包安装目录

    ```
    MACOS：~/Library/Application\ Support/SERO Wallet
    LINUX：~/.config/SERO Wallet
    ```

* #### SERO钱包的数据目录

    ```
    MACOS：~/Library/Sero/
    LINUX：~/.sero/
    ```

* #### 查看日志文件：

    ![image_1ctfj3dc33s2nviqi0gf52t13a.png-63.1kB][27]

<br>

**以上是SERO钱包所有功能介绍，如有疑问或者遇到问题，可以加入SERO社区技术交流群    Gitter[点击加入](https://gitter.im/sero-cash/wallet)。**

<br/>
## 相关链接

    [SERO Github](https://github.com/sero-cash)
    [SERO 官方网站](https://sero.cash)
    [SERO 区块链浏览器](https://explorer.web.sero.cash)



[1]: http://static.zybuluo.com/erlenzi-han/h02ilr77skx8s9yey3ryhgj3/image_1ctd0ndog1q0e1dbk1rte28t6j7g.png
[2]: http://static.zybuluo.com/erlenzi-han/ipbbw2vxk84gkc07ovh30r5f/image_1ctd0s8gu2rpd381tun179p1boqt.png
[3]: http://static.zybuluo.com/erlenzi-han/6bgowy2vrvdzddbphyodwl5k/image_1ctd12da6q2t10ak1r9ruqsqmc1n.png
[4]: http://static.zybuluo.com/erlenzi-han/w9qy3g26ov1awslivefp8m3t/image_1ctd1pebh12dutb824l13ij1n054d.png
[5]: http://static.zybuluo.com/erlenzi-han/rn5eav4uablmfrajjscnbxuz/image_1ctfio5ekrlb1m90ahi29okdc2t.png
[6]: http://static.zybuluo.com/erlenzi-han/zasph1ifgb210dyluugbd7h4/image_1ctd0vevj1d3785r1ajafkd17bn1a.png
[7]: http://static.zybuluo.com/erlenzi-han/ubm6ajnwkbz17relsocvi063/image_1ctd27r0v1sjdpjp19ot7olho06q.png
[8]: http://static.zybuluo.com/erlenzi-han/ryd9kezxua78jtumah0b7yn5/image_1ctd29jnm4mn1t101sar85h1d3k77.png
[9]: http://static.zybuluo.com/erlenzi-han/oe6l93syxbs8cd0iynuneuat/image_1ctd2fsnj43k1r8h1ji21rcj1him81.png
[10]: http://static.zybuluo.com/erlenzi-han/t7wiqcv69bogdwuvlzp0un73/image_1ctd2p2dl8lp1217uls145a39ub8.png
[11]: http://static.zybuluo.com/erlenzi-han/hlgceg42c1sfkwqgooql11zg/image_1ctd2hhe7jpb1regqskebifo38e.png
[12]: http://static.zybuluo.com/erlenzi-han/zzdwyk37nosx9gyx0s0diki3/image_1ctd2q8i7f47as71t8m19erqc7bl.png
[13]: http://static.zybuluo.com/erlenzi-han/oitpan40ro9k88eeh22url9f/image_1ctd34sbge43mqf1pbtaa21bvcf.png
[14]: http://static.zybuluo.com/erlenzi-han/hlgceg42c1sfkwqgooql11zg/image_1ctd2hhe7jpb1regqskebifo38e.png
[15]: http://static.zybuluo.com/erlenzi-han/vblw2c3wr9g7u0e2piddonhy/image_1ctd2mb8i1ck61iivpit18d38hj8r.png
[16]: http://static.zybuluo.com/erlenzi-han/cuhu5g8prnbqs01ju31qzg78/image_1ctd3422jhef1vvk33q1vmmjegc2.png
[17]: http://static.zybuluo.com/erlenzi-han/pbv6hl36c53ux3uyohfg5ipo/image_1ctd3d2eu2aal7djj47ikn0ncs.png
[18]: http://static.zybuluo.com/erlenzi-han/4ia3u9sxb1hu8arq18iam06v/image_1ctd3gsf614dc19973q33hq1v8ud9.png
[19]: http://static.zybuluo.com/erlenzi-han/ibsgciilgro27utvk8dvle2u/image_1ctd3lf1v168t1ndv1sku1tqiej8dm.png
[20]: http://static.zybuluo.com/erlenzi-han/l0kd9unpeu6wrfzuu9ka4d3a/image_1ctd4e1nf4863ms13pm15to1a3le3.png
[21]: http://static.zybuluo.com/erlenzi-han/n8u52v1n345eu9dmk393ywwf/image_1ctf5pi6b15224lp1ii8180l18qeg.png
[22]: http://static.zybuluo.com/erlenzi-han/rhlqerb0rymez3k3w4na1qvr/image_1ctf7g92g1f021dni1utk1m0pf3bet.png
[23]: http://static.zybuluo.com/erlenzi-han/k15jcg55cna62b9w0vt2czhm/image_1ctfi1isf5f31ubg6kj1oe9i0r9.png
[24]: http://static.zybuluo.com/erlenzi-han/0yihzhw9kahdgwbbajbx4zgs/image_1ctfi7hfv1jiq1kadv2915nis4qm.png
[25]: http://static.zybuluo.com/erlenzi-han/8u0qucz5xi365fvjdipvyln8/image_1ctfi9slj1nttkf3vongmm19ao13.png
[26]: http://static.zybuluo.com/erlenzi-han/okirq5myudofkxnhkj1633hj/image_1ctfibf3p16mfr7k1cre14db12mm1g.png
[27]: http://static.zybuluo.com/erlenzi-han/6hddx0tnfvdrgeu2hcaflsj2/image_1ctfj3dc33s2nviqi0gf52t13a.png
```

```