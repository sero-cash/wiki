# SERO Staking (PoS) and Staking Node Introduction

 The main difference between the official release version of the SERO mainnet and the previous Betanet is the upgrade of the consensus mechanism. Joining the Staking mechanism (PoS) to participate in the consensus by verifying the outflow of the PoW provides a better cooperation between the underlying network and the ecological roles. incentive balance and can continuously optimize and adjust in the process of ecological development.

 

## Original Purpose

At this stage, more mechanisms are needed to ensure the security of the network and to deal with some other issues, including:

 

**Power Monopoly**: At present, the whole consensus of PoW mining has become a relatively unbalanced. The incentive of miners is a very fair mechanism. However, due to the lack of a reasonable evaluation system for the ecological value of blockchain at this stage, simple miners are encouraged. The mechanism makes the network security have considerable hidden dangers, such as the probability of 51% attack increases, we do not think that there is no sufficient interest to drive so the probability of 51% attack is reduced is a reasonable explanation.

**High Energy Expenditures:** Mining is a computationally intensive industry that consumes a lot of resources. Taking BTC mining as an example, the annual electricity consumption is about 49 TWh (trillion watt-hours), which is almost equivalent to the power consumption of  Singapore in one year. Therefore, some of the PoS mechanisms that can also quantify the cost can effectively reduce the actual energy consumption. With a metaphor that may not be entirely appropriate, it is like we can use thermal power generation but also use cleaner water or wind power. We must understand that the participation of PoS is not without cost, which is like a one-time investment. The return on assets and the continuous generation of income through labor makes a more complete economy.

 

**Fairness of Rewards**: In the previously released SERO BetaNet-R7.1, we have adjusted the block rewards to be related to the difficulty of the whole network to ensure that the emission of SERO coins is reasonable (and related to ecological development) in the circulation. The level of expansion, in the newly added Staking mechanism, we also define Staking's block reward as an all-network PoS participation ratio to form an automatic balance relationship which will further effectively adjust the inflation level. If the size of the computing power (productivity) and the market demand maintain a positive correlation, the proportion of investment in fixed assets affects the liquidity of the market. When the market liquidity is poor, we should reduce the return on investment in fixed assets.

**Cybersecurity:** Although it has always been considered that motives are related to costs and benefits, in reality, for a public chain that aims to develop in the long terms, we must ensure that the network is always as safe as possible rather than just ensuring threats to the network. The cost of safety is higher than the ratio of a certain market capitalization.

The bookkeeping right is in the hands of the miners and 51% of the attackers have the opportunity to attack far less than the market value of the circulation. By controlling the computing power in a short period of time, only a small amount of computing power can be rented, which can bring abnormalities. 
 By adding the Staking mechanism, the short-term computing power can be further increased by 51% so that the success rate of the attack is close to zero.

 

## SERO Staking (PoS)

SERO's Staking operation is simple,  mainly because the PoW miners are responsible for the block but the validity of the block must be confirmed by the PoS participants. Since the PoS miners are the holders of the SERO and play a part of "verifier" in the process of the block validation. The selection process is very random, so the attack cost is almost not related to the short-term computing power. If you want to ensure that the counterfeit block is valid, you'd need to get the full PoS participation.

The specific implementation principle is that the user needs to lock a part of his SERO coins for auction block vote ( ValidateShare ). When each PoW miner generates 1 block, he needs to randomly select 3 ValidateShare from the ticket pool to validate the block once. After the voting is completed, the user's SERO coins bidding for the ValidateShare will be returned and the corresponding PoS block reward will be obtained. It is worth mentioning that in order to effectively reduce the number of transactions on the whole network and to make the validity of the verification in the network after the block is further checked it is confirmed that the PoS coins used for the PoS purchase of the ballot and the block reward will be automatically settled once a week after the user participates in the PoS and are returned to the account.

The above part of the PoS block rewards the  2/8 ratio of mining output. If a block reward is 72 coins, PoW miners will get 45 of them, and PoS participants will get 18 of them. 9 will reward StakingPool (discussed later).

 

The ticket pool does not have a fixed size, which can be roughly calculated. On average, each ValidateShare will lock that part of the SERO token for 30 days . During the period of purchase concentration, the purchase price of each ValidateShare will be increased so that the entire network circulation level of the SERO token can be effectively and automatically adjusted .


 When ValidateShare is selected to vote on the block, the holder of ValidateShare needs to keep the whole node online and automatically complete the effective voting by the account. If the online vote cannot be maintained at that time, it will be treated as a discard and will not receive the block reward. .

 

So another option is to choose the equity pool node to perform voting for yourself when initiating PoS participation (when purchasing ValidateShare)  so that you don't have to keep the whole node online to get PoS revenue.



## SERO StakingNode

When ValidateShare is selected for voting, the user needs to go online through the node to participate in the voting. If the voting is not possible, the user cannot get the reward, considering the cost of the node online and the network and the need to participate in the voting of verification of block within time. Considering the hardware conditions, the user can choose to vote by a special node, which we call StakingNode.

![图片](https://uploader.shimo.im/f/2JtfYzaqhBkAQwoK.png!thumbnail)

Unlike most existing STAKING consensus blockchain networks, SERO's STAKING voting node, also known as StakingNode can be selected by any node actively by registering on the network. When registering StakingNode, the network will be based on the current network. The number of StakingNodes and the total amount of PoS participation automatically calculate the SERO coins that need to be mortgaged at the time of registration and return the registration result status to the registrant.

After successfully registering as StakingNode, you can provide your own node address to the common node. When the ordinary node participates in the PoS, you need to fill in (select) a valid StakingNode address for voting when submitting the purchase ballot (default is Own address) to participate in PoS through StakingNode to get a larger voting success rate. 

 

All the StakingNodes in the whole network will share the block rewards. For the nodes such as StakingNode, because they provide a stable voting channel and fairly distribute the service value of the PoS reward the corresponding block rewards are obtained. The 1/8 (tentative) part of the block reward.

 

The specific reward rule for StakingNode is that 5/8 will be allocated to the miners who provide the PoW computing power to obtain the billing rights, and 2/8 will be assigned to the 3 votes voted randomly for the block. The owner, 1/8, will be assigned to the StakingNode that provides voting services for the three votes.

(Note: Nodes that vote by non-StakingNode will not be able to get this 1/8 reward and the resulting 1/8 will be destroyed)

Therefore, the reward obtained by each StakingNode will be roughly determined by its proportion of the total number of votes of the StakingNode in the entire ticket pool.

![图片](https://uploader.shimo.im/f/JvDct2C53EIPp6hu.png!thumbnail)

## How to sign up for StakingNode

The SERO Staking mechanism is decentralized, so the registration method of StakingNode does not need to apply to any central organization.

 

**The specific registration method is: **
 Need to be initiated by the whole node wallet (or equity pool software) pledge on the network for a period of time (about 180 days) a certain number of SERO coin automatically register as an equity pool account, you can automatically get a StakingNode The account node identity, the specific payment amount is calculated dynamically by the whole network and prompts the registrant.

 

The number of SERO coins that need to be pledged in the equity pool registration is 200,000. After the following conditions are met, the currency can be returned to the account:

1. The equity pool is initiated by the equity pool account;

2. All ValidShares that specify the equity pool to fulfill their voting obligations complete the voting clearing.

3. Completion of 30 days since the registration of the equity pool.



After obtaining the StakingNode identity, when the ordinary user participates in the PoS to purchase the ticket , the StakingNode address can be set and the StakingNode votes for the vote.

So in order to ensure that StakingNode can provide proxy voting service stably to ensure that PoS participant's effective voting can get revenue, StakingNode needs to keep the node long-term online. If the voting rate is lower than a certain value, it will trigger the penalty mechanism.

 

 

 

 