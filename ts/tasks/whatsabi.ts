import { task, types } from 'hardhat/config.js';
import { TASK_WHATSABI } from './task-names.ts';
import { whatsabi } from '@shazow/whatsabi';
import { writeFileSync } from 'fs';

task(TASK_WHATSABI, 'Try to determine the ABI of a contract')
  .addParam('address', 'Unverified contract address')
  .addOptionalParam('save', 'Save the ABI to a file', false, types.boolean)
  .setAction(async (args, hre) => {
    const contract = args.address;
    const abi = await whatsabi.autoload(contract, {
      provider: hre.ethers.provider,
      // abiLoader: whatsabi.loaders.defaultABILoader, // Optional
      // signatureLoader: whatsabi.loaders.defaultSignatureLookup, // Optional
    });
    if (args.save) {
      writeFileSync(`temp/${contract}.json`, JSON.stringify(abi, null, 2));
    }
  });
