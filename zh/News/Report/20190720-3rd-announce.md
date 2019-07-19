# SERO共识升级公告（第三方对接用户）



最新的SERO全节点程序已经发布，请尽快更新程序。

SERO网络在130万块高度的时候会切换共识为 POS+POW。



## 下面是注意事项：

### 时间

大约是北京时间7月24日早上6点前后。

### 需要更新的程序

* 全节点程序（gero）
       确认版本号在 v1.0.0-rc2 以上。
       链接：https://github.com/sero-cash/go-sero/releases

* nodejs 离线签名程序（js-sero-client）
       确认版本号在 0.1.8 以上
       链接：https://github.com/sero-cash/js-sero-client

### 请确认

   全节点程序 gero 的增加了启动参数：
       ` --confirmedBlock 32`    //增加确认块数量

### 建议
   在7月24日130万块前后关闭充提直到网络稳定

