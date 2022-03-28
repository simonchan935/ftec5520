//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

/* Users with account
0: Bank 0x7FA5AF3B12202c0304B4Cdd4FB38CAaEff0A1A68
1: Alice 0xfEDd9796390647a1c1375072FE7A6B870691e299
2: Bob 0xe14c7827B0C3B10D5D5E3083fB782F3B3C01f909
3: Lawyer / Notary 0xa4400C4EbDa4c65F3EFDb9367119a07f535b0C1a
4: IRD = Inland Revenue Department 0xA644AA3d7bD163Ea2AF302F567e2653e83247B14

*/
contract Users{
    
    string userGp;
    address payable[] users;
    
    
    function setup(
    address payable bank,
    address payable buyer,
    address payable seller,
    address payable lawyer,
    address payable ird
    ) external {
        users.push(bank);
        users.push(buyer);
        users.push(seller);
        users.push(lawyer);
        users.push(ird);
    }

    function getBank() external view returns(address payable){
        return users[0];
    }
    function getBuyer() external view returns(address payable){
        return users[1];
    }
    function getSeller() external view returns(address payable){
        return users[2];
    }
    function getLawyer() external view returns(address payable){
        return users[3];
    }
    function getIRD() external view returns(address payable){
        return users[4];
    }
}
