# Super Zero Protocol (SERO) Smart Contracts Tutorial - Issue Anonymous Tokens

`super zero` `super-zk` `sero` `zpk` `zero knowledge proofs` `blockchain` `nizk` `super-zk` `zh` `anonymous` `anonymous tokens`

We have already described [Super Zero Protocol (SERO) Smart Contracts Tutorial - Anonymous Tokens Issuance Principle] (https://sero.cash) in the previous article, now we are going to introduce how to issue your own tokens step by step.



## What can SERO's anonymous Tokens do?

In the current blockchain systems, issuing anonymous tokens is a unique function of SERO, no other blockchain systems can have this function. So what cool things can we do with this stunt?

**With SERO's anonymous token mechanism, you can do something like these:**

1. Promise to the customer that your tokens has **the same anonymity as SERO**.
2. After the business grows **safely expand** your service features, without worrying that the previous smart contract does not provide some interfaces.
3. Use the smart contracts to write a **Decentralized Token Exchange** to achieve the exchange of various tokens on the SERO.
4. Only part of your operating information will be disclosed to the public.

**You can also do such things after the Beta version is released**

1. Let customers visiting your business pay the SERO fee with the token you issued.
2. Let your business have the fairness of sealed auction.



> SERO can provide even more amazing features by issuing anonymous ticket assets. Detailed tutorials can wait for ["Issuing Anonymous Tickets"] (https://sero.cash).

Let's start with a hypothetical example and see how to issue anonymous tokens on SERO.



## Scenarios

Alice is a member of a non-profit organization that plans to conduct a fundraiser in order to enable out-of-school children in poor areas to study. The operation mechanism of public welfare activities is often very complicated. The following points are of very concern to her:

1. The money raised can be used in the children who need to donate, not for other purposes.
2. Some real philanthropists whose main purpose is to donate and do not want to disclose the amount and identity of their donations.
3. She hopes that this kind of care will have a transmission effect, so that more people can easily participate in it, share the costs and help these out-of-school children.

In order to operate such a public welfare activity, Alice designed a blockchain application called **Tomorrow Flowers**. This application is to separate the funds from the use of funds. Of course, when she was about to start developing smart contracts, she found that **the only blockchain that can meet such needs**, and has already launched, is the **The SERO Protocol**.

**Alice’s application is like this**

![image.png](https://upload-images.jianshu.io/upload_images/277023-edd4b2ba0ad45c85.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

She wants to develop a smart contract. This smart contract that issues two type of tokens, namely `Assisted Token` and `Helper Token`, which must be issued in the same proportion (that is, how many `Heper Tokens` are purchased and how many `assigned tokens` must be generated accordingly).

* **Assisted Token**

  Recorded in a regular way and is supervised by banks and public supervision, which is used to track the situation of donated children. Assisted Tokens will be uniformly distributed according to the needs and circumstances of the activities. When all the Tokens are required to apply for funds for out-of-school donations, they must fully report the operation of the funds and record them on the blockchain and be supervised by the public.

* **Helper Token**

  Issued anonymously for charitable fundraising. People who buy `Helper Token` can trade tokens to other charitable donors to share the cost of the action and pass on this charitable behavior. Transactions resulting from such behavior should enjoy corresponding social returns. The `Helper Token` transaction will not disclose any information from the donors because it is anonymous.

> This article focuses on the development process of anonymous tokens. `Assisted Token` is a regular Token issue. Since SERO's smart contract is compatible with Ethereum, the release process of public assets is consistent with Ethereum. You can refer to Ethereum's method to issue ERC20 tokens.

## Steps for issuing anonymous tokens

You can follow my steps to issue your own anonymous tokens. If you are unfamiliar with some basic concepts, it is recommended to read the article (https://sero.cash)[Super Zero Protocol (SERO) Smart Contracts Tutorial - Anonymous Tokens Issuance Principle](https://sero.cash).



> In addition, the main process of issuing smart contracts is consistent with Ethereum. The focus of this article will focus on  the differences.



### Step 1. Preparation

#### Solidity Language

![image.png](https://upload-images.jianshu.io/upload_images/277023-2bdef85e6118d982.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

SERO uses the Solidity programming language for smart contracts development and is currently compatible with v0.5.0 and below. If you have questions about the Solidity's grammar, you can refer to [Solidity Official Handbook] (https://solidity.readthedocs.io/en/v0.5.0/).

#### SERO Smart Contracts Development Environment

![image.png](https://upload-images.jianshu.io/upload_images/277023-e09c65925d1f6783.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

We recommend that you use SERO's officially customized Solidity IDE for the development and compilation of SERO smart contracts. It currently integrates the most basic API for issuing anonymous smart contracts (serointerface.sol), an example of issuing anonymous tokens (token_test.sol), and some necessary automation. We will add anonymous assets debugging features later.

You can open SERO's smart contract development environment via the link: [http://remix.web.sero.cash] (http://remix.web.sero.cash).
> Please note that the link must be opened in a non-encrypted way (http://) instead of (https://) in order to function properly.

#### Full node service program (gero) or SERO client wallet (Wallet)

Although SERO's client wallet can also publish smart contracts, we strongly recommend that you use a full-node service program to publish smart contracts so you can get more information and flexibility.

This article uses gero to illustrate the release process of smart contracts. For the compilation and installation of gero, please refer to ["Step by step detailed technical manual for installing SERO (SUPER-ZK) Protocol on your local machine"] (https://sero.cash) and ["SERO Mining Tutorial"] (https:// Sero.cash)

> You can get the latest gero source code and compiled package on this page.
> [https://github.com/sero-cash/go-sero/releases](https://github.com/sero-cash/go-sero/releases)

![image.png](https://upload-images.jianshu.io/upload_images/277023-91763145b4fe8435.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

For information on how to publish smart contracts with your wallet, please refer to [SERO Wallet Instructions] (https://sero.cash)

> You can get the latest wallet source code and compiled installation package on this page.
> [https://github.com/sero-cash/wallet/releases](https://github.com/sero-cash/wallet/releases)

![image.png](https://upload-images.jianshu.io/upload_images/277023-060fc708d35cdff7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

### Step 2. Determine the token name
Now we are going to issue the Helper Token, we first give this token a name, such as **`"TFHCOIN"`** means "Tomorrow Flowers Helper Coin".

It should be noted that the token name needs to be registered to the SERO consensus through the basic interface provided by SERO, and it must satisfy the following conditions:

> * Is case insensitive
> * Cannot be duplicated globally
> * Cannot exceed 24 characters
> * Only use uppercase letters ` a-z ` and underline ` _ `

Therefore, when you repeat this example, use SERO's Dev mode to make sure you are the first developer to use this name.

### Step 3. Edit smart contracts on SERO's solidity IDE

#### 1. SERO Basic Interface

On the left side of the SERO IDE there is a file called `serointerface.sol`, which has a base contract called `SeroInterface`. To issue an anonymous Token, you must inherit this contract. The main interfaces used in this contract in this article are:

```solidity
pragma solidity ^0.4.25;

contract SeroInterface {

  function sero_issueToken(
      uint256 _total,
      string memory _currency
  ) internal returns (bool success) {...}
  
  function sero_balanceOf(
      string memory _currency
  ) internal returns (uint256 amount) {...}
  
  function sero_send_token(
      address _receiver,
      string memory _currency,
      uint256 _amount
  ) internal returns (bool success){...}
  
  ...
  
}
```

* ***`sero_issueToken`*** has two functions. The first is to register a token name `_currency`, and the second is to generate `_total` corresponding tokens to the smart contract account.
> **Note:** When the token name already exists, only the smart contract that created the token ***name can call the method again to issue the tokens.

* ***`sero_balanceOf`*** function is the token balance of the smart contract account holding the currency name `_currency`.
> **Note:** The `_currency` here may not be the name of the token issued by this smart contract, or even `SERO`. That is to say, the smart contract can accept any asset like the ordinary account.

* ***`sero_send_token`*** is used to transfer the `_amount` tokens of the smart contract account with the token name `_currency` to the address `_receiver`.
> **Note:** The `_receiver` here can be either a normal account or a smart contract. If it is a normal account, only the temporary address `PKr` is supported. If you transfer to any public key address `PK`, the Token will be transferred to an account that no one can use again.

#### 2. Write a simple smart contract `TFHCoin.sol` in the IDE to issue **`"TFHCOIN"`**

```solidity
// TFHCoin.
pragma solidity ^0.4.16;
import "./seroInterface.sol";

contract TFHCoin is SeroInterface {
    
    string private _currency="TFHCOIN";
    address private _owner;

    constructor()
          public
    {
        _owner=msg.sender;
        if(!sero_issueToken(
              1000000000*10**9,
              _currency
        )){
            require(false);
        }
    }

    function balanceOf()
          public returns (uint256 amount)
    {
        return sero_balanceOf(_currency);
    }
    
    function transfer(
          address _to,
          uint256 _value
    )
          public returns (bool success)
    {
        require(_owner==msg.sender);
        return sero_send(_to,_currency,_value,'','');
    }

}
```

* First, let's look at the constructor `constructor`. In the method body, we will write the creator as `_owner` and call `sero_issueToken` to issue 1 billion tokens of `TFHCOIN` with $10^9$ decimals. The return value indicates whether or not successful. If not, the entire transactionwe will be rolled back.

* The `balanceOf` method calls `sero_balanceOf` to query the balance of the `TFHCOIN` held by the current smart contract.

* The `transfer` method first determines whether the caller is `_owner`, and then rolls out `_value` `TFHCOIN` to the temporary address `_to`.

> **Note:** `_to` is the temporary address `PKr`. If the public key address `PK` is used, this token will not have any account to be used again!

#### 3. Compile **`TFHCoin.sol`**

* Select the `TFHCOIN` smart contract on the right side of the IDE and click the `Detail` button next to it.

![image.png](https://upload-images.jianshu.io/upload_images/277023-e23b8cb8c9b8e467.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* Find the the button of copy next to `WEB3DEPLOY` in the pop-up box and click it to copy the compiled contents.

![image.png](https://upload-images.jianshu.io/upload_images/277023-34d4e074e8c13375.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

> **Note** The constructor of `TFHCOIN` has no arguments passed in. If there are arguments passed in, you need to copy it to a text editor to set the initialization parameters of the constructor.

#### 4. Run the gero background and the command line console

> For the gero background and how to run the console, please refer to ["Step by step detailed technical manual for installing SERO (SUPER-ZK) Protocol on your local machine"] (https://sero.cash) and ["SERO Mining Tutorial"] (https://sero.cash)

Since we are running gero in Dev mode, we need to create an account and prepare some SERO coins as a processing fee.
```
> alice_addr=personal.newAccount("1234")
"2yKtQ7rMHLn1dSSuAFvsi1s7NaLL1zkNysmMv4L51WCubgjHtMtKNwVsDdEMXXH1QvmWQgKTKcyUXBK2RUPoK7mo"
> sero.accounts
["2yKtQ7rMHLn1dSSuAFvsi1s7NaLL1zkNysmMv4L51WCubgjHtMtKNwVsDdEMXXH1QvmWQgKTKcyUXBK2RUPoK7mo"]
> miner.start();admin.sleepBlocks(1);miner.stop();
true
> sero.getBalance(alice_addr)
{
  tkn: {
    SERO: 24000000000000000000
  }
}
```

#### 5. Install the smart contract

* **Then we paste the compiled contents copied from the IDE into the console and click enter to create the transaction.**


![image.png](https://upload-images.jianshu.io/upload_images/277023-7510f0afadee18a5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

The installation of the smart contract is carried out in the transaction, and the address of the transaction can be viewed after the transaction is created. Use this address to query the current state of packaging in the block browser.

   ```
> tfhcoin.transactionHash
"0x254bbefcbe0eaa3cb5a657377fd49b756880839a1bb69eaa006106a882055f09"
   ```

* **Now mine a block to package the transaction and confirm that the smart contract has been successfully installed.**

 ![image.png](https://upload-images.jianshu.io/upload_images/277023-184f8bc5a3ef536e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

The SERO console will return the smart contract address and transaction number after successful installation.

* **You can view the balance in the smart contract**
 ```javascript
> sero.getBalance(tfhcoin.address)
{
      tkn: {
          TFHCOIN: 1000000000000000000
      }
}
 ```
At present, we have generated `TFHCOIN` tokens with $10^9$ decimals, and amount is 1 billion.

#### 6. Public issuing **`TFHCOIN`**

* Public issuing `TFHCOIN` means that Alice and her agency accept donations from donors and issue a corresponding amount of 'TFHCOIN` to the donor, while the money from the donation is supervised by the regulator.

> We can call the TFHCoin smart contract's `transfer` method to send a certain number of TFHCoins to the donor.

* For this, we create a dummy donor `helper_addr` to test the function.

  ```
  > helper_addr=personal.newAccount("1234")
  "37NVgL22rksMLK6Euos9eoS2T7prRUrXKzMMXPYr4SfNCaiDgXfvbfe6SmD3EgfhRuZtPekop3BgwGRByWLSeRHg"
  ```

* Give this donor 10 'TFHCOIN` with `account[0]`.
  ```
  > tfhcoin.transfer(helper_addr,10*1000000000,{from:sero.accounts[0]})
  "0xbd290e7c1385af11eb8bedbb3c03644dd27bcd7ae12604aac7e40d66597efee0"
  > miner.start();admin.sleepBlocks(1);miner.stop();
  true
  > sero.getBalance(helper_addr)
  {
      tkn: {
        TFHCOIN: 10000000000
      }
  }
  > sero.getBalance(tfhcoin.address)
  {
      tkn: {
        TFHCOIN: 999999990000000000
      } 
  }
  ```

After the `transfer` method is called, you can see that there are 10 `TFHCOIN` tokens in the helper_addr account, and `TFHCOIN` tokens subtracted in the smart contract address.

> **Note:** We said that the first parameter `_to` of `transfer` needs to use the temporary address `PKr`. But in the SERO console, you can directly transfer the tokens to the other party's public key address `PK`. The SERO console will automatically convert `PK` to `PKr` to generate the transaction.

#### 7. Donors sell **`TFHCOIN`** to allow other donors to share the donation with him
* Because this is a Dev account, `helper_addr` does not have `SERO` coins for the transaction fee, so the main account need to transfers some `SERO` coins to `helper_addr`.

   ```
   > sero.sendTransaction({from:alice_addr,to:helper_addr,value:web3.toTa(10)})
   "0x9a5fd4f155254483f62a0cd85341ef8942e8a433b1be903a646740a8debb636f"
   > miner.start();admin.sleepBlocks(1);miner.stop();
   true
   > sero.getBalance(helper_addr)
   {
        tkn: {
          SERO: 10000000000000000000,
          TFHCOIN: 10000000000
        }
   }
   ```

   Let's take a look at the composition of this SERO transaction.
   ```
   > sero.getTransaction("0x9a5fd4f155254483f62a0cd85341ef8942e8a433b1be903a646740a8debb636f")
   {
     blockHash: "0x937ddb...1f6120",
     blockNumber: 7,
     gas: 90000,
     gasPrice: 1000000000,
     hash: "0x9a5fd4f...b636f",
     input: "0x",
     nonce: 0,
     stx: {
      Bcr: "0x7b309...0f617",
      Bsign: "0xd38f8a...e2705",
      Desc_O_Ins: [],
      Desc_O_Outs: [],
      Desc_Z_Ins: [{
          Anchor: "0x89ef81...33e2e99",
          AssetCM: "0x795c4...11720",
          Nil: "0x986d5...32afdf",
          Proof: "0x03687c...d0aefc21c",
          Trace: "0x5abf87...04006"
      }],
      Desc_Z_Outs: [
         {
          AssetCM: "0x1eee25e...da8816",
          OutCM: "0x25773...c164ba9",
          PKr: "0x5e4f8b...ec6902",
          Proof: "0x0215c...6a526"
         }, 
         ...
      ],
      Ehash: "0xd8483...14a4",
      Fee: "90000000000000",
      From: "0x568ec...bfb5dd07",
      Sign: "0x95f35...f8b600"
     },
     to: null,
     transactionIndex: 0,
     value: 0
   }
   ```

   **There is none information leaked out, anyone do not know the input address, do not know the output address and do not know the amount!**

* We create another dummy donor `other_helper_addr` to receive `TFHCOIN` of the `helper_addr`.

   ```
   > other_helper_addr=personal.newAccount("1234")
   "15B2TPeRdE6GwKsE2V7sprk3yYZXuTVaGMGNXZZAUUHRH3U5pW59BZWhXhAud2a8zFxPp9JRBz4akpHwoLx99No"
   ```
* Now `helper_addr` can anonymously transfer 5 `TFHCOIN` tokens to `other_helper_addr`
   ```
   > sero.sendTransaction(
      {from:helper_addr,to:other_helper_addr,value:5*1000000000,cy:"TFHCOIN"}
   )
   "0x7024f426f376d188b6980b720d44104fe3f908d25d0d53c3f7e130f30f6d9765"
   > miner.start();admin.sleepBlocks(1);miner.stop();
   true
   > sero.getBalance(helper_addr)
   {
     tkn: {
       SERO: 9999975000000000000,
       TFHCOIN: 5000000000
     }
   }
   > sero.getBalance(other_helper_addr)
   {
     tkn: {
       TFHCOIN: 5000000000
     }
   }
   ```

* **Let's pay attention to two things:**
> * Send 'TFHCOIN' tokens in the same way as sending `SERO` coins, using the SERO's native transfer mechanism, not the smart contract `TFHCoin` method `transfer`. This means that `TFHCOIN` and `SERO` exist in the user account in the same data state.
> * One more currency name parameter `cy` in the trading parameters, the value is `"TFHCOIN"`.

   * **Then let's look at the details of the transaction:**
   ```
   > sero.getTransaction(
   "0x7024f426f376d188b6980b720d44104fe3f908d25d0d53c3f7e130f30f6d9765"
   )
    {
      blockHash: "0x735bb...17c3a",
      blockNumber: 10,
      gas: 90000,
      gasPrice: 1000000000,
      hash: "0x7024f...d9765",
      input: "0x",
      nonce: 0,
      stx: {
        Bcr: "0x85247...d8a714",
        Bsign: "0x52013f...6df801",
        Desc_O_Ins: [],
        Desc_O_Outs: [],
        Desc_Z_Ins: [
          {
              Anchor: "0xb0aaddf...d856d06",
              AssetCM: "0x2d3cc...89cf62d",
              Nil: "0x30da...bcee20",
              Proof: "0x025eed...da7031b",
              Trace: "0x811f...90b10b"
          },
          ...
        ],
        Desc_Z_Outs: [
          {
              AssetCM: "0xac8f2...e11c3ad",
              OutCM: "0x0a586e...13e2486",
              PKr: "0x875808...14d1c10",
              Proof: "0x036b46...8d100e"
          },
          ...
        ],
        Ehash: "0xf125e7...4809768",
        Fee: "90000000000000",
        From: "0x807dc...d1bb80a",
        Sign: "0xadf77...003702"
      },
      to: null,
      transactionIndex: 0,
      value: 0
    }
   ```
**It is the same as the `SERO` coins's transfer seen above, anyone do not know the input address, do not the output address and do not know the amount!**



## Conclusions

With the prototype of the smart contract that issued `TFHCOIN` tokens, Alice can continuously enrich it to achieve her charitable purposes. After the smart contract is generated and released, since the issued tokens is directly into the user account, rather than being hosted by the smart contract, it is easy to write another smart contract to receive the tokens and add new logic to the tokens. It's as simple as adding new logic to `SERO` coins.

Of course, Alice has a long way to go to complete her career, and we hope that SERO can be used for the right cause.