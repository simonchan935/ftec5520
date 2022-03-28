//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import 'contracts/House.sol';

contract Contract{
    string public name;
    address public buyer;
    address public seller;
    House public property;
    uint public price;
    ContractStatus public status;

    constructor(string memory _name, House _house){
        name = _name;
        property = _house;
        buyer = msg.sender;
        seller = _house.owner();
        price = _house.price();
        status = ContractStatus(false, false, false, 0,0,0);
        _house.addContracts(this);
    }

    function get() view public returns(address _buyer,
    address _seller,
    string memory _name,
        address _house,
      uint _price,
    bool _buyerSigned,
    bool _sellerSigned,
    bool _lawyerSigned,
    uint _initialDeposit,
    uint _secondDeposit,
    uint _remainingAmount){
        return (buyer, seller, name, address(property), price, status.buyerSigned, status.sellerSigned, status.lawyerSigned
        , status.initialDeposit, status.secondDeposit, status.remainingAmount);
    }

    function getProperty() external view returns(House){
        return property;
    }
    
    function getPrice() external view returns(uint){
        return price;
    }

    function getStatus() external view returns(ContractStatus memory){
        return status;
    }    

    function validate() external view virtual returns(bool){
        return false;
    }

    /*
    Balance of this contract
    */ 
    function balanceOf() public view returns(uint){
        return address(this).balance;
    }

    /*
    Deposit asset into this contract with agreed amount
    */    
    function deposit() external payable{                                
    }   

    /*
    Withdrawn the balance of this contract to settle payment
    */    
    function withdrawn() external{
        uint amount = address(this).balance;
        require(amount > 0, "Mortgage is invalid with zero amount");        
        payable(msg.sender).transfer(amount);        
    }


}

contract TempContract is Contract{

    constructor(string _name, House _house, uint _intialDeposit) Contract(_name, _house){
        status.initialDeposit = _intialDeposit;
    }

    function validate() external view virtual override returns(bool){
        bool all_signed =  status.buyerSigned && status.sellerSigned && status.lawyerSigned;        
        bool amount_match = super.balanceOf() == status.initialDeposit;
        return all_signed && amount_match;
    }

}

contract OfficialContract is Contract{
    
    TempContract tempContract;

    constructor(string _name, TempContract _tempContract) Contract(_name, _tempContract.property()) public{
        tempContract = _tempContract;
        status.initialDeposit = _tempContract.getStatus().initialDeposit;
    }

    function validate() external view virtual override returns(bool){
        if (!tempContract.validate()) return false;
        
        return status.buyerSigned && status.sellerSigned && status.lawyerSigned;        
    }

}

struct ContractStatus{
    bool buyerSigned;
    bool sellerSigned;
    bool lawyerSigned;
    uint initialDeposit;
    uint secondDeposit;
    uint remainingAmount;
}