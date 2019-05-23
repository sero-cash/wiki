# ProgPow GPU 挖矿兼容性测试

**本发布用来测试progpow的兼容性，参与测试的矿工可以在官方矿池中测试自己GPU的算力。**

由于GPU的hashrate较高，所以请用startum协议连接矿池。

**本次测试目的是测试serominer的兼容性，使GPU矿工能更顺利的切换到即将到来的progpow算法上，并无贡献奖励。**

[serominer 下载](https://github.com/sero-cash/serominer/releases/tag/v0.1.0-beta.1)
<https://github.com/sero-cash/serominer/releases/tag/v0.1.0-beta.1>

## 参数

```sh
   serominer.exe -P stratum1+tcp://[你的收款地址].[显示在矿池的名称]@129.204.197:8010 [-U] [-G] [--cuda-devices=0 1 2] [--opencl-devices=1 2]
   -U                     启用CUDA (N卡推荐)
   --cuda-devices=0 1 2   启用第0、1、2块N卡
   
   -G                     启用OpenCL(A卡和N卡支持）
   --opencl-devices=0 1 2 启用第0、1、2块支持OpenCL的卡
```

**说明：**
   1. 如果机器是N卡的话，请按照cuda10.0的驱动，通常情况下，只需要设置 -U， Nivida 对 OpenCL 的支持较弱。
   2. 如果机器是A卡的话，通常情况下，需要设置-G，设置--opencl-devices将集成显卡过滤掉。

目前测试情况，集成显卡基本不能流畅的挖矿。


## N卡矿工例子
```sh
serominer.exe -P stratum1+tcp://4ujQrFsaYqMugcBCiqKyJyTYpzA35TkmobaSVNru3ubTuhHPzYqdeJdk4V8pcnLhWNu2WCrznJhHqWZzxtnqgTsL.opencl_worker@129.204.197.105:8018 -U
```

## A卡矿工例子
```sh
serominer.exe -P stratum1+tcp://4ujQrFsaYqMugcBCiqKyJyTYpzA35TkmobaSVNru3ubTuhHPzYqdeJdk4V8pcnLhWNu2WCrznJhHqWZzxtnqgTsL.cuda_worker@129.204.197.105:8018 -G
```