# foundry+hardhat template

derives from https://github.com/bgd-labs/bgd-forge-template

To create a new project using this template run

```shell
$ forge init --template panukettu/sol-template my_new_project
```

## Included modules

[Rari-Capital/solmate](https://github.com/Rari-Capital/solmate) - simple sources for base contracts

[OpenZeppelin/openzeppelin-contracts](https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable) - for not so simple base contracts

## Module recommendations

[bgd-labs/solidity-utils](https://github.com/bgd-labs/solidity-utils) - common contracts we use everywhere, ie transparent proxy and around

[bgd-labs/aave-address-book](https://github.com/bgd-labs/aave-address-book) - the best and only source about all deployed Aave ecosystem related contracts across all the chains

[bgd-labs/aave-helpers](https://github.com/bgd-labs/aave-helpers) - useful utils for integration, and not only testing related to Aave ecosystem contracts

## Development

This project uses [Foundry](https://getfoundry.sh). See the [book](https://book.getfoundry.sh) for usage.

This project also uses [Hardhat](https://hardhat.org/). See the [docs](https://hardhat.org/hardhat-runner/docs/advanced/hardhat-and-foundry) for more info on hardhat + foundry projects.

### Setup

```sh
cp .env.example .env
pnpm i
```

### Test

```sh
forge test
```

## Advanced features

### Diffing

For contracts upgrading implementations it's quite important to diff the implementation code to spot potential issues and ensure only the intended changes are included.
Therefore the `Makefile` includes some commands to streamline the diffing process.

#### Download

You can `download` the current contract code of a deployed contract via `make download chain=polygon address=0x00`. This will download the contract source for specified address to `src/etherscan/chain_address`. This command works for all chains with a etherscan compatible block explorer.

#### Git diff

You can `git-diff` a downloaded contract against your src via `make git-diff before=./etherscan/chain_address after=./src out=filename`. This command will diff the two folders via git patience algorithm and write the output to `diffs/filename.md`.

**Caveat**: If the onchain implementation was verified using flatten, for generating the diff you need to flatten the new contract via `forge flatten` and supply the flattened file instead fo the whole `./src` folder.
