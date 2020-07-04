pragma solidity ^0.5.0;

import "../Library/Ownable.sol";

contract OwnableMock is Ownable {

    constructor() Ownable() public {

	  }

    function transferOwnershipMock(address account) public {
         _transferOwnership(account);
    }
}
