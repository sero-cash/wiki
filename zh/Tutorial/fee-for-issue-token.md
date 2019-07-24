# SERO发行匿名Token的费用说明

### 为了不让币名被无意义的注册

- SERO共识机制会对每个成功的注册币名进行收费。
- 所收的SERO币由SERO基金会的支配。



### 所收的费用取决于币名的长度

- 长度 <= 3
  -  暂不开放 
-  长度 = 4
  - 1000 SERO
-  长度 = 5 
  - 10 SERO
- 长度 = 6
  - 1 SERO
- 长度 >= 7
  -  0.1 SERO



### 币名的规则

1. 只允许 大写字母 [A-Z]、数字 [0-9]、下划线 _
2. 不可包含SERO关键字
3. 必须以字母开头
4. 最长32个字节



### 付费方式

注册时添加value字段，附带费用。

```javascript
var serointerfaceContract = web3.sero.contract([{"co ... ... on"}]);
var serointerface = serointerfaceContract.new(
   {
     from: web3.sero.accounts[0], 
     data: '0x6080 ... ... 60029', 
     gas: '4700000',
     value: web3.toTa(1),                  // 6字币名 付费用 1 SERO
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })
```