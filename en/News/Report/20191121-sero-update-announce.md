Sero full node service upgrade announcement
==================

In order for the normal operation of the network, please upgrade the following systems to the latest version as soon as possible (before November 26).
-----------------------------------

1. gero v1.0.1-rc6
   https://github.com/sero-cash/go-sero/releases/tag/v1.0.1-rc6

2. js-sero-client 1.0.1-rc6
   Update with npm

3. go-czero-import v1.0.1-rc6
   git clone Https://github.com/sero-cash/go-czero-import.git

This sero upgrade feature is as follows:
----------------

1. The number of transaction outputs has been increased from 8 to 500.
2. Set checkpoint before the 207w block to increase the synchronization speed.
3. The ability to ignore the utxo of a pkr for exchange interface.
4. Reduce the runtime memory usage.