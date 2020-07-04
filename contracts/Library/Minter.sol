pragma solidity ^0.5.11;

import "../Interface/IERC20.sol";
import "./Ownable.sol";

contract Minter is Ownable {
    event Finished();

    bool public minting;

    modifier isMinting() {
        require(minting == true, "Minter/Finish-Minting");
        _;
    }

    constructor() public {
        minting = true;
    }

    function finishMint() external onlyOwner returns (bool) {
        require(minting == true, "Minter/Already-Finish");

        minting = false;

        emit Finished();

        return true;
    }
}
