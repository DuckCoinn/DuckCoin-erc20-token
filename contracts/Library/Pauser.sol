pragma solidity ^0.5.11;

import "./Ownable.sol";

/**
 * @title Pauser

 * @notice This Contracts is an extension of the ERC20. Transfer
 * of a specific address can be blocked from by the Owner of the
 * Token Contract.
 */
contract Pauser is Ownable {
    event Pause(address pauser);
    event Resume(address resumer);

    bool public pausing;

    modifier isPause() {
        require(pausing == false, "Pause/Pause-Functionality");
        _;
    }

    function pause() external onlyOwner {
        require(pausing == false, "Pause/Already-Pausing");

        pausing = true;

        emit Pause(msg.sender);
    }

    function resume() external onlyOwner {
        require(pausing == true, "Pause/Already-Resuming");

        pausing = false;

        emit Resume(msg.sender);
    }
}
