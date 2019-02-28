# Mining using SERO Wallet Client

### 1. Install SERO Wallet



Download URL: [https://github.com/sero-cash/wallet/releases](https://github.com/sero-cash/wallet/releases)

#### Installation Package

Currently only 64-bit system is supported. Please select the corresponding system installation package to download.
- Windows :` SERO-Wallet-windows-{version}.exe`
- MacOs : `SERO-Wallet-mac-{version}.dmg`
- Linux : `SERO-Wallet-linux64-{version}.deb`

#### Data Folder
Wallet data folder, used to store wallet configuration data and log files
- Windows `C:\Users\%username%\AppData\Roaming\SERO Wallet`
- macOS `~/Library/Application\ Support/SERO Wallet`
- Linux `~/.config/SERO Wallet`

Block data folder, used to store blockchain data and wallet account files
- Windows `C:\Users\%username%\AppData\Roaming\Sero`
- macOS `~/Library/Sero`
- Linux `~/.sero`

### 2. Start the Wallet
> - The first time you start the wallet, the nodes are automatically looked up.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-b328b98c4d808376.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
>
> `Note: If you stay in the “Finding Node” state, please check if your PC time is up to date. `

> - click "USE THE BETA NETWORK" to enter the interface of import account or license
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-49af5000142e80dc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
>
> `Note: You can also import after entering the main interface of the wallet. This is not a necessary step.`

> - Click "SKIP" to enter the create new account interface
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-39eb040a758415ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
>
> `Note: Do not create an account repeatedly. You can also create a new account after entering the main interface of the wallet. The step is not a necessary step.`

> - Click "SKIP" or "NEXT".
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-d6133ed6d0e3329e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> - Click "LAUNCH APPLICATION" to enter the main interface. You can see the current number of nodes and the progress of the sync block data.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-293cfbfdde61b6d7.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
>
> `Note: Please be patient and wait for the block to be synchronized. Try not to close the wallet client halfway.`

### 3. Create Account

> - Click "ADD ACCOUNT", enter the password, and create a new account.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-7ece222912b67c7d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
>
> `Note: If you need to delete a account, please find the corresponding account file in the keystore folder of the block data directory and delete it. Please make a backup or double confirmation before deleting to avoid loss SERO coins or tokens. `

> - The account marked "Serobase" is the primary account. Please use this account to apply for a license, as well as mining.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-e53e0efd2da88f8a.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
>
> `Note: only one account can be used for mining in a wallet. `

### 4. Import License

Next, we need to apply for a license from the SERO team, and we need to do the following steps:

* ### **Join SERO's gitter community**
    > **The link of the community**
    > [https://gitter.im/sero-cash/miner](https://gitter.im/sero-cash/miner)
    > ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-fecac3360cd796e6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
    >
    > `gitter` is github.com's free instant messaging tool with good integration with `github`, which can be logged in via github/gitlab/twitter account. Some important notices about miner will be posted here.

* ### **Send application email**
    > The account has been generated above. Please send the account address of the tag `Serobase` to [license@sero.vip](mailto:license@sero.vip) by email and explain your information.
    > ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-e72fcce8a23a8578.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

    `Note: This address can be used as an asset acceptance address and can be provided to third parties to generate transactions. Disclosure the public key will not reveal your information in SERO.`

* ### **Install mining license**

> - The SERO team will generate a BetaNet mining license for you within 48 hours and will reply to you.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/277023-ce2d496f2b656112.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
>   **In your reply, you have one copy of your license in the mainbody and one copy in the attachment. The two copies are identical.**

> - Click the menu "Accounts"> "Import account or mining license", as shown in the figure below, to open the import interface.  At this time, just drag and drop the file named `BLIC.DATA` into the box.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-b277de832cd7235f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 5. Start Mining

> - Click new "Develop">"Start mining"
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-aa6fb907c86f786c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> - When the following picture appears, it means that the mining is successful started.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-bc56aa379a752b55.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
