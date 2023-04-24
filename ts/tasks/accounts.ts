import { task } from 'hardhat/config.js';
import { logger } from '../scripts/utils.ts';
import { TASK_ACCOUNTS } from './task-names.ts';

task(TASK_ACCOUNTS).setAction(async (args, hre) => {
  const log = logger(TASK_ACCOUNTS);
  const accounts = await hre.ethers.getSigners();

  const named = await hre.getNamedAccounts();

  for (const [name, addr] of Object.entries(named)) {
    const bal = await hre.ethers.provider.getBalance(addr);
    log(`Named ${name}: ${addr} (${hre.ethers.utils.formatEther(bal)} NATIVE)`);
  }
  for (let i = 0; i < 100; i++) {
    const bal = await accounts[i].getBalance();
    const addr = accounts[i].address;
    log(`Account ${i}: ${addr} (${hre.ethers.utils.formatEther(bal)} NATIVE)`);
  }
});
