import { BigNumber } from 'ethers';
import { logger } from './utils.ts';

import type { HardhatRuntimeEnvironment } from 'hardhat/types/runtime.ts';

export const logContext = async (hre: HardhatRuntimeEnvironment) => {
  const log = logger('context');
  const { deployer } = await hre.getNamedAccounts();

  const bal = await hre.ethers.provider.getBalance(deployer);
  const gasPrice = await hre.ethers.provider.getGasPrice();
  const gasPriceConfig = hre.ethers.utils.formatUnits(
    hre.network.config.gasPrice,
    'gwei'
  );
  const gasPriceProvider = hre.ethers.utils.formatUnits(gasPrice, 'gwei');

  const ERC20TransferCostConfig = hre.ethers.utils.formatEther(
    BigNumber.from(hre.network.config.gasPrice).mul(68000)
  );
  const ERCTransferCostProvider = hre.ethers.utils.formatEther(
    gasPrice.mul(65000)
  );
  const companionNetworks = Object.keys(hre.companionNetworks);
  const itemsToLog = [
    `network: ${hre.network.name} (${hre.network.config.chainId})`,
    `companions: (${companionNetworks.length}) ${companionNetworks.join(' ')}`,
    `forking: ${hre.userConfig.networks.hardhat.forking.url}`,
    `live: ${hre.network.live}`,
    `deployer: ${deployer}`,
    `balance: ${hre.ethers.utils.formatEther(bal)} ETH`,
    `gas (provider): ${gasPriceProvider} gwei`,
    `gas (config): ${gasPriceConfig} gwei`,
    `cost (provider): ${ERCTransferCostProvider} ETH (ERC20-Transfer)`,
    `cost (config): ${ERC20TransferCostConfig} ETH (ERC20-Transfer)`,
  ];

  for (const item of itemsToLog) {
    log(item);
  }
  return {
    fork: hre.userConfig.networks.hardhat.forking.url ?? '',
    deployer: await hre.ethers.getSigner(deployer),
    network: hre.deployments,
    companions: hre.companionNetworks,
  };
};

export const getCtx = async (hre: HardhatRuntimeEnvironment) => {
  const { deployer } = await hre.getNamedAccounts();
  return {
    fork: hre.userConfig.networks.hardhat.forking.url ?? '',
    deployer: await hre.ethers.getSigner(deployer),
    network: hre.deployments,
    companions: hre.companionNetworks,
  };
};
