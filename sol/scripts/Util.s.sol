import { IERC20 } from '../contracts/vendor/IERC20.sol';
import { IWETH } from '../contracts/vendor/IWETH.sol';
import { INCHV5 } from '../contracts/vendor/1NCH.sol';
import { IUniswapV2Router02, IUniswapV2Factory } from '../contracts/vendor/IUniswapV2.sol';
import { IParaswap } from '../contracts/vendor/IParaswap.sol';
import { ISwapRouter } from '../contracts/vendor/IUniswapV3Router.sol';
import { IUniswapV3Factory } from '../contracts/vendor/IUniswapV3Factory.sol';
import { IUniversalRouter } from '../contracts/vendor/IUniversalRouter.sol';

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
}

abstract contract Deployments {
  function mainnet() internal pure returns (Contracts memory) {
    return
      Contracts({
        ETHW: IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2),
        NATIVEW: IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2),
        USDC: IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48),
        USDT: IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7),
        DAI: IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F),
        UNIFV2: IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f),
        UNIRV2: IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D),
        UNIRV3: ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564),
        UNIFV3: IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984),
        UNIVERSAL: IUniversalRouter(0xEf1c6E67703c7BD7107eed8303Fbe6EC2554BF6B),
        INCH: INCHV5(0x1111111254EEB25477B68fb85Ed929f73A960582),
        PARASWAP: IParaswap(0xDEF171Fe48CF0115B1d80b88dc8eAB59176FEe57)
      });
  }

  function polygon() internal pure returns (Contracts memory) {
    return
      Contracts({
        NATIVEW: IWETH(0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270),
        ETHW: IWETH(0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619),
        USDC: IERC20(0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174),
        USDT: IERC20(0xc2132D05D31c914a87C6611C10748AEb04B58e8F),
        DAI: IERC20(0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063),
        UNIFV2: IUniswapV2Factory(0x5757371414417b8C6CAad45bAeF941aBc7d3Ab32),
        UNIRV2: IUniswapV2Router02(0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff),
        UNIRV3: ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564),
        UNIFV3: IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984),
        UNIVERSAL: IUniversalRouter(0x4C60051384bd2d3C01bfc845Cf5F4b44bcbE9de5),
        INCH: INCHV5(0x1111111254EEB25477B68fb85Ed929f73A960582),
        PARASWAP: IParaswap(0xDEF171Fe48CF0115B1d80b88dc8eAB59176FEe57)
      });
  }

  function bsc() internal pure returns (Contracts memory) {
    return
      Contracts({
        NATIVEW: IWETH(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c),
        ETHW: IWETH(0x2170Ed0880ac9A755fd29B2688956BD959F933F8),
        USDC: IERC20(0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d),
        USDT: IERC20(0x55d398326f99059fF775485246999027B3197955),
        DAI: IERC20(0x1AF3F329e8BE154074D8769D1FFa4eE058B1DBc3),
        UNIFV2: IUniswapV2Factory(0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73),
        UNIRV2: IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E),
        UNIRV3: ISwapRouter(address(0)),
        UNIFV3: IUniswapV3Factory(address(0)),
        UNIVERSAL: IUniversalRouter(0x5Dc88340E1c5c6366864Ee415d6034cadd1A9897),
        INCH: INCHV5(0x1111111254EEB25477B68fb85Ed929f73A960582),
        PARASWAP: IParaswap(0xDEF171Fe48CF0115B1d80b88dc8eAB59176FEe57)
      });
  }

  function optimism() internal pure returns (Contracts memory) {
    return
      Contracts({
        NATIVEW: IWETH(0x4200000000000000000000000000000000000006),
        ETHW: IWETH(0x4200000000000000000000000000000000000006),
        USDC: IERC20(0x7F5c764cBc14f9669B88837ca1490cCa17c31607),
        USDT: IERC20(0x94b008aA00579c1307B0EF2c499aD98a8ce58e58),
        DAI: IERC20(0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1),
        UNIFV2: IUniswapV2Factory(address(0)),
        UNIRV2: IUniswapV2Router02(address(0)),
        UNIRV3: ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564),
        UNIFV3: IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984),
        UNIVERSAL: IUniversalRouter(0xb555edF5dcF85f42cEeF1f3630a52A108E55A654),
        INCH: INCHV5(0x1111111254EEB25477B68fb85Ed929f73A960582),
        PARASWAP: IParaswap(0xDEF171Fe48CF0115B1d80b88dc8eAB59176FEe57)
      });
  }

  function arbitrum() internal pure returns (Contracts memory) {
    return
      Contracts({
        NATIVEW: IWETH(0x82aF49447D8a07e3bd95BD0d56f35241523fBab1),
        ETHW: IWETH(0x82aF49447D8a07e3bd95BD0d56f35241523fBab1),
        USDC: IERC20(0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8),
        USDT: IERC20(0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9),
        DAI: IERC20(0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1),
        UNIFV2: IUniswapV2Factory(address(0)),
        UNIRV2: IUniswapV2Router02(address(0)),
        UNIRV3: ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564),
        UNIFV3: IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984),
        UNIVERSAL: IUniversalRouter(0x4C60051384bd2d3C01bfc845Cf5F4b44bcbE9de5),
        INCH: INCHV5(0x1111111254EEB25477B68fb85Ed929f73A960582),
        PARASWAP: IParaswap(0xDEF171Fe48CF0115B1d80b88dc8eAB59176FEe57)
      });
  }

  function goerli() internal pure returns (Contracts memory) {
    return
      Contracts({
        ETHW: IWETH(0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6),
        NATIVEW: IWETH(0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6),
        USDC: IERC20(0x07865c6E87B9F70255377e024ace6630C1Eaa37F),
        USDT: IERC20(0xe802376580c10fE23F027e1E19Ed9D54d4C9311e),
        DAI: IERC20(0x11fE4B6AE13d2a6055C8D9cF65c55bac32B5d844),
        UNIFV2: IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f),
        UNIRV2: IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D),
        UNIRV3: ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564),
        UNIFV3: IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984),
        UNIVERSAL: IUniversalRouter(0x4648a43B2C14Da09FdF82B161150d3F634f40491),
        INCH: INCHV5(address(0)),
        PARASWAP: IParaswap(0xDEF171Fe48CF0115B1d80b88dc8eAB59176FEe57)
      });
  }
}
