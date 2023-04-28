// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import { ScriptBase } from './Util.s.sol';

contract Deploy is ScriptBase('MNEMONIC_TESTNET') {
  function run() external {
    doThing();
  }

  function doThing() public broadcastWithMnemonic(0) {
    // uint256 bal = goerli().DAI.balanceOf(getAddr(0));
  }
}
