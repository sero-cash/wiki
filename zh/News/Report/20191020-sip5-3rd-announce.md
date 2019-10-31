# SERO v1.0.1 版本升级指南

**各位对接方：**

`SERO`协议已经升级为`SuperZK2.0`，请在10月27日前完成`全节点程序`以及`相关组件`的升级。

软分叉将在 **1958696** 高度进行（北京时间 **2019年10月31日 20:30时** 左右）。

更新情况可以参考：[MAINNET V1.0.1](?file=News/Release/SERO-MAINNET-V1.0.1)

**涉及对象**

* 权益池运营者，需升级
  * `gero`
* 矿池运营者，需升级
  * `gero`
  * `gero源码依赖` （如有依赖）
  * `mine-pool`（如采用官方矿池代码）
* 交易所，需升级
  * `gero`
  * `gero源码依赖`（如有依赖）
  * `js-sero-client`（如有依赖）
* 各SERO生态对接方，需升级
  * `gero`
  * `gero源码依赖`（如有依赖）
  * `js-sero-client`（如有依赖）

## 重点

* ### 10月27日之前完成各组件升级

* ### 原则上升级完成后不需要修改其他代码。（对于完全按照文档进行的对接的用户）

  * 如果在升级过程有任何问题，请在任何SERO社群里面留言。

* ### 需要升级的组件

  * gero `v1.0.1-rc5`
    * 下载链接 <https://github.com/sero-cash/go-sero/releases/tag/v1.0.1-rc5>
  * js-sero-client `v1.0.1-rc5` （如有使用）
    * 用npm升级即可
  * gero 源码 `v1.0.1-rc5` （如有源码依赖）
    * go-sero
      * <https://github.com/sero-cash/go-sero>
      * Commit Id: `19a0b0d76eb0610fc4365f7d58171161afda2f4c`
    * go-czero-import
      * https://github.com/sero-cash/go-czero-import
      * Commit Id: `dac153d3b8ad511934e7e007810bdcef7c11e8cf`
  * mine-pool `v0.1.4` (如使用官方矿池部署)
    * <https://github.com/sero-cash/mine-pool>
    * Commit Id: `fc3f2af2f261beefbe99b95d89abcb19b0d047f3`

* ### 在 **1958696** 高度左右1小时内，暂停充提或者转账操作。

  * （北京时间 **2019年10月31日 20:30时** 左右）



## 建议(非必须)

在升级程序确认稳定后，可根据需求升级`SuperZK2.0`协议账户。
   [详细内容](?file=News/Report/20191020-sip5-superzk20-account-update)