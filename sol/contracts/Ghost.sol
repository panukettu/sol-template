// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from 'solmate/erc20/ERC20.sol';
import './interfaces/IGhost.sol';

contract Ghost is IGhost {
  function boo() external pure returns (string memory) {
    return 'Boo!';
  }
}
