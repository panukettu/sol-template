import type { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers.js';
import type { BigNumber, Contract } from 'ethers';
import type { Address, DeploymentsExtension } from 'hardhat-deploy/types.ts';
import type {
  EthereumProvider,
  HardhatRuntimeEnvironment,
} from 'hardhat/types';
import 'hardhat/types/config';

declare global {
  export type CompanionNetwork = {
    deployments: DeploymentsExtension;
    getNamedAccounts: () => Promise<{
      [name: string]: Address;
    }>;
    getUnnamedAccounts: () => Promise<string[]>;
    getChainId(): Promise<string>;
    provider: EthereumProvider;
  };

  export type RPCProvider = 'pokt' | 'infura' | 'alchemy' | 'omnia';
  export type Networks =
    | 'mainnet'
    | 'goerli'
    | 'sepolia'
    | 'arbitrum'
    | 'arbitrumGoerli'
    | 'optimism'
    | 'optimismGoerli'
    | 'polygon'
    | 'polygonMumbai'
    | 'polygonZkEvm'
    | 'bsc'
    | 'moonbeam'
    | 'moonriver'
    | 'gnosis'
    | 'polygonZkEvmTestnet';
}

declare module 'hardhat/types/runtime.ts' {
  export interface HardhatRuntimeEnvironment {
    toBig: (value: string | number, dec?: number) => BigNumber;
    fromBig: (value: BigNumber, dec?: number) => string;
    hash: (value: string) => string;
    salt: (value: string) => string;
    read: <T = any>(
      network: Networks,
      contract: Contract,
      funcName: string,
      ...args: any[]
    ) => Promise<T>;
    exec: <T = any>(
      network: Networks,
      contract: Contract,
      funcName: string,
      ...args: any[]
    ) => Promise<T>;
    ctx: () => Promise<{
      fork: string;
      deployer: SignerWithAddress;
      network: DeploymentsExtension;
      companions: { [key in Partial<Networks>]?: CompanionNetwork };
    }>;
    logCtx: () => Promise<{
      fork: string;
      deployer: SignerWithAddress;
      network: DeploymentsExtension;
      companions: { [key in Partial<Networks>]?: CompanionNetwork };
    }>;
  }
}

export {};
