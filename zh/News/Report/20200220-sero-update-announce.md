SERO 全节点服务升级公告
==================

为不影响网络正常运作，请尽快（2月26日前）将下面几个系统升级到最新版本。
-----------------------------------

1. gero `v1.0.2-rc1`
   https://github.com/sero-cash/go-sero/releases/tag/v1.0.2-rc1

   > 注意：先在命令行用`admin.close()`保存状态，再停止gero。

2. js-sero-client `1.0.2-rc1`
   用 npm 更新即可

3. go-czero-import `v1.0.2-rc1`
   git clone https://github.com/sero-cash/go-czero-import.git

   (或者 git clone https://gitee.com/sero-cash/go-czero-import.git)

4. mine-pool `v0.1.5`
   https://github.com/sero-cash/mine-pool


本次SERO升级特性于下：
----------------

1. 减排放
2. 267w块之前设置Checkpoint。
3. 支持Abigen
4. 智能合约增加TxHash接口

减排放原理
--------------
在 2764851 高度之后（包括此高度），原规则不变，所有排放产出都减半。


