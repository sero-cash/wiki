# SERO Popup decentralized mobile phone light wallet DApp access tutorial

## Introduction

SERO Popup Wallet is a decentralized mobile phone wallet, divided into three versions: IOS, Android, and browser. It manages the rich asset form of the SERO ecosystem and supports the import of mnemonics from the Pullup wallet. The Popup wallet will be the main entry point for various decentralized applications on the SERO in the future.

## Install

* IOS
     * **Use WebApp**
         * Open the link in the browser
             * [http://popup.sero.cash](http://popup.sero.cash/)
         * Click the [Share] button below
         * Click [Add to Home Screen]
     * **Installation using TestFlight**
         * Install Apple's official Beta test tool [TestFlight] (https://itunes.apple.com/cn/app/testflight/id899247664?mt=8)
         * Open the Popup installation link in your browser
             * [https://testflight.apple.com/join/cGWEPyC7] (https://testflight.apple.com/join/cGWEPyC7)
* Android
     *   Download and install
         * [https://sero-media.s3-ap-southeast-1.amazonaws.com/popup/sero_popup_v1.0.apk](https://sero-media.s3-ap-southeast-1.amazonaws.com /popup/sero_popup_v1.0.apk)
* Browser
     * Open [http://popup.sero.cash](http://popup.sero.cash/)
     
## Get started

### 1. Configuring the development environment

- Open with the Crome browser: http://popup.sero.cash/
- New account
- In "My" - "Settings" - "Node Settings", set the gero node, this example uses: [http://127.0.0.1:8545](http://127.0.0.1:8545)

### 2. Developing smart contracts

- IDE:  [https://remix.web.sero.cash/](https://remix.web.sero.cash/)
- Source: 

```
pragma solidity ^0.4.16;

contract HelloDapp {
    
    string public name;
    string public message;
    
    constructor() public{
        name = "Tom";
        message = "Hello";
    }
    
    function say(string _name,string _msg) public {
        name = _name;
        message = _msg;
    }
    
    function sayHello() public view returns (string){
        var a = stringAdd(name," say ");
        return stringAdd(a,message);
    }
    
    function stringAdd(string a, string b) returns(string){
        bytes memory _a = bytes(a);
        bytes memory _b = bytes(b);
        bytes memory res = new bytes(_a.length + _b.length);
        for(uint i = 0;i < _a.length;i++)
            res[i] = _a[i];
        for(uint j = 0;j < _b.length;j++)
            res[_a.length+j] = _b[j];  
        return string(res);
    }
}
```

### 3. Create a new `DApp` project (this tutorial uses `react` development)

- Install development components

```
create-react-app hello-dapp
cd hello-dapp
npm install
npm install sero-pp serojs bignumber.js sero-web3
npm run start
```

- - Modify App.js to import components

```
import serojs from 'serojs'
import seropp from 'sero-pp'
import Web3 from 'sero-web3'
import BigNumber from 'bignumber.js'
```

- Initialize the DApp information


```
const dapp = {
            name: "Hello DApp",
            contractAddress: contractAddress,
            github: "https://github.com/sero-cash/sero-pp/example",
            author: "tom",
            url: "http://127.0.0.1:3000",
            logo: "http://127.0.0.1:3000/logo192.png",
        }

seropp.init(dapp,function (rest) {
    console.log("init result >>> " , rest);
})
```

### 4. Debugging

- 在Popup钱包中，打开“应用” ,输入DApp的地址

![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-3cbed5aa9cca490a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- Core method

```
// Method of calling a smart contract (do not send a transaction)
callMethod(_method, _args, callback) {
        let that = this;
        // let param = [ABI, contractAddress, _method, args]

        let packData = contract.packData(_method, _args);
        let callParams = {
            from: that.state.accounts[0].MainPKr,
            to: contractAddress,
            data: packData
        }

        seropp.call(callParams,function (callData) {
            if(callData !== "0x"){
                let res = contract.unPackData(_method, callData);
                if (callback){
                    callback(res);
                }
            }else{
                callback("0x0");
            }
        });
    }

// Method of executing a smart contract (sending a transaction)
executeMethod(_method, args, value, cy, callback) {
        let that = this;

        let packData = contract.packData(_method, args);
        let executeData = {
            from: that.state.accounts[0].PK,
            to: contractAddress,
            value: "0x"+value,//SERO
            data: packData,
            gasPrice: "0x"+new BigNumber("1000000000").toString(16),
            cy:cy,
        };
        let estimateParam = {
            from: that.state.accounts[0].MainPKr,
            to: contractAddress,
            value: "0x"+value,//SERO
            data: packData,
            gasPrice: "0x"+new BigNumber("1000000000").toString(16),
            cy:cy,
        }
        seropp.estimateGas(estimateParam,function (gas) {
            executeData["gas"] = gas;
            seropp.executeContract(executeData,function (res) {
                if (callback) {
                    callback(res)
                }
            })
        });
    }
```

- load account

```
getAccountList = ()=>{
        let that = this;
        seropp.getAccountList(function (rest) {
            that.setState({
                accounts:rest
            })
        })
    }
```

- load contract

```
load = () => {
        let that = this;
        this.callMethod("name","",function (rest) {
            that.setState({
                name:rest
            })
        })

        this.callMethod("msg","",function (rest) {
            that.setState({
                msg:rest
            })
        })

        this.callMethod("sayHello","",function (rest) {
            that.setState({
                say:rest
            })
        })

        let balance = web3.sero.getBalance(contractAddress, "latest");
        console.log("balance:: ",balance);
    }
```

- execute contract

```
execute = () => {
        let name = document.getElementById("name").value;
        let msg = document.getElementById("msg").value;
        this.executeMethod("say",[name,msg],0,"SERO",function (res) {
            alert("transaction submit successful. hash :"+res);
        })
    }
```

### 5. DEMO Download [https://github.com/sero-cash/sero-pp/tree/master/example/hello-dapp](hello-dapp)

- Hello Dapp Home page

![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-11672b169285cb3e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- Load account

![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-c499af2e0a5c45bb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- Load contract and execute contract

![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-f0958f64e3c9a841.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- Confirm transaction information (components of SERO Popup, no separate development required)

![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-f56b53c5a2021b16.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- Popup password input box (component of SERO Popup, no need to develop separately)

![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-97e1321a827b6b67.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### Reference material

>- **sero-pp** [https://github.com/sero-cash/sero-pp/](https://github.com/sero-cash/sero-pp/)
