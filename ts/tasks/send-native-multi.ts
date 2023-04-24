import { task } from 'hardhat/config.js';
import { logger } from '../scripts/utils.ts';
import { TASK_SEND_NATIVE_MULTI } from './task-names.ts';

task(TASK_SEND_NATIVE_MULTI, 'Send native tokens to multiple accounts')
  .addParam('to', 'to')
  .addParam('amount', 'decimal amount')
  .setAction(async (args, hre) => {
    const log = logger(TASK_SEND_NATIVE_MULTI);
    const ctx = await hre.ctx();
    const companionNetworkNames = Object.keys(ctx.companions) as Networks[];

    if (companionNetworkNames.length === 0) {
      throw new Error('No companion networks found');
    }

    log(
      `${companionNetworkNames.length + 1} networks: ${hre.network.name} ${
        companionNetworkNames.length ? companionNetworkNames.join(' ') : ''
      }`
    );
    const { to, amount } = args;

    const promises = companionNetworkNames.map(async (network) => {
      const currentNetwork = ctx.companions[network];
      const logNetwork = logger(TASK_SEND_NATIVE_MULTI + ':' + network);

      try {
        const { deployer } = await currentNetwork.getNamedAccounts();
        const amountBig = hre.toBig(amount, 18);

        logNetwork(`Sending ${amount} NATIVE from: ${deployer} to: ${to}`);

        const tx = await currentNetwork.deployments.rawTx({
          from: deployer,
          to: to,
          value: amountBig,
        });

        hre.explorerTx(tx, network);
      } catch (e) {
        log(`Error while determining addresses in ${network}: ` + e);
      }
    });
    await Promise.all(promises);
  });
