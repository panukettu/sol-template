// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Test } from 'forge-std/Test.sol';
import { TestWallets, Wallets } from '../scripts/Wallet.s.sol';

string constant testnet = 'MNEMONIC_TESTNET';
string constant mainnet = 'MNEMONIC';

string constant pkTestnet = 'PRIVATE_KEY_TESTNET';
string constant pk = 'PRIVATE_KEY';

contract TestWalletTest is TestWallets, Test {
  function testMnemonic() public {
    address zeroIndex = vm.addr(vm.deriveKey(vm.envString(testnet), 0));
    assertTrue(super.getAddr(0) != address(0));

    assertEq(zeroIndex, super.getAddr(0));
  }

  function testPK() public {
    address wallet = vm.addr(vm.envUint(pkTestnet));
    assertTrue(wallet != address(0));

    assertEq(wallet, super.getAddr(pkTestnet));
  }
}

contract WalletTest is Wallets, Test {
  function testMnemonic() public {
    address zeroIndex = vm.addr(vm.deriveKey(vm.envString(mainnet), 0));
    assertTrue(super.getAddr(0) != address(0));

    assertEq(zeroIndex, super.getAddr(0));
  }

  function testPK() public {
    address wallet = vm.addr(vm.envUint(pk));
    assertTrue(wallet != address(0));

    assertEq(wallet, super.getAddr(pk));
  }
}
