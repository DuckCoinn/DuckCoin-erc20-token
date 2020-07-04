pragma solidity ^0.5.11;

import "../Library/Freezer.sol";

contract FreezerMock is Freezer {
    function isFreezedMock(address src) public view isFreezed(src) returns (bool) {
        return true;
    }
}
