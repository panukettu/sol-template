// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.17;

import { IERC721ReceiverUpgradeable } from 'oz-upgradeable/token/ERC721/IERC721ReceiverUpgradeable.sol';
import { IERC1155ReceiverUpgradeable } from 'oz-upgradeable/token/ERC1155/IERC1155ReceiverUpgradeable.sol';

interface IUniversalRouter is IERC721ReceiverUpgradeable, IERC1155ReceiverUpgradeable {
  /// @notice Thrown when a required command has failed
  error ExecutionFailed(uint256 commandIndex, bytes message);

  /// @notice Thrown when attempting to send ETH directly to the contract
  error ETHNotAccepted();

  /// @notice Thrown when executing commands with an expired deadline
  error TransactionDeadlinePassed();

  function collectRewards(bytes calldata looksRareClaim) external;

  /// @notice Thrown when attempting to execute commands and an incorrect number of inputs are provided
  error LengthMismatch();

  /// @notice Executes encoded commands along with provided inputs. Reverts if deadline has expired.
  /// @param commands A set of concatenated commands, each 1 byte in length
  /// @param inputs An array of byte strings containing abi encoded inputs for each command
  /// @param deadline The deadline by which the transaction must be executed
  function execute(
    bytes calldata commands,
    bytes[] calldata inputs,
    uint256 deadline
  ) external payable;
}
