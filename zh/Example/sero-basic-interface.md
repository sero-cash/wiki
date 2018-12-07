# SERO basic interface



在SERO的智能合约[集成开发环境](http://remix.web.sero.cash)中，固化了两个`.sol`文件，其中的`serointerface.sol`是SERO智能合约发行匿名资产的`API`。你的智能合约如果想要在SERO上发行匿名的`Token`或者`Ticket`，必须继承这个文件中的`SeroInterface`基础合约。



下面我们来仔细了解一下`SeroInterface`给我们带来了什么接口：

```javascript
contract SeroInterface {
    //for token
    function sero_msg_currency() internal returns (string)
    
    function sero_issueToken(
         uint256 _total,
         string memory _currency) internal returns (bool success)
    
    function sero_balanceOf(string memory _currency) internal returns (uint256 amount)
    
    function sero_send_token(
         address _receiver,
         string memory _currency,
         uint256 _amount) internal returns (bool success)
    
    //for ticket
    function sero_msg_category() internal returns (string)
    
    function sero_msg_ticket() internal returns (bytes32 value)
    
    function sero_allotTicket(
         address _receiver,
         bytes32 _value,
         string memory _category) internal returns (bytes32 ticket)
    
    function sero_send_ticket(
         address _receiver,
         string memory _category,
         bytes32 _ticket) internal returns (bool success)
    
    //for all anonymous assets
    function sero_setCallValues(
         string memory _currency,
         uint256 _amount,
         string memory _category,
         bytes32 _ticket) internal
                 
    function sero_send(
         address _receiver,
         string memory _currency,
         uint256 _amount,
         string memory _category,
         bytes32 _ticket) internal returns (bool success)

}
```



