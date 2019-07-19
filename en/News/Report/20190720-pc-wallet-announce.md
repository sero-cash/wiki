# SERO Consensus Upgrade Announcement (PC Full Node Wallet User)

 

The latest SERO full-node program has been released, please update the program as soon as possible.

The SERO network will switch the consensus to PoS+PoW at a height of *1300000*

 

## Please note these :  

### PC Full-Node Wallet will trigger automatic update, the updated content includes:

* Wallet client
  * Please confirm the version number "v0.1.6" in the wallet's "About" dialog box.
  * If the version numbers do not match, please download the latest wallet program on github
    * Link <https://github.com/sero-cash/wallet/releases>

 

* All-node backend (gero) are included with the wallet
  * The wallet client will automatically upgrade this daemon
  * Please confirm the node version number in the wallet's "About" dialog box> is greater than "v1.0.0-rc2"
  * If it does not match, please uninstall the wallet and reinstall.
    * Uninstalling the wallet will not clear the block data
    * Please note the backup number keystore file

 

## NOTE : 

* This update replaces the account transaction balance analysis service, which may result in abnormal account balance for a period of time after the update. (The background zero-knowledge verification program will analyze the decryption block from the beginning, the CPU will calculate the balance within eight hours of full-speed operation, and then transfer the funds, there will be no loss of assets, do not panic during this period.
  * Convert the balance from the "balance" service to the "exchange" service to analyze the account balance.
  * The "exchange" service is identical to the third-party listing interface and runs more stable.

 

* If the account is abnormal, you can enter the account interface to view the progress of the analysis.
  * 