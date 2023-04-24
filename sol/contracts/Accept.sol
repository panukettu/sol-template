// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19;

contract Accept {
  constructor(address accepter) payable {
    selfdestruct(payable(accepter));
  }
}
