pragma solidity ^0.5.11;

import "./Ownable.sol";

/**

 * @notice This Contracts is an extension of the ERC20. Transfer
 * of a specific address can be blocked from by the Owner of the
 * Token Contract.
 */
contract Freezer is Ownable {
    event Freezed(address dsc);
    event Unfreezed(address dsc);

    mapping(address => bool) public freezing;

    modifier isFreezed(address src) {
        require(freezing[src] == false, "Freeze/Fronzen-Account");
        _;
    }

    /**
    * @notice The Freeze function sets the transfer limit
    * for a specific address.
    * @param dsc address The specify address want to limit the transfer.
    */
    function freeze(address dsc) external onlyOwner {
        require(dsc != address(0), "Freeze/Zero-Address");
        require(freezing[dsc] == false, "Freeze/Already-Freezed");

        freezing[dsc] = true;

        emit Freezed(dsc);
    }

    /**
    * @notice The Freeze function removes the transfer limit
    * for a specific address.
    * @param dsc address The specify address want to remove the transfer.
    */
    function unFreeze(address dsc) external onlyOwner {
        require(freezing[dsc] == true, "Freeze/Already-Unfreezed");

        delete freezing[dsc];

        emit Unfreezed(dsc);
    }
}
