# SERO Red Envelope DApp Development Summary

Recently (2020.04), the SERO Foundation organized a DApp Developer Contest. I  owned the SERO coin, and was concerned about the development of SERO, so I signed up to participate in this contest.

> SERO is world's first  Zero-Knowledge Proof based Privacy Protection platform for Decentralised applications which supports Turing Complete Smart Contract distributed infrastructure.

The SERO Smart Contract is developed in the language of Solidity. If you have not been familiar to this language before, you need to learn Solidity. The reference tutorial is available at https://solidity-cn.readthedocs.io/zh/develop/index.html A programmer with static language experience can grasp the grammar simply by going through the documentation, focusing on the need to look at some noun explanations, as well as a few examples.

After understanding the Solidity language, you have to decide about what kind of DAPP you want to make. I decided that i'll  make a DAPP that sends SERO or Token Red Envelopes on the SERO chain. It is can be used to  liven up the group atmosphere or someone can use them.

When it was officially developed, I wrote the contract first. At the beginning, I wrote it directly at http://remix.web.sero.cash/#optimize=true&version=builtin, because debugging is convenient, and it is easy to remove errors.

The following summarizes some of the problems encountered during the development of DAPP:

### How to share the Red Envelope?

First, the Red Envelope information is stored in an array

```solidity
Package[] private packages;
```

If you want to directly share the ID of the Red Envelope, this will definitely not work. The user can identify all the Red Envelope IDs and each Red Envelope randomly generates a code (password). This may lead to repetitive coding and less efficient. Therefore, we need to use a coding method to encode numbers into fixed characters. I have learned about the hashids algorithm before, just in line with my own needs. On the internet, I did not have the implementation version of Solidity. Fortunately, the algorithm is simple. I implemented one of my own, tested it, and met the requirements.

Example：

```solidity
string memory hash = hashids.encode(1000000);//hash encoded as a string similar to Sh23xR
```

When done in this way, you only need to share the password of `Sh23xR` and that's it.

### The Red Envelope is sent directly to the user's wallet or record the user's balance, and then the user can withdraw.

The Red Envelope DAPP needs to charge a certain handling fee. If you grab the Red Envelope and send it directly to the user's wallet, you will need a handling fee for each transaction. This will cause the user to receive a certain different amount and the user the may get a very small amount of money, there may not be enough fees. So after careful consideration, the final design is to grab the amount of money, record the user's fund balance in the contract, and then charge a certain fee when the user withdraws the money. The recommended method in the Solidity document is also to use the withdrawal mode in the contract, as described in：[https://solidity-cn.readthedocs.io/zh/develop/common-patterns.html#withdrawal-pattern](https://solidity-cn.readthedocs.io/zh/develop/common-patterns.html#withdrawal-pattern)

Code shown as below：

```solidity
struct BalanceInfo {
    uint256 balance; //Balance
    uint256 send; //Issued
    uint256 sendNums; //Amount Issued
    uint256 get; //Grabbed
    uint256 getNums; //Number of Grabs
    uint256 getMax; //Grabbed the Biggest
}

//List of tokens grabbed by users
struct UserCurrency {
    mapping(string => bool) exists;
    string[] currency;
}

//User's Red Envelope Balance: Address => Token => Balance Information
mapping(address => mapping(string => BalanceInfo)) private balances;
mapping(address => UserCurrency) private userCurrencyList;
```

### Need to restrict the call permissions of certain functions

For example, to add a Token that supports sending, you need to restrict the contract owner to invoke the function. The general method here is to create a `onlyOwner` `modifier` and then apply it to the corresponding function. The code is as follows:

```solidity
contract Ownable {
    address public owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() internal {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}


function addToken(
    uint8 decimals,
    uint64 weight,
    uint256 fees,
    uint256 minWithdrawAmount,
    uint256 minSendAmount,
    string memory currency
) public onlyOwner { //这里使用了 onlyOwner modifier
    TokenConfig storage item = tokenMap[currency];

    if (bytes(item.currency).length == 0) {
        tokens.push(currency);
    }
    item.decimals = decimals;
    item.fees = fees;
    item.weight = weight;
    item.minWithdrawAmount = minWithdrawAmount;
    item.minSendAmount = minSendAmount;
    item.currency = currency;
}
```

### You need to verify the user's input, especially whether the user's entered Token is required by this function

This kind of checking is definitely indispensable, we must check whether the user's input information meets the requirements. For example, when sending Red Envelope, it is checked whether this Token is supported and whether the amount sent is >=1

```solidity
//Check if this Token is supported in Red Envelope
require(
    bytes(tokenMap[currency].currency).length != 0,
    "Unsupported token"
);
//Check if the amount sent is >=1
require(nums >= 1, "nums error");
```

**Whether the user's entered Token is required by this function**

When sending Red Envelopes, you need to choose what currency to send and then pay the corresponding amount. If the currency name is passed from the front end, the contract must strictly check that the currency name and the currency received in the contract are the same.

```solidity
//Red Envelope
function createPackage(
    uint8 typ,
    uint64 nums,
    string memory currency,//User-selected currency name
    string memory note,
    string memory cover,
    uint8 whoCanOpen
) public payable {
    // sero_msg_currency()This is the currency name received by the contract, it must be checked whether it is same, otherwise the user may construct the call by himself, and the actual currency sent is not the required currency.
    bool isMsgCurrency = Strings.equals(
        Strings.toSlice(sero_msg_currency()),
        Strings.toSlice(currency)
    );
    require(isMsgCurrency, "sero msg currency error");
}
```

After the contract is basically completed, it is time to write the front-end interface. I am familiar with front-end single-page framework Vue, and the UI framework is Bootstrap, so it is based on these two to build a Red Envelope page.

After the page is built, the integration of the front end and the contract begins. The Internet applications that everyone knows about are all running server applications, and pages and servers obtain data through HTTP requests. DAPP is also very similar, except that the server is replaced with a smart contract, and interaction with the smart contract only requires the SDK provided by SERO (serojs and seropp).

The two most common methods to use serojs and seropp are seropp.call and seropp.executeContract.

seropp.call is mainly used to query contract data, which can be encapsulated according to the tutorial provided on Wiki. The sample code is as follows:

```solidity
  callMethod(_method, _args) {
    let packData = contract.packData(_method, _args);
    let callParams = {
      from: this.app.account.MainPKr,
      to: contractAddress,
      data: packData,
    };

    return new Promise((resolve, reject) => {
      seropp.call(callParams, function(callData) {
        if (callData !== "0x") {
          try {
            let res = contract.unPackData(_method, callData);
            resolve(res);
          } catch (err) {
            reject(err);
          }
        } else {
          reject("0x0");
        }
      });
    });
  },
```

### Problems encountered by seropp.call: serojs decoding contract return data does is not decoded by tuple type

Since the return value in the contract uses struct or struct[], for example, the following token list function returns a TokenConfig[]
```solidity
    function tokenList() public view returns (TokenConfig[] memory result) {
        result = new TokenConfig[](tokens.length);

        for (uint256 i = 0; i < tokens.length; i++) {
            TokenConfig memory token = tokenMap[tokens[i]];
            result[i] = token;
        }
    }
```

It can be normally run and returned in http://remix.web.sero.cash/, but using serojs will report an error and prompt: `Error: invalid solidity type!: tuple[]`，It is indeed very convenient to directly return the struct[] form, otherwise you have to return the corresponding list of fields, which would add a lot of code and make it hard to read. So I checked the information and found [web3-eth-abi](https://web3js.readthedocs.io/en/v1.2.0/web3-eth-abi.html) this library and tried to change the serojs, can parse the tuple normally. Mainly changed `serojs/lib/abi/index.js` in `ContractFactory.prototype.unPackData` function and `serojs/lib/abi/contract/function.js` in `SolidityFunction.prototype.toPayload`、`SolidityFunction.prototype.signature`，the changes are as follows：

```solidity
// serojs/lib/abi/index.js
var Web3EthAbi = require('web3-eth-abi');
ContractFactory.prototype.unPackData = function (method, outData) {
    // console.log("unPackData:",method,outData)
    // abi.encodeFunctionSignature('Error(string)') 0x08c379a0
    if (outData.substr(0, 10) == '0x08c379a0') {
        throw Web3EthAbi.decodeParameter('string',outData.substr(10))
    }
    var result = this.abi.filter(function (json) {
        return json.type === 'function' && json.name === method;
    }).map(function (json) {
        return Web3EthAbi.decodeParameters(json.outputs, outData);
    })[0];
    return result;
}

// serojs/lib/abi/contract/function.js
SolidityFunction.prototype.toPayload = function (args) {
    var options = {};
    if (args.length > this._inputTypes.length && utils.isObject(args[args.length -1])) {
        options = args[args.length - 1];
    }
    // this.validateArgs(args);
    // this.validateAddress(args);
    var rand = this.getRand();
    var prefix = coder.addressPrefix(this._inputTypes, args, rand);

    options.to = this._address;
    // options.data = prefix + this.signature() + coder.encodeParams(this._inputTypes, args);
    this._inputs.forEach((value,index) => {
        if (value.type == 'address') {
            args[index] = "0x" + coder.encodeParams(["address"], [args[index]]).substr(-40)
        }
    })
    options.data = prefix + this.signature() + Web3EthAbi.encodeParameters(this._inputs, args).slice(2);

    return options;
};

SolidityFunction.prototype.signature = function () {
    return Web3EthAbi.encodeFunctionSignature(this._json).slice(2, 10);
};

```

Specific changes can be referred to https://gitee.com/anonymous2020/sero-redpackage/tree/master/serojs

seropp.executeContract  mainly used to send transactions (modify contract data)

### Solidity Version Issue

When I first started developing contracts on remix, I used 0.4.25 and there were no problems. A function was added later, and the contract was deployed unsuccessful. The problem appears in `bool isFriend = friends[p.owner].map[msg.sender];` this line of code, but this line of code found no problems, and it can be successfully deployed on remix. But the contract is not deployed successfully, checked SERO also supports the Solidity of version 0.5.0。So I compiled a 0.5.17 version of solc locally, and changed the version number of all sols to `pragma solidity ^0.5.0;` and successfully deployed the contract after recompiling. In the future, I do not have to use the remix development contract (remix development sometimes gets stuck), and replaced it with Visual Studio Code and local solc deployment.

```solidity
    function checkCanOpen(Package memory p) private view returns (bool) {
        bool isFriend = friends[p.owner].map[msg.sender];
        bool isOwner = p.owner == msg.sender;
        bool canOpen = isFriend || isOwner;

        return canOpen;
    }
```

### Points to note on the interface

Since the transaction on chain takes a certain amount of time to complete, after the transaction is submitted, the user can be prompted on page (the transaction has been submitted, waiting for block confirmation), it is best to have a loading animation, and at the same time user can query the status of the transaction in the background. If the transaction is successful, cancel the loading animation and prompt the user that the operation was successful.

SERO Red Envelope Open Source Address：
https://gitee.com/anonymous2020/sero-redpackage

Use the SERO mobile phone POPUP wallet to find the SERO Red Envelope DAPP to experience, or enter https://anonymous2020.gitee.io/sero-redpackage/  in the wallet url bar.
