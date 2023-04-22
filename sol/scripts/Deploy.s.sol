// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {Ghost} from '../contracts/Ghost.sol';

contract Test is Script {
  function run() external {
    vm.startBroadcast();
    new Ghost();
    vm.stopBroadcast();
  }
}

contract Deploy is Script {
  function run() external {
    vm.startBroadcast();
    new Ghost();
    vm.stopBroadcast();
  }
}
