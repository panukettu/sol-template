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

library Optimism {
  address internal constant BRIDGE_GOERLI = 0x636Af16bf2f682dD3109e60102b8E1A089FedAa8;
  address internal constant BRIDGE_MAINNET = 0x99C9fc46f92E8a1c0deC1b1747d010903E884bE1;
}

interface IOPBridge {
  /**
   * @dev Deposit an amount of ETH to a recipient's balance on L2.
   * @param _to L2 address to credit the withdrawal to.
   * @param _l2Gas Gas limit required to complete the deposit on L2.
   * @param _data Optional data to forward to L2. This data is provided
   *        solely as a convenience for external contracts. Aside from enforcing a maximum
   *        length, these contracts provide no guarantees about its content.
   */
  function depositETHTo(address _to, uint32 _l2Gas, bytes calldata _data) external payable;
}

library Arbitrum {
  address internal constant BRIDGE_GOERLI = 0x6BEbC4925716945D46F0Ec336D5C2564F419682C;
  address internal constant BRIDGE_MAINNET = 0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f;
  address internal constant BRIDGE_MAINNET_NOVA = 0xc4448b71118c9071Bcb9734A0EAc55D18A153949;
}

interface IArbitrumBridge {
  function depositEth() external payable;
}
