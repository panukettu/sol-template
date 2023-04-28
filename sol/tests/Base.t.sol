// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19;
import { TestBase, LibTest } from './Util.sol';

contract TestBaseTest is TestBase('MNEMONIC_TESTNET') {
  using LibTest for LibTest.Params;

  function setUp() public fork('mainnet') {}

  function testHelper() public checkSetup {
    assertEq(users.user0.balance, 10 ether);
  }

  function testFoo() public fork('optimism') withUsers(10, 11, 12) {
    assertEq(users.user0.balance, 0 ether);
  }

  function testAnother() public withUsers(10, 11, 12) {
    (users, test) = create(LibTest.Params(mainnet().DAI, 1.1 ether, mainnet()));

    assertEq(mainnet().DAI.balanceOf(users.user0), 1.1 ether);
    assertEq(mainnet().DAI.balanceOf(users.user1), 1.1 ether);
    assertEq(mainnet().DAI.balanceOf(users.user2), 1.1 ether);
  }
}
