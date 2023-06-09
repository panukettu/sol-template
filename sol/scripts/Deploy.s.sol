// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import { ScriptBase } from './Util.s.sol';
import { Ghost } from '../contracts/Ghost.sol';

contract Deploy is ScriptBase('MNEMONIC_TESTNET') {
  function run() external broadcastWithMnemonic(0) {
    new Ghost();
  }
}
