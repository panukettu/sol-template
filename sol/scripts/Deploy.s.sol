// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import { Script } from 'forge-std/Script.sol';
import { Ghost } from '../contracts/Ghost.sol';

contract Deploy is Script {
  function run() external {
    vm.startBroadcast();
    new Ghost();
    vm.stopBroadcast();
  }
}
