# SERO SuperZK2.0 Protocol Upgrade Guide

**Dear SERO Project Technical Partners:**

This SERO **SuperZK2.0** Protocol release mainly introduces the following three features:

* Provides a more secure and efficient privacy encryption service.
* Support for decentralized mobile wallets.
* Removal of **POW** mining license.

The soft fork will be at the block height of **1958696**

* Approximate Beijing time **20:30, 31st October, 2019**
* Switching will be seamless.
* SuperZK1.0 and SuperZK2.0 accounts will coexist after the switch is completed.


## Please ask the technical support staff to do the following:

### 1. Upgrade related components (must be upgraded otherwise the blocks will not be synchronized after switching height)

1. Upgrade `gero` to the `v1.0.1` version.

2. Upgrade the `js-sero-client` component to the `v1.0.1` version.

3. If you depend on the `go-sero` source code, please switch to the `v1.0.1` source.

### 2. After upgrading the components, the new and old protocols will be seamlessly switched. If you want to use the SuperZK2.0 protocol, you would need to make some adjustments to some of the details.

* #### For users who use the SSI interface

  * You can create an account with `ssi_szkCreateKr` instead of `ssi_createKr` to create a protocol based on `SuperZK2.0`.

* #### For users using the Flight interface

  * You can pass a protocol version to `local_seed2Sk` to create a protocol based on `SuperZK2.0`.
  * Two output attributes of `Out_P` and `Out_C` would be added to the `Out` structure of the transaction.
    * If you just use `decOut` for decryption, you can ignore it.

* #### For users who use the Exchange interface

  If you want to create a new protocol account, you can increase the protocol version number when calling the following methods:

  * **Go**

    * Create a new protocol account with `keys.Seed2SkByVersion`

    ```go
    //****Before the change****//
    keys.Seed2Sk(seed)
    //****After the change****//
    keys.Seed2SkByVersion(
      Seed,
      Version      //1: SuperZK1.0 2: SuperZK2.0, default 1
    )
    ```

  * **Javascript**

    * Create a new protocol account with `require('js-sero-client').newKeysBySeed`

      ```javascript
      //****Before the change****//
      Const account=require('js-sero-client').Account
      Const keys=account.NewKeys(seed)
      //****After the change****//
      Const newKeysBySeed=require('js-sero-client').newKeysBySeed
      Const keys=newKeysBySeed(
        Seed,
        Version //1: SuperZK1.0 2: SuperZK2.0, default 1
      )
      //****Also for sk/tk/pk, you can create keys****//
      Const newKeysBySk=require('js-sero-client').newKeysBySk
      Const newKeysByTk=require('js-sero-client').newKeysByTk
      Const newKeysByPK=require('js-sero-client').newKeysByPK
      ```

  * **Gero-Console**

    * Create a new protocol account via `personal.importRawKey`

      ```javascript
      //****Before the change****//
      personal.importRawKey(seed,password)
      //****After the change****//
      personal.importRawKey(
        Seed,
        Password,
        Version, //1: SuperZK1.0 2: SuperZK2.0, default 1
        At / / from that piece to start analysis, the default 0
      )
      ```

  * **RPC**

    * Create a new protocol account via `exchange_seed2Sk`

      ```javascript
      //****Before the change****//
      exchange.seed2Sk(seed)
      //****After the change****//
      exchange.seed2Sk(
        Seed,
        Version //1: SuperZK1.0 2: SuperZK2.0, default 1
      )
      ```

      