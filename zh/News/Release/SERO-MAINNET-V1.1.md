# MAINNET-V1.1 发布概要



## 声明

本次发布涉及对存储方式以及节点之间同步策略的优化，因此需要进行硬分叉，具体情况：

**分叉高度：**5703394 

**预计时间：**

  UTC时间 - 2021年6月10日中午12时

  北京时间 - 2021年6月10日晚上20时

**提示:**

  通过运行 `kill -INT [PID of gero]` 停止旧版本的 gero 服务，可以立即保存状态，防止区块回撤。



## 发布名称

MainNet-V1.1.0




## 版本号

gero:  `v1.1.0`
go-czero-import:  `v1.1.0`
mine-pool:  `v0.1.4`
js-sero-client:  `v1.0.1`



## 新增特性
* v1.1.0
   - [x] 调整存储结构，支持本地快照生成。
   - [x] 调整 peer 之间的广播算法，减轻节点网络阻塞的情况。
   - [x] 在智能合约中可通过 SeroInterface 的 sero_update 方法实现自升级功能。
   - [x] 解决智能合约调用时，预估 Gas 费用与实际使用不符合的 Bug。
   - [x] 增加 abigen 对 Ticket 资产以及 NFT 资产的支持。 
   - [x] 优化交易池的校验逻辑。



## 提交ID
go-sero `92fd3138298d0123d518da289fc65894abb15cbc`
go-czero-import `92dfb4110904ece1e0066d8126a7863ed3487db7`
console `df296a4b359ba14f555ab34e35896807581577f9`
mine-pool `fc3f2af2f261beefbe99b95d89abcb19b0d047f3`
serominer `a111c98b0b3ba5767ba4a7c2d02c949603ba90a9`



## 发布包
> 二进制下载地址：https://github.com/sero-cash/go-sero/releases/tag/v1.1.0
> > gero-v1.1.0-darwin-amd64.tar.gz `macos`, md5: `e6c6afb2fe2535fc3fc2c48c7b614c7c`
> > gero-v1.1.0-linux-amd64-v3.tar.gz `centos & ubuntu`, md5: `8557a2f34ee0ac06fd609e05f492d667`
> > gero-v1.1.0-windows-amd64.zip `windows`, md5: `e22ca135cf37b180f125e2a14d152e85`



## 亚洲版下载地址
### DARWIN (MacOS)
https://sero-1259797294.file.myqcloud.com/gero/v1.1.0/gero-v1.1.0-darwin-amd64.tar.gz

### LINUX3
https://sero-1259797294.file.myqcloud.com/gero/v1.1.0/gero-v1.1.0-linux-amd64-v3.tar.gz

### WINDOWS (>= Win10.1)
https://sero-1259797294.file.myqcloud.com/gero/v1.1.0/gero-v1.1.0-windows-amd64.tar.gz

