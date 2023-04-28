// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { Test } from 'forge-std/Test.sol';
import { IERC20 } from '../../contracts/vendor/IERC20.sol';
import { IUniswapV2Pair } from '../../contracts/vendor/IUniswap.sol';
import { UniswapV2Library } from '../../contracts/vendor/UniswapV2Library.sol';
import { UniswapV2LiquidityMathLibrary } from '../../contracts/vendor/UniswapV2LiquidityMathLibrary.sol';
import { Deployments, Contracts } from '../../scripts/Util.s.sol';
import { FixedPoint } from '../../contracts/lib/FixedPoint.sol';

library LibTest {
  using LibTest for LibTest.Params;
  using FixedPoint for FixedPoint.Unsigned;

  struct Params {
    IERC20 asset;
    uint256 assetAmount;
    Contracts c;
  }
  struct Users {
    address user0;
    address user1;
    address user2;
  }

  function assetPriceV2(Params storage self, address pairToken) internal view returns (uint256) {
    IUniswapV2Pair pair = IUniswapV2Pair(self.c.UNIFV2.getPair(address(self.asset), pairToken));
    (uint256 reserve0, uint256 reserve1, ) = pair.getReserves();
    if (address(self.asset) == pair.token0()) {
      return UniswapV2Library.quote(1 ether, reserve1, reserve0);
    }
    return UniswapV2Library.quote(1 ether, reserve0, reserve1);
  }

  function removeLiquidityV2(Params storage self, address user, address pairToken) internal {
    IUniswapV2Pair pair = IUniswapV2Pair(self.c.UNIFV2.getPair(address(self.asset), pairToken));
    self.c.UNIRV2.removeLiquidity(
      address(self.asset),
      pairToken,
      pair.balanceOf(user),
      0,
      0,
      user,
      block.timestamp
    );
  }

  function sortTokensV2(
    Params storage self,
    address pairToken
  ) internal view returns (address, address) {
    return UniswapV2Library.sortTokens(address(self.asset), pairToken);
  }

  function getLPValueV2(
    Params storage self,
    address user,
    address pairToken
  ) internal view returns (uint256 amountAsset, uint256 amountOther) {
    IUniswapV2Pair pair = IUniswapV2Pair(self.c.UNIFV2.getPair(address(self.asset), pairToken));
    (address tokenA, address tokenB) = sortTokensV2(self, pairToken);

    (uint256 amountA, uint256 amountB) = UniswapV2LiquidityMathLibrary.getLiquidityValue(
      address(self.c.UNIFV2),
      tokenA,
      tokenB,
      pair.balanceOf(user)
    );

    (amountAsset, amountOther) = tokenA == address(self.asset)
      ? (amountA, amountB)
      : (amountB, amountA);
  }

  function addLiquidityPCTV2(
    Params storage self,
    address user,
    address pairToken,
    uint256 pct
  ) internal {
    IUniswapV2Pair pair = IUniswapV2Pair(self.c.UNIFV2.getPair(address(self.asset), pairToken));
    (uint256 reserveA, uint256 reserveB, ) = pair.getReserves();
    (address tokenA, address tokenB) = sortTokensV2(self, pairToken);

    uint256 amountAsset = (self.asset.balanceOf(user) * pct) / 100;
    uint256 amountOther;

    bool isAssetA = tokenA == address(self.asset);
    if (isAssetA) {
      amountOther = UniswapV2Library.quote(amountAsset, reserveA, reserveB);
    } else {
      amountOther = UniswapV2Library.quote(amountAsset, reserveB, reserveA);
    }

    self.c.UNIRV2.addLiquidity(
      tokenA,
      tokenB,
      isAssetA ? amountAsset : amountOther,
      isAssetA ? amountOther : amountAsset,
      0,
      0,
      user,
      block.timestamp
    );
  }
}
