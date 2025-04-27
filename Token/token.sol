// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// ERC Token Standard #20 Interface
interface ERC20Interface {
    function totalSupply() external view returns (uint);
    function balanceOf(address tokenOwner) external view returns (uint balance);
    function allowance(address tokenOwner, address spender) external view returns (uint remaining);

    function transfer(address to, uint tokens) external returns (bool success);
    function approve(address spender, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Burn(address indexed from, uint tokens);
    event Mint(address indexed to, uint tokens);
}

// Actual token contract
contract CustomToken is ERC20Interface {
    string public symbol = "CTK";
    string public name = "Custom Token";
    uint8 public decimals = 18; // Use the same decimals as ETH for simplicity
    uint256 private _totalSupply;

    mapping(address => uint) private balances;
    mapping(address => mapping(address => uint)) private allowed;

    constructor() {
        _totalSupply = 1000000 * (10**uint256(decimals));
        balances[msg.sender] = _totalSupply;
    }

    function totalSupply() public override view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public override returns (bool success) {
        require(tokens <= balances[msg.sender]);

        balances[msg.sender] -= tokens;
        balances[to] += tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function approve(address spender, uint256 tokens) public override returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function allowance(address tokenOwner, address spender) public override view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

    function transferFrom(address from, address to, uint256 tokens) public override returns (bool success) {
        require(tokens <= balances[from]);
        require(tokens <= allowed[from][msg.sender]);

        balances[from] -= tokens;
        allowed[from][msg.sender] -= tokens;
        balances[to] += tokens;
        emit Transfer(from, to, tokens);
        return true;
    }

    // Custom function to burn tokens
    function burn(uint256 tokens) public returns (bool success) {
        require(tokens <= balances[msg.sender]);

        balances[msg.sender] -= tokens;
        _totalSupply -= tokens;
        emit Burn(msg.sender, tokens);
        return true;
    }

    // Custom function to mint new tokens
    function mint(address to, uint256 tokens) public returns (bool success) {
        balances[to] += tokens;
        _totalSupply += tokens;
        emit Mint(to, tokens);
        return true;
    }
}
