# MAINNET-V1.1.0 Release Announce



## Attention

This release involves optimization of the storage method and the synchronization strategy between peers,  so therefore requires a hard fork, as follows:

**Height:** 5703394 

**Estimated time:**

  UTC Time - June 10, 2021 at 12:00 AM

  Beijing Time - June 10, 2021 at 20:00 PM

**Hint:**

  Stopping the older gero service by running **`kill -INT [PID of gero]`** will immediately save the state and prevent Block-Rollbacks.



## Release Name

MainNet-V1.1.0




## Version

gero :  `v1.1.0`
go-czero-import :  `v1.1.0`
mine-pool :  `v0.1.4`
js-sero-client :  `v1.0.1`



## New Feature

* v1.1.0
  - [x] Restructured storage structure to support local snapshot generation.
  - [x] Adjust the broadcast algorithm between peers to reduce node network blocking.
  - [x] Implement self-updating feature in smart contracts via the sero_update method of SeroInterface.
  - [x] Fix the bug that the estimated gas cost does not match the actual usage when a smart contract is called.
  - [x] Add Ticket assets and NFT assets features for abigen.
  - [x] Optimize the validation logic of tx pool.



## Commit ID

go-sero `92fd3138298d0123d518da289fc65894abb15cbc`
go-czero-import `92dfb4110904ece1e0066d8126a7863ed3487db7`
console `df296a4b359ba14f555ab34e35896807581577f9`
mine-pool `fc3f2af2f261beefbe99b95d89abcb19b0d047f3`
serominer `a111c98b0b3ba5767ba4a7c2d02c949603ba90a9`



## Release Package

> **Download Urls:** https://github.com/sero-cash/go-sero/releases/tag/v1.1.0
>
> > gero-v1.1.0-darwin-amd64.tar.gz `macos`, md5: `e6c6afb2fe2535fc3fc2c48c7b614c7c`
> > gero-v1.1.0-linux-amd64-v3.tar.gz `centos & ubuntu`, md5: `8557a2f34ee0ac06fd609e05f492d667`
> > gero-v1.1.0-windows-amd64.zip `windows`, md5: `e22ca135cf37b180f125e2a14d152e85`



## Asian version download address

### DARWIN (MacOS)

https://sero-1259797294.file.myqcloud.com/gero/v1.1.0/gero-v1.1.0-darwin-amd64.tar.gz

### LINUX3

https://sero-1259797294.file.myqcloud.com/gero/v1.1.0/gero-v1.1.0-linux-amd64-v3.tar.gz

### WINDOWS (>= Win10.1)

https://sero-1259797294.file.myqcloud.com/gero/v1.1.0/gero-v1.1.0-windows-amd64.tar.gz

