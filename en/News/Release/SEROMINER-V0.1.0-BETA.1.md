# ProgPow GPU mining compatibility test



**This release is used to test progpow compatibility. Miners participating can test their GPU hashrate in the official pool.**

Since the GPU's hashrate is high, please connect to the pool use stratum protocol.

[serominer download](https://github.com/sero-cash/serominer/releases/tag/v0.1.0-beta.1)
<https://github.com/sero-cash/serominer/releases/tag/v0.1.0-beta.1>

## Parameter setting:
```sh
serominer.exe -P stratum1+tcp://[YOUR COLLECT ADDRESS].[YOUR HOST NAME]@129.204.197:8010 [-U] [-G] [--cuda-devices=0 1 2] [--opencl-devices=1 2]

-U                     use CUDA 10.0 (Nvidia recommend)
--cuda-devices=0 1 2   only use 0,1,2 cards for CUDA

-G                     use OpenCL (support AMD and Nvidia cards）
--opencl-devices=0 1 2 only use 0,1,2 cards for OpenCL
```


## For Nvidia Cards:
```sh
serominer.exe -P stratum1+tcp://4ujQrFsaYqMugcBCiqKyJyTYpzA35TkmobaSVNru3ubTuhHPzYqdeJdk4V8pcnLhWNu2WCrznJhHqWZzxtnqgTsL.opencl_worker@129.204.197.105:8018 -U
```

## For OpenCL(AMD) Cards:
```sh
serominer.exe -P stratum1+tcp://4ujQrFsaYqMugcBCiqKyJyTYpzA35TkmobaSVNru3ubTuhHPzYqdeJdk4V8pcnLhWNu2WCrznJhHqWZzxtnqgTsL.cuda_worker@129.204.197.105:8018 -G
```