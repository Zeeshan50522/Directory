// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract Directory{

    string Name = "Directory";
    string Symbol = "D";
    uint totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping (address=>uint256)) allowance;
    mapping(address => string) public registerUser;
    address [] public registerUserAccount;
    string []  public registerUserName;
    mapping(address => mapping(address => string)) message;

    string public yourGeneratedTokenName;
    string public yourGeneratedTokenSymbol;
    uint   public yourGeneratedTokenSupply;
    uint   public yourTokenPrice;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    constructor()public {
        totalSupply = 540000000;
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success){
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender,_to,_value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success){
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender,_spender,_value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }

    function createAccount(string memory userName) public {
        transfer(address(this),1);
        registerUser[msg.sender] = userName;
        registerUserAccount.push(msg.sender);
        registerUserName.push(userName);
    }
    function createAccountToken(string memory token_name)public {
            yourGeneratedTokenName = string(abi.encodePacked("Directory_",token_name)); 
            yourGeneratedTokenSymbol = token_name;
            yourGeneratedTokenSupply = 540000000;
            yourTokenPrice = 1;
    }

    function Message(address senderAddress, string memory messageSent) public{
        message[msg.sender][senderAddress] = messageSent;
    }
}