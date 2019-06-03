# SIP3: Reward Improvement Plan (BETANET-R7.1 Content)



## Time

- **Release Time**
  - **Before 20:00 Beijing time on May 28, 2019**
- **Fork Time**
  - **About 20:00 Beijing time on May 30, 2019 (at height of 940410)**



## Key Point

- The POW algorithm is changed from the variant of ethash to the progpow.
- Release serominer, to support GPU mining.
- Adjust the block rewards when the difficulty is too low (700G ~ 28T).
  - The minimum pow reward is 17.6 SERO.
  - The highest pow reward is 44.5 SERO.



**Note: The purpose of this fork is to change the POW algorithm, not including the pos part, pos mining will go release in June.**



## Rules Of Coin Reward

- A total of 1 billion SERO coin issued
  - 50% mine by the pow miners in 101 years
  - 30% mine by the pos miners in 101 years (release time to be determined)
  - 10% Belong to the team share，Follow the pow+pos and release it over 101 years.
  - 10% Belong to the share of financing，currently released using ERC20，after the mainnet goes online, 1:1 maps to mainnet.



## Block Reward Rule

- $[940410, 3057600)$ 
  - The block reward increase with the pow difficulty, and the highest reward for each block is 28.1
    - POW reward is 17.6 SERO
    - POS hightest reward is 10.5 SERO  (launch time to be determined)
    - The team share changes with the proportion of the block reward.
  - When the block difficulty exceeds 28T, the highest reward reaches 71.2 SERO
    - POW reward is 44.5 SERO
    - POS highest reward is 26.7 SERO  (specific rules to be determined)
- $[3057600,\infty)$
  - The highest reward for each piece is 35.6 SERO.
    - POW is 22.25 SERO
    - POS highest reward is 13.35 SERO  (specific rules to be determined)
  - The reward is halved every 8294400.
  - Until 900 million coins were fully mined.



## Difficulty and reward

- Difficulty and POW reward formula is
  $$
  Reward_{std}=985347985347985 \cdot Diff + 16910256410256400000
  $$

  $$
  Reward_{pow}=Max(Min(Reward_{std},44.5 \cdot 10^{18}),17.6 \cdot 10^{18})
  $$

  

- The relationship between pow and the highest pos reward is
  $$
  Reward_{pos} = \frac {Reward_{pow} \cdot 3}{5}
  $$

  

- Part of the team reward is
  $$
  Reward_{team} = \frac {Reward_{pow}}{5}
  $$