# Popup Instructions and FAQ
## Instructions for use
> SERO Popup is a decentralized digital asset mobile wallet. It is based on the SERO chain and integrates the functions of creating / importing accounts, transfer and collection and can manage personal wallet accounts and multi-currency assets based on the SERO chain.
In addition, the DApp marketplace opens the door to the decentralized ecology for users. You can use one identity to travel the world of decentralized applications at any time and any place, so that blockchain technology can better integrate into your life.

## Common Issues

### Transfer Payment

### What should I do if the wallet does not open after white screen?
1.	Make sure to use the latest version of the SERO Popup wallet community, download link: https://sero.cash/app/popup.html
2.	Check whether the mobile phone network is normal.
The account balance is sufficient, but what happens if the error shows balance is insufficient?
To send transactions continuously, because of the characteristics of SERO's account model, you need to ensure that the number of available UTXO accounts is sufficient.

### What should I do if the sending transaction fails or reports an error?
1.	Check if the data is synchronized, you can view the synchronization log, "My">>"Settings">>"Check Sync Status", if there is a print log, and there are: "AddTx", "Fetch", "Remove" and other logs, indicating that account data is being synchronized, just keep the wallet running in the front end (switching to the background or exiting will interrupt synchronization) until the block is synchronized to the latest height.
2.	Check if the transaction gas fee (SERO) is sufficient.

### What should I do if the tokens disappear after importing the wallet?
1.	Check if the mobile phone network is normal.
2.	Check the node settings, "My">>"Settings">>"Node Settings", use "Node 2 (Mainland China)" in Mainland China, and "Node 1 (Global)" in other regions.
3.	Check the synchronization log, "My">>"Settings">>" Check Sync Status", if there is a print log, and there are: "AddTx", "Fetch", "Remove" and other logs, indicating that the account is synchronizing data, just keep the wallet running in the front end (switching to the background or quitting will interrupt synchronization) until the block is synchronized to the latest height.

### Account data display incorrect, how to repair the data?
1.	To repair data for a single account, click "..." in the upper right corner of the wallet to enter "Wallet Management", click the "Repair Data" button, and then keep the wallet running in the front end (switching to the background or exiting will interrupt synchronization) until the block Sync to the latest height.
2.	During the synchronization process, you can view the synchronization log, "My">>" Settings">>"Check Sync Status", if there is a print log, and there are: "AddTx", "Fetch", "Remove" and other logs, indicating that the account is syncing data. If the account has more transactions, the synchronization time will be longer, hence be patient.
3.	You can also use "My">>"Settings">>"Clear App Data". Note that this function is to clear the data of all accounts. It may take a long time to synchronize all accounts.

### What if I send to the wrong address?
After the transfer is successful, the currency has reached the collection address then transaction cannot be cancelled. If you accidentally fill in the wrong payment address when transferring money, we suggest that you contact the other party and negotiate the transfer back.
*Tips:*
If the address you filled in is copied from the exchange or other platform, please contact the customer service of the exchange or other platform directly to appeal.

## Wallet Security

### What should I do if I get errors when importing mnemonics?

**Please choose a solution according to the below table:**

|Error Message|Reason	|Solution|
|-|-|-|
|The mnemonic is incorrect|	A word in the mnemonic is wrong|Find and correct the wrong words from the [BIP39 Thesaurus](https://github.com/bitcoin/bips/blob/master/bip-0039/english.txt) and re-import the correct mnemonic words|
|The length of the mnemonic is incorrect|Excluding "v2", the length of the mnemonic word is 24 words, the number of words entered does not meet the standard	|	1. Check if the number of mnemonic words is correct |
|Re-enter the mnemonic words, separated by spaces|The mnemonic check digit is incorrect|	The last word of the mnemonic is wrong	Correct the last word from the [BIP39 Thesaurus](https://github.com/bitcoin/bips/blob/master/bip-0039/english.txt) and re-import|

### How to backup mnemonic words?

**Whoever has the mnemonic words, has the right to use the wallet, so we must do the following two points:**

- Backup mnemonic
- Keep the mnemonic properly

**Please note:**

1.	Once the mnemonic is lost, no one can get it back
2.	Don’t tell anyone mnemonic words to avoid irreparable losses

**Steps to backup mnemonic:**
1.	Copy words accurately in the order shown
2.	Confirm the mnemonic words to ensure that the words in step 1 are transcribed correctly and sorted correctly
3.	Mnemonic backup complete

### What if I forget my wallet password?
SERO Popup wallet does not support password recovery. But you can reset the password by importing the wallet. 
If you have not backed up the corresponding mnemonic words, you can enter the password repeatedly to try, there is no limit on the number of times.

### What if the wallet is stolen?
SERO Popup is a decentralized wallet that does not store the user's wallet private key and does not keep the user's assets. 
If the assets in your wallet are stolen, you should:

1. Realizing that the private key of the wallet has been leaked, immediately replace the wallet and make a wallet backup
2. Quickly transfer assets from your wallet to a new wallet
3. Troubleshoot your own private key
4. Immediately go to the jurisdiction to call the police for help
