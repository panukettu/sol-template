// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import { Script } from 'forge-std/Script.sol';
import { IPolygonZkEvmBridge, PolygonZkEvm, Arbitrum, Optimism, IArbitrumBridge, IOPBridge } from '../contracts/interfaces/IBridges.sol';
import { TestWallets } from './Wallet.s.sol';

string constant key = 'PRIVATE_KEY';

contract BridgeZkEvm is TestWallets {
  IPolygonZkEvmBridge internal zkEvmBridge;

  function run() external broadcastWithKey(key) {
    address user = getAddr(key);
    zkEvmBridge = IPolygonZkEvmBridge(PolygonZkEvm.BRIDGE_GOERLI);
    uint256 toBridge = 1 ether;

    zkEvmBridge.bridgeAsset{ value: toBridge }(
      PolygonZkEvm.ZKEVM_ID,
      user,
      toBridge,
      address(0),
      true,
      ''
    );
  }
}

contract BridgeArbitrum is TestWallets {
  IArbitrumBridge internal arbitrumBridge;

  function run() external broadcastWithKey(key) {
    arbitrumBridge = IArbitrumBridge(Arbitrum.BRIDGE_GOERLI);
    uint256 toBridge = 0.1 ether;

    arbitrumBridge.depositEth{ value: toBridge }();
  }
}

contract BridgeOptimism is TestWallets {
  IOPBridge internal opBridge;

  function run() external broadcastWithKey(key) {
    address to = getAddr(key);

    opBridge = IOPBridge(Optimism.BRIDGE_GOERLI);
    uint256 amount = 0.1 ether;

    opBridge.depositETHTo{ value: amount }(to, 200000, '');
  }
}

contract BridgeAll is TestWallets {
  IOPBridge internal opBridge;
  IArbitrumBridge internal arbitrumBridge;
  IPolygonZkEvmBridge internal zkEvmBridge;

  function run() external {
    address to = getAddr(0);
    uint256 amount = 0.05 ether;
    sendToAllBridges(amount, to);
  }

  function sendToAllBridges(uint256 _amountToBridge, address _to) public broadcastWithMnemonic(0) {
    address to = _to == address(0) ? getAddr(0) : _to;

    opBridge = IOPBridge(Optimism.BRIDGE_GOERLI);
    arbitrumBridge = IArbitrumBridge(Arbitrum.BRIDGE_GOERLI);
    zkEvmBridge = IPolygonZkEvmBridge(PolygonZkEvm.BRIDGE_GOERLI);

    arbitrumBridge.depositEth{ value: _amountToBridge }();
    opBridge.depositETHTo{ value: _amountToBridge }(to, 200000, '');
    zkEvmBridge.bridgeAsset{ value: _amountToBridge }(
      PolygonZkEvm.ZKEVM_ID,
      to,
      _amountToBridge,
      address(0),
      true,
      ''
    );
  }
}
