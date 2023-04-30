// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import { ScriptBase } from './Util.s.sol';

contract BridgeZkEvm is ScriptBase('MNEMONIC_TESTNET') {
  function run() external broadcastWithKey('PRIVATE_KEY') {
    address to = getAddr('PRIVATE_KEY');
    uint256 amount = 0.05 ether;
    goerli().depositZkEvm(to, amount);
  }
}

contract BridgeArbitrum is ScriptBase('MNEMONIC_TESTNET') {
  function run() external broadcastWithKey('PRIVATE_KEY') {
    uint256 amount = 0.05 ether;
    goerli().depositArbitrum(amount);
  }
}

contract BridgeOptimism is ScriptBase('MNEMONIC_TESTNET') {
  function run() external broadcastWithKey('PRIVATE_KEY') {
    address to = getAddr('PRIVATE_KEY');
    uint256 amount = 0.05 ether;

    goerli().depositOptimism(to, amount);
  }
}

contract BridgeAll is ScriptBase('MNEMONIC_TESTNET') {
  function run() external broadcastWithMnemonic(0) {
    address to = getAddr('PRIVATE_KEY');
    uint256 amount = 0.05 ether;
    goerli().multibridge(amount);
  }
}
