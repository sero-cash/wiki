SERO 全节点服务升级公告
==================

为不影响网络正常运作，请尽快（11月26日前）将下面几个系统升级到最新版本。
-----------------------------------

1. gero v1.0.1-rc6
   https://github.com/sero-cash/go-sero/releases/tag/v1.0.1-rc6

2. js-sero-client 1.0.1-rc6
   用 npm 更新即可

3. go-czero-import v1.0.1-rc6
   git clone https://github.com/sero-cash/go-czero-import.git

本次SERO升级特性于下：
----------------

1. 交易输出数量由8个提升至500个。
2. 207w块之前设置Checkpoint，提升同步速度。
3. exchange接口增加忽略某PKr的Utxo的功能。
4. 减少运行时对内存资源的占用。