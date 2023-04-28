// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;
import { IERC20 } from '../../contracts/vendor/IERC20.sol';
import { IWETH } from '../../contracts/vendor/IWETH.sol';
import { IUniswapV3Factory } from '../../contracts/vendor/IUniswapV3Factory.sol';
import { IUniversalRouter } from '../../contracts/vendor/IUniversalRouter.sol';
import { IParaswap } from '../../contracts/vendor/IParaswap.sol';
import { ISwapRouter } from '../../contracts/vendor/IUniswapV3Router.sol';
import { INCHV5 } from '../../contracts/vendor/1NCH.sol';
import { IUniswapV2Router02, IUniswapV2Factory } from '../../contracts/vendor/IUniswapV2.sol';
import { IPolygonZkEvmBridge, PolygonZkEvm, Arbitrum, Optimism, IArbitrumBridge, IOPBridge } from '../../contracts/interfaces/IBridges.sol';

struct Contracts {
  IWETH NATIVEW;
  IWETH ETHW;
  IERC20 USDC;
  IERC20 USDT;
  IERC20 DAI;
  IUniswapV2Factory UNIFV2;
  IUniswapV2Router02 UNIRV2;
  IUniswapV3Factory UNIFV3;
  ISwapRouter UNIRV3;
  IUniversalRouter UNIVERSAL;
  IParaswap PARASWAP;
  INCHV5 INCH;
  IPolygonZkEvmBridge zkEvmBridge;
  IArbitrumBridge arbBridge;
  IArbitrumBridge arbBridgeNova;
  IOPBridge opBridge;
}

using Bridges for Contracts global;

library Bridges {
  function depositOptimism(Contracts memory self, address to, uint256 value) internal {
    require(address(self.opBridge) != address(0), 'op-bridge-addr-0');
    require(to != address(0), 'op-bridge-to-0');
    require(value > 0, 'op-bridge-amount-0');
    self.opBridge.depositETHTo{ value: value }(to, 200000, '');
  }

  function depositArbitrum(Contracts memory self, uint256 value) internal {
    require(address(self.arbBridge) != address(0), 'arb-bridge-addr-0');
    require(value > 0, 'arb-bridge-amount-0');
    self.arbBridge.depositEth{ value: value }();
  }

  function depositZkEvm(Contracts memory self, address to, uint256 value) internal {
    require(address(self.zkEvmBridge) != address(0), 'zkevm-bridge-addr-0');
    require(to != address(0), 'zkevm-bridge-to-0');
    require(value > 0, 'zkevm-bridge-amount-0');
    self.zkEvmBridge.bridgeAsset{ value: value }(
      PolygonZkEvm.ZKEVM_ID,
      to,
      value,
      address(0),
      true,
      ''
    );
  }

  function multibridge(Contracts memory self, uint256 value) internal {
    self.depositOptimism(msg.sender, value);
    self.depositArbitrum(value);
    self.depositZkEvm(msg.sender, value);
  }
}
