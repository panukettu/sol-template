// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19;

library PolygonZkEvm {
  uint32 internal constant ETHEREUM_ID = 0;
  uint32 internal constant ZKEVM_ID = 1;
  address internal constant BRIDGE_GOERLI = 0xF6BEEeBB578e214CA9E23B0e9683454Ff88Ed2A7;
  address internal constant BRIDGE_MAINNET = 0x2a3DD3EB832aF982ec71669E178424b10Dca2EDe;
}

interface IPolygonZkEvmBridge {
  // Mainnet identifier

  /**
   * @notice Deposit add a new leaf to the merkle tree
   * @param destinationNetwork Network destination
   * @param destinationAddress Address destination
   * @param amount Amount of tokens
   * @param token Token address, 0 address is reserved for ether
   * @param forceUpdateGlobalExitRoot Indicates if the new global exit root is updated or not
   * @param permitData Raw data of the call `permit` of the token
   */
  function bridgeAsset(
    uint32 destinationNetwork,
    address destinationAddress,
    uint256 amount,
    address token,
    bool forceUpdateGlobalExitRoot,
    bytes calldata permitData
  ) external payable;
}
