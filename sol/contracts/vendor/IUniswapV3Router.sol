// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;
import './IUniswapV3Pool.sol';

/// @title Periphery Payments
/// @notice Functions to ease deposits and withdrawals of ETH
interface IPeripheryPayments {
  /// @notice Unwraps the contract's WETH9 balance and sends it to recipient as ETH.
  /// @dev The amountMinimum parameter prevents malicious contracts from stealing WETH9 from users.
  /// @param amountMinimum The minimum amount of WETH9 to unwrap
  /// @param recipient The address receiving ETH
  function unwrapWETH9(uint256 amountMinimum, address recipient) external payable;

  /// @notice Refunds any ETH balance held by this contract to the `msg.sender`
  /// @dev Useful for bundling with mint or increase liquidity that uses ether, or exact output swaps
  /// that use ether for the input amount
  function refundETH() external payable;

  /// @notice Transfers the full amount of a token held by this contract to recipient
  /// @dev The amountMinimum parameter prevents malicious contracts from stealing the token from users
  /// @param token The contract address of the token which will be transferred to `recipient`
  /// @param amountMinimum The minimum amount of token required for a transfer
  /// @param recipient The destination address of the token
  function sweepToken(address token, uint256 amountMinimum, address recipient) external payable;
}

/// @title Self Permit
/// @notice Functionality to call permit on any EIP-2612-compliant token for use in the route
interface ISelfPermit {
  /// @notice Permits this contract to spend a given token from `msg.sender`
  /// @dev The `owner` is always msg.sender and the `spender` is always address(this).
  /// @param token The address of the token spent
  /// @param value The amount that can be spent of token
  /// @param deadline A timestamp, the current blocktime must be less than or equal to this timestamp
  /// @param v Must produce valid secp256k1 signature from the holder along with `r` and `s`
  /// @param r Must produce valid secp256k1 signature from the holder along with `v` and `s`
  /// @param s Must produce valid secp256k1 signature from the holder along with `r` and `v`
  function selfPermit(
    address token,
    uint256 value,
    uint256 deadline,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external payable;

  /// @notice Permits this contract to spend a given token from `msg.sender`
  /// @dev The `owner` is always msg.sender and the `spender` is always address(this).
  /// Can be used instead of #selfPermit to prevent calls from failing due to a frontrun of a call to #selfPermit
  /// @param token The address of the token spent
  /// @param value The amount that can be spent of token
  /// @param deadline A timestamp, the current blocktime must be less than or equal to this timestamp
  /// @param v Must produce valid secp256k1 signature from the holder along with `r` and `s`
  /// @param r Must produce valid secp256k1 signature from the holder along with `v` and `s`
  /// @param s Must produce valid secp256k1 signature from the holder along with `r` and `v`
  function selfPermitIfNecessary(
    address token,
    uint256 value,
    uint256 deadline,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external payable;

  /// @notice Permits this contract to spend the sender's tokens for permit signatures that have the `allowed` parameter
  /// @dev The `owner` is always msg.sender and the `spender` is always address(this)
  /// @param token The address of the token spent
  /// @param nonce The current nonce of the owner
  /// @param expiry The timestamp at which the permit is no longer valid
  /// @param v Must produce valid secp256k1 signature from the holder along with `r` and `s`
  /// @param r Must produce valid secp256k1 signature from the holder along with `v` and `s`
  /// @param s Must produce valid secp256k1 signature from the holder along with `r` and `v`
  function selfPermitAllowed(
    address token,
    uint256 nonce,
    uint256 expiry,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external payable;

  /// @notice Permits this contract to spend the sender's tokens for permit signatures that have the `allowed` parameter
  /// @dev The `owner` is always msg.sender and the `spender` is always address(this)
  /// Can be used instead of #selfPermitAllowed to prevent calls from failing due to a frontrun of a call to #selfPermitAllowed.
  /// @param token The address of the token spent
  /// @param nonce The current nonce of the owner
  /// @param expiry The timestamp at which the permit is no longer valid
  /// @param v Must produce valid secp256k1 signature from the holder along with `r` and `s`
  /// @param r Must produce valid secp256k1 signature from the holder along with `v` and `s`
  /// @param s Must produce valid secp256k1 signature from the holder along with `r` and `v`
  function selfPermitAllowedIfNecessary(
    address token,
    uint256 nonce,
    uint256 expiry,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external payable;
}

/// @title Interface for permit
/// @notice Interface used by DAI/CHAI for permit
interface IERC20PermitAllowed {
  /// @notice Approve the spender to spend some tokens via the holder signature
  /// @dev This is the permit interface used by DAI and CHAI
  /// @param holder The address of the token holder, the token owner
  /// @param spender The address of the token spender
  /// @param nonce The holder's nonce, increases at each call to permit
  /// @param expiry The timestamp at which the permit is no longer valid
  /// @param allowed Boolean that sets approval amount, true for type(uint256).max and false for 0
  /// @param v Must produce valid secp256k1 signature from the holder along with `r` and `s`
  /// @param r Must produce valid secp256k1 signature from the holder along with `v` and `s`
  /// @param s Must produce valid secp256k1 signature from the holder along with `r` and `v`
  function permit(
    address holder,
    address spender,
    uint256 nonce,
    uint256 expiry,
    bool allowed,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external;
}

/// @title Multicall interface
/// @notice Enables calling multiple methods in a single call to the contract
interface IMulticall {
  /// @notice Call multiple functions in the current contract and return the data from all of them if they all succeed
  /// @dev The `msg.value` should not be trusted for any method callable from multicall.
  /// @param data The encoded function data for each of the calls to make to this contract
  /// @return results The results from each of the calls passed in via data
  function multicall(bytes[] calldata data) external payable returns (bytes[] memory results);
}

/// @title Router token swapping functionality
/// @notice Functions for swapping tokens via Uniswap V3
interface ISwapRouter is IUniswapV3SwapCallback {
  struct ExactInputSingleParams {
    address tokenIn;
    address tokenOut;
    uint24 fee;
    address recipient;
    uint256 deadline;
    uint256 amountIn;
    uint256 amountOutMinimum;
    uint160 sqrtPriceLimitX96;
  }

  /// @notice Swaps `amountIn` of one token for as much as possible of another token
  /// @param params The parameters necessary for the swap, encoded as `ExactInputSingleParams` in calldata
  /// @return amountOut The amount of the received token
  function exactInputSingle(
    ExactInputSingleParams calldata params
  ) external payable returns (uint256 amountOut);

  struct ExactInputParams {
    bytes path;
    address recipient;
    uint256 deadline;
    uint256 amountIn;
    uint256 amountOutMinimum;
  }

  /// @notice Swaps `amountIn` of one token for as much as possible of another along the specified path
  /// @param params The parameters necessary for the multi-hop swap, encoded as `ExactInputParams` in calldata
  /// @return amountOut The amount of the received token
  function exactInput(
    ExactInputParams calldata params
  ) external payable returns (uint256 amountOut);

  struct ExactOutputSingleParams {
    address tokenIn;
    address tokenOut;
    uint24 fee;
    address recipient;
    uint256 deadline;
    uint256 amountOut;
    uint256 amountInMaximum;
    uint160 sqrtPriceLimitX96;
  }

  /// @notice Swaps as little as possible of one token for `amountOut` of another token
  /// @param params The parameters necessary for the swap, encoded as `ExactOutputSingleParams` in calldata
  /// @return amountIn The amount of the input token
  function exactOutputSingle(
    ExactOutputSingleParams calldata params
  ) external payable returns (uint256 amountIn);

  struct ExactOutputParams {
    bytes path;
    address recipient;
    uint256 deadline;
    uint256 amountOut;
    uint256 amountInMaximum;
  }

  /// @notice Swaps as little as possible of one token for `amountOut` of another along the specified path (reversed)
  /// @param params The parameters necessary for the multi-hop swap, encoded as `ExactOutputParams` in calldata
  /// @return amountIn The amount of the input token
  function exactOutput(
    ExactOutputParams calldata params
  ) external payable returns (uint256 amountIn);
}
