pragma solidity ^0.5.11;

import "./Interface/IERC20.sol";
import "./Interface/IMint.sol";
import "./Interface/IBurn.sol";

import "./Library/Ownable.sol";
import "./Library/SafeMath.sol";
import "./Library/Freezer.sol";
import "./Library/Pauser.sol";
import "./Library/Locker.sol";
import "./Library/Minter.sol";

contract DuckCoin is IERC20, IMint, IBurn, Ownable, Freezer, Pauser, Locker, Minter {
    using SafeMath for uint256;

    string public constant name = "DuckCoin";
    string public constant symbol = "DUCK";
    uint8 public constant decimals = 6;
    uint256 public totalSupply = 4000000000;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private approved;

    constructor() public Minter() {
        totalSupply = totalSupply.mul(10**uint256(decimals));
        balances[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 value)
        external
        isFreezed(msg.sender)
        isLockup(msg.sender, value)
        isPause
        returns (bool)
    {
        require(to != address(0), "DuckCoin/Not-Allow-Zero-Address");

        balances[msg.sender] = balances[msg.sender].sub(value);
        balances[to] = balances[to].add(value);

        emit Transfer(msg.sender, to, value);

        return true;
    }

    function transferWithLockup(address to, uint256 value)
        external
        onlyOwner
        isLockup(msg.sender, value)
        isPause
        returns (bool)
    {
        require(to != address(0), "DuckCoin/Not-Allow-Zero-Address");

        balances[msg.sender] = balances[msg.sender].sub(value);
        balances[to] = balances[to].add(value);

        lock(to, value);

        emit Transfer(msg.sender, to, value);

        return true;
    }

    function transferFrom(address from, address to, uint256 value)
        external
        isFreezed(from)
        isLockup(from, value)
        isPause
        returns (bool)
    {
        require(from != address(0), "DuckCoin/Not-Allow-Zero-Address");
        require(to != address(0), "DuckCoin/Not-Allow-Zero-Address");

        balances[from] = balances[from].sub(value);
        balances[to] = balances[to].add(value);
        approved[from][msg.sender] = approved[from][msg.sender].sub(value);

        emit Transfer(from, to, value);

        return true;
    }

    function mint(uint256 value) external isMinting onlyOwner isPause returns (bool) {
        totalSupply = totalSupply.add(value);
        balances[msg.sender] = balances[msg.sender].add(value);

        emit Transfer(address(0), msg.sender, value);

        return true;
    }

    function burn(uint256 value) external isPause returns (bool) {
        require(value <= balances[msg.sender], "DuckCoin/Not-Allow-Unvalued-Burn");

        balances[msg.sender] = balances[msg.sender].sub(value);
        totalSupply = totalSupply.sub(value);

        emit Transfer(msg.sender, address(0), value);

        return true;
    }

    function approve(address spender, uint256 value) external isPause returns (bool) {
        require(spender != address(0), "DuckCoin/Not-Allow-Zero-Address");
        approved[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);

        return true;
    }

    function balanceOf(address target) external view returns (uint256) {
        return balances[target];
    }

    function allowance(address target, address spender) external view returns (uint256) {
        return approved[target][spender];
    }
}
