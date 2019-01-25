# SIP1: Bonus improvement plan (BETANET-R5 Release Content)

## Online Time

* **Before 00:00 Beijing time on January 26, 2019**

## Summary

* The total amount of 1 billion SERO coins will remain unchanged.
* Increase miners' share from 25% to (75+5)%.
* Based on the deflation model, it is halved in 4 years and the mining time is 101.5 years.
* Reduce the team share to 10% and release it in proportion to the miners.
* Reduce the share of financing to 10%.
* Soft fork BetaNet network.
* Burn 90% of the SERO tokens in SERO's ERC20.

## The Time of Soft Fork

* Starting from the 75,000 blocks, before the 8th day (January 27th 24:00).

  Fork height: $ 130000 $

* This fork is soft fork, which is beneficial to miners.

## SERO Protocol: The SERO coins distribution principle

* A total of 1 billion SERO coins issued：
  * BetaNet Network SERO coins changed to:
    * The standard miner's bonus is 75% (750 million SERO) per 101.5 years of minning
    * The miners community rewards 5% (50000000 SERO) in the same proportion as standard miners.
    * Team share of 10% (100000000 SERO coins) is released in the same proportion as standard miners.
  * In the SERO ERC20 smart contract, 90% of SERO tokens were burned.
  * After MainNet is online, both ERC20 SERO tokens and BetaNet SERO coins are mapped to MainNet 1:1.

## Standard miner bonus

* $[130000, 3057600)$ 2937600 blocks difference (about 17 months)
  * The bonus for each block is 66.77350574 SERO coins.
  * $[3057600,\infty)$
  * The initial bonus for each block is 33.38675287 SERO coins.
  * The bonus is halved every 8294400 blocks.
  * Until 900 million SERO coins are completely mined.

## The relationship of difficulty and bonus 

* Divided into five levels of difficulty
  * $[0, 340 million)$
    * The block bonus is 1 SERO
    * Difficulty-bonus dramatically inversely

  * $[340 million, 1.7 billion)$
    * The block bonus is `5.6+((difficulty-3.4) * 1.647)`
    * Difficulty-bonus slow proportional

  * $[1.7 billion, 4 billion)$
    * The block bonus is `28+((difficulty-17) * 0.217)`
    * Difficulty-bonus dramatically inversely

  * $[4 billion, 17 billion)$
    * The block bonus is `33+((difficulty-40) * 0.259)`
    * Difficulty-bonus slow inversely

  * $[17 billion,\infty )$
    * The block bonus is `66.77350574`
    * Difficulty-bonus dramatically inversely

## Bonus calculation method

* $Rreward_{ori}=66.773505743000000000$

* $Current \ni  [130000, 3057600) $
  * $Reward_{std}=Reward_{ori}$
* $ Current \ni [3057600, \infty) $
  * $rate_{reward}=1+[ (Current-3057600)/8294400 ]$
  * $Reward_{std}=Reward _{ori} >> rate_{reward}$

* $Diff \ni [170,\infty )$
  * $ Reward_{mine} = Reward_{std} $

* $Diff \ni  [1,3.4)$
  * $ Reward_{mine} = 1 $

* $Diff \ni  [3.4,17) $
  * $ Reward_{mine} = \frac{5.6+[1.647 \cdot (Diff-3.4)]}{Reward_{ori}} \cdot Reward_{std} $

* $Diff \ni  [17,40) $
  *  $ Reward_{mine} = \frac{28+[0.217 \cdot (Diff-17)]}{Reward_{ori}} \cdot Reward_{std} $

* $Diff \ni  [40,170) $
  * $ Reward_{mine} = \frac{33+[0.259 \cdot (Diff-40)]}{Reward_{ori}} \cdot Reward_{std} $

* $Reward_{community}=\frac{Reward_{std}}{15}$ (for every 5760 blocks)

* $Reward_{team}=\frac{Reward_{mine} \cdot 2}{15}$ (for every 5760 blocks)