# How to Realize Anonymous Crypto Kitties by SERO DAPP

_Author: [kusun](https://github.com/kusun)_

_Translator: [SERO](https://github.com/sero-cash)_

`Super Zero` `sero` `zpk` `zero-knowledge-proofs` `blockchain` `confidential transactions` `nizk` `anonymous tokens` `super-zk` `smart contracts` `crypto kitties`

### Privacy protection issues for blockchain development platforms

We now know that Ethereum is a blockchain application development platform. Based on the network built by Ethereum and the smart contract language, we can implement various distributed applications (DApps) that are close to the real world. These distributed applications based on smart contract are innovations, but they also cause the market to worry about information security. At present, they are easy to trace all the transactions of an account and the funds of the account through the [Ethereum Block Browser](https://etherscan.io/). There is basically no threshold for this kind of behavior. As long as you can access the Internet, you can analyze the funds flow and currency holding of an account, which has no privacy for individuals.

### SERO: The world's first anonymous public chain supporting smart contracts

![image.png](https://upload-images.jianshu.io/upload_images/277023-50e80f9db60148e1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/800)

Currently, there are popular anonymous blockchain technologies such as Monero, Dash and Zcash. Although they can be anonymously protected by privacy, they do not support smart contracts and cannot be used to develop DApps. The SERO(Super Zero Protocol) ([SERO](https://sero.cash))[[White Paper](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/Sero_ENG_V1.06.pdf) is an anonymous public chain that supports Turing's complete smart contracts, implements privacy protection technology with zero knowledge proofs, and has already released the beta version. SERO seems to be a perfect solution for privacy protection and can develop anonymous DAPPs on it.

### Overview of the Crypto Kitties program on Ethereum

![image.png](https://upload-images.jianshu.io/upload_images/277023-c9de77ecd764b845.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/800)

[Crypto Kitties] (https://github.com/cryptocopycats/awesome-cryptokitties) should be Ethereum's most mature and successful game DAPP so far. It caused the congestion of Ethereum in a short period of time. The Crypto Kitties was developed in accordance with ERC721, with about 2,000 lines of Smart contract code. The source code is open source on github and can also be found in the [Ethereum Block Browser](https://etherscan.io/).

The Crypto Kitties program includes seven main programs:
1. **KittyAccessControl**, this contract manages various addresses and constraints that can only be performed by specific roles. These roles are called CEO, CFO and COO.
2. **KittyBase**, this contract defines the most basic code shared in the entire core functions. This includes our main data stores, constants and data types, and internal functions for managing these data.
3. **KittyOwnership**, which provides the method required for basic interchangeable token transactions of the draft ERC-721 specification.
4. ** KittyBreeding**, this file contains the necessary methods for breeding cats together, including tracking breeding providers, and relying on external gene combination contracts.
5. **KittyAuctions**, here, there are public ways to auction cats or tender cats or breed cats. The actual auction function is handled in two brother contracts (one for trading and one for breeding), and the creation and bidding of the auction are mainly through the core contracts.
  6, **KittyMinting**, the contract contains the function to create a new gen0 cat
  7, ** KittyCore**, this is the main CryptoKitties contract, compiled and run on the Ethereum blockchain. This contract links everything together.

### Anonymous version of the Crypto Kitties implementation

![image.png](https://upload-images.jianshu.io/upload_images/277023-944732110b239103.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/800)

According to the SERO DApp programming specification, an anonymous version of the Crypto Kitties DApp can be implemented. At present, the function of SERO to support the issue of "anonymous tickets" has been released. This function corresponds to the Ethereum ERC721 protocol, which is the basis for implementing the Crypto Kitties.

###### Ticket (Ticket) related interface definition

The SERO team deployed a [Remix-ide] (http://remix.web.sero.cash) site with an example called SeroInterface.sol, which provides an interface for publishing anonymous tokens and tickets. It is a system interface and must be inherited if anonymity is to be implemented. According to the example provided by the SERO team, the interface for generating and transferring tickets must contain the system-defined log topic.

```JavaScript
  /**
  * the follow topics is system topics,can not be changed at will
  */ 
  bytes32 private topic_sero_send           =  0x868bd6629e7c2e3d2ccf7b9968fad79b448e7a2bfb3ee20ed1acbc695c3c8b23;
  bytes32 private topic_sero_allotTicket    =  0xa6a366f1a72e1aef5d8d52ee240a476f619d15be7bc62d3df37496025b83459f;
  bytes32 private topic_sero_category       =  0xf1964f6690a0536daa42e5c575091297d2479edcc96f721ad85b95358644d276;
  bytes32 private topic_sero_ticket         =  0x9ab0d7c07029f006485cf3468ce7811aa8743b5a108599f6bec9367c50ac6aad;
```
From the topic defined above, each type of ticket must have a category attribute, similar to syboml in ERC721.

SeroInterface mainly provides the following interfaces that are needed to write the anonymous version of the Crypto Kitties:

**1. Generate a ticketId and save the ticketId directly to your personal account.**

```JavaScript
  /**
   * @dev generate a tickeId and allot to the receiver address
   * @param _receiver receiving address of tickeId
   * @param _value  the seq of tickeId, can be zero. If zero, the system randomly generates
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

**2. Get the category in the transaction parameters**

```JavaScript
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

**3. Get the ticketId in the transaction parameters**

```JavaScript
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

**4. Deposit the ticketId in the transaction to the recipient's personal account**

```JavaScript
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

The ticketId generated by the SeroInterface smart contract will be saved directly to the personal account. The smart contract does not need to manage the personal account assets. Therefore, when transferring the ticket, the ticketId and category must be passed through the transaction parameters, and cannot be passed through the parameters of the smart contract method. The transferred ticketId will eventually be stored directly in the recipient's personal account. After figuring out the interfaces provided by SERO, the changes in the Crypto Kitties are very simple. To some extent, realizing the Crypto Kitties on the SERO will be simpler and the code size should be less.

###### KittyBase

Since the data types of the ticekId on the SERO are changed to bytes32, it is necessary to change the data types of all the ticketIds in the KittyBase to be bytes32.

```JavaScript
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

After the data type of kittyId is changed, some corresponding data interfaces also need to be adjusted. Kittys in Kitty Base need to be changed from array type to map.

```JavaScript
 mapping(bytes32 => Kitty) kittys;
```

According to the source code of [SERO source code](https://github.com/sero-cash/go-sero), the first step in making anonymous transactions is to anonymize the account address, and all account addresses involved in the transactions are replaced by one-time addresses, so sireAllowedToAddress in the previous KittyBase is changed to sireAllowedToTokenId. The mapping from tickeId to the account is modified to map from tickeId to ticketId.

```JavaScript
  mapping (bytes32 => bytes32) public sireAllowedToTokenId;
```

The attributes kittyIndexToOwner and ownershipTokenCount are deleted because all ticekIds are saved in the personal account eventually, so there is no need for a smart contract to save the relationship between the ticketId and the account.

When generating Kitty, directly call the sero_allotTicket method in SeroInterface.sol in the _createKitty method to generate the kittyId and save the kittyId to the owner's personal account without calling the _ transfer method.

###### KittyOwnership

Since the kittyId created by the smart contract is sent directly to the personal account, there is no need for the ownerOf, tokensOfOwner method in the file, as long as you can query in your personal account and pass the kittyId through the transaction parameters. Go to the smart contract and prove that your account has this kittyId. Therefore, the smart contract ends up with only two methods of transfer and totalSupply.

Because this is a simple attempt, many places have been simplified. I deleted the relevant method of approve. If I need to add it, I think the idea is to change the mapping of kittyId to account to the mapping of kittyId to kittyId to make the address temporary. As long as you can send the kittyId through the transaction, you can prove that you have the kittyId, and the reverse reasoning can prove that the kittyId owner is the account address you need to approve. In the final implementation process, the approve method may not be necessary in the anonymous version of the Crypto Kitties.

###### KittyBreeding
This file should not need to be changed. Since sireAllowedToAddress is changed to sireAllowedToTokenId, only the approveSiring method needs to be modified.
```JavaScript
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
_sireId is passed to the smart contract through the transaction parameters, so you need to call SeroInterface's sero_msg_ticket method to get the ticekId in the transaction parameters. Because _sireId is passed through the transaction parameters, the _sireId will be marked as used from the personal account in the SERO chain, and you will no longer own the _sireId. However, only authorization is implemented here and no transfer of assets are required. Therefore, the _sireId needs to be stored in the personal account again at the end of the method.

###### KittyAuction

Delete the _kittyId parameter in the createSaleAuction and createSiringAuction methods. All the parameters are retrieved from the transaction parameters by calling SeroInterface's sero_msg_ticket method. This is slightly different from Ethereum's implementation. The previous approach of Ethereum was to extend credit to saleAuction and siringAuction, and then transfer the _kitttyId to your account through nonFungibleContract for hosting. Since the kittyId on the SERO chain exists in the personal account, and the kittyId is passed through the transaction parameters when the auction is created, once the transaction is successful, the kittyId may not use the kittyId again, so there is no need to host this step. After the bid method is called, the kittyId will be directly stored in the Winner's personal account. 

Delete the _matronId parameter in the bidOnSiringAuction method, the caller passes it through the transaction parameter, and then gets it in the method body by the sero_msg_ticket method. Here is a similar situation with approveSiring in KittyBreeding. The important point of _matronId passing through the transaction parameters is to do an identity check and not transfer the assets, so you need to save the _matronId to your personal account at the end of the method..

At this point, the core part of the Crypto Kitties has been modified. Since the smart contract of GeneScienceInterface has not been published, the mixGenes method is replaced by the method of generating random numbers. If you are interested, you can go to the Internet to find the cracked version.

### Conclusions

The core part of the Crypto Kitties is ERC721 (Non-Fungible Token Standard) based on Ethereum, followed by the core business logic. This implementation of the anonymous version of the Crypto Kitties is mainly to adjust the implementation of ERC 721 interface. According to the interface provided by the SERO team in SeroInterface.sol can fully realize the function of Ethereum ERC721, so the above adjustment is mainly for the generation, storage, authentication and parameter transfer of kittyId.

Because the kittyId generated on the SERO will be directly stored in the personal account whether it is created or generated, the smart contract does not need to manage the ownership of the kittyId. When calling the smart contract method, all the places that need to pass the kittyId that they own must be passed to the smart contract through the transaction parameters. What needs special attention is that the kittyId in the transaction parameters will be marked as used from the personal account in the SERO chain, and you will no longer own the kittyId. If the kittyId passed through the transaction parameter is used only for authentication and does not need to be transferred, it is important to remember that the kittyId needs to be stored in the personal account again in the smart contract method.

![image.png](https://upload-images.jianshu.io/upload_images/277023-e10fa5b921944fee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/800)

The first step in realizing anonymity in SERO is to modify the address. Both the address in the transaction and the address passed into the smart contracts will be converted into temporary addresses. Only the person who owns the address can query the asset status and use them, which virtually weakens the function of the address. In the case where the cattyId is approved to an address in the Crypto Kitties, this is obviously not the case in the SERO because the address that is passed into the smart contract may be different each time, even if it is the same address. Although it is impossible to directly approve an address, SERO can also implement similar functions, just by changing our thinking. Because all the assets of SERO have been saved in the personal account, for a person with a non-fungible token, a tickeId can prove the identity of an address under certain circumstances, so when the Crypto Kitties approve a kittyId to an address, it can be replaced by a method of approving one kittyId to another kietyId and the approver's kittyId must be passed to the smart contract through the transaction parameters. After understanding the above major changes, it is easy to anonymize Crypto Kitties without changing their business logic. Compared to the original version of the code, the amount of code will be less, and the asset management logic will be reduced. The main focus of implementation will be on the business logic.

Using SERO, not only can the cats be anonymized, but also simplifies asset management logic based on the support for anonymity, so that all DApp developers can focus on business logic development. In some cases, SERO reduces the threshold for issuing tokens through smart contracts, making it easier for traditional app developers to develop their own DApps.

Source code:
[[Sero-CryptoKitties source code]](https://github.com/kusun/Sero-CryptoKitties)

--
[[Website] https://sero.cash](https://sero.cash)
[[White paper V1.0.6] http://sero-media.s3-website-ap-southeast-1.amazonaws.com/Sero_ENG_V1.06.pdf](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/Sero_ENG_V1.06.pdf)
[[Twitter] https://twitter.com/SEROdotCASH](https://twitter.com/SEROdotCASH)
[[Telegram] https://t.me/SeroOfficial](https://t.me/SeroOfficial)
[[Github] https://github.com/sero-cash/go-sero](https://github.com/sero-cash/go-sero)
[[Gitter Community] https://gitter.im/sero-cash/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link](https://gitter.im/sero-cash/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link)
[[SERO Blockchain Browser]  https://explorer.web.sero.cash/blocks.html](https://explorer.web.sero.cash/blocks.html)
[[SERO Smart Contract Editor]  https://remix.web.sero.cash/](https://remix.web.sero.cash/)
[[SERO Introduction Video] https://www.youtube.com/watch?v=lqFUhXskgNg](https://www.youtube.com/watch?v=lqFUhXskgNg)
[[SERO vs Zcash Video] https://www.youtube.com/watch?v=bc6yHTLSl5M](https://www.youtube.com/watch?v=bc6yHTLSl5M)