# SERO v1.0.1 版本升级指南

**各位对接方：**

`SERO`协议已经升级为`SuperZK2.0`，请在10月27日前完成`全节点程序`以及`相关组件`的升级。

软分叉将在 **1958696** 高度进行（北京时间 **2019年10月31日 20:30时** 左右）。

更新情况可以参考：[MAINNET V1.0.1-RC1](?file=News/Release/SERO-MAINNET-V1.0.1-RC1)

**涉及对象**

* 权益池运营者
  * 需升级gero
* 矿池运营者
  * 需升级gero、gero源码依赖
* 交易所
  * 需升级gero、gero源码依赖、js-sero-client
* 各SERO生态对接方
  * 需升级gero、gero源码依赖、js-sero-client

## 重点

* ### 10月27日之前完成各组件升级

* ### 原则上升级完成后不需要修改其他代码。（对于完全按照文档进行的对接的用户）

  * 如果在升级过程有任何问题，请在任何SERO社群里面留言。

* ### 需要升级的组件

  * gero v1.0.1
    * 下载链接 <https://github.com/sero-cash/go-sero/releases/tag/v1.0.1-rc1>
  * js-sero-client v1.0.1 （如有使用）
    * 用npm升级即可
  * gero 源码 v1.0.1 （如有源码依赖）
    * 用git升级即可 <https://github.com/sero-cash/go-sero>

* ### 在 **1958696** 高度左右1小时内，暂停充提或者转账操作。

  * （北京时间 **2019年10月31日 20:30时** 左右）

## 建议(非必须)

在升级程序确认稳定后，可根据需求升级`SuperZK2.0`协议账户。
   [详细内容](?file=News/Report/20191020-sip5-superzk20-account-update)