import { BigNumber } from 'ethers';
import { logger } from './utils.ts';

import type { HardhatRuntimeEnvironment } from 'hardhat/types/runtime.ts';
import { extendEnvironment } from 'hardhat/config.js';
import { etherscan, rpc } from '../../shared.config.ts';

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

extendEnvironment((hre) => {
  hre.logCtx = () => logContext(hre);
  hre.ctx = () => getCtx(hre);
  hre.explorerTx = (tx, network = hre.network.name) => {
    const explorer = etherscan(network as any).url;
    if (!explorer) {
      console.warn(`No explorer for network ${network}!`);
    }
    if (!tx.hash) {
      const result = `${explorer}/tx/${tx.transactionHash}`;
      console.log(result);
      return result;
    } else if (!tx.transactionHash) {
      const result = `${explorer}/tx/${tx.hash}`;
      console.log(result);
      return result;
    }
    console.warn(`No tx hash found in ${tx}`);
  };
  hre.explorerAddr = (address, network = hre.network.name) => {
    const explorer = etherscan(network as any).url;
    if (!explorer) {
      console.warn(`No explorer for network ${network}!`);
    }
    const result = `${explorer}/address/${address}`;
    console.log(result);
    return result;
  };
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
