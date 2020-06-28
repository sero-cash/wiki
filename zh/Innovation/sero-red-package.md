# SERO 红包 DAPP 开发总结

最近（2020.04） SERO 基金会组织了开发者大赛，由于自己本身持有 SERO 币，对 SERO 的发展也一直保持关注，于是报名参加了这次比赛。

> SERO 是全球首创的，基于零知识证明技术实现的隐私币，并且能支持图灵完备智能合约运行的区块链基础设施平台。

SERO 智能合约使用 Solidity 语言开发，由于之前没接触过这门语言，所以首先还需要学习 Solidity，参考的教程是 [https://solidity-cn.readthedocs.io/zh/develop/index.html](https://solidity-cn.readthedocs.io/zh/develop/index.html) 语言难度并不大，有静态语言经验的程序员基本过一遍文档就能掌握语法，着重需要看一下一些名词解释，以及里面的几个例子。

Solidity 语言大概了解了一番之后，就得想一想做一个什么 DAPP 了，想来想去就想到了做一个发 SERO 或者 SERO 链上 Token 红包的 DAPP，主要是可以用来活跃群气氛，还是有人会使用的。

正式开发的时候，我是先写的合约，最开始是直接在 http://remix.web.sero.cash/#optimize=true&version=builtin 写，因为调试方便，排除错误很容易。

下面总结下开发 DAPP 过程中遇到的一些问题：

### 发了红包怎么分享出去

首先红包的信息是存在一个数组里面的

```solidity
Package[] private packages;
```

要直接分享红包的 ID 这样肯定不行，用户可以枚举出所有的红包 ID，每个红包随机生成一个编码（口令）？这样可能会出现编码重复，效率也不太好。所以需要用一种编码方法可以将数字编码成固定的字符，之前了解过 hashids 这个算法，刚好符合自己的需求，网上找了下，居然没有 Solidity 的实现版本，好在算法简单，自己实现了一个，测试了一下，满足需求。

示例：

```solidity
string memory hash = hashids.encode(1000000);//hash 被编码成了类似 Sh23xR 的字符串
```

这样分享的时候，只需要分享 `Sh23xR` 这个口令就好了。

### 抢了红包是直接发送到用户钱包还是记录用户余额，然后用户提现

红包 DAPP 需要收取一定的手续费，如果抢了红包直接发送到用户钱包，那么每笔都需要手续费，这就会造成用户收到的金额跟抢到的金额有一定差距，而且用户有可能抢到极少的金额，可能都不够手续费。所以仔细思考后，最终设计成了抢到的金额，在合约内部记录用户的资金余额，然后用户提现的时候收取一定的手续费。solidity 文档中的推荐方式也是在合约中使用取回（withdrawal）模式，详见：[https://solidity-cn.readthedocs.io/zh/develop/common-patterns.html#withdrawal-pattern](https://solidity-cn.readthedocs.io/zh/develop/common-patterns.html#withdrawal-pattern)

代码如下：

```solidity
struct BalanceInfo {
    uint256 balance; //余额
    uint256 send; //发出的
    uint256 sendNums; //发出的数量
    uint256 get; //抢到的
    uint256 getNums; //抢到的数量
    uint256 getMax; //抢到的最大
}

//用户抢到的 Token 列表
struct UserCurrency {
    mapping(string => bool) exists;
    string[] currency;
}

//用户的红包余额：地址=>Token=>余额信息
mapping(address => mapping(string => BalanceInfo)) private balances;
mapping(address => UserCurrency) private userCurrencyList;
```

### 需要限制某些函数的调用权限

比如说添加支持发送的 Token，需要限制只能合约 owner 才能调用此函数。这里一般的做法创建一个 `onlyOwner` 的 `modifier` 然后作用于对应的函数上即可。代码如下：

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

### 需要检验用户的输入，特别是用户的输入 Token 是否是此函数要求的

这种检查肯定是不可少的，一定要检查用户的输入信息是否符合要求。比如在发红包时，就检查了是否支持此 Token 和发送的数量是否>=1

```solidity
//检查了是否支持此 Token 红包
require(
    bytes(tokenMap[currency].currency).length != 0,
    "Unsupported token"
);
//检查发送的数量是否>=1
require(nums >= 1, "nums error");
```

**用户的输入 Token 是否是此函数要求的**

发送红包时，需要选择发送的是什么币，然后支付对应的金额。如果发送的币名由前端传入，在合约中一定要严格检查传入币名和合约中收到的币种是否一致。

```solidity
//发红包
function createPackage(
    uint8 typ,
    uint64 nums,
    string memory currency,//用户选择的币名
    string memory note,
    string memory cover,
    uint8 whoCanOpen
) public payable {
    // sero_msg_currency()是合约收到的币名，一定要判断是否相等，否者用户可能自己构造调用，发送过来的实际不是要求的币种
    bool isMsgCurrency = Strings.equals(
        Strings.toSlice(sero_msg_currency()),
        Strings.toSlice(currency)
    );
    require(isMsgCurrency, "sero msg currency error");
}
```

合约基本完成后，就是开始写前端界面了。自己熟悉的前端单页框架是 Vue， UI 框架是 Bootstrap，所以就是基于这 2 个来搭建红包页面了。

页面搭建完成后，就开始前端与合约的集成了。现在大家所熟知的互联网应用，都是有服务器应用在运行着，页面和服务端通过 HTTP 请求来获取数据。DAPP 也很类似，只不过这里的服务端换成了智能合约，跟智能合约交互只需要使用 SERO 提供的 SDK 就可以了（serojs 和 seropp）。

使用 serojs 和 seropp ，最常用的 2 个方法就是 seropp.call 和 seropp.executeContract 。

seropp.call 主要用来查询合约数据，可以按照 wiki 提供的教程，封装一下。示例代码如下：

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

### seropp.call 遇到的问题：serojs 解码合约返回数据未实现 tuple 类型解码

由于在合约里面返回值使用了 struct 或 struct[]，例如下面这个 token 列表函数,返回了一个 TokenConfig[]

```solidity
    function tokenList() public view returns (TokenConfig[] memory result) {
        result = new TokenConfig[](tokens.length);

        for (uint256 i = 0; i < tokens.length; i++) {
            TokenConfig memory token = tokenMap[tokens[i]];
            result[i] = token;
        }
    }
```

在 http://remix.web.sero.cash/ 中是可以正常运行和返回的，但是使用 serojs ，会报错，提示：`Error: invalid solidity type!: tuple[]`，直接返回 struct[] 这种形式确实会很方便，不然就得返回对应的字段列表，这样代码增加许多，同时也很难阅读。所以去查了下资料，发现了 [web3-eth-abi](https://web3js.readthedocs.io/en/v1.2.0/web3-eth-abi.html) 这个库，自己试着改了下 serojs，可以正常解析 tuple，主要是改动了 `serojs/lib/abi/index.js` 中的 `ContractFactory.prototype.unPackData` 函数 和 `serojs/lib/abi/contract/function.js`中的 `SolidityFunction.prototype.toPayload`、`SolidityFunction.prototype.signature`，改动如下：

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

具体改动可以参考 https://gitee.com/anonymous2020/sero-redpackage/tree/master/serojs

seropp.executeContract 主要用来发送交易（修改合约数据）

### Solidity 版本问题

最开始在 remix 开发合约时，一直用的 0.4.25，没有出现什么问题，后面增加了一个函数，合约始终部署不成功。问题出现在 `bool isFriend = friends[p.owner].map[msg.sender];` 这行代码，可是这行代码没发现问题，在 remix 上也能成功部署。但是合约就是部署不成功，查了下 SERO 也支持 0.5.0 版本的 solidity。于是自己在本地编译了个 0.5.17 版本的 solc，把所有 sol 的版本号也改成了 `pragma solidity ^0.5.0;` 重新编译后成功部署合约。后续也没有在使用 remix 开发合约了（remix 开发有时候会卡主），换成了用 Visual Studio Code 和本地 solc 部署。

```solidity
    function checkCanOpen(Package memory p) private view returns (bool) {
        bool isFriend = friends[p.owner].map[msg.sender];
        bool isOwner = p.owner == msg.sender;
        bool canOpen = isFriend || isOwner;

        return canOpen;
    }
```

### 界面上需要注意的点

由于链上交易需要一定的时间来完成，所以交易提交后，可以在页面提示用户（交易已提交，正在等待区块确认之类的提示），最好能有一个加载动画，同时可以在后台查询交易的状态，如果交易成功，取消加载动画，同时提示用户操作成功。

SERO 红包开源地址：
https://gitee.com/anonymous2020/sero-redpackage

使用 SERO 手机 Popup 钱包找到 SERO 红包 DAPP 即可体验、或在钱包输入 https://anonymous2020.gitee.io/sero-redpackage/ 体验



**本文章由“希望之石”编写**
