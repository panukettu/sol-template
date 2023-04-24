// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Test } from 'forge-std/Test.sol';
import { Ghost } from '../contracts/Ghost.sol';

contract Base is Test {
  Ghost public deployMain;
  Ghost public deployTest;

  // the identifiers of the forks
  uint256 internal mainnet;
  uint256 internal testnet;

  function setUp() public {
    mainnet = vm.createSelectFork(vm.rpcUrl('mainnet'));
    testnet = vm.createSelectFork(vm.rpcUrl('goerli'));

    vm.selectFork(mainnet);
    deployMain = new Ghost();
    vm.selectFork(testnet);
    deployTest = new Ghost();
  }

  /**
   * @dev Execute on forks
   */
  function testBoo() public {
    vm.selectFork(mainnet);
    assertEq(deployMain.boo(), 'Boo!');

    vm.selectFork(testnet);
    assertEq(deployTest.boo(), 'Boo!');
  }
}
