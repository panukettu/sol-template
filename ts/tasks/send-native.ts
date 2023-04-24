import { task } from 'hardhat/config.js';
import { logger } from '../scripts/utils.ts';
import { TASK_SEND_NATIVE } from './task-names.ts';

task(TASK_SEND_NATIVE, 'Send native')
  .addParam('to', 'to')
  .addParam('amount', 'decimal amount')
  .setAction(async (args, hre) => {
    const log = logger(`${TASK_SEND_NATIVE}-${hre.network.name}`);

    const { to, amount } = args;
    const { deployer } = await hre.ctx();
    const amountBig = hre.toBig(amount, 18);
    log(`Sending ${amount} NATIVE from: ${deployer.address} to: ${to}`);

    const tx = await deployer.sendTransaction({
      to,
      value: amountBig,
    });

    hre.explorerTx(tx);
  });
