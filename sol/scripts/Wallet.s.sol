// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import { Script } from 'forge-std/Script.sol';

contract Wallet is Script {
  string public mnemonicId;

  constructor(string memory _mnemonicId) {
    mnemonicId = _mnemonicId;
  }

  modifier broadcastWithMnemonic(uint32 index) {
    vm.startBroadcast(vm.deriveKey(vm.envString(mnemonicId), index));
    _;
    vm.stopBroadcast();
  }

  modifier broadcastWithKey(string memory key) {
    vm.startBroadcast(vm.envUint(key));
    _;
    vm.stopBroadcast();
  }

  function getKey(uint32 index) public view returns (uint256) {
    return vm.deriveKey(vm.envString(mnemonicId), index);
  }

  function getAddr(uint32 index) public view returns (address) {
    return vm.addr(vm.deriveKey(vm.envString(mnemonicId), index));
  }

  function getAddr(string memory key) public view returns (address) {
    return vm.addr(vm.envUint(key));
  }
}
