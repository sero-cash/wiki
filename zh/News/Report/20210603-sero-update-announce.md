# SERO 全节点服务升级公告



## 1. 特别注意

    关闭 gero 程序的时候请采用 `kill -INT [PID of gero]`，不要使用 kill -9，否则会导致最多要重新同步1万个区块。此步骤可能需要耗时，请等待进程完全退出后再进行后续的升级操作。



## 2. 为不影响网络正常运行，请尽快 (6月8日之前) 将下面的系统升级到最新版本。


1. gero  `v1.1.0`
    https://github.com/sero-cash/go-sero/release/tag/v1.1.0

2. go-czero-import  `v1.1.0` 
    git clone https://github.com/sero-cash/go-czero-import.git
    (或者 git clone https://gitee.com/sero-cash/go-czero-import.git)



## 3. 本次分叉高度为 5703394

**大约在:**
    UTC时间 2021年6月10日中午
    北京时间 2021年6月10日晚上20时。




## 4. 分叉说明

为缓解 SERO 全节点逐步增大的存储压力，并顺利实现后续的 Fast Sync Node 切换和未来向 SERO 2.0 过度。

- [x] 调整存储结构，支持本地快照生成。
- [x] 调整 peer 之间的广播算法，减轻节点网络阻塞的情况。
- [x] 在智能合约中可通过 SeroInterface 的 sero_update 方法实现自升级功能。
- [x] 解决智能合约调用时，预估 Gas 费用与实际使用不符合的 Bug。
- [x] 增加 abigen 对 Ticket 资产以及 NFT 资产的支持。 
- [x] 优化交易池的校验逻辑。