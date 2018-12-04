# Anonymous Tokens Issuance Principle

`Super Zero` `sero` `zpk` `zero-knowledge-proofs` `blockchain` `confidential transactions` `nizk` `anonymous tokens` `super-zk` `smart contracts`

SERO is the world's first privacy blockchain system that supports Turing's complete smart contracts. Since it supports smart contracts, it is certainly not a simple smart contracts + anonymous coins. SERO deeply integrates the advantages of both: the openness of smart contracts and the closeness of privacy systems. With the support of the two features, SERO's smart contracts have very exciting features that can do some amazing things.

This article mainly explains the application of the `Anonymous Token API` provided by SERO in smart contracts, and briefly introduces the  principle of the anonymous tokens at the beginning. If you want to compile and install SERO, please refer to [[Step by step detailed technical manual for installing SERO (SUPER-ZK) Protocol on your local machine]](https://medium.com/@SERO.CASH/step-by-step-detailed-manual-for-installing-sero-super-zk-protocol-on-your-local-6c7fad2492fc) , join us [[SERO Developer Community]](https://gitter.im/sero-cash/developer?utm_source=share-link&utm_medium=link&utm_campaign=share-link), you can ask any questions related to SERO development in the community.

As a basis, this article believes that readers have a general understanding of the blockchain system and related technical principles.



## UTXO and ACCOUNT

Readers who understand the structure of blockchain should know that the blockchain is a distributed ledger, each ledger account contains multiple transactions `Tx`, and each transaction contains multiple records. The smallest unit of the ledger account is record, and each record stores the inflow or outflow of the account's assets. However, from the actual implementations, according to the different ways of asset outflow recording, the blockchain systems have evolved into two different accounting implementations, which are UTXO model and ACCOUNT model. These two models correspond to the models of Bitcoin and Ethereum respectively. SERO uses a more complex hybrid model.

### UTXO-Based Transactions

![image.png](https://upload-images.jianshu.io/upload_images/277023-d4f32a0a0768aca8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

As shown above, there are two types of records in the UTXO mode. For the transaction creator, they are `Input` and `Output`, which in the view of the transaction acceptor is `Unspent Transaction Output (UTXO)`, until the transaction acceptor initiate another transaction and specify an `Input` to invalidate this `UTXO`. Records in transactions always link various inputs and outputs. In this mode, `account` is not necessary as a status summary.

For example, in the above picture, Alice received a transaction `Tx 0`, this transaction has an output of `UTXO 0`, and there are `V` SERO coins in `UTXO 0`, which can be recorded on her account [+V SERO , BALANCE=V]. Then she transfers the `V` SERO coins to Bob, so she generates a transaction `Tx 1`, this transaction has an `Input` to invalidate `UTXO 0`, then Alice's `ACCOUNT` should record [-V SERO, BALANCE=0]. For Bob, he added a `UTXO 1` with a value of `V` SERO. If his `BALANCE` before `ACCOUNT` is 0, his account can record [+V SERO, BALANCE=V].

**This model has two advantages：**

1. Each transaction in UTXO model is independent of each other, which means that transactions under one account can be processed in parallel as long as the problem of double spend can be handled properly, and the capability of multi-core CPU can be fully utilized.
2. UTXO is essentially a record form based on history, both a process and a result, so it has great advantages in some applications where proofs need to be generated. This is why the blockchain systems with CT(Conﬁdential Transactions) features are basically UTXO mode.

### ACCOUNT-Based Transactions

![image.png](https://upload-images.jianshu.io/upload_images/277023-0ee97ccbafff9d07.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

The UTXO model mentioned above said that each account can generate a temporary `ACCOUNT` as a status summary. In UTXO model, this account is temporary and not necessary. In the ACCOUNT model, each asset inflow and outflow record in the transaction references `ACCOUNT` instead of `UTXO`, the record `Input` indicates that the assets of the `ACCOUNT` are added, and the record `Output` indicates that the assets of the `ACCOUNT` are subtracted. In this model, the `ACCOUNT` entity is required. Without this `ACCOUNT`, all records do not make sense to the ledger.

As mentioned above, for example, Alice has previously received a transaction `Tx 0`, this transaction has an output value of `Output 0` for V SERO coins, and her `ACCOUNT` will add V SERO coins. At this time she wants to transfer out V SERO coins to Bob, then she initiates a transaction, the `Input` of the transaction points to her `ACCOUNT`, the value is V SERO coins, and the `Output 1` points to Bob's `ACCOUNT`, the value is also V SERO coins. When the transaction is processed by the system, the assets in both `ACCOUNT` will be directly added or subtracted. In this model, Alice can't distinguish whether the `Input` is the SERO coins transfered by `Output 0` or the SERO coins that was previously stored in the `ACCOUNT`.

**The ACCOUNT model also has two advantages**

1. ACCOUNT model directly add or subtract the assets in an independent account, and can add or subtract any value of assets in an account with only one record. Therefore, the generated record size is much smaller than the record generated by UTXO in the same situation.
2. The ACCOUNT model is state-based, `Input` and `Output` are processes, and `ACCOUNT` is the result, so it is easy to implement the Turing machine, that is why the blockchain that supports Turing's complete smart contracts mostly uses the ACCOUNT model.

### SERO's Hybrid Model

![image.png](https://upload-images.jianshu.io/upload_images/277023-00dcc847debac203.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

SERO applies UTXO and ACCOUNT models together, using UTXO model where CT(Conﬁdential Transactions) are required, and using ACCOUNT model where smart contracts need to be run. SERO seamlessly integrates these two models through trading, consensus, and Pedersen Commitment algorithms, enabling smart contracts to perform surprisingly.

> The `smart contracts` mentioned in this article corresponds to the concept of `Online Smart Contracts` in SERO's white paper.



## Anonymous Transaction Structure

In the BETANet network, SERO's general transactions are mandatory for anonymity. Because if any non-anonymous transaction can be allowed, the privacy of the users who wants to use the anonymous feature will not be guaranteed in the associated transaction. In addition, if you want to publicize information such as your own assets, it is recommended to use smart contracts to disclose some information to a limited extent.

> When the MAINNet is released, SERO will achieve a balance of privacy and execution speed by selecting the privacy level.

### Transactions `Tx`

![image.png](https://upload-images.jianshu.io/upload_images/277023-9c52fb6586e6ba0e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

SERO's confidential transactions `Tx` have an anonymous input set `Z ins`, an anonymous output set `Z outs`, a normal output set `O outs`, and a temporary address `From`. `Z ins` is completely anonymous, making it impossible for third-party observers to find out the source and content. `Z outs` is completely anonymous `UTXO`, only the receiver can view and use its content, the content carried by the `O Outs` is not hidden, and it refers to the receiver in two situations: one is pointing to a smart contract address, and the other is pointing to a temporary address. `From` represents the sender of the transaction and is also a temporary address. Therefore, the whole `Tx` cannot make the third-party observers determine who is the real user, and the information such as assets carried in it is also hidden to the greatest extent.

### Input `Z ins`

![image.png](https://upload-images.jianshu.io/upload_images/277023-52d7661f96f8479b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

In the input set `Z ins` of the SERO transactions, each input is anonymous, including the Id of the source `UTXO` and the asset information carried. Each input is converted to a `Proof` generated by zero-knowledge proofs `ZKP`. The `Proof` pointed to a particular `UTXO` hidden in a huge `UTXO` sequence, which is part of the SERO history, all details hidden by `Proof`. The verifier can confirm whether the input is valid by `Proof` without knowing the details. This way of hidding data is similar to the ring signature, but the `Proof` is much smaller than the ring signature, and using the zero knowledge proofs, the data range used to hide the UTXO collections is much larger than the ring signature.

### Two types of output `outs`

![image.png](https://upload-images.jianshu.io/upload_images/277023-01ae40ec8cdfb86f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

The outputs contained in the SERO transaction are divided into two forms, zero-knowledge output `Z out` and normal output `O out`.

**Z out**
`Z out` points to the temporary address `PKr`, and the temporary address can only be decrypted by the receiver. Since each temporary address is different, no third party can identify the `Z out` real point address. `Z out` also carries the encrypted information `Encrypt Info` of the asset, which can only be decrypted by the party holding the receiver's private key. And `OutCM` is the output commitment, only the parties of the transaction can reproduce the computing process of `OutCM`. `OutCM` plays a crucial role in proving that `Z out` is referenced by `ins`.

**O out**

The PKr pointed to by `O out` has two forms, one is initiated by a smart contract and points to the temporary address of the common account. The other is initiated by a normal account, pointing to the address of the smart contract. Due to the randomness of the temporary address, the third party cannot know the identity of the receiver, and the asset information carried by `O out` is public.

### The `Balance` of inputs and outputs

![image.png](https://upload-images.jianshu.io/upload_images/277023-f95d65efdd4e239d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

`Tx` packages `ins`, `Z outs`, and `O outs` together. How to prevent malicious attackers from tampering with the data and ensuring asset security? By introducing perdesen commitment, its homomorphic encryption feature enables verifiers to confirm that `Balance` must be balanced without knowing the details of the information, that is, the input is equal to the output.

In addition, in order to prevent malicious attackers from tampering with `O outs`, we use the random feature of **perdesen commitment** to sign `Tx Hash` with the random part of `Balance`. In this way, each input and output can be computed independently and then packaged together by `B-Sign`.

### Transaction Sender `From`
When the output of a transaction points to a smart contract, the smart contract sometimes needs to output resources to a given account based on the written rules. At this time, the temporary address `From` is the place where the output resources are received. `From` is determined when the transaction is generated and used only once. Other than the sender of the transaction, the third parties cannot locate the identity of the sender.



## Principle of Issuing Anonymous Tokens

#### Token Assets
Token, also known as the “homogeneous pass”, is an asset form recognized within SERO system. The same kind of tokens can be arbitrarily divided and mixed, specifically the so-called "coins". As the first currency of the SERO system, SERO coins are also a type of tokenss in essence. For Token assets, except for handling fees, which can only be paid in SERO coins, they are treated the same within the SERO system, and their privacy and security are ensured by consensus.

> Unlike the `Token` concept in Ethereum, the `Tokens` in Ethereum are only symbols of the internal records of the smart contracts, and `ETH` is the Token asset that is actually running inside Ethereum.

####Token Name
Each `Token` has a name. After the SERO system is initialized, there is only one registered token named `SERO` by default. When a smart contract issues an anonymous token, a globally unique string must be registered with the SERO system as the name of the token. The token name can greatly improve the readability of your issued assets.

#### Anonymous Token Assets

![image.png](https://upload-images.jianshu.io/upload_images/277023-dad514ff5a2f031e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

SERO's smart contracts have a very powerful feature, which is that you can issue an "anonymous Token" at will. Of course, the premise is that you need a token name that has never been registered. Once the anonymous Tokens are successfully issued, the smart contract can send the tokens to the temporary address `PKr` of a normal account in the form of a normal transaction. At this time, thess sent tokens will be separated from the smart contract account in the form of UTXO, and transfered into the user's account like SERO coins , thus being protected by SERO's privacy mechanism.

> The issue of SERO coins is achieved by miners. The process is similar to the mechanism for smart contracts to issue anonymous tokens. It is the built-in tokens distribution function of SERO.