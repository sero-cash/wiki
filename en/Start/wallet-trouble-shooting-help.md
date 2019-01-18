# SERO Wallet Trouble Shooting Help


#### How to contact the SERO team?
---
> - The URL of the SERO Development Community: [https://gitter.im/sero-cash/wallet](https://gitter.im/sero-cash/wallet)
> - `gitter'is a free instant communication tool for github.com, which has good integration with `github`, and can be logged in through github/gitlab/twitter account. Some important notices about wallets will be published there.

#### How to view wallet logs?
---
> 1. Open the log file as shown below:
![image.png](https://upload-images.jianshu.io/upload_images/13141677-4b9642b60df09133.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
> 2. Locate the log files, node.log is the current log file, node.log.{x} are the history log files.

#### Why can't SERO coins be displayed in the wallet?

---
First, the SERO wallet client is only a visual desktop tool of the SERO chain. To ensure that the wallet works properly, the following processes are needed:

> 1. Wallet has synchronized all blocks
> 2. Because of the characteristics of anonymous coins, the wallet will parse the status of all accounts. This process is in the block synchronization process, so it will take some time. Please wait patiently.
> 3. After completing the above two points, if there are still problems, please send the latest log to the SERO team.

#### Why can not find nodes?
---
> 1. Please check if your network is in a normal state
> 2. Please check if your computer time is accurate
> 3. After completing the above two points, if you have any questions, please send the latest logs to the SERO team.

#### Why start mining failure?
---
> 1. Please confirm that you have applied for a mining license and imported it into your wallet
> 2. Please confirm whether the mining main account matches the mining license
> 3. After completing the above two points, if you have any questions, please send the latest log to the SERO team.

#### How to delete an account?
---
>Q: When I created an account, I created / imported several more accounts. Can I delete the redundant accounts?
>A:
> 1. To prevent the risk of accidental deletion of the accounts, the SERO wallet does not have the function of deleting the accounts. However, you can manually delete the corresponding files in the block data directory, pay attention to backup or secondary confirmation before deleting.
> 2. The directory of the account:
> - Windows `C:\Users\%username%\AppData\Roaming\Sero\keystore`
> - macOS `~/Library/Sero/keystore`
> - Linux `~/.sero/keystore `

#### Can Windows set the data directory?
---
> Q: The data directory of the wallet is in the C drive, but my system disk space is very small. Can I set the data directory to other drive?
> A: When Windows is installed, you can select the data directory to install. Note: Please start the wallet with a shortcut, because the configuration of the data directory is written in the startup file of the shortcut.

#### Can node be configured manually?
---
>Q: When I start the wallet, the wallet will automatically detect the update. However, sometimes the network is not good, there will be incorrect prompts for file hash. Can you configure node manually?
>A: You can manually configure the node.

1. First download the latest configuration file
> - The url is:
[http://sero-media.s3-website-ap-southeast-1.amazonaws.com/clients/clientBinaries.json](http://sero-media.s3-website-ap-southeast-1.amazonaws.com/clients/clientBinaries.json)
> - When the download is complete, overwrite the configuration file:
> - Windows `C:\Users\%username%\AppData\Roaming\SERO Wallet\clientBinaries.json`
> - macOS `~/Library/Application\ Support/SERO Wallet/clientBinaries.json`
> - Linux `~/.config/SERO Wallet/clientBinaries.json`

2. Download the gero compressed package for the corresponding system
> - See github releases posted by SERO team for the download address.
[https://github.com/sero-cash/go-sero/releases](https://github.com/sero-cash/go-sero/releases)
> - When the download is complete, copy the file to the following directory and name it archive.zip|tar, such as archive.zip for Windows. Then unzip to the unpacked directory.
> - The correct directory structure after decompression is as follows:
> - Windows `C:\Users\%username%\AppData\Roaming\SERO Wallet\binaries\gero\unpacked\geropkg`
> - macOS `~/Library/Application\ Support/SERO Wallet/binaries/gero/unpacked/geropkg`
> - Linux `~/.config/SERO Wallet/binaries/gero/unpacked/geropkg`

3. Copy the executable file of gero
> - Windows `cppy ./unpacked/geropkg/bin/gero.exe to ./unpacked/`
> - macOS `copy ./unpacked/geropkg/bin/gero to ./unpacked/`
> - Linux `copy ./unpacked/geropkg/bin/gero to ./unpacked/`
`Note: There should be a gero executable file and a geropkg folder in the path ./unpacked/`

4. Restart the SERO wallet

#### How to start script mining?

---

1. Find the path of the script:
>`C:\Users\%username%\AppData\Roaming\SERO Wallet\binaries\gero\unpacked\geropkg`

2. Start gero node
>Double click startup.bat, Don't close the window after opening it, just minimize it.
>![image.png](https://upload-images.jianshu.io/upload_images/13141677-a191e72f201d0ab9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3. Connect to gero nodes
>Double click attach.bat, run attach.bat
>![image.png](https://upload-images.jianshu.io/upload_images/13141677-25a2e01876377569.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

4. Start mining
>Input `miner.start(2);`, "2" is the number of threads, which can be adjusted according to requirements.
>![image.png](https://upload-images.jianshu.io/upload_images/13141677-0ed38055b0390e8c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

5. Check the mining status
>Input `sero.minging; `, If you see "true", it means that you have successfully opened the mine, “false” means you have failed.
>![image.png](https://upload-images.jianshu.io/upload_images/13141677-6f13934708267373.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

6. View balance
>Input `web3.fromTa(sero.getBalance(sero.coinbase).tkn.SERO);` 
>
>If the above command fails, use the following command:
>
>`sero.getBalance(sero.coinbase)`
>
>`web3.fromTa(number); ` You can convert numbers into SERO units by pasting them in parentheses.
>![image.png](https://upload-images.jianshu.io/upload_images/13141677-21735e739c899978.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

7. Stop mining
>Input  `miner.stop();` to stop mining
