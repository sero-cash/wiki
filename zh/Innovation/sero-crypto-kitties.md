# 如何以DApp的方式实现匿名版的以太猫


`Super Zero` `sero` `zpk` `zero-knowledge-proofs` `blockchain` `confidential transactions` `nizk` `anonymous tokens` `super-zk` `smart contracts` `crypto kitties`

### 现在区块链开发平台的隐私保护问题

我们现在基本都知道以太坊是一个区块链应用开发平台，基于以太坊构建的网络和智能合约语言，我们可以实现各种各样的与现实世界接近的分布式应用（DApp）。这种基于智能合约实现去中心化的分布式应用固然是一种创新，但不觉又引发了市场对信息安全的担忧。目前通过[以太坊区块浏览器](https://etherscan.io/)很容易就能追溯一个账号的所有交易情况，以及该账户资金情况等，这基本上没有任何门槛，只要你能上网就能分析一个账号的资金流向，以及持币等情况，这对个人来说毫无隐私可言。

### SERO：世界上首个支持智能合约的匿名公链

目前门罗币（Monero），达世币（DASH）以及大零币（Zcash）等热门的匿名区块链技术。虽然都能匿名起到隐私保护的作用，但是它们都不支持智能合约，无法用来开发DApp。超零协议（[SERO](https://sero.cash)）[[白皮书](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/Sero_ENG_V1.06.pdf)]的公链，是个支持图灵完备智能合约的匿名公链，采用零知识证明实现隐私保护技术，并且已经发布beta版本。SERO似乎是隐私保护的一个完美方案，并且可以在其上开发匿名的DAPP。

### 以太坊上的以太猫程序概述

[以太猫](https://github.com/cryptocopycats/awesome-cryptokitties)应该是以太坊迄今为止最成熟，最成功的Dapp。它在很短的时间内造成了以太坊的交易拥堵。以太猫是按照ERC721开发的，智能合约代码大约两千行，源码在github上有开源，并且也可以在[以太坊区块浏览器](https://etherscan.io/)中找到。

以太猫程序包括了七个主程序：
1、**KittyAccessControl**，这个合约管理只能由特定角色执行操作的各种地址和约束。这些角色叫CEO, CFO and COO。
2、**KittyBase**，这个合约定义在整个核心功能中共享的最基本代码的地方。这包括我们的主要数据存储，常量和数据类型，以及用于管理这些数据的内部函数。
3、**KittyOwnership**，这提供了遵循ERC-721规范草案的基本不可互换令牌交易所需的方法。
4、**KittyBreeding**，这个文件包含了将猫一起繁殖所必需的方法，包括跟踪繁殖提供者，并依靠外部基因组合合约。
5、**KittyAuctions**，在这里，有公开的方法来拍卖猫或招标猫或繁殖猫。实际的拍卖功能是在两个兄弟合约（一个用于买卖，一个用于繁殖）中处理的，而拍卖的创建和投标主要是通过核心合约。
6、**KittyMinting**，该合约包含用来创建新的gen0猫的功能
7、**KittyCore**，这是主要的CryptoKitties合约，编译和运行在以太坊区块链上。这份合约把所有东西联系在一起。

### 匿名版以太猫实现

按照SERO的DApp编程规范，可以实现一款匿名版以太猫的DApp。目前SERO支持"发行匿名票据"的功能已经发布，这个功能对应的就是以太坊ERC721协议，是实现以太猫的基础。

###### 票据(Ticket)相关接口定义

SERO团队部署了一个[Remix-ide](http://remix.web.sero.cash)的站点，其中有一个名为SeroInterface.sol的例子，主要是提供发布匿名token和ticket的接口，这些应该是系统接口，只要是想实行匿名就必须继承的。根据SERO团队提供的例子，在生成、转移Ticket的接口中必须包含系统定义好的日志Topic
```css
  /**
  * the follow topics is system topics,can not be changed at will
  */
  bytes32 private topic_sero_send           =  0x868bd6629e7c2e3d2ccf7b9968fad79b448e7a2bfb3ee20ed1acbc695c3c8b23;
  bytes32 private topic_sero_allotTicket    =  0xa6a366f1a72e1aef5d8d52ee240a476f619d15be7bc62d3df37496025b83459f;
  bytes32 private topic_sero_category       =  0xf1964f6690a0536daa42e5c575091297d2479edcc96f721ad85b95358644d276;
  bytes32 private topic_sero_ticket         =  0x9ab0d7c07029f006485cf3468ce7811aa8743b5a108599f6bec9367c50ac6aad;
```
从上面定义的topic来看每种类型的Ticket都必须有category属性，类似于ERC721中的syboml。

SeroInterface主要提供了以下几个接口是本次写匿名版以太猫需要用到的：

**1.生成ticketId，并将ticketId直接存入到个人账号中去.**
```css
  /**
   * @dev generate a tickeId and allot to the receiver address
   * @param _receiver receiving address of tickeId
   * @param _value  the seq of tickeId,can be zero. if zero the system ，the system randomly generates
   * @param _category the category of the ticket
   */
  function sero_allotTicket(address _receiver, bytes32 _value, string memory _category) internal returns (bytes32 ticket){
      bytes memory temp = new bytes(96);
      assembly {
          let start := temp
          mstore(start, _value)
          mstore(add(start, 0x20), _receiver)
          mstore(add(start, 0x40), _category)
          log1(start, 0x60, sload(topic_sero_allotTicket_slot))
          ticket := mload(add(start, 0x40))
      }
      return;
  }
```
**2.获取交易参数中的category**
```css
  /**
  * @dev the get category from the tx params
  */
  function sero_msg_category() internal returns (string) {
      bytes memory tmp = new bytes(32);
      bytes32 b32;
      assembly {
          log1(tmp, 0x20, sload(topic_sero_category_slot))
          b32 := mload(tmp)
      }
    return bytes32ToString(b32);
  }
```
**3.获取交易参数中的ticketId**
```css
 /**
  * @dev the get ticketId from the tx params
  */
  function sero_msg_ticket() internal returns (bytes32 value) {
      bytes memory tmp = new bytes(32);
      assembly {
          log1(tmp, 0x20, sload(topic_sero_ticket_slot))
          value := mload(tmp)
      }
      return;
  }
```
**4.将交易中的ticketId存入到接收方的个人账号**
```css
 /**
   * @dev transfer the tickeId to the receiver
   * @param _receiver the address of receiver
   * @param _category the category of ticket
   * @param _ticket the tickeId
   */
  function sero_send_ticket(address _receiver, string memory _category, bytes32 _ticket)internal returns (bool success){
      return sero_send(_receiver,"",0,_category,_ticket);
  }

  /**
  * @dev transfer the token or ticket to the receiver
  * @param _receiver the address of receiver
  * @param _currency the currency of token
  * @param _amount the amount of token
  * @param _category the category of the ticket
  * @param _ticket the Id of the ticket
  */
  function sero_send(address _receiver, string memory _currency, uint256 _amount, string memory _category, bytes32 _ticket) internal returns (bool success){
    bytes memory temp = new bytes(160);
    assembly {
      mstore(temp, _receiver)
      mstore(add(temp, 0x20), _currency)
      mstore(add(temp, 0x40), _amount)
      mstore(add(temp, 0x60), _category)
      mstore(add(temp, 0x80), _ticket)
      log1(temp, 0xa0, sload(topic_sero_send_slot))
      success := mload(add(temp, 0x80))
    }
    return;
}
```
继承SeroInterface的智能合约生成的ticketId将直接保存到个人账号中去，智能合约无需管理个人账号资产，因此当转移ticket的时候，ticketId和category必须通过交易参数传递，无法通过智能合约方法的参数传递，转移的ticketId最终也将直接存储到接收方的个人账号中去。弄清楚上面这几个SERO提供的接口后，以太猫的改动就很简单了，某种程度上在SERO上写以太猫会更简单，而且代码量应该会更少。

###### KittyBase

由于SERO上ticekId的数据类型全部变为bytes32,一次需要将KittyBase中所有ticketId的数据类型全部有uint32变成bytes32。
```css
  struct Kitty {
      bytes32 kittyId;
      uint256 genes;
      uint64 birthTime;
      uint64 cooldownEndBlock;
      bytes32 matronId;
      bytes32 sireId;
      bytes32 siringWithId;
      uint16 cooldownIndex;
      uint16 generation;
      address owner;
  }
```

kittyId的数据类型转变后，相应的一些数据接口也需要做调整，需要将KittyBase中的kittys由数组类型改成map
```css
 mapping(bytes32 => Kitty) kittys;
```
从[SERO的源码](https://github.com/sero-cash/go-sero)来看,做匿名交易的第一步就是匿名账号地址，所有交易中涉及的账号地址都被一次性地址给替换，所以之前的KittyBase中的sireAllowedToAddress修改为sireAllowedToTokenId。由tickeId到账号的映射修改为tickeId到ticketId的映射。
```css
  mapping (bytes32 => bytes32) public sireAllowedToTokenId;
```
删除kittyIndexToOwner、ownershipTokenCount两个属性，因为所有的ticekId最终都保存在个人账号中，因此无需智能合约来保存ticketId和账号之间的关系。

生成Kitty的时候在_createKitty方法中直接调用SeroInterface.sol中的sero_allotTicket方法生成kittyId并且将kittyId保存到owner的个人账号中去，无需调用一次_transfer方法。

###### KittyOwnership

由于通过智能合约创建的kittyId创建后就直接发送到个人账号中去了，因此该文件中无需ownerOf、tokensOfOwner这样的方法，只要你能够在你的个人账户中查询到并且能够通过交易参数将kittyId传递到智能合约中，就证明你这个账号拥有这个kittyId。因此该智能合约最终只有transfer和totalSupply两个方法。

因为本次是简单的尝试，很多地方从简了。删除了approve相关的方法，需要加上的话，我想思路就是将kittyId到账号的映射修改为kittyId到kittyId的映射，弱化地址。只要你能将kittyId通过交易发送出去，就能证明你有拥有这个kittyId，反过来推理就能证明kittyId拥有者就是你所需要授信的账号地址。在最终的实现过程中发现approve方法在匿名版的以太猫中可以不需要。

###### KittyBreeding
这个文件应该不需要怎么改动，由于将sireAllowedToAddress修改为sireAllowedToTokenId，因此只需要修改下approveSiring方法。
```css
function approveSiring(bytes32 _matronId)
    external
    whenNotPaused
    {
        //get _sireId A Kitty that you own from the tx param
        bytes32 _sireId = sero_msg_ticket();
        sireAllowedToKittyId[_sireId] = _matronId;
        //Re-save _sireId to your personal account after approval
        sero_send_ticket(msg.sender,symbol,_sireId);
    }
```
_sireId就是通过交易参数传递给智能合约的，因此需要调用SeroInterface的sero_msg_ticket的方法获取交易参数的中的ticekId。因为_sireId是通过交易参数传递，SERO链上会将_sireId从个人账号中标记为已经使用掉，你将不再拥有该_sireId。但此处只是实现授权，并不需要发生资产转移，因此在方法的最后还需要将该_sireId再次存入到个人账号中去。

###### KittyAuction

删除createSaleAuction、createSiringAuction方法中的_kittyId参数，所有该参数的获取都调用SeroInterface的sero_msg_ticket的方法从交易参数中获取。此处和以太坊的实现稍微有些区别，以太坊之前的做法是先要对saleAuction、siringAuction进行授信，然后再通过nonFungibleContract将_kitttyId转移到自己账号中进行托管。由于SERO链上的kittyId都存在个人账号中，并且创建拍卖的时候kittyId都是通过交易参数传递，一旦交易成功，kittyId不可能再次使用这个kittyId,因此无需托管这一步，等bid方法被调用后直接将kittyId存入到winner的个人账号中去。

删除bidOnSiringAuction方法中的_matronId的参数，调用者通过交易参数传递，然后在方法体中通过sero_msg_ticket方法获取。此处和KittyBreeding中的approveSiring有类似的情况，_matronId通过交易参数传递很重要的一点就是为做一个身份校验，并不反生资产的转移，因此在方法的最后还需要将该_matronId再次存入到个人账号中去

至此，以太猫的核心部分就都修改完成，由于GeneScienceInterface的智能合约未公布，因此mixGenes方法用生成随机数的方法替代。有兴趣的可以去网上找破解版的。

### 总结

以太猫核心部分就是基于以太坊的ERC721（非同质代币协议），其次就是核心的业务逻辑。本次实现匿名版的以太猫主要是调整ERC721接口实现部分，根据SERO团队在SeroInterface.sol中提供的接口完全能够实现以太坊ERC721的功能，因此以上的调整主要是针对kittyId的生成，存储，鉴权以及参数的传递。

因为SERO上生成的kittyId无论是创建还是发生交易最终都会直接存执到个人账号中去，因此智能合约无需管理kittyId的归属。在调用智能合约方法的时候，凡是涉及到需要传递自己拥有的kittyId的地方都必须通过交易参数传递到智能合约中去。需要特别注意的地方是，SERO链上会将交易参数中的kittyId从个人账号中标记为已经使用掉，你将不再拥有该kittyId。如果通过交易参数传递的kittyId仅作为鉴权使用而不需要发生资产转移，切记在智能合约的方法中还需要将该kittyId再次存入到个人账号中去。

SERO实现匿名的第一步就是对地址作文章，无论是交易中的地址还是传入到智能合约中地址都将转换成一次性地址，最终只有拥有该地址私有的人才能查询到自己的资产情况并且使用这些资产，这无形当中弱化了地址的功效。在以太猫中存在将kittyId授信给一个地址的情况，在SERO中显然这一点无法做到这一点，因为每次传入到智能合约中的地址可能都不一样了，即使是同一个地址。虽然无法实现对一个地址直接授信，但SERO同样可以实现类似的功能，只需要我们转换下思路就可以了。因为SERO的所有资产都保存到个人账户中去了，因此对于拥有非同质代币的人，在某种情况下一个tickeId就能证明一个地址的身份，因此以太猫中类似将kittyId授信给一个地址的时候，都可以替换为将一个kittyId授信给另外一个kiettyId这样的方式来实现，授信方的kittyId必须通过交易参数传递到智能合约中。搞清楚以上一些主要的变化后，在不变动以太猫的业务逻辑的情况下，就能很容易将其匿名化。对比原版代码量会更少，而且资产的管理逻辑也会减少，实现起来主要的重心就在业务逻辑上了。

通过SERO，不但可以实现以太猫匿名化，而且SERO之于智能合约，在支持匿名的基础上还简化了资产管理逻辑，使所有的DApp开发者可以将重心放到业务逻辑开发上来。某种情况下SERO降低了通过智能合约发布代币的门槛，使传统App开发者可以更加容易上手开发自己的DApp。

匿名版以太猫的Github源码。
https://github.com/kusun/Sero-CryptoKitties

--
