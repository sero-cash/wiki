# SERO v1.0.1 版本升级指南

**尊敬的各SERO对接方：**

SERO 本次发布 **SuperZK2.0** 协议主要提供下面两个方面的能力：

* 提供更安全和高效的隐私加密服务

* 支持去中心化的移动钱包。

软分叉将在 **1950548** 高度进行

* 大约北京时间 **2019年10月31日 20:30时** 左右
* 切换是无缝进行的。
* 切换完成后SuperZK1.0和2.0账户是共存的。



## 请技术们进行下面几个操作：

### 1. 升级相关的组件（必须升级，否则切换高度之后无法正常同步）

1. 将 `gero` 升级为 `v1.0.1` 版本。

2. 将 `js-sero-client` 组件升级为 `v1.0.1` 版本。

3. 如果依赖 `go-sero` 源码的请切换到 `v1.0.1` 源码上。

   

### 2. 原则上升级完组件后，新老协议既可以进行无缝切换。如果希望使用SuperZK2.0协议，需要对部分细节进行下面的调整。

* #### 对于使用 SSI 接口的用户

  * 可以用`ssi_szkCreateKr`代替`ssi_createKr`创建账户，创建基于`SuperZK2.0`的协议。

* #### 对于使用 Flight 接口的用户

  * 可以给`local_seed2Sk`传入一个协议版本来创建基于`SuperZK2.0`的协议。
  * 交易的`Out`结构里面增加了`Out_P`和`Out_C`两个输出属性。
    * 如果只是使用`decOut`进行解密，可以忽略。

* #### 对于使用 Exchange 接口的用户

  如果想要创建新协议账户，可以在调用下面方法时增加协议版本号：

  * **Go**

    * 采用`keys.Seed2SkByVersion`创建新协议账户

    ```go
    //****改动前****//
    keys.Seed2Sk(seed)
    //****改动后****//
    keys.Seed2SkByVersion(
      seed,
      version        //1: SuperZK1.0 2: SuperZK2.0, 默认 1
    )
    ```

  * **Javascript**

    * 采用 `require('js-sero-client').newKeysBySeed`创建新协议账户

      ```javascript
      //****改动前****//
      const account=require('js-sero-client').Account
      const keys=account.NewKeys(seed)
      //****改动后****//
      const newKeysBySeed=require('js-sero-client').newKeysBySeed
      const keys=newKeysBySeed(
        seed,
        version      //1: SuperZK1.0 2: SuperZK2.0, 默认 1
      )
      //****另外对于sk/tk/pk分别可以这样创建keys****//
      const newKeysBySk=require('js-sero-client').newKeysBySk
      const newKeysByTk=require('js-sero-client').newKeysByTk
      const newKeysByPK=require('js-sero-client').newKeysByPK
      ```

  * **Gero-Console**

    * 通过`personal.importRawKey`创建新协议账户

      ```javascript
      //****改动前****//
      personal.importRawKey(seed,password)
      //****改动后****//
      personal.importRawKey(
        seed,
        password,
        version,      //1: SuperZK1.0 2: SuperZK2.0, 默认 1
        at            //从那一块开始分析，默认 0
      )
      ```

  * **RPC**

    * 通过`exchange_seed2Sk`创建新协议账户

      ```javascript
      //****改动前****//
      exchange.seed2Sk(seed)
      //****改动后****//
      exchange.seed2Sk(
        seed,
        version         //1: SuperZK1.0 2: SuperZK2.0, 默认 1
      )
      ```

      