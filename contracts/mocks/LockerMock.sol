pragma solidity ^0.5.11;

import "../Library/Locker.sol";

contract LockerMock is Locker {
  constructor() Ownable() public {
  }

  function lockMock(address target, uint256 value) external onlyOwner returns (bool) {
    return lock(target,value);
  }
}
