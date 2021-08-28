# 如何缩减 SERO 区块数据存储空间 (手工创建区块快照)


1. ### 为什么要手工创建快照
   当 `SERO 1.0` 全节点运行一段时间，由于过程中会接收、计算和存储由挖矿竞争而产生的各种叔块和区块分支数据，`SERO 1.0` 全节点的区块数据会非常的巨大。创建快照可以有效的去除不必要的数据存储，极大的压缩 `SERO 1.0` 全节点数据的大小。根据经验， 600 万高度的区块的快照大小只有 150G 左右。



2. ### `SERO 1.0` 数据目录说明
   先找到 `SERO 1.0` 的数据目录，一般在 `gero` 启动时由 `--datadir` 指定。
   
   在datadir下可能有四个文件夹：
   * **exchange:**  `gero` 的账户分析数据，你导入的 `keystore` 对应的账户余额保存在这个下面。
   * **gero:** 跟 `SERO 1.0` 链本身相关的数据都在这个下面。
   * **light:** 如果你开启了轻钱包服务，那么相关的数据在这个下面。
   * **stake:** 如果你开启了 `stake` 统计服务，相关的统计数据在这个下面。
   
   其中 `gero/chaindata` 就是 `SERO1.0` 的区块和状态数据。我们所建的快照就是将`gero/chaindata` 中的有效数据提取出来，生成一个只包含有效数据的新的较小的 `chaindata`。然后你可以手工替换掉之前巨大的 `gero/chaindata`。





3. ### 手工创建快照的先决条件
   * 你的 `gero` 版本号需要大于等于 `v1.1.0`
   * 你已经用基金会发布的大于等于 `6137414` 高度的快照同步到过最新的区块。
     * 参考：[快照下载](https://wiki.sero.cash/zh/index.html?file=Start/sero-chain-snapshot-list)
   
   
   
   上面两个条件缺少任何一个都会导致创建快照失败。
   
   
   
4. ### 创建快照的方法 
   * 先停止 gero 服务（如果不停止将导致快照创建失败）
   * 然后运行命令
   
   ```bash
   ./bin/gero snapshot [TARGET_FILE_PATH] --datadir [GERO_DATA_DIR]
   ```
   

​        **`TARGET_FILE_PATH`** 指定新生成的 `chaindata` 快照的路径。

​        **`GERO_DATA_DIR`** 指定旧的 `SERO 1.0` 的数据目录（ `--datadir` 指定的目录）。

​         然后耐心等待快照创建成功。