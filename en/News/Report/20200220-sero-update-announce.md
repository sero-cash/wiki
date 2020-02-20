Sero full node service upgrade announcement
==================

In order for the normal operation of the network, please upgrade the following systems to the latest version as soon as possible (before Feb. 26).
-----------------------------------

1. gero `v1.0.2-rc1`
   https://github.com/sero-cash/go-sero/releases/tag/v1.0.2-rc1

   > Note: save the state with 'admin.close ()' on the command line before stopping gero.

2. js-sero-client `1.0.2`
   Update with npm

3. go-czero-import `v1.0.2-rc1`
   git clone https://github.com/sero-cash/go-czero-import.git

This sero upgrade feature is as follows:
----------------

1. Reduce the `SERO` emissions of `POW` and `POS`
2. Add the tx hash getting API to smart contract
3. Provide and support `Abigen`