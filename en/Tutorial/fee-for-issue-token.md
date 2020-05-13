# SERO Fee for Issuing Anonymous Tokens

### In order to limit meaningless token names to be registered

- The SERO Consensus Mechanism charges each successful registered token name.
- The SERO coins received will go the SERO Foundation.

### The fee charged depends on the length of the anonymous token  

- length <= 3
  - Not eligible yet
- length = 4
  - 1000 SERO
- length = 5
  - 10 SERO
- length = 6
  - 1 SERO
- length >= 7
  - 0.1 SERO

### Rules for Anonymous Token names

1. Only uppercase letters [A-Z], numbers [0–9], underscores _
2. Cannot contain “SERO” as keywords
3. Must start with a letter
4. Up to 32 bytes

### Payment methods
Add a value field when registering with a fee.

```javascript
var serointerfaceContract = web3.sero.contract([{"co ... ... on"}]);
var serointerface = serointerfaceContract.new(
  {
    From: web3.sero.accounts[0],
    Data: '0x6080 ... ... 60029',
    Gas: '4700000',
    Value: web3.toTa(1), // 6 word name fee 1 SERO
  }, function (e, contract){
    Console.log(e, contract);
    If (typeof contract.address !== 'undefined') {
      Console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
})
```