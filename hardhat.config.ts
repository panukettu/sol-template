import 'hardhat-deploy';
import '@nomicfoundation/hardhat-foundry';
import '@nomicfoundation/hardhat-toolbox';
import '@nomiclabs/hardhat-solhint';
import type { HardhatUserConfig, SolcUserConfig } from 'hardhat/types';
import { infura, rpc } from './shared.config.ts';
export const compilers: SolcUserConfig[] = [
  {
    version: '0.8.19',
  },
  {
    version: '0.8.18',
  },
  {
    version: '0.8.4',
  },
];

const config: HardhatUserConfig = {
  solidity: { compilers },
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
  },
  typechain: {
    outDir: 'ts/types/typechain',
  },
  paths: {
    artifacts: 'build/hardhat-artifacts',
    cache: 'build/hardhat-cache',
    sources: 'sol/contracts',
    tests: 'ts/tests',
  },
};

export default config;
