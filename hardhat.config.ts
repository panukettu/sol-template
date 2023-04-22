import '@nomicfoundation/hardhat-foundry';
import type { SolcUserConfig } from 'hardhat/types';

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

export default {
  solidity: { compilers },
  networks: {
    hardhat: {
      autoImpersonate: true,
      forking: {
        // url: "https://divine-powerful-putty.matic.discover.quiknode.pro/${process.env.QUICKNODE_API_KEY}/",
        url: `https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`,
      },
    },
  },
  paths: {
    artifacts: 'build/hardhat-artifacts',
    cache: 'build/hardhat-cache',
    sources: 'sol/contracts',
    tests: 'ts/test',
  },
};
