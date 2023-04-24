# foundry+hardhat template

_this template is derived from [bgd-forge-template](https://github.com/bgd-labs/bgd-forge-template)_

Uses [Foundry](https://getfoundry.sh). See the [docs](https://book.getfoundry.sh).

Uses [Hardhat](https://hardhat.org/). See the [docs](https://hardhat.org/hardhat-runner/docs/advanced/hardhat-and-foundry).

Use [blackbox](https://github.com/StackExchange/blackbox#installation-instructions) to commit encrypted secrets (optional)

Lots of boilerplate for RPC, Etherscan and LayerZero configuration.

templates (forking not reliable with public RPCs):

- forge test on multiple forks: `forge test` or `pnpm f:test` or `./test.sh`
- hh test on single fork: `npx hardhat test` or `pnpm hh:test`
- hh deploy to multiple chains concurrent : eg. `npx hardhat deploy --network optimismGoerli` or `pnpm hh:deploy --network optimismGoerli`
- two gh workflow jobs: hardhat (dispatch) and forge (push, dispatch)

## setup

1. (init) use this template from github

- (init) or with forge init

```shell
$ forge init --template panukettu/sol-template my_new_project
```

2. (env) without blackbox

```sh
cp .env.example .env
```

- (env) with [blackbox](https://github.com/StackExchange/blackbox#installation-instructions) (requires homebrew and gpg)

```shell
$ make init-blackbox email=NEW@GPG.EMAIL
```

3. (optional) for hardhat:

```sh
pnpm i
```

## locations

```sh
-- foundry
src = 'sol/contracts'
test = 'sol/tests'
script = 'sol/scripts'
out = 'build/foundry-artifacts'
cache_path = 'build/foundry-cache'
libs = ['lib']
-- hardhat
deploy: 'ts/deploy',
deployments: 'exports/deployments',
artifacts: 'build/hardhat-artifacts',
cache: 'build/hardhat-cache',
sources: 'sol/contracts',
tests: 'ts/tests',
```

## foundry packages

[Rari-Capital/solmate](https://github.com/Rari-Capital/solmate) - simple base contracts

[OpenZeppelin/openzeppelin-contracts](https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable) - not so simple base contracts

## hardhat packages

```sh
"@layerzerolabs/lz-sdk": "^0.0.12",
"@nomicfoundation/hardhat-chai-matchers": "^1.0.6",
"@nomicfoundation/hardhat-foundry": "^1.0.1",
"@nomicfoundation/hardhat-network-helpers": "^1.0.8",
"@nomicfoundation/hardhat-toolbox": "^2.0.2",
"@nomiclabs/hardhat-ethers": "^2.2.3",
"@nomiclabs/hardhat-etherscan": "^3.1.7",
"@nomiclabs/hardhat-solhint": "^3.0.1",
"@typechain/ethers-v5": "^10.2.0",
"@typechain/hardhat": "^6.1.5",
"@wagmi/chains": "^0.2.20",
"ethers": "^5.7.2",
"hardhat": "^2.14.0",
"hardhat-deploy": "^0.11.26",
"hardhat-gas-reporter": "^1.0.9",
"solhint": "^3.4.1",
"solidity-coverage": "^0.8.2",
```

## forge recommendations ([bgd-forge-template](https://github.com/bgd-labs/bgd-forge-template))

[bgd-labs/solidity-utils](https://github.com/bgd-labs/solidity-utils) - common contracts we use everywhere, ie transparent proxy and around

[bgd-labs/aave-address-book](https://github.com/bgd-labs/aave-address-book) - the best and only source about all deployed Aave ecosystem related contracts across all the chains

[bgd-labs/aave-helpers](https://github.com/bgd-labs/aave-helpers) - useful utils for integration, and not only testing related to Aave ecosystem contracts

## advanced features (mostly from [bgd-forge-template](https://github.com/bgd-labs/bgd-forge-template))

### unverified contract abi

`npx hardhat whatsabi --address 0x --save true/false (saved in temp/{address}.json)

### diffing

For contracts upgrading implementations it's quite important to diff the implementation code to spot potential issues and ensure only the intended changes are included.
Therefore the `Makefile` includes some commands to streamline the diffing process.

#### download

You can `download` the current contract code of a deployed contract via `make download chain=polygon address=0x00`. This will download the contract source for specified address to `src/etherscan/chain_address`. This command works for all chains with a etherscan compatible block explorer.

#### git diff

You can `git-diff` a downloaded contract against your src via `make git-diff before=./etherscan/chain_address after=./src out=filename`. This command will diff the two folders via git patience algorithm and write the output to `diffs/filename.md`.

**Caveat**: If the onchain implementation was verified using flatten, for generating the diff you need to flatten the new contract via `forge flatten` and supply the flattened file instead fo the whole `./src` folder.
