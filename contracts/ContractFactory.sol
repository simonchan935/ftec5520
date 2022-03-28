//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import 'contracts/PurchaseContract.sol';
import 'contracts/House.sol';

contract ContractFactory{
    
    function newTempContract(address house_addr, ,uint initialDeposit) external returns(address){
        House house = House(house_addr);
        TempContract temp = TempContract(house, initialDeposit);
        house.addContracts(temp);
        houseList.push(house1);
        return address(house1);
    }

}
