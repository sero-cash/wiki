# 如何使用PC端去中心化轻钱包

`Pullup钱包`是一款PC端的去中心化钱包，在配置全节点的IP和端口之后，不用忍受长时间的区块同步，也不需要上传用户信息，即可在本地安全的创建和管理账户，发送接收交易，调用智能合约，以及购买POS股份。

>  Pullup钱包需要连接`v1.0.0-rc2`版本以上的全节点（gero），并且需要确保全节点启动参数中包含`--light`以及`--rpcapi light`，

> Pullup钱包只能购买股份和注册StakingNode，无法代替全节点进行投票，因此进行Staking投票的用户依然需要下载全节点钱包，并同步完整的区块数据。



## 注意

* Pullup钱包和PC全节点钱包的关系
  * 彼此之间账户不要互相导入。
  * 可以采用收款码向彼此发送资产。
  * 均可接受交易所或者Flight钱包的提款（采用收款码）



## 下载

Pullup钱包是在github上开源的，可以通过访问下面的链接来下载最新的Pullup钱包：

<https://github.com/sero-cash/pullup>



## 安装

* MAC下安装
  * 解压sero-pullup-mac.zip 为 sero-pullup-mac。
  * 将sero-pullup-mac拷贝到【应用程序】文件夹中。
  * 即可从启动面板里面启动Pullup钱包。
  * 如果被系统阻止，需要进入【偏好设置->安全性与隐私】，点击【仍要打开】
* Win32下安装
  * 解压sero-pullup-win32.zip 为 sero-pullup-win32文件夹
  * 可将sero-pullup-win32放置于任何文件夹下
  * 进入文件夹中双击pullup.exe即可启动Pullup钱包
  * 如果系统弹出防火墙拦截通知，可以点击【允许】



## 全节点选择

在钱包的首页有一个名为`节点`的卡片。

![image.png](https://upload-images.jianshu.io/upload_images/277023-f4a44c0339b71fa1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

点击卡片上的双向箭头，就可以弹出节点选择器，你可以选择默认的节点`SERO Main Network`，也可以选择自己或者他人搭建的节点，不管选择那一种，都是安全的，因为钱包不会上传任何用户隐私信息到节点上。

![image.png](https://upload-images.jianshu.io/upload_images/277023-ba2866aa1f6da3fd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

> 如果是选择自己或者他人搭建的 gero 节点，请确保其 gero 的版本号大于 `v1.0.0-rc2`，并且开启了 `--light --rpcapi light` 服务。

> 另外两个选项是：
>
> * localhost:8545
>   * 连接本地节点（需要在本地部署gero）
> * Personal Rpc
>   * 设置第三方的全节点ip和端口



## 账户管理

### 创建新账户

* Pullup钱包用助记词管理账户，创建账户可以点击首页最下方的按钮【创建账户】。

![image.png](https://upload-images.jianshu.io/upload_images/277023-e724f0c64336e0ee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)



* 输入两次至少8位的任意字符密码

![image.png](https://upload-images.jianshu.io/upload_images/277023-ac4ea0a6658fdc04.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* 备份助记词

  * 助记词就相当于你的私钥，一定要保管好，泄漏助记词，相当于将账户掌控权交给其他人。

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-67d760fde0b44384.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

* 进入首页后就能看到刚刚创建的账户

![image.png](https://upload-images.jianshu.io/upload_images/277023-e34887ff226db347.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)



### 备份助记词

* Pullup钱包以助记词为媒介备份账户，因此你可以点击首页中需要备份的账户方块进入账户页面。

![image.png](https://upload-images.jianshu.io/upload_images/277023-5e15cbcc4295f3e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* 弹出助记词页面后，请尽快记下来，然后关闭窗口，记住千万不能泄漏。

![image.png](https://upload-images.jianshu.io/upload_images/277023-47fb24e5312dce43.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)



### 导入助记词

* 在创建账户的页面点击下方的【使用助记词导入】按钮

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-5bd7988e78bd21a0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* 钱包弹出助记词输入页面，在页面中填入正确的助记词，并设置密码。

  ![image.png](https://upload-images.jianshu.io/upload_images/277023-23ffaff7038a664e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

