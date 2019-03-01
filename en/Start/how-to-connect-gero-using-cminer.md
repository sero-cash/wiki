# How to mining solo using cminer

## Why need to mine with cminer?

**Many miners complain that mining using wallet is unstable, often crash or disconect, which are because:**

* The current SERO version uses CPU mining, mining and block data synchronization on the same machine, the CPU pressure is too large, affecting the speed of the system to process network requests.

* Wallet is written using github's open source framework electron, which is unstable and crashes when the CPU load is too high.

**Therefore, using cminer to connect gero or wallet to mine is the best SOLO mining way.**

* cminer and gero can be deployed separately.
  * cminer is only responsible for POW calculation, only uses CPU and memory, and only synchronizes very little data, so it can be deployed on multiple nodes.
  * gero is used for synchronizing and processing block data as quickly as possible. Hard disk, CPU and memory are required, and only a few servers need to be deployed.

* The current SERO requires a mining license. If there are too many nodes, it is very troublesome to replace the licenses. A small number of gero nodes can greatly reduce the workload.

## Steps to connect gero with cminer

1. #### Start gero and add rpc parameter

   ```shell
   ./gero --datadir YOUR_DATA_DIR --rpc --rpcaddr YOUR_GERO_HOST_IP --rpcport PORT --rpccorsdomain "*" --serobase YOUR_MINING_ADDRESS
   ```

2. #### Start gero, set up the miner account, and configure the license.

   * For details of operation, please refer to [SERO Mining Tutorial](?file=Start/from-the-binary-package)
   * The only difference is that you don't need to run miner.start() command
   * Note: When using cminer to connect to gero for mining, the HashRate cannot be displayed in the gero console and can only be viewed through the output log of cminer.
   * For details on how to view, please refer to [Mining using SERO opensource mining pool](?file=Start/mined-in-the-mine-pool)

3. #### When starting cminer, the parameter needs to be specified as:

   ```shell
   cminer -P http://YOUR_GERO_HOST_IP:PORT --cpu=0
   ```

   * `YOUR_GERO_HOST_IP` and `PORT` are the parameter values specified for gero in step 1.
   * --cpu=0 is to let cminer choose the number of mining threads, please refer to [Mining using SERO opensource mining pool](?file=Start/mined-in-the-mine-pool)

4. #### The logs of cminer submits a result to the gero after minging the block
   ![image_1d4fqrtbfpgp1gqhtai2no19mmm.png-68.6kB][1]

   * **In the green box:** The result is accepted
   * **In the red box:** The result is rejected
   * **In the blue box:** The hashrate of current machine

[1]: http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/201902/image_1d4fqrtbfpgp1gqhtai2no19mmm.png

