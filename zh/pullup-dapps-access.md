# SERO pullup钱包 DApp接入文档

## 配置开发环境

- **需要下载的开发工具**
> 1. gero [点击下载](https://github.com/sero-cash/go-sero/releases)
> 2. pullup [点击下载](http://github.com/sero-cash/pullup)

- **请按以下步骤配置开发环境**
> 1. [下载最新的gero](https://github.com/sero-cash/go-sero/releases)，启动gero的开发环境，启动参数：
>  ```
> gero --dev --rpc --rpcport 8545 --rpccorsdomain "*" --rpcapi "sero,light,stake" --lightNode --gcmode archive --mineMode --exchange
>  ```
>2. [下载最新的pullup钱包](http://github.com/sero-cash/pullup)（**DApp开发仅支持pullup v0.1.7以上的版本**），并启动pullup钱包
>3. 设置本地gero的节点 : http://127.0.0.1:8545
> 3. 点击首页的 "backup" 按钮，打开数据目录
> 4. 关闭钱包
> 5. 删除 data 文件夹。**注意不要删除keystore文件**
> 6. 重启钱包

- **使用remix编写DApp的智能合约**
> 1. [http://remix.web.sero.cash](http://remix.web.sero.cash)

- **开发DApp需要的JS组件**
> 1. [pullup-js-sdk](https://github.com/sero-cash/pullup-js-sdk)
> 2. [sero-js](https://github.com/sero-cash/pullup-js-sdk)
> 3. [sero-web3](https://github.com/sero-cash/console)


## 开发示例
**1. 编写智能合约，学习solidity语法请参考 [https://solidity.readthedocs.io](https://solidity.readthedocs.io/)**
```
pragma solidity ^0.4.16;
contract HelloWorld {
    
    string public name;
    
    function setName(string _name) external{
        name = _name;
    }
    
    function sayHello() external view returns (string s){
        return strConcat("HelloWorld ," , name);
    }
    
    function strConcat(string _a, string _b) internal pure returns (string){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory ret = new string(_ba.length + _bb.length);
        bytes memory bret = bytes(ret);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++)bret[k++] = _ba[i];
        for (i = 0; i < _bb.length; i++) bret[k++] = _bb[i];
        return string(ret);
   }  
}
```
**2.部署合约**
注意：开发环境需要100块后才能 
连接gero控制台
```
> gero --datadir ~/Library/Sero/dev attach
```
**WEB3DEPLOY**
```
var helloworldContract = web3.sero.contract([{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_name","type":"string"}],"name":"setName","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"sayHello","outputs":[{"name":"s","type":"string"}],"payable":false,"stateMutability":"view","type":"function"}]);
var helloworld = helloworldContract.new(
   {
     from: web3.sero.accounts[0], 
     data: '0x608060405234801561001057600080fd5b506104a0806100206000396000f3006080604052600436106100565763ffffffff7c010000000000000000000000000000000000000000000000000000000060003504166306fdde03811461005b578063c47f0027146100e5578063ef5fb05b14610107575b600080fd5b34801561006757600080fd5b5061007061011c565b6040805160208082528351818301528351919283929083019185019080838360005b838110156100aa578181015183820152602001610092565b50505050905090810190601f1680156100d75780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100f157600080fd5b5061010560048035602481019101356101aa565b005b34801561011357600080fd5b506100706101bb565b6000805460408051602060026001851615610100026000190190941693909304601f810184900484028201840190925281815292918301828280156101a25780601f10610177576101008083540402835291602001916101a2565b820191906000526020600020905b81548152906001019060200180831161018557829003601f168201915b505050505081565b6101b6600083836103dc565b505050565b604080518082018252600c81527f48656c6c6f576f726c64202c000000000000000000000000000000000000000060208083019190915260008054845160026001831615610100026000190190921691909104601f8101849004840282018401909552848152606094610287949391929183018282801561027d5780601f106102525761010080835404028352916020019161027d565b820191906000526020600020905b81548152906001019060200180831161026057829003601f168201915b505050505061028d565b90505b90565b606080606080606060008088955087945084518651016040519080825280601f01601f1916602001820160405280156102d0578160200160208202803883390190505b50935083925060009150600090505b85518110156103555785818151811015156102f657fe5b90602001015160f860020a900460f860020a02838380600101945081518110151561031d57fe5b9060200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a9053506001016102df565b5060005b84518110156103cf57848181518110151561037057fe5b90602001015160f860020a900460f860020a02838380600101945081518110151561039757fe5b9060200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a905350600101610359565b5091979650505050505050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061041d5782800160ff1982351617855561044a565b8280016001018555821561044a579182015b8281111561044a57823582559160200191906001019061042f565b5061045692915061045a565b5090565b61028a91905b8082111561045657600081556001016104605600a165627a7a72305820259a99f312189f0bfd7a1c8292c4757bcb30c96a6d59495b4977b1a85f20dc460029', 
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })
```
启动挖矿
```
>miner.start(1)
```
当看到以下信息，则表示智能合约发布成功，记下技能合约的 **Contract Address** 和 **ABI**
```
Contract mined! address: 54ZJqe8orGqAucdFqcZRupMa1WFeL6e5raCUw7FcBit9G9GZ5JFHXhNEKkhBPWRDEf1kDRLbX3qiPqSJ5H5Kasit transactionHash: 0x8fee3e10e16c762d42614f317df0b0574658ecb3cca8199b022aa41f50ca5892
```

**3.新建DApp工程，本文使用react开发**

```
> create-react-app dapp-hello
> yarn add pullup-js-sdk serojs
```
导入工具包
```
import Pullup from 'pullup-js-sdk'
import serojs from 'serojs'
import abi from './ABI'
import BigNumber from 'bignumber.js'
```
初始化pullup provider
```
let pullup = new Pullup();
pullup.setProvider(new pullup.providers.HttpProvider('http://127.0.0.1:2345'));
```
定义contract
```
let contractAddress = "54ZJqe8orGqAucdFqcZRupMa1WFeL6e5raCUw7FcBit9G9GZ5JFHXhNEKkhBPWRDEf1kDRLbX3qiPqSJ5H5Kasit";
let contract = serojs.callContract(abi, contractAddress);
```
执行智能合约方法
```
execute(method, args) {
        let that = this;
        try{
            let packData = contract.packData(method, args);
            let executeData = {
                from: that.state.fromPKr,
                to: contractAddress,
                value: "0x0",//SERO
                data: packData,
                gas_price: "0x"+new BigNumber("1000000000").toString(16),
            };
            executeData["gas"] = pullup.sero.estimateGas(executeData);
            let res = pullup.local.executeContract(executeData);

            return res;
        }catch (e) {
            alert(e.message);
        }
    }
```
调用智能合约方法
```
call(method, args) {
        let that = this;
        try{
            let packData = contract.packData(method, args);
            let callParams = {
                from: that.state.fromPKr,
                to: contractAddress,
                data: packData
            }
            console.log(callParams);
            let callData = pullup.sero.call(callParams, "latest");
            if (callData !== "0x") {
                let res = contract.unPackData(method, callData);
                return res;
            }
            return "";
        }catch (e) {
            alert(e.message);
        }
    }
```
在根目录新建 dapp.json文件
```
{
  "img": "http://localhost:3000/logo192.png",
  "title": "Say Hello",
  "desc": "Say Hello Demo",
  "author": "tom",
  "url": "http://localhost:3000",
  "state": 1
}
```
**Say Hello Demo 演示：**
Set Name: 
![3381568724750_.pic_hd.jpg](https://upload-images.jianshu.io/upload_images/13141677-d0d8f547d73e85ec.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![3361568724686_.pic.jpg](https://upload-images.jianshu.io/upload_images/13141677-1a835a58a32afd7e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Say Hello
![3371568724722_.pic.jpg](https://upload-images.jianshu.io/upload_images/13141677-868cd0cb4f1245ad.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

添加DApp
![3391568726149_.pic_hd.jpg](https://upload-images.jianshu.io/upload_images/13141677-63ec442509180b63.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![3401568726217_.pic_hd.jpg](https://upload-images.jianshu.io/upload_images/13141677-a32fafbe6493c0b8.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


## 相关资料：
>- [从源码开始——基于CENTOS7](https://wiki.sero.cash/zh/index.html?file=Start/from-the-sourcecode-base-on-centos7)
>- [pullup钱包使用教程](https://wiki.sero.cash/zh/index.html?file=Start/how-to-use-pullup-pc-wallet)
>- [匿名Token发行原理](https://wiki.sero.cash/zh/index.html?file=Tutorial/principle-of-anonymous-token)
>- [匿名Token发行实战](https://wiki.sero.cash/zh/index.html?file=Tutorial/practice-of-anonymous-token)
>- [发行匿名Token的费用](https://wiki.sero.cash/zh/index.html?file=Tutorial/fee-for-issue-token)
