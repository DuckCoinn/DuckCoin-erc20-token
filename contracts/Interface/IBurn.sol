pragma solidity ^0.5.11;

interface IBurn {
    function burn(uint256 _value) external returns(bool);
}