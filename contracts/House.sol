//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import 'contracts/PurchaseContract.sol';

contract House{
    string public name;
    string public location;
    uint public price;          //in wei
    string public status;      //Available | Selling | Sold
    address public owner;
    Contract[] public contracts;

    constructor(string memory _name, string memory _location, uint _hkd_price) public{
        owner = msg.sender;
        status = "Available";
        location = _location;
        price = _hkd_price / 23000 * 1e18;
        name = _name;
    }

    function get() view public returns(address _owner,
    string memory _name,
      string memory _location,
      uint _price,
       string memory _status,
        Contract[] memory _contracts){
        return (owner, name, location, price, status, contracts);
    }

    function getName() view public returns(string memory){
        return name;
    }

    function getLocation() view public returns(string memory){
        return location;
    }

    function getPrice() view public returns(uint){
        return price;
    }

    function setPrice(uint _price) external{
        price = _price;        
    }      

    function getStatus() view public returns(string memory){
        return status;
    }      

    function setStatus(string calldata _status) external{
        status = _status;        
    }          

    function getOwner() view public returns(address){
        return owner;
    }        

    function setOwner(address _owner) public returns(address){
        owner = _owner;
        return owner;
    }        

    function getContracts() view public returns(Contract[] memory){
        return contracts;        
    }

    function addContracts(Contract _contract) public returns(uint){
        contracts.push(_contract);        
        return contracts.length;
    }    

}