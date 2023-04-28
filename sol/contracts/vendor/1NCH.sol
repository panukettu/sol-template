import { IERC20 } from './IERC20.sol';

abstract contract AggregationRouterV4 {
  struct SwapDescription {
    IERC20 srcToken;
    IERC20 dstToken;
    address payable srcReceiver;
    address payable dstReceiver;
    uint256 amount;
    uint256 minReturnAmount;
    uint256 flags;
    bytes permit;
  }

  struct SwapDescriptionNoPermit {
    IERC20 srcToken;
    IERC20 dstToken;
    address payable srcReceiver;
    address payable dstReceiver;
    uint256 amount;
    uint256 minReturnAmount;
    uint256 flags;
  }
}

interface IClipperExchangeInterface {
  struct Signature {
    uint8 v;
    bytes32 r;
    bytes32 s;
  }

  function sellEthForToken(
    address outputToken,
    uint256 inputAmount,
    uint256 outputAmount,
    uint256 goodUntil,
    address destinationAddress,
    Signature calldata theSignature,
    bytes calldata auxiliaryData
  ) external payable;

  function sellTokenForEth(
    address inputToken,
    uint256 inputAmount,
    uint256 outputAmount,
    uint256 goodUntil,
    address destinationAddress,
    Signature calldata theSignature,
    bytes calldata auxiliaryData
  ) external;

  function swap(
    address inputToken,
    address outputToken,
    uint256 inputAmount,
    uint256 outputAmount,
    uint256 goodUntil,
    address destinationAddress,
    Signature calldata theSignature,
    bytes calldata auxiliaryData
  ) external;
}

/// @title Interface for making arbitrary calls during swap
interface IAggregationExecutor {
  /// @notice Make calls on `msgSender` with specified data
  function callBytes(address msgSender, bytes calldata data) external payable; // 0x2636f7f8
}
bytes32 constant _POOL_INIT_CODE_HASH = 0xe34f199b19b2b4f47f68442619d555527d244f78a3297ea89325f843f87b8b54;

interface INCHV5 {
  /// @notice Performs swap using Uniswap V3 exchange. Wraps and unwraps ETH if required.
  /// Sending non-zero `msg.value` for anything but ETH swaps is prohibited
  /// @param recipient Address that will receive swap funds
  /// @param amount Amount of source tokens to swap
  /// @param minReturn Minimal allowed returnAmount to make transaction commit
  /// @param pools Pools chain used for swaps. Pools src and dst tokens should match to make swap happen
  function uniswapV3SwapTo(
    address payable recipient,
    uint256 amount,
    uint256 minReturn,
    uint256[] calldata pools
  ) external payable returns (uint256 returnAmount);

  /// @notice Same as `uniswapV3SwapTo` but uses `msg.sender` as recipient
  /// @param amount Amount of source tokens to swap
  /// @param minReturn Minimal allowed returnAmount to make transaction commit
  /// @param pools Pools chain used for swaps. Pools src and dst tokens should match to make swap happen
  function uniswapV3Swap(
    uint256 amount,
    uint256 minReturn,
    uint256[] calldata pools
  ) external payable returns (uint256 returnAmount);

  /// @notice Performs swap using Clipper exchange. Wraps and unwraps ETH if required.
  /// Sending non-zero `msg.value` for anything but ETH swaps is prohibited
  /// @param recipient Address that will receive swap funds
  /// @param srcToken Source token
  /// @param dstToken Destination token
  /// @param inputAmount Amount of source tokens to swap
  /// @param outputAmount Amount of destination tokens to receive
  /// @param goodUntil Timestamp until the swap will be valid
  /// @param r Clipper order signature (r part)
  /// @param vs Clipper order signature (vs part)
  /// @return returnAmount Amount of destination tokens received
  function clipperSwapTo(
    IClipperExchangeInterface clipperExchange,
    address payable recipient,
    IERC20 srcToken,
    IERC20 dstToken,
    uint256 inputAmount,
    uint256 outputAmount,
    uint256 goodUntil,
    bytes32 r,
    bytes32 vs
  ) external payable returns (uint256 returnAmount);

  function uniswapV3SwapToWithPermit(
    address payable recipient,
    IERC20 srcToken,
    uint256 amount,
    uint256 minReturn,
    uint256[] calldata pools,
    bytes calldata permit
  ) external returns (uint256 returnAmount);

  /// @notice Performs swap using Uniswap exchange. Wraps and unwraps ETH if required.
  /// Sending non-zero `msg.value` for anything but ETH swaps is prohibited
  /// @param recipient Address that will receive swapped funds
  /// @param srcToken Source token
  /// @param amount Amount of source tokens to swap
  /// @param minReturn Minimal allowed returnAmount to make transaction commit
  /// @param pools Pools chain used for swaps. Pools src and dst tokens should match to make swap happen
  function unoswapTo(
    address payable recipient,
    IERC20 srcToken,
    uint256 amount,
    uint256 minReturn,
    uint256[] calldata pools
  ) external payable returns (uint256 returnAmount);

  function swap(
    IAggregationExecutor executor,
    AggregationRouterV4.SwapDescriptionNoPermit calldata desc,
    bytes calldata permit,
    bytes calldata data
  ) external payable returns (uint256 returnAmount);

  function swap(
    IAggregationExecutor caller,
    AggregationRouterV4.SwapDescription calldata desc,
    bytes calldata data
  ) external returns (uint256 returnAmount, uint256 gasLeft);
}
