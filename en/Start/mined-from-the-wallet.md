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

> - You don't need a license anymore.

### 5. Start Mining

> - Click new "Develop">"Start mining"
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-aa6fb907c86f786c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> - When the following picture appears, it means that the mining is successful started.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-bc56aa379a752b55.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
