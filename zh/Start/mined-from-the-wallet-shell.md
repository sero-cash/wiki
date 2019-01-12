# SERO Windows钱包如何开启脚本挖矿
----
1. 找到脚本目录：
>`C:\Users\%username%\AppData\Roaming\SERO Wallet\binaries\gero\unpacked\geropkg`

2. 启动gero节点
>双击startup.bat,打开后请不要关闭窗口，最小化即可。
>![image.png](https://upload-images.jianshu.io/upload_images/13141677-a191e72f201d0ab9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3. 连接gero节点
>双击 attach.bat ，打开attach.bat
>![image.png](https://upload-images.jianshu.io/upload_images/13141677-25a2e01876377569.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

4. 开启挖矿
>输入 `miner.start(2);`  “2”代表线程数,可根据需求调整。
>![image.png](https://upload-images.jianshu.io/upload_images/13141677-0ed38055b0390e8c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

5. 查看挖矿状态
>输入 `sero.minging; `,如果看到  true 表示开启挖矿成功，false为失败。
>![image.png](https://upload-images.jianshu.io/upload_images/13141677-6f13934708267373.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

6. 查看余额
>
>输入 `web3.fromTa(sero.getBalance(sero.coinbase).tkn.SERO);` 
>
>如过👆上面命令报错，请使用下面命令：
>
>`sero.getBalance(sero.coinbase)`
>
>`web3.fromTa(数字); ` 把数字贴入括号中，可以转换为SERO单位。
>![image.png](https://upload-images.jianshu.io/upload_images/13141677-21735e739c899978.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

7. 停止挖矿
>输入  `miner.stop();` 可停止挖矿。