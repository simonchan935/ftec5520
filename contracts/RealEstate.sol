//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import 'contracts/House.sol';

/*
*/
contract RealEstate{
  
    address bankAddress;

    House[] houseList;
    mapping(address => House) houses;


    function newHouseForSale(string calldata _name, string calldata _location,uint hkd_price) external returns(address){
        House house1 = new House( _name, _location, hkd_price);
        houseList.push(house1);
        return address(house1);
    }

    function getHouseCount() public view returns(uint){
        return houseList.length;
    }

    function getHouseList() public view returns(House[] memory){
        return houseList;
    }
 
    function getHouse(uint _index) public view returns(address _house, address _owner,
        string memory _name,
        string memory _location,
        uint _price,
        string memory _status){

        House house = houseList[_index];
        return (address(house), house.owner(), house.name(),house.location(),house.price()
        ,house.status());
   }

    function setBank(address _bankAddress) external{
        bankAddress = _bankAddress;
    }
}