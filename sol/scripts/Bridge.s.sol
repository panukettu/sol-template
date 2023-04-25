// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import { Script } from 'forge-std/Script.sol';
import { IPolygonZkEvmBridge, PolygonZkEvm, Arbitrum, Optimism, IArbitrumBridge, IOPBridge } from '../contracts/interfaces/IBridges.sol';

contract BridgeZkEvm is Script {
  IPolygonZkEvmBridge internal zkEvmBridge;

  function run() external {
    vm.startBroadcast(vm.envUint('PRIVATE_KEY_EXTERNAL'));
    address user = vm.addr(vm.envUint('PRIVATE_KEY_EXTERNAL'));
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
    vm.stopBroadcast();
  }
}

contract BridgeArbitrum is Script {
  IArbitrumBridge internal arbitrumBridge;

  function run() external {
    vm.startBroadcast(vm.envUint('PRIVATE_KEY_EXTERNAL'));
    // address user = vm.addr(vm.envUint('PRIVATE_KEY_EXTERNAL'));

    arbitrumBridge = IArbitrumBridge(Arbitrum.BRIDGE_GOERLI);
    uint256 toBridge = 0.1 ether;

    arbitrumBridge.depositEth{ value: toBridge }();
    vm.stopBroadcast();
  }
}

contract BridgeOptimism is Script {
  IOPBridge internal opBridge;

  function run() external {
    vm.startBroadcast(vm.envUint('PRIVATE_KEY_EXTERNAL'));
    address to = vm.addr(vm.envUint('PRIVATE_KEY_EXTERNAL'));

    opBridge = IOPBridge(Optimism.BRIDGE_GOERLI);
    uint256 toBridge = 0.1 ether;

    opBridge.depositETHTo{ value: toBridge }(to, 200000, '');
    vm.stopBroadcast();
  }
}

contract BridgeAll is Script {
  IOPBridge internal opBridge;
  IArbitrumBridge internal arbitrumBridge;
  IPolygonZkEvmBridge internal zkEvmBridge;

  function run() external {
    vm.startBroadcast(vm.envUint('PRIVATE_KEY_EXTERNAL'));
    address to = vm.addr(vm.envUint('PRIVATE_KEY_EXTERNAL'));

    opBridge = IOPBridge(Optimism.BRIDGE_GOERLI);
    arbitrumBridge = IArbitrumBridge(Arbitrum.BRIDGE_GOERLI);
    zkEvmBridge = IPolygonZkEvmBridge(PolygonZkEvm.BRIDGE_GOERLI);

    uint256 toBridge = 0.1 ether;

    arbitrumBridge.depositEth{ value: toBridge }();
    opBridge.depositETHTo{ value: toBridge }(to, 200000, '');

    zkEvmBridge.bridgeAsset{ value: toBridge }(
      PolygonZkEvm.ZKEVM_ID,
      to,
      toBridge,
      address(0),
      true,
      ''
    );
  }
}
