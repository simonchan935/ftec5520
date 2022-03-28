//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;


contract Bank{

    bool inited;
    string name;

    User[] userList;
    mapping(address => User) users;
    mapping(address => Account) accounts;
    mapping(address => uint) balances;

    //TODO
    function setup(string calldata _name) external {
        require(!inited, "This Bank has already been setup.");
        name = _name;

        //setup users and accounts
        //openAccount("Alice");   //acc: 1
        //openAccount("Bob");
        //openAccount("LawFighter");
        //openAccount("IRD");


        //setup account manager
        AccountManager manager = new AccountManager(this);

        //setup balances : 10ETH       


        inited = true;
    }


    function newUser(string calldata _username) private returns(User memory){
        User memory user = User(msg.sender, _username);
        users[msg.sender] = user;
        return user;
    }

    /*
    * Create an account by given name
    */
    function openMyAccount(string calldata _username) external returns(address){                
        require(users[msg.sender].addr == address(0));
        require(accounts[msg.sender].state == STATE.INACTIVE);
        User memory owner = newUser(_username);
        userList.push(owner);
        Account memory newAccount = Account(owner, STATE.ACTIVE);
        accounts[newAccount.owner.addr] = newAccount;
        balances[newAccount.owner.addr] = 0;
        return owner.addr;
    }

    function getMyAccount() external view returns(Account memory){
        return accounts[msg.sender];
    }

    function getMyBlances() external view returns(uint) {
        return balances[msg.sender];
    }    
    

    function withdrawn(uint amount) external{
        require(balances[msg.sender] >= amount, "The amount is not sufficent!");
        payable(msg.sender).transfer(amount);
        balances[msg.sender] -= amount;
    }

    function deposit() external payable returns(bool){        
        balances[msg.sender] += msg.value;
        return true;
    }   

    function transferEther(address payable receipient, uint amount) public{
        uint w = amount * 1e18;
        require(balances[msg.sender] >= w, "Amount not sufficient for transfer.");
        receipient.transfer(w); //transfer actual wei to receipient
        balances[msg.sender] -= w;
    }
    
    /*
    Balance of this bank in wei
    */ 
    function balanceOf() external view returns(uint){
        return address(this).balance;
    }

    function getAddress() public view returns(address){
        return address(this);
    }

}


struct User{
    address addr;
    string name;
    //address[] accountAddrs;    
}

    enum STATE {INACTIVE, ACTIVE}

struct Account{
    User owner;
    STATE state;    
}

contract AccountManager{

    address bankAddress;

    constructor(Bank bank) {
        bankAddress = address(bank);
    }

    function setBank(address _bankAddress) external {
        bankAddress = _bankAddress;
    }

    function getBank() public view returns(Bank){
        return Bank(bankAddress);
    }

    function getAccount() public returns(Account memory){
        Bank bank = getBank();
        return bank.getMyAccount();
    }

    function activate() external{
        Account memory acc = getAccount();
        acc.state =  STATE.ACTIVE;
    }

    function deactivate() external{
        Account memory acc = getAccount();
        acc.state =  STATE.INACTIVE;
    }

    function getMyBlances() external view returns(uint) {
        Bank bank = getBank();
        return bank.getMyBlances();
    }
    


}

