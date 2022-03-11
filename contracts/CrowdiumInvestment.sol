//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract CrowdiumInvestment is Ownable {
    //counter for txs
    using Counters for Counters.Counter;
    Counters.Counter public txCounter;
    Counters.Counter public idCounter;

    struct Investment {
        uint256 id;
        string data;
    }

    struct response {
        uint256 index;
        string data;
    }

    Investment[] public investments; //holds all investments

    //sets an investment
    function setInvestment(string memory _data) public onlyOwner {
        Investment memory _new_investment;
        _new_investment.id = idCounter.current();
        _new_investment.data = _data;
        investments.push(_new_investment);
        //tx+1
        txCounter.increment();
        idCounter.increment();
    }


    function getInvestments() public view returns(response[] memory){
        response[] memory responses_ = new response[](investments.length);
        for (uint256 i = 0; i < investments.length; i++) {
            response memory response_;
            response_.index = i;
            response_.data = investments[i].data;
            responses_[i]=response_;
        }
        return responses_;
    }

    function getInvestmentData(uint256 _index) public view returns(string memory){
        return investments[_index].data;
    }

    //update investment
    function updateInvestment(uint256 _index, string memory _data)
        public
        onlyOwner
    {
         investments[_index].data=_data;
         //tx+1
         txCounter.increment();
    }

}
