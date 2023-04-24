// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import { Script } from 'forge-std/Script.sol';
import { Ghost } from '../contracts/Ghost.sol';
import { Accept } from '../contracts/Accept.sol';
import { IPolygonZkEvmBridge, PolygonZkEvm } from '../contracts/interfaces/IBridges.sol';

contract Deploy is Script {
  function run() external {
    vm.startBroadcast();
    new Ghost();
    vm.stopBroadcast();
  }
}

contract Bridge is Script {
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
