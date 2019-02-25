# 如何用cminer连接gero进行SOLO挖矿



## 为什么需要用cminer挖矿

**很多矿工都抱怨使用wallet全节点挖矿不稳定，经常崩溃或者掉线，这是因为：**

* 当前SERO采用CPU挖矿，挖矿和块数据同步在同一台机器上，对CPU压力过大，影响了系统处理网络请求的速度。

* wallet采用github的框架electron编写，这个框架在CPU负载过高的时候非常不稳定，容易崩溃。

**所以，采用cminer连接gero或者wallet来挖矿才是最佳的SOLO方式。**

* cminer和gero可以分开部署。
  * cminer只负责POW计算，只消耗CPU和内存，并且只同步非常少的数据，所以可以部署在多个节点上。
  * 而gero负责尽可能快的同步和处理区块数据。对硬盘、CPU、内存都有要求，只需要部署在少数服务器上。

* 当前SERO需要挖矿许可证，如果节点过多，更换许可证非常麻烦，少量的gero节点可以大幅度减轻这个工作量。



## 用cminer连接gero的步骤

1. #### 开启gero的同时加上rpc参数

   ```shell
   ./gero --datadir YOUR_开源DATA_DIR --rpc --rpcaddr YOUR_GERO_HOST_IP --rpcport PORT --rpccorsdomain "*" --serobase YOUR_MINING_ADDRESS
   ```

2. #### 启动gero，并且设置好矿工帐号，以及设置好license。

   * 具体操作，请参考[SERO挖矿教程](file=Start/from-the-binary-package)

   * 唯一不同的是不需要开启miner.start()
   * 注意：采用cminer连接gero挖矿的算力(HashRate)，在gero控制台无法显示出来，只能通过cminer的输出查看。
     * 具体如何查看，请参考[如何使用矿工程序(cminer)连接矿池挖矿](file=Start/mined-in-the-mine-pool)

3. #### 启动cminer，参数需要指定为：

   ```shell
   cminer -P http://YOUR_GERO_HOST_IP:PORT --cpu=0
   ```

   * `YOUR_GERO_HOST_IP` 和 `PORT` 都是在第1步的时候为gero指定的参数值
   * --cpu=0 是让cminer自己选择矿工线程数，具体指定办法可以参考[如何使用矿工程序(cminer)连接矿池挖矿](file=Start/mined-in-the-mine-pool)

4. #### cminer在挖到块之后向gero提交结果
   ![image_1d4fqrtbfpgp1gqhtai2no19mmm.png-68.6kB][1]

   * **绿色：** 结果被接受
   * **红色：** 结果被拒绝
   * **蓝色：** 当前机器算力



[1]: http://static.zybuluo.com/erlenzi-han/lmb61zmh57gw5zt9nmf5wbb3/image_1d4fqrtbfpgp1gqhtai2no19mmm.png

