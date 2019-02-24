# Mining using SERO opensource mining pool

`sero-manual`

---

**Note:** 

* Mining in mining pool using cminer **does not require** mining license.
* Be sure to upgrade your wallet to the latest version of **R6 or above**, otherwise the remuneration from the mine pool may not be displayed at your wallet.
  * Please refer to [BetaNet-R6 Release Note](?file=News/Release/SERO-BETANET-R6)

### Basic Mining Process
1. Generate wallet address
2. Download mining client
3. Connect the mine pool
4. View mining status and revenue
5. Q&A

### Install a Full-node Wallet and Generate an Account

Note: Users who have installed their wallet and have an account can skip these steps.

##### Download a full node wallet

Download SERO's full node wallet https://github.com/sero-cash/wallet/releases

For example, the posting is that the version of wallet is **Release 0.1.4**, please select the corresponding operating system version of the wallet to download

![wallet-relase.jpg-328kB][1]

##### Data Folder

Wallet data folder, used to store wallet configuration data and log files

> - Windows `C:\Users\%username%\AppData\Roaming\SERO Wallet`
> - macOS `~/Library/Application\ Support/SERO Wallet`
> - Linux `~/.config/SERO Wallet`

Block data folder, used to store blockchain data and wallet account files

> - Windows `C:\Users\%username%\AppData\Roaming\Sero`
> - macOS `~/Library/Sero`
> - Linux `~/.config/Sero`

##### Start the Wallet

> - The first time you start the wallet, the nodes are automatically looked up.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-b328b98c4d808376.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
>   `Note: If you stay in the “Finding Node” state, please check if your PC time is up to date. `

> - click "USE THE BETA NETWORK" to enter the interface of import account or license
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-49af5000142e80dc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
> `Note: You can also import after entering the main interface of the wallet. This is not a necessary step.`

> - Click "SKIP" to enter the create new account interface
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-39eb040a758415ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
> `Note: Do not create an account repeatedly. You can also create a new account after entering the main interface of the wallet. The step is not a necessary step.`

> - Click "SKIP" or "NEXT".
> - Click "LAUNCH APPLICATION" to enter the main interface. You can see the current number of nodes and the progress of the sync block data.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-d6133ed6d0e3329e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> - Click "LAUNCH APPLICATION" to enter the main interface. You can see the current number of nodes and the progress of the sync block data.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-293cfbfdde61b6d7.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
> `Note: Please be patient and wait for the block to be synchronized. Try not to close the wallet client halfway.`

##### Create Account
> - Click "ADD ACCOUNT", enter the password, and create a new account.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-7ece222912b67c7d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
> `Note: If you need to delete a account, please find the corresponding account file in the keystore folder of the block data directory and delete it. Please make a backup or double confirmation before deleting to avoid loss SERO coins or tokens. `

> - Mining software can be configured to mine at any address in the wallet.
>   ![image.png](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/images/jianshu/15078246-e53e0efd2da88f8a.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### Copy account address

Install the wallet and open the wallet to create a wallet account. The red box in the figure below is the wallet address, copy the address.

>  ![image.png](https://upload-images.jianshu.io/upload_images/13141677-4d58b7fe97dee23b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### Download Mining Client

Github url: https://github.com/sero-cash/cminer/releases

### Connect Mining Pool

The current mining client version is 0.1.0-beta.1
Decompress the compressed package of cminer

##### Windows version
![w-c.jpg-89.4kB][3]

Right-click "start.bat" and click Edit shown below:
![w_s.jpg-243.9kB][4]

##### Mac version
![image_1d4feefmll9iv52drql5mebn39.png-23.4kB][5]

Right click on “start.command” to open the edit, as shown below:

![m_s.jpg-145.2kB][6]

##### Linux version

Edit the "start.sh" file

**In the red box：** Mine pool address, need to be replaced. The address of the current test mine pool version is: http://129.204.197.105:9999. Miners are free to choose other pools.

**In the blue box：** The account address in the miner's wallet,  needs to be replaced.

**In the green box：** Miner's machine identification, cannot exceed 8 characters. It needs to be replaced and defined by the user.

**In the yellow box：** Set the number of mining threads to be used. 0 is set the number of mining threads to CPU threads minus 1. Miners can set the number of mining threads by themselves, and the value should not exceed the maximum number of CPU threads.

After modifying the startup script, double-click to open the cpu mining.

* ### Running interface

  * **The number of CPU threads and the number of mining threads in the machine are as follows:**![c_t.jpg-68.9kB][7]
    **Yellow:** Current CPU maximum number of threads
    **Red:** Current number of mining threads

  * **HashRate display**

    ![image_1d4flc8fb1re74ela7h10jmnfm9.png-147.9kB][14]

    **Red:** Total HashRate of this machine

    **Blue：** HashRate of thread cp0

    **Yellow: ** Get the task from the mining pool.

#### View machine status and revenue in the browser

1. Open the mining pool home page in a browser (Google Chrome): http://203.195.255.129:8082 (Test Version)
2. Enter the wallet address in the middle search box.
   ![pool-serach.jpg-253.8kB][8]
3. After opening, the page is displayed as follows:
   ![miner.jpg-300.3kB][9]

#### View revenue:

![miner-amount.jpg-315.5kB][10]
**In the green box:** Immuature and unpaid balance
**In the blue box:** Pending and unpaid balance
**In the red box:** Total paid balance

#### View machine status
![mac.jpg-282kB][11]
**In the red box:** Number of miners' machines under current account
**In the blue box:** Average hashrate in 30 minutes
**In the green box:** Average hashrate in 3 hours
**In the yellow box:** The ratio of the miners' strength to the mine pool's strength under the wallet account (statistics in the last 3 hours)
The proportion of miner's total hashrate to mining pool's all hashrate under an account (data statistics for the last three hours)
**In the gray box:** If the miner number under the current account is not submitted in 15 minutes, the background of the record will become a light yellow warning, and the machine has the risk of dropping.

### Q&A
1. **Why can't find miners' records**
    Miners just mining, please note that it may take half an hour to see the statistics in the web page, just wait patiently.

2. **Mining pool paid period**
    There are hints on the front page of the mining pool, as shown in the following figure, for reference only, subject to the actual release of the paid period of the mining pool.
   ![home.jpg-119.3kB][12]

3. **Pool Fee of the mining pool**
    There is a reminder on the front page of the mining pool. The following figure is for reference only, whichever is the actual pool fee of the mining pool published.
   ![home-fee.jpg-102.7kB][13]

4. **Mining pool share revenue mode**
    PPLNS method is adopted in the mine pool. After mining a block, the pool is divided into shares according to the proportion of the miners'contribution in the last three hours.

5. **Where can I find the SERO's mine pool?**
   * The current mine pool is a trial mine pool built by the SERO team and will only operate for a period of time.
   * Mine pool is open source, so mining guilds and individuals with appropriate technical capabilities can build mining pool for community use.

[1]: http://static.zybuluo.com/erlenzi-han/xbcort74b65ltq4ot8fdw25o/wallet-relase.jpg
[2]: http://static.zybuluo.com/erlenzi-han/01z4im278qsy43b8la0afoj0/wallet_address.jpg
[3]: http://static.zybuluo.com/erlenzi-han/cogd2qoejpx99yzlt0j2y376/w-c.jpg
[4]: http://static.zybuluo.com/erlenzi-han/gktys0p12mdlkqyj3dv87ess/w_s.jpg
[5]: http://static.zybuluo.com/erlenzi-han/qjz0g269toxb7wwzpl3yriat/image_1d4feefmll9iv52drql5mebn39.png
[6]: http://static.zybuluo.com/erlenzi-han/ceu9tw9b0qiva0jaud4avw1t/m_s.jpg
[7]: http://static.zybuluo.com/erlenzi-han/rrptmffhy0c1iz10ma1c32x7/c_t.jpg
[8]: http://static.zybuluo.com/erlenzi-han/9987edgor92b10y48uqzqwq8/pool-serach.jpg
[9]: http://static.zybuluo.com/erlenzi-han/wjs6n45ak7deyi4xu1kwy3e5/miner.jpg
[10]: http://static.zybuluo.com/erlenzi-han/dyiivwrsxm7bmr8gvwmrawj7/miner-amount.jpg
[11]: http://static.zybuluo.com/erlenzi-han/uif7u0351rqd4a39aux6tb2s/mac.jpg
[12]: http://static.zybuluo.com/erlenzi-han/7q5z8wepeq3somei3k1itizy/home.jpg
[13]: http://static.zybuluo.com/erlenzi-han/gct76u6iz05zbkcnac8h9yrk/home-fee.jpg
[14]: http://static.zybuluo.com/erlenzi-han/j96ni2266at3wm98a5ztsu4r/image_1d4flc8fb1re74ela7h10jmnfm9.png
