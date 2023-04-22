// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Test } from 'forge-std/Test.sol';
import { Ghost } from '../contracts/Ghost.sol';

contract GhostTest is Test {
  Ghost public main;
  Ghost public test;

  // the identifiers of the forks
  uint256 mainnet;
  uint256 testnet;

  function setUp() public {
    mainnet = vm.createSelectFork(vm.rpcUrl('mainnet'));
    testnet = vm.createSelectFork(vm.rpcUrl('goerli'));
    vm.selectFork(mainnet);
    main = new Ghost();
    vm.selectFork(testnet);
    test = new Ghost();
  }

  /**
   * @dev Execute on forks
   */
  function testBoo() public {
    vm.selectFork(mainnet);
    assertEq(main.boo(), 'Boo!');
    vm.selectFork(testnet);
    assertEq(test.boo(), 'Boo!');
  }
}
