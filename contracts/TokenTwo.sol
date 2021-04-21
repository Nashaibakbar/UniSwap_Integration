// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

contract MyToken {
    string public name_;
    string public symbol_;
    uint256 private total_supply;
    uint8 public decimal_;
    address public owner;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allownce;

    event Approval(address indexed, address indexed, uint256 indexed);
    event Transfer(address indexed, address indexed, uint256 indexed);

    constructor() {
        name_ = "Farhan Coin 2";
        symbol_ = "FAC2";
        total_supply = 2000000 * 10**18;
        decimal_ = 18;
        owner = msg.sender;
        balances[owner] += total_supply;
    }

    function totalSupply() public view returns (uint256) {
        return total_supply;
    }

    function name() public view returns (string memory) {
        return name_;
    }

    function symbol() public view returns (string memory) {
        return symbol_;
    }

    function decimals() public view returns (uint8) {
        return decimal_;
    }

    function balanceOf(address _user) public view returns (uint256 balance) {
        return balances[_user];
    }

    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(_to != address(0), "Invalid Address");
        require(_value <= balances[msg.sender]);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address spender, uint256 amount)
        public
        returns (bool success)
    {
        require(spender != address(0), "Not Valid Address ");
        require(amount <= balances[msg.sender]);
        allownce[msg.sender][spender] += amount;
        emit Approval(owner, spender, amount);
        (msg.sender, spender, amount);
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {
        return allownce[_owner][_spender];
    }

    function transferFrom(
        address _sender,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(_to != address(0), "Invalid recipient address");
        require(
            allownce[_sender][msg.sender] >= _value,
            "_sender have not enough balance"
        );
        balances[_sender] -= _value;
        balances[_to] += _value;
        allownce[_sender][msg.sender] -= _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function mint(address _from, uint256 amount) public returns (bool success) {
        require(_from != address(0), "Invalid Address...!");
        require(msg.sender == owner, "Minter is not a owner");
        balances[_from] += amount;
        total_supply += amount;
        return true;
    }

    function burn(address _from, uint256 amount) public returns (bool success) {
        require(_from != address(0), "invalid address");
        require(amount <= balances[msg.sender]);
        balances[_from] -= amount;
        total_supply -= amount;
        return true;
    }
}
