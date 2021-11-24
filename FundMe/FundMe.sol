// SPDX-License-Identifier: MIT
pragma solidity >= 0.6.6 <0.9.0; 
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol"; //using safemath in order to avoid overflow

contract FundMe {
    using SafeMathChainlink for uint256; //attaching satemath library to uint256 (not needed for solidity versions above 0.8.0)

    mapping (address => uint256) public addressToAmountFunded; 
    function fund() public payable {
        //minimum value of funding is 50$
        uint256 minimumUSD = 50*10**18; //multiplication by 10^18 in order to ensure 18 decimals
        require(getConversionRate(msg.value) >= minimumUSD, "you need to spend at least 50 USD"); 
        //msg.sender is the caller of the function fund()
        //msg.value is the amount sent with fund()
        addressToAmountFunded[msg.sender] += msg.value; 

        //what is ETH => USD conversion?
    }

    function getVersion() public view returns(uint256) {
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e); 
        return pricefeed.version(); 
    }

    function getPrice() public view returns(uint256)  {
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e); 
        (,int256 answer,,,) = pricefeed.latestRoundData(); 
        return uint256(answer * 10000000000); //multiplication by 10^10 is required in order to get 18 decimal places, there are only 8 by default
    }

    //this function converts any amount sent through to USDollar
    // 1000000000
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice =  getPrice(); 
        uint256 ethAmountInUSD = ( ethPrice * ethAmount)/1000000000000000000; //division by 10^18 is required to get to the Dollar Amount as ethPrice and ethAmount have 18 decimals
        return ethAmountInUSD; 

    }

    function withdraw() public payable{
        msg.sender.transfer(address(this).balance); //address of this contract, transfer all the amount of this contract to msg.sender
    }

    function withdrawold() public payable{
        msg.sender.transfer(0x8D4Cce6933DfE0b04a17F4aF3eD5e25F39067401).balance); 
    }
}