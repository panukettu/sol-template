import '@nomicfoundation/hardhat-foundry';
import '@nomicfoundation/hardhat-toolbox';
import '@nomiclabs/hardhat-solhint';
import 'hardhat-deploy';
import { extendEnvironment } from 'hardhat/config.js';
import type { HardhatUserConfig } from 'hardhat/types';
import { mainnets, rpc, testnets } from './shared.config.ts';
import { getCtx, logContext } from './ts/scripts/extensions.ts';

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

extendEnvironment((hre) => {
  hre.logCtx = () => logContext(hre);
  hre.ctx = () => getCtx(hre);
  hre.hash = (value: string) => hre.ethers.utils.id(value);
  hre.salt = (value: string) => hre.ethers.utils.formatBytes32String(value);
  hre.read = (network, contract, funcName, ...args) => {
    try {
      const provider = new hre.ethers.providers.JsonRpcProvider(rpc(network));
      const contractWithSigner = contract.connect(provider);
      return contractWithSigner.callStatic[funcName](...args);
    } catch (e) {
      console.error(`Error reading on ${network}: e`);
    }
  };
  hre.exec = (network, contract, funcName, ...args) => {
    try {
      const provider = new hre.ethers.providers.JsonRpcProvider(rpc(network));
      const contractWithSigner = contract.connect(provider);
      return contractWithSigner[funcName](...args);
    } catch (e) {
      console.error(`Error executing on ${network}: e`);
    }
  };
  hre.toBig = (value, dec = 18) =>
    hre.ethers.utils.parseUnits(String(value), dec);
  hre.fromBig = (value, dec = 18) => hre.ethers.utils.formatUnits(value, dec);
});

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
