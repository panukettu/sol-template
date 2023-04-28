import { task } from 'hardhat/config.js';
import { logger } from '../scripts/utils.ts';
import { TASK_SEND_ERC20 } from './task-names.ts';

const erc20hrabi = [
  'function symbol() view returns (string symbol)',
  'function decimals() view returns (uint8 decimals)',
  'function transfer(address to,uint256 amount)',
  'function balanceOf(address account) view returns (uint256 balance)',
];

task(TASK_SEND_ERC20, 'Send ERC20')
  .addParam('token', 'token')
  .addParam('to', 'to')
  .addParam('amount', 'decimal amount')
  .setAction(async (args, hre) => {
    const log = logger(`${TASK_SEND_ERC20}-${hre.network.name}`);
    const { to, amount } = args;
    const { deployer } = await hre.ctx();

    const Token = await hre.ethers.getContractAt(
      erc20hrabi,
      args.token,
      deployer
    );
    const symbol = await Token.symbol();
    const amountBig = hre.toBig(amount, await Token.decimals());

    try {
      await Token.callStatic.transfer(to, amountBig);
    } catch (e) {
      log('Failed static check on transfer:');
      throw new Error(e);
    }

    log(`Sending ${amount} ${symbol} from: ${deployer} to: ${to}`);

    const tx = await Token.transfer(to, amountBig);

    hre.explorerTx(tx);
  });
