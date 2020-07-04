pragma solidity ^0.5.11;

import "../Interface/IERC20.sol";
import "./Ownable.sol";
import "./SafeMath.sol";

contract Locker is Ownable {
    event LockedUp(address target, uint256 value);

    using SafeMath for uint256;

    mapping(address => uint256) public lockup;

    modifier isLockup(address _target, uint256 _value) {
        uint256 balance = IERC20(address(this)).balanceOf(_target);
        require(
            balance.sub(_value, "Locker/Underflow-Value") >= lockup[_target],
            "Locker/Impossible-Over-Lockup"
        );
        _;
    }

    function lock(address target, uint256 value) internal onlyOwner returns (bool) {
        lockup[target] = lockup[target].add(value);
        emit LockedUp(target, lockup[target]);
    }

    function decreaseLockup(address target, uint256 value) external onlyOwner returns (bool) {
        require(lockup[target] > 0, "Locker/Not-Lockedup");

        lockup[target] = lockup[target].sub(value, "Locker/Impossible-Underflow");

        emit LockedUp(target, lockup[target]);
    }

    function deleteLockup(address target) external onlyOwner returns (bool) {
        require(lockup[target] > 0, "Locker/Not-Lockedup");

        delete lockup[target];

        emit LockedUp(target, 0);
    }
}
