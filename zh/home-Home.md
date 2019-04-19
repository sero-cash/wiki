# SERO是什么？

`SERO` `超零协议` `零知识证明` `区块链隐私` `匿名币`

#### **SERO系统是全球首创的，基于零知识证明技术实现隐私保护，并且能支持图灵完备智能合约运行的区块链基础设施平台。**

当前去中心化的区块链系统，比如比特币和其它公链系统，作为价值互联网的基础设施，已经迅速得到普及。像这样的公链系统，由于其去中心化的性质，不仅需要在数据流上达到共识，而且需要在涉及到该数据的计算上达到共识。在比特币系统中，数据包括用户提出的汇款交易、涉及到交易验证的计算和UXTO的更新，这类数据结构需要不断跟踪用户的账户余额。另外一类区块链系统，比如以太坊，采用基于账户的模型，构建了一个富有表现力的去中心化智能合约系统。

尽管支持智能合约的区块链系统强大并且已经富含表现力，但这些技术现在的实现缺乏交易隐私保护。在智能合约中，整个行为序列通过网络传播并记录在区块链上，因此是公开可见的。即使参与交易的各方可以创建新的假名公钥以增加其匿名性，但是每个公钥所有交易和余额的值都是公开可查的，有很多区块链分析项目的工作已经证明，通过分析这些区块链数据的交易图结构可以进行用户行为的去匿名化。

现实世界中组织的经济活动行为表明，缺乏隐私是广泛采用去中心化智能合约的主要障碍。比如企业供应链管理、金融交易、暗标拍卖、社交或网络购物行为等，有很多行为的过程其使用者认为是需要保密的。当前的匿名区块链系统，比如Zcash、Monero等，尽管在设计隐私保护加密货币方面取得了一些进展，但是这些系统放弃了可编程性，并且没探索出如何在不把交易数据以明文方式暴露给交易验证者或者矿工的情况下实现可编程性。

当前上线的这一版SERO系统解决了上述问题，这个公链系统有如下突出特点：

**1、 NIZK（非交互式零知识证明）相关算法改进**
工程化实现了基于Ben-Sasson, Eli等密码学专家关于2014年发表的"Succinct Non-Interactive Zero Knowledge for a von Neumann Architecture."论文内容，并对算法加以优化，以更适用于分布式网络中对于区块链数据结构的加密场景。

**2、加密流程优化**
针对Zcash的加密性能的诟病（往往整个交易完成需要1-2分钟），为了削减安全生成私密交易的时间，SERO CHAIN重新定义优化了整个加密过程，这个方面比Zcash当前线上版本有数十倍的性能提升。

**3、清晰、易于扩展的区块链结构**
SERO CHAIN重构了以太坊的存储结构，改为基于历史与状态混合的方式，同时，为了让基于SERO CHAIN发布的Token具备安全隐私特性，SERO CHAIN作出了部分差异化的设计，使整个结构具备强大的扩展能力。整个数据块加密流程清晰简洁，并增加了数据块的链下存储结构。

**4、图灵完备的匿名智能合约**
通过零知识证明和同态加密协议，区块链上的智能合约支持不同模式图灵完备的运行过程，DApp开发者可以自由选择，是否要进行带隐私保护属性的资产发行，计算细节是否公开。资产包括Token以及可以存储复杂数据结构的票据，通过这些匿名资产，利用图灵完备的线上智能合约，DApp可以实现例如发行隐私Token，进行暗标拍卖之类有趣的应用。

**5、实现同一智能合约调用多种Token**
SERO CHAIN当前版本可以用智能合约进行匿名的线上资产的发行和交易，并且支持在同一个智能合约中实现对在SERO CHAIN发⾏的多个不同数字资产之间的交换，这样SERO CHAIN的智能合约可以实现对不同的数字资产进行去中心化交易的功能。

**6、可控的隐私审计⽅方案**
对于某些较为复杂的商业应用领域，用户可能需要有完全信用的第三⽅对他发⽣的所有交易进⾏财务方面的审计，SERO生态的用户可以做出自主选择，决定是否给予第三⽅跟踪相关交易具体信息以便于进行审计的权限。

SERO团队经过长时间的努力，让图灵完备的智能合约真正运行在了匿名区块链系统上，极大的拓展了业界对于区块链系统的应用领域。至此开始，安全匿名虚拟货币的发行权不再为少数对密码学有深厚造诣的极客组织所独享。普通系统开发者，只要有发行匿名虚拟货币的业务需要，都可以在SERO链上发行自己的匿名代币，建立自己的隐私生态。除此之外，因为当前版本SERO链上智能合约的图灵完备性，对于发行和交换复杂数据结构的隐私票据也是支持的。匿名票据支持丰富的数据结构，极大的拓展了隐私智能合约的应用范围，让区块链应用开发者可以把业务相关数据安全的放在链上，而不用担心相关数据的隐私泄露问题。

在匿名性支持方面，SERO团队采用的是非交互式零知识证明（NIZK）技术。NIZK技术可以让完全加密的交易也可以验证其有效性，在此过程中交易各方的地址和相关的交易数据都是保密的。NIZK相比于其他的匿名手段，比如各类混币器或者环形签名技术，有其突出的优点，其最大的特色是其匿名化算法有极高的安全性并且不受环境的影响。目前计算机科学领域面世的匿名类库有zk-SNARKs，zk-STARKs，Bulletproofs等几类。综合算法的成熟度和加密执行性能，当前版本的SERO的Superk-ZK零知识证明系统采用libsnarks框架进行构建，并且为了进一步增强NIZK系统的实用性，SERO团队对libsnarks库进行了增强，在proof生成速度上相对于Zcash系统有20倍以上的提高。其改进方面包括采用效率更高的椭圆曲线和进一步改进其底层散列算法的效率等多个层面。



--



[[官网] https://sero.cash](https://sero.cash)
[[白皮书 V1.1] http://sero-media.s3-website-ap-southeast-1.amazonaws.com/SERO_CHS_V1.1.pdf](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/SERO_CHS_V1.1.pdf)
[[Twitter] https://twitter.com/SEROdotCASH](https://twitter.com/SEROdotCASH)
[[Telegram] https://t.me/SeroOfficial](https://t.me/SeroOfficial)
[[Discord] https://discordapp.com/invite/3AZVMRU](https://discordapp.com/invite/3AZVMRU)
[[Github] https://github.com/sero-cash/go-sero](https://github.com/sero-cash/go-sero)
[[Gitter Community] https://gitter.im/sero-cash/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link](https://gitter.im/sero-cash/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link)
[[SERO区块浏览器]  https://explorer.web.sero.cash/blocks.html](https://explorer.web.sero.cash/blocks.html)
[[SERO智能合约编辑器]  https://remix.web.sero.cash/](https://remix.web.sero.cash/)
[[SERO介绍视频] https://v.qq.com/x/page/s0792e921ok.html](https://v.qq.com/x/page/s0792e921ok.html)
[[SERO vs Zcash加密速度对比] https://v.qq.com/x/page/r0796jotef8.html](https://v.qq.com/x/page/r0796jotef8.html)
