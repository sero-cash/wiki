# SERO Pay 接入指南

## 接口声明

**JSON对象**
```
{
	"to": "", // 收款地址，收款码或者合约地址
	"value": "0x2544faa778090e00000", // 支付的金额
	"data": "", // 当执行合约时使用，使用serojs，packData
	"gasPrice": "0x3b9aca00", 
	"cy": "SERO",//支付的币种
	"gas": "0x1600240", 
	"gasCy": "SERO",
	"feeValue": "0x51f55bdc468000", // gas*gasPrice
	"payFrom": "", //指定支付地址，当跳转到popup支付时候，用户只能使用此地址。
	"type": "thirdpay", //固定的参数和值
	"pName":"com.test", // app id ,用户支付成功后的回调
    "pSchema":"test://" // app schema ,用户支付成功后的回调
}
```

## APP接入支付

**场景：为您的APP新增SERO Pay，获得使用SERO链上的资产支付产品的功能。**

| Invoke | Transfer | Result |
| ---- | ---- | --- |
|![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-da9b772b24ba00c3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)|![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-e349eb5e59044bdd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)|![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-ba5ae7fbde7d651b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
|

**APP 调用Popup的代码，请根据开发语言修改 **
```javascript
function openPopup() {
	var txParams = {"payFrom":"","to":"5p9kwQ5MgmABNq9XEUTwQLzCsBXfXQ6XLu8jm5hPueQ2owRWQ62RT1WGo9Cw8gj4Ld9YoBwLfZ3XeQA8guT2nCHX","value":"0x8ac7230489e80000","data":"0xf0baae20183286e1e5ed79f4b5af6aa60000c4abf2b9000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000000034d30310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a3135393034383230303300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d4f52443135393034383230303300000000000000000000000000000000000000","gasPrice":"0x3b9aca00","cy":"SERO","gas":"0x3e951","type":"thirdpay"};
    if ( plus.os.name == "Android" ) {				
        plus.runtime.launchApplication( {pname:"cash.sero.popup.community",newTask:false,extra:txParams}
        	, function ( e ) {
				plus.nativeUI.confirm( "Check that you have not installed \"SERO Popup Community\", go to download?", function(i){
					if ( i.index == 0 ) {
						plus.runtime.openURL("https://sero.cash/app/popup.html");
					}
				} );
        } );
    } else if ( plus.os.name == "iOS" ) {
		var iosParams = jsonToUrlParams(txParams);
        plus.runtime.launchApplication( {action:"seropopup://&"+iosParams}, function ( e ) {
			plus.nativeUI.confirm( "Check that you have not installed \"SERO Popup Community\", go to download?", function(i){
				if ( i.index == 0 ) {
					plus.runtime.openURL("https://sero.cash/app/popup.html");
				}
			} );
        } );
    }
}
```

## 二维码支付

**场景： 商家提供收款二维码，用户使用SERO Popup钱包扫码支付。**

| Scan | Transfer | Result |
| ---- | ---- | --- |
| ![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-3100b5d51bf33ada.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)|![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-e349eb5e59044bdd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)|![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-ba5ae7fbde7d651b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
|

**生成二维码**
```
var txParams = {"payFrom":"","to":"5p9kwQ5MgmABNq9XEUTwQLzCsBXfXQ6XLu8jm5hPueQ2owRWQ62RT1WGo9Cw8gj4Ld9YoBwLfZ3XeQA8guT2nCHX","value":"0x8ac7230489e80000","data":"0xf0baae20183286e1e5ed79f4b5af6aa60000c4abf2b9000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000000034d30310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a3135393034383230303300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d4f52443135393034383230303300000000000000000000000000000000000000","gasPrice":"0x3b9aca00","cy":"SERO","gas":"0x3e951","type":"thirdpay"};

QRCode.toCanvas(canvas, JSON.stringify(txParams), function (error) {
    if (error) console.error(error)
 });
```
**测试二维码*

![image.png](https://sero-media.s3-ap-southeast-1.amazonaws.com/images/jianshu/13141677-986ed600f6bbc986.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)



