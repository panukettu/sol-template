// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19;

import { Wallet } from '../scripts/Util.s.sol';
import { LibTest, Deployments, IERC20, Test } from './libs/LibTest.sol';

abstract contract TestWallet is Wallet, Test {
  constructor(string memory _mnemonicId) Wallet(_mnemonicId) {}

  modifier prankKey(string memory key) {
    vm.startPrank(getAddr(key), getAddr(key));
    _;
    vm.stopPrank();
  }

  modifier prankAddr(address addr) {
    vm.startPrank(addr, addr);
    _;
    vm.stopPrank();
  }
  modifier prankMnemonic(uint32 index) {
    vm.startPrank(getAddr(index), getAddr(index));
    _;
    vm.stopPrank();
  }
}

abstract contract TestBase is Deployments, TestWallet {
  modifier fork(string memory f) {
    vm.createSelectFork(f);
    _;
  }

  using LibTest for LibTest.Params;
  address internal DAI_HOLDER_MAINNET = 0x60FaAe176336dAb62e284Fe19B885B095d29fB7F;

  constructor(string memory _mnemonicId) TestWallet(_mnemonicId) {}

  uint256 internal constant MAX_256 = type(uint256).max;

  modifier checkSetup() {
    check();
    _;
  }

  LibTest.Params internal test;
  LibTest.Users internal users;

  modifier withUsers(
    uint32 a,
    uint32 b,
    uint32 c
  ) {
    users = LibTest.Users(getAddr(a), getAddr(b), getAddr(c));
    _;
  }

  /* ----------------------------- Test the setup ----------------------------- */

  function check() internal withUsers(10, 11, 12) {
    (users, test) = createUsers(LibTest.Params(mainnet().DAI, 10000 ether, mainnet()));

    assertEq(users.user0, getAddr(10), '!u0');
    assertEq(users.user1, getAddr(11), '!u1');
    assertEq(users.user2, getAddr(12), '!u2');

    assertEq(users.user0.balance, 10 ether, '!u0eth');
    assertEq(users.user1.balance, 10 ether, '!u1eth');
    assertEq(users.user2.balance, 10 ether, '!u2eth');

    (address user0, LibTest.Params memory test0) = createUser(getAddr(20), test);
    assertEq(user0, getAddr(20), '!u0');
    assertEq(test0.c.DAI.balanceOf(user0), 10000 ether, '!u0dai');
    assertEq(user0.balance, 10 ether, '!u0deth');
  }

  /* ------------------------------- Create test ------------------------------ */

  function createUser(
    address _user,
    LibTest.Params memory _test
  ) public returns (address user, LibTest.Params memory) {
    address[] memory _approvals = new address[](2);
    _approvals[0] = address(_test.c.UNIRV2);
    _approvals[1] = address(_test.c.INCH);

    createBalance(_test, DAI_HOLDER_MAINNET, _user);
    createApprovals(_test, _approvals, _user);
    return (_user, _test);
  }

  function createUsers(
    LibTest.Params memory _test
  ) public returns (LibTest.Users memory, LibTest.Params memory) {
    address[] memory _approvals = new address[](2);
    _approvals[0] = address(_test.c.UNIRV2);
    _approvals[1] = address(_test.c.INCH);

    createBalance(_test, DAI_HOLDER_MAINNET, users.user0);
    createBalance(_test, DAI_HOLDER_MAINNET, users.user1);
    createBalance(_test, DAI_HOLDER_MAINNET, users.user2);
    createApprovals(_test, _approvals, users.user0);
    createApprovals(_test, _approvals, users.user1);
    createApprovals(_test, _approvals, users.user2);
    return (users, _test);
  }

  function createBalance(
    LibTest.Params memory params,
    address from,
    address user
  ) internal prankAddr(from) {
    require(address(params.asset) != address(0), 'asset-addr-0');

    vm.deal(user, 10 ether);
    params.asset.transfer(user, params.assetAmount);
  }

  function createApprovals(
    LibTest.Params memory params,
    address[] memory addresses,
    address user
  ) internal prankAddr(user) {
    require(address(params.asset) != address(0), 'asset-addr-0');
    require(user != address(0), 'user-addr-0');

    for (uint256 i = 0; i < addresses.length; i++) {
      params.asset.approve(addresses[i], MAX_256);
    }
  }
}
