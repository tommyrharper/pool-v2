// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.7;

import { IERC20 } from "../../modules/erc20/contracts/interfaces/IERC20.sol";

import { IERC4626 } from "./IERC4626.sol";

interface IPool is IERC20, IERC4626 {

    /**************/
    /*** Events ***/
    /**************/

    /**
     *  @dev   `newOwner_` has accepted the transferral of RDT ownership from `previousOwner_`.
     *  @param previousOwner_ The previous RDT owner.
     *  @param newOwner_      The new RDT owner.
     */
    event OwnershipAccepted(address indexed previousOwner_, address indexed newOwner_);

    /**
     *  @dev   `owner_` has set the new pending owner of RDT to `pendingOwner_`.
     *  @param owner_        The current RDT owner.
     *  @param pendingOwner_ The new pending RDT owner.
     */
    event PendingOwnerSet(address indexed owner_, address indexed pendingOwner_);

    /***********************/
    /*** State Variables ***/
    /***********************/

    /**
     *  @dev The address of the account that is allowed to update the vesting schedule.
     */
    function manager() external view returns (address owner_);

    /************************/
    /*** Staker Functions ***/
    /************************/

    /**
     *  @dev    Does a ERC4626 `deposit` with a ERC-2612 `permit`.
     *  @param  assets_   The amount of `asset` to deposit.
     *  @param  receiver_ The receiver of the shares.
     *  @param  deadline_ The timestamp after which the `permit` signature is no longer valid.
     *  @param  v_        ECDSA signature v component.
     *  @param  r_        ECDSA signature r component.
     *  @param  s_        ECDSA signature s component.
     *  @return shares_   The amount of shares minted.
     */
    function depositWithPermit(uint256 assets_, address receiver_, uint256 deadline_, uint8 v_, bytes32 r_, bytes32 s_) external returns (uint256 shares_);

    /**
     *  @dev    Does a ERC4626 `mint` with a ERC-2612 `permit`.
     *  @param  shares_    The amount of `shares` to mint.
     *  @param  receiver_  The receiver of the shares.
     *  @param  maxAssets_ The maximum amount of assets that can be taken, as per the permit.
     *  @param  deadline_  The timestamp after which the `permit` signature is no longer valid.
     *  @param  v_         ECDSA signature v component.
     *  @param  r_         ECDSA signature r component.
     *  @param  s_         ECDSA signature s component.
     *  @return assets_    The amount of shares deposited.
     */
    function mintWithPermit(uint256 shares_, address receiver_, uint256 maxAssets_, uint256 deadline_, uint8 v_, bytes32 r_, bytes32 s_) external returns (uint256 assets_);


    /**********************/
    /*** View Functions ***/
    /**********************/

    /**
     *  @dev    Returns the amount of underlying assets owned by the specified account.
     *  @param  account_ Address of the account.
     *  @return assets_  Amount of assets owned.
     */
    function balanceOfAssets(address account_) external view returns (uint256 assets_);

}