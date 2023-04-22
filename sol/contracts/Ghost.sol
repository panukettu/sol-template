// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import { ERC20 } from 'solmate/tokens/ERC20.sol';
import { IGhost } from './interfaces/IGhost.sol';

contract Ghost is IGhost {

  function boo() external pure returns (string memory) {
    return 'Boo!';
  }
}
