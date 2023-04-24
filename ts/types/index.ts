import type { DeploymentsExtension, Address } from 'hardhat-deploy/types.ts';
import type { EthereumProvider } from 'hardhat/types/provider.js';

export type CompanionNetwork = {
  deployments: DeploymentsExtension;
  getNamedAccounts: () => Promise<{
    [name: string]: Address;
  }>;
  getUnnamedAccounts: () => Promise<string[]>;
  getChainId(): Promise<string>;
  provider: EthereumProvider;
};
