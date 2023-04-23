import { ethers } from 'ethers';
import hre from 'hardhat';
export const salt = (text: string) => {
  return ethers.utils.formatBytes32String(text);
};

export const randomContractAddress = () => {
  const pubKey = ethers.Wallet.createRandom().publicKey;

  return ethers.utils.getContractAddress({
    from: pubKey,
    nonce: 0,
  });
};
export const logger =
  (prefix: string) =>
  (...args: any[]) =>
    console.log(`${prefix}:`, ...args);
