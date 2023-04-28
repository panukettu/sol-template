// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;
import { IERC20 } from './IERC20.sol';

/* solhint-disable func-name-mixedcase */

interface ITokenTransferProxy {
  function transferFrom(address token, address from, address to, uint256 amount) external;
}

interface IAugustusSwapper {
  struct FeeStructure {
    uint256 partnerShare;
    bool noPositiveSlippage;
    bool positiveSlippageToUser;
    uint16 feePercent;
    string partnerId;
    bytes data;
  }

  function DEFAULT_ADMIN_ROLE() external view returns (bytes32);

  function ROUTER_ROLE() external view returns (bytes32);

  function WHITELISTED_ROLE() external view returns (bytes32);

  function getAdapterData(bytes32 key) external view returns (bytes memory);

  function getFeeWallet() external view returns (address);

  function getImplementation(bytes4 selector) external view returns (address);

  function getPartnerFeeStructure(address partner) external view returns (FeeStructure memory);

  function getRoleAdmin(bytes32 role) external view returns (bytes32);

  function getRoleMember(bytes32 role, uint256 index) external view returns (address);

  function getRoleMemberCount(bytes32 role) external view returns (uint256);

  function getRouterData(bytes32 key) external view returns (bytes memory);

  function getTokenTransferProxy() external view returns (address);

  function getVersion() external pure returns (string memory);

  function grantRole(bytes32 role, address account) external;

  function hasRole(bytes32 role, address account) external view returns (bool);

  function initializeAdapter(address adapter, bytes calldata data) external;

  function initializeRouter(address router, bytes calldata data) external;

  function isAdapterInitialized(bytes32 key) external view returns (bool);

  function isRouterInitialized(bytes32 key) external view returns (bool);

  function registerPartner(
    address partner,
    uint256 _partnerShare,
    bool _noPositiveSlippage,
    bool _positiveSlippageToUser,
    uint16 _feePercent,
    string memory partnerId,
    bytes calldata _data
  ) external;

  function renounceRole(bytes32 role, address account) external;

  function revokeRole(bytes32 role, address account) external;

  function setFeeWallet(address _feeWallet) external;

  function setImplementation(bytes4 selector, address implementation) external;

  function transferTokens(address token, address destination, uint256 amount) external;
}

library Utils {
  /**
   * @param fromToken Address of the source token
   * @param fromAmount Amount of source tokens to be swapped
   * @param toAmount Minimum destination token amount expected out of this swap
   * @param expectedAmount Expected amount of destination tokens without slippage
   * @param beneficiary Beneficiary address
   * 0 then 100% will be transferred to beneficiary. Pass 10000 for 100%
   * @param path Route to be taken for this swap to take place

   */
  struct SellData {
    address fromToken;
    uint256 fromAmount;
    uint256 toAmount;
    uint256 expectedAmount;
    address payable beneficiary;
    Utils.Path[] path;
    address payable partner;
    uint256 feePercent;
    bytes permit;
    uint256 deadline;
    bytes16 uuid;
  }

  struct MegaSwapSellData {
    address fromToken;
    uint256 fromAmount;
    uint256 toAmount;
    uint256 expectedAmount;
    address payable beneficiary;
    Utils.MegaSwapPath[] path;
    address payable partner;
    uint256 feePercent;
    bytes permit;
    uint256 deadline;
    bytes16 uuid;
  }

  struct SimpleData {
    address fromToken;
    address toToken;
    uint256 fromAmount;
    uint256 toAmount;
    uint256 expectedAmount;
    address[] callees;
    bytes exchangeData;
    uint256[] startIndexes;
    uint256[] values;
    address payable beneficiary;
    address payable partner;
    uint256 feePercent;
    bytes permit;
    uint256 deadline;
    bytes16 uuid;
  }

  struct Adapter {
    address payable adapter;
    uint256 percent;
    uint256 networkFee;
    Route[] route;
  }

  struct Route {
    uint256 index; //Adapter at which index needs to be used
    address targetExchange;
    uint percent;
    bytes payload;
    uint256 networkFee; //Network fee is associated with 0xv3 trades
  }

  struct MegaSwapPath {
    uint256 fromAmountPercent;
    Path[] path;
  }

  struct Path {
    address to;
    uint256 totalNetworkFee; //Network fee is associated with 0xv3 trades
    Adapter[] adapters;
  }
}

interface IParaswap {
  event Swapped(
    bytes16 uuid,
    address initiator,
    address indexed beneficiary,
    address indexed srcToken,
    address indexed destToken,
    uint256 srcAmount,
    uint256 receivedAmount,
    uint256 expectedAmount
  );

  event Bought(
    bytes16 uuid,
    address initiator,
    address indexed beneficiary,
    address indexed srcToken,
    address indexed destToken,
    uint256 srcAmount,
    uint256 receivedAmount
  );

  event FeeTaken(uint256 fee, uint256 partnerShare, uint256 paraswapShare);

  function multiSwap(Utils.SellData calldata data) external payable returns (uint256);

  function megaSwap(Utils.MegaSwapSellData calldata data) external payable returns (uint256);

  function protectedMultiSwap(Utils.SellData calldata data) external payable returns (uint256);

  function protectedMegaSwap(
    Utils.MegaSwapSellData calldata data
  ) external payable returns (uint256);

  function protectedSimpleSwap(
    Utils.SimpleData calldata data
  ) external payable returns (uint256 receivedAmount);

  function protectedSimpleBuy(Utils.SimpleData calldata data) external payable;

  function simpleSwap(
    Utils.SimpleData calldata data
  ) external payable returns (uint256 receivedAmount);

  function simpleBuy(Utils.SimpleData calldata data) external payable;

  function swapOnUniswap(
    uint256 amountIn,
    uint256 amountOutMin,
    address[] calldata path
  ) external payable;

  function swapOnUniswapFork(
    address factory,
    bytes32 initCode,
    uint256 amountIn,
    uint256 amountOutMin,
    address[] calldata path
  ) external payable;

  function buyOnUniswap(
    uint256 amountInMax,
    uint256 amountOut,
    address[] calldata path
  ) external payable;

  function buyOnUniswapFork(
    address factory,
    bytes32 initCode,
    uint256 amountInMax,
    uint256 amountOut,
    address[] calldata path
  ) external payable;

  function swapOnUniswapV2Fork(
    address tokenIn,
    uint256 amountIn,
    uint256 amountOutMin,
    address weth,
    uint256[] calldata pools
  ) external payable;

  function buyOnUniswapV2Fork(
    address tokenIn,
    uint256 amountInMax,
    uint256 amountOut,
    address weth,
    uint256[] calldata pools
  ) external payable;

  function swapOnZeroXv2(
    IERC20 fromToken,
    IERC20 toToken,
    uint256 fromAmount,
    uint256 amountOutMin,
    address exchange,
    bytes calldata payload
  ) external payable;

  function swapOnZeroXv4(
    IERC20 fromToken,
    IERC20 toToken,
    uint256 fromAmount,
    uint256 amountOutMin,
    address exchange,
    bytes calldata payload
  ) external payable;
}
