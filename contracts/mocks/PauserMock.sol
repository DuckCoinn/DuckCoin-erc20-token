pragma solidity ^0.5.11;

import "../Library/Pauser.sol";

contract PauserMock is Pauser {
  constructor() Ownable() public {
  }
}
