# Mining using Gero

This article mainly explains how to install SERO from binary package and use it to mine SERO coins. For more information, please visit our [Product Technology WIKI](https://wiki.sero.cash).

# Bonus Design

SERO issued a total of 1 billion SERO coins, of which 25 % were awarded as community node contributions, that is, 250 million SERO coins were awarded to SERO miners for mining.  Mining bonus follow these rules:

* ### Bonus will be issued within 10 years, and a certain amount of SERO coins will be mined each year until 250 million SERO coins are mined.

   > **Because the initial SERO community network capacity is still relatively small, we use this strategy:**

   > * 250 million SERO coins are used as a bonus pool, when the miners succeed in generating a block, the corresponding SERO coins will be drawn from the bonus pool as a reward according to the rules.
   > * After each generation of 2,100,000 blocks, the bonus is reduced by about 1.4 times.
   > * In order to encourage miners to package more transactions, the consensus will compare the `gas usage' of the two blocks before and after.
   >     * $\frac{4}{5}$ for the block bonus when the current block consumes less than or equal to the previous block.
   >     * When the block consumption gas is greater than the previous one, you can get an extra bonus for the block reward $\frac{2}{5}$.
   > * To ensure fairness when the capacity of nodes is small, we set an initial difficulty value.
   >     * If the difficulty of generating block is less than the initial value, the bonus will be given in proportion to the initial difficulty.
   >     * If the difficulty of the block is greater than or equal to the initial value, the bonus will be paid according to the full amount.
   > * The above rules will work at the same time.

* ### Starting from the Betanet-Release version, mines will be mined with the POW consensus. At that time, the SERO tokens on it will be mapped to Main Net by 1:1, and the distribution of node maintenance bonus on the Main Net will follow the SE-Random consensus.

   > **The Versions of BetaNet**
   > * RC version: Betanet's release in release candidate will require several versions of adjustments from the official Betanet, the ledger will be cleared after the release of the RC version.
   >
   > * Release version: The official version of BetaNet will be deployed at 24:00 on January 7, 2019. The ledger will not be cleared when subsequent versions are updated.
   >
   >   `Originally scheduled for December 31, 2018, due to the influence of Christmas and New Year's Day, we feel that we are delaying for one week.`

* ### In order to ensure the initial security of the network, mining during BetaNet requires a license from the SERO team.

   > **Mining application process**
   > * Run [full node service (gero)](http://sero.cash) or [client wallet (wallet)](http://sero.cash)
   > * Import or create a mining user and get the public key address of the user.
   > * Join SERO's [miner community](https://gitter.im/sero-cash/miner?utm_source=share-link&utm_medium=link&utm_campaign=share-link) on gitter.
   >     `This step can be taken first, so that problems you encounter in using SERO can be raised in the community.`
   > * Send an email to [license@sero.vip](mailto:license@sero.vip) to explain your information and attach your public key address.
   > * The SERO team will generate a license corresponding to the public key address within 48 hours and respond to your email.
   >
   > **After the BetaNet-Releaes version is released, each application of mining will be strictly reviewed.**

# The steps mining operation

## 1. Install SERO

> **There are two options for you to install SERO on your own computer**

> * One is to install the `all-node service program (gero)` and operate the `gero` through the `command line console`.
> * The other is to install the wallet directly and operate it through the GUI interface.
>
> **`Note: This article only explains how to install the gero service from the "binary package" released by SERO.`**

> **If you want to install `gero` from `source`, please refer to**
>
> * [From Source Code -- base on CentOS7](https://wiki.sero.cash/zh/index.html?file=Start/from-the-sourcecode-base-on-centos7)
>
> **If you want to install `wallet`, please refer to**
>
> * [SERO Tutorial -- Wallet Manual](https://wiki.sero.cash/zh/index.html?file=Tutorial/manual-of-wallet)

* ### **Download the latest version of `gero` binary package via github.**
   Readers can download the latest binary package by visiting the link [https://github.com/sero-cash/go-sero/releases](https://github.com/sero-cash/go-sero/releases).

   ![image.png](https://upload-images.jianshu.io/upload_images/277023-b731e437b567c179.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

   > **In the Assets section, you can see the binary packages for different system environments**
   > * `gero-[VERSION]-darwin-amd64.tar.gz` corresponds to the 64-bit `MacOS` system
   > * `gero-[VERSION]-linux-amd64-v3.tar.gz` corresponds to 64-bit `linux3` kernel system
   > * `gero-[VERSION]-linux-amd64-v4.tar.gz` corresponds to the 64-bit `linux4` kernel system
   > * `gero-v0.3.1-beta.rc.5-windows-amd64.zip` corresponds to 64-bit `WIN7/WIN8/WIN10` system
   >
   > **When BetaNet-RC5 is released**
   > * The latest `Ubuntu & CentOS7` distribution defaults to the `Linux3` kernel.
   > * The latest `Fedora` distribution defaults to the `Linux4` kernel.
   >
   > **`Note: This article is based on the CentOS system, and other systems are similar in the use of binary packages. `**

    Take the binary package corresponding to CentOS7 as an example, first download it:

   ```sh
   $ pwd
   /root
   ```

   ```sh
   $ wget https://github.com/sero-cash/go-sero/releases/download/v0.3.1-beta.rc.5/gero-v0.3.1-beta.rc.5-linux-amd64-v3.tar.gz
   ```

   ```sh
   $ ls
   gero-v0.3.1-beta.rc.5-linux-amd64-v3.tar.gz
   ```

   ```sh
   $ tar -xvf gero-v0.3.1-beta.rc.5-linux-amd64-v3.tar.gz
   $ ls
   geropkg gero-v0.3.1-beta.rc.5-linux-amd64-v3.tar.gz
   ```

   `geropkg` is the directory that extracts the binary program. Let's see what's inside:

   ```sh
   $ ls geropkg
   attach.sh  bin  clean.sh  czero  startup.sh  stop.sh
   ```

   > **Description of each file:**
   >
   > * `czero` is the zero knowledge proofs library of SERO
   > * `bin` has SERO's main program gero in it
   > * `startup.sh` is the service startup script
   > * `stop.sh` is the service stop script
   > * `attach.sh` is the console startup script
   > * `clean.sh` is the script to clear the account data
   >     * **Note: ** After execution, the keystore directory will not be cleared, but the ledger data will be resynchronized.

* ### **Determine `datadir`**

   > * The first important directory of SERO is `datadir`, which stores synchronized account data.
   > * Another important directory is `keystore`, which contains the encrypted `account file` and the `license file` for minning, like this:
   >
   >   ![image.png](https://upload-images.jianshu.io/upload_images/277023-d8801c3d87c486e5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

   In order not to affect the synchronized data when upgrading `geropkg` in the future, we separate the data directory, such as:

   ```sh
   $ mkdir .sero-data
   $ ls -a
   . .. .sero-data geropkg gero-v0.3.1-beta.rc.5-linux-amd64-v3.tar.gz
   ```

* ### **Start `gero`**

   Execute `startup.sh` to start `gero`

   > **startup parameters of `startup.sh`**
   > ```sh
   > ./startup.sh [--datadir DATA_DIR] [--keystore KEYSTORE_DIR]
   > ```
   > Where `DATA_DIR` is used to specify the `datadir` location, and `KEYSTORE_DIR` is used to specify the location of the `keystore` directory.
   >
   > **This script follows the rules below**
   >
   > * If `keystore` is not specified, `gero` will create it under `datadir` by default.
   > * If `datadir` is not specified, `gero` will create it in the user's home directory by default.

   **Let's enter the `geropkg` directory and make sure it has a log file directory**

   ```sh
   $ cd geropkg
   $ mkdir log
   $ ls
   attach.sh  bin  clean.sh  czero  log  startup.sh  stop.sh
   ```

   **Then execute the `startup.sh` script**

   ```sh
   $ startup.sh --datadir "../sero-data"
   /root/geropkg/czero/lib/
   /root/geropkg/bin/gero --datadir=../datadir --port 60602
   ```

   **We can check `log` to determine if `gero` is working properly**

   ```sh
   $ tail -f log/gero.log
   ```

   **You will see text similar to the following**

   ![image.png](https://upload-images.jianshu.io/upload_images/277023-8397a48ee35318a9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

   As long as you see the text `IPC endpoint opened`, the startup is successful.

## 2. Create Account

* ### **Start console**
   Start the console by executing `attach.sh`
   > **Startup parameters of `attach.sh`**
   > ```sh
   > ./attach.sh [DATA_DIR]
   > ```
   > where `DATA_DIR` is used to specify the location of `datadir` when gero is started. If not specified, gero will look for `datadir` in the default location.

   ```sh
   $./attach.sh "../sero-data"
   ```

   If you see a console interface similar to the one below, the console will start successfully.

   ![image.png](https://upload-images.jianshu.io/upload_images/277023-9511643359456b35.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

* ### **Create account**
   Now we can create an account by typing the command below:

   **`Note: The greo console supports pressing [TAB] to complete the command`**

   ```JavaScript
   > personal.newAccount("123456")
   "4GYNYzECNovCniXiYi1VV58vk97U1vWF7KfSRJCTFVv95kbdVhWYX4kjkcYBpw2zzfDZfaeEqB8YhANGDGFkG3SP"
   ```
   Set the password in the `newAccount` function input. Please remember the password. If you lose it, you will lose control of the account and cannot retrieve it. The return value is the public key address `PK` of the created account.

   > `PK` can be safely given to the other party as a transfer receiving address

   If you want to view the account created by this node, you can call the following command to get the public key of all accounts:

   ```JavaScript
   > sero.accounts
   ["4GYNYzECNovCniXiYi1VV58vk97U1vWF7KfSRJCTFVv95kbdVhWYX4kjkcYBpw2zzfDZfaeEqB8YhANGDGFkG3SP"]
   ```

   For security, if the account is not used for 5 minutes after it is created, it will be locked. If the account is locked, you need to enter a password to unlock the account.

   ```JavaScript
   > sero.sendTransaction(...)
   Error: authentication needed: password or unlock
   
   > personal.unlockAccount(sero.account[0],"123456")
   true
   ```

   > Note: The bonus from mining will default to the account created by the current node, which is the account represented by `sero.account[0]`.

   The command to exit the console is:

   ```JavaScript
    > exit
   ```

## 3. Install Mining License

Next we need to apply for a license from the SERO team, which requires the following steps:

* ### **Join SERO's gitter community**
   > **The link of the community is**
   > [https://gitter.im/sero-cash/miner](https://gitter.im/sero-cash/miner)
   > ![image.png](https://upload-images.jianshu.io/upload_images/277023-fecac3360cd796e6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
   >
   > `gitter` is a free instant messaging tool in github.com. It has good integration with `gitHub` and can be logged in through gitHub/gitlab/twitter account. Some important notices about miner will be posted here.

* ### **Send an application email for the license**
   > The account has been generated above. Please send the public key `PK` of `sero.account[0]` to [license@sero.vip](mailto:license@sero.vip) by email and explain your information.
   > ![image.png](https://upload-images.jianshu.io/upload_images/277023-e72fcce8a23a8578.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

   `Note: The public key can be used as an asset acceptance addressand provided to a third party to generate transactions. Disclosure of the public key will not reveal your information in SERO. `

* ### **Install the license**
   The SERO team will generate a BetaNet mining license for you within 48 hours and reply to you.
   ![image.png](https://upload-images.jianshu.io/upload_images/277023-ce2d496f2b656112.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

   ** In your reply, you have one copy of your license in the mail body and one copy in the attachment. The two copies are identical.**

   You need to create a license directory in the keystore directory and copy the license file `BLIC.DATA` into this directory.

   ```sh
   $ cd ../datadir
   $ mkdir keystore/license
   $ echo "1169..[IGNORE]..51a85" > keystore/license/BLIC.DATA
   ```

   **The license is now installed**

   > **Safety instructions:**
   > The license is generated based on your mining public key, and the licenses generated by different public keys are different. At the time of mining, the license will be used for zero-knowledge proofs, and the proofs generated each time will be different. Therefore:
   * The license will not be exposed in the block.
   * Consensus will check if the block you generated is licensed.
   * As long as you don't reveal your tracking key `TK` and private key `SK`, it is safe to disclose the license and public key.
      * Will not reveal the identity as a miner.
      * Other users cannot use your license.

## 4. Start Mining

Now we can start mining happily, let us enter the console again, and then start mining:

```JavaScript
> miner.start()
```

The command to stop mining:

```JavaScript
> miner.stop()
```

To see if mining is in progress:
```JavaScript
> sero.mining
true
```
> return `true` to indicate that mining is under way

View the current block height:

```JavaScript
> sero.blockNumber
32165
```

See if you've mined SERO coins:

```JavaScript
> sero.getBalance(sero.account[0])
{
  tkn: {
    SERO: 2.03085359120665e+22
  }
}
```

The above unit is `Ta` (1 SERO = $10^{18}$ Ta), converted to `SERO` coins can be called:
```JavaScript
> web3.fromTa(2.03085359120665e+22)
"20308.5359120665"
```

## 5. In The End

The basic mining process starting from the binary package installation is here. If you want to learn more about the principle of `SERO` or detailed operation tutorial, you can visit our [official website](https://sero.cash) to download the white paper, or visit our [product technology wiki](https://wiki.sero.cash).