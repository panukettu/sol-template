import '@nomicfoundation/hardhat-foundry';
import '@nomicfoundation/hardhat-toolbox';
import '@nomiclabs/hardhat-solhint';
import 'hardhat-deploy';
import type { HardhatUserConfig } from 'hardhat/types';
import { mainnets, rpc, testnets } from './shared.config.ts';
import './ts/scripts/extensions.ts';
import './ts/tasks/index.ts';
if (
  !process.env.PRIVATE_KEY &&
  !process.env.MNEMONIC &&
  !process.env.LEDGER_SENDER
) {
  console.warn('No mainnet signer in .env. Using default hardhat accounts.');
}

if (!process.env.PRIVATE_KEY_TESTNET && !process.env.MNEMONIC_TESTNET) {
  console.warn('No testnet signer in .env. Using default hardhat accounts.');
}

const accountsMain = process.env.PRIVATE_KEY
  ? [process.env.PRIVATE_KEY]
  : process.env.MNEMONIC
  ? {
      mnemonic: process.env.MNEMONIC,
      initialIndex: !isNaN(+process.env.MNEMONIC_INDEX)
        ? +process.env.MNEMONIC_INDEX
        : 0,
    }
  : [];

const accountsTest = process.env.PRIVATE_KEY_TESTNET
  ? [process.env.PRIVATE_KEY_TESTNET]
  : process.env.MNEMONIC_TESTNET
  ? {
      mnemonic: process.env.MNEMONIC_TESTNET,
      initialIndex: !isNaN(+process.env.MNEMONIC_INDEX)
        ? +process.env.MNEMONIC_INDEX
        : 0,
    }
  : [];

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: '0.8.19',
      },
      {
        version: '0.8.18',
      },
      {
        version: '0.8.4',
      },
    ],
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
    external: {
      default: `privatekey://${
        process.env.PRIVATE_KEY_EXTERNAL || '0'.repeat(64)
      }`,
    },
  },
  networks: {
    hardhat: {
      autoImpersonate: true,
      saveDeployments: false,
      forking: {
        url: rpc('mainnet'),
      },
    },
    ...mainnets(accountsMain),
    ...testnets(accountsTest),
  },
  typechain: {
    outDir: 'ts/types/typechain',
  },
  paths: {
    deploy: 'ts/deploy',
    deployments: 'exports/deployments',
    artifacts: 'build/hardhat-artifacts',
    cache: 'build/hardhat-cache',
    sources: 'sol/contracts',
    tests: 'ts/tests',
  },
};

export default config;
