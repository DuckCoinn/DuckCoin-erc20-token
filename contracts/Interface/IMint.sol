pragma solidity ^0.5.11;

interface IMint {
    function mint(uint256 _value) external returns (bool);
    function finishMint() external returns (bool);
}
