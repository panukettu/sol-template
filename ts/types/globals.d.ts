import type { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers.ts';
import type { BigNumber, Contract } from 'ethers';
import type { DeploymentsExtension } from 'hardhat-deploy/types.ts';
import 'hardhat/types/config';
import type { CompanionNetwork } from './index.ts';

declare global {
  export type RPCProvider = 'pokt' | 'infura' | 'alchemy' | 'omnia';
  export type Networks =
    | 'mainnet'
    | 'goerli'
    | 'sepolia'
    | 'arbitrum'
    | 'arbitrumNova'
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
    | 'celo'
    | 'avax'
    | 'fantom'
    | 'aurora'
    | 'metis'
    | 'harmony'
    | 'zkSync'
    | 'zkSyncTestnet'
    | 'polygonZkEvmTestnet';
}

declare module 'hardhat/types/runtime.ts' {
  export interface HardhatRuntimeEnvironment {
    toBig: (value: string | number, dec?: number) => BigNumber;
    fromBig: (value: BigNumber, dec?: number) => string;
    hash: (value: string) => string;
    explorerTx: (tx: any, network?: string) => string;
    explorerAddr: (tx: any, network?: string) => string;
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
