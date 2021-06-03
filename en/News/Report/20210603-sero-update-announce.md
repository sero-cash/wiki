# Sero full node service upgrade announcement



## 1. Note

    Please use `kill -INT [PID of gero]` when shutting down the gero program, do not use kill -9, as this will result in resynchronizing up to 10,000 blocks. This step may be time consuming, please wait until the process is fully exited before proceeding with subsequent upgrade operations.



## 2. In order for the normal operation of the network, please upgrade the following systems to the latest version as soon as possible (June 8).


1. gero  `v1.1.0`
   https://github.com/sero-cash/go-sero/release/tag/v1.1.0

2. go-czero-import  `v1.1.0` 
   git clone https://github.com/sero-cash/go-czero-import.git
   (或者 git clone https://gitee.com/sero-cash/go-czero-import.git)



## 3. The height of this forking is 5703394

**Approximately at:**
    UTC Time:  June 10, 2021 a.m.
    Beijing Time: June 10, 2021 at 20:00 p.m.




## 4. Description

In order to alleviate the progressively increasing storage pressure on SERO full nodes and to smoothly implement the subsequent Fast Sync Node switch and future transition to SERO 2.0.

- [x] Restructured storage structure to support local snapshot generation.
- [x] Adjust the broadcast algorithm between peers to reduce node network blocking.
- [x] Implement self-updating feature in smart contracts via the sero_update method of SeroInterface.
- [x] Fix the bug that the estimated gas cost does not match the actual usage when a smart contract is called.
- [x] Add Ticket assets and NFT assets features for abigen.
- [x] Optimize the validation logic of tx pool.