// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Test } from 'forge-std/Test.sol';
import { Accept } from '../contracts/Accept.sol';

contract AcceptTest is Test {
  Accept public deployment;

  uint256 internal testnet;
  address internal caller = vm.addr(2);
  address internal accepter = vm.addr(3);

  function setUp() public {
    testnet = vm.createSelectFork(vm.rpcUrl('goerli'));

    vm.selectFork(testnet);
    vm.deal(caller, 10 ether);
  }

  /**
   * @dev Execute on fork
   */
  function testAccept() public {
    vm.selectFork(testnet);

    vm.startBroadcast(caller);
    deployment = new Accept{ value: 1 ether }(accepter);

    assertEq(caller.balance, 9 ether);
    assertEq(accepter.balance, 1 ether);
    vm.stopBroadcast();
  }
}
