import type { DeployFunction } from 'hardhat-deploy/types.ts';
import { logger } from '../scripts/utils.ts';

export const deploymentId = 'GhostMultichain';
const log = logger(deploymentId);

const deploy: DeployFunction = async (hre) => {
  const { deployer, network, companions } = await hre.ctx();
  const companionNetworkNames = Object.keys(companions) as Networks[];
  const create2 = network.deterministic;

  log(
    `Deployment in ${companionNetworkNames.length + 1} networks: ${
      hre.network.name
    } ${companionNetworkNames.length ? companionNetworkNames.join(' ') : ''}`
  );

  const results: Record<string, any> = {};

  const deployment = await create2(deploymentId, {
    from: deployer.address,
    contract: 'Ghost',
    log: true,
    salt: hre.salt(deploymentId),
    proxy: {
      owner: deployer.address,
      proxyContract: 'OptimizedTransparentProxy',
    },
  });

  results[hre.network.name] = {
    proxy: deployment.address,
    implementation: deployment.implementationAddress,
  };

  const promises = companionNetworkNames.map(async (network) => {
    const currentNetwork = companions[network];
    const companionCreate2 = currentNetwork.deployments.deterministic;

    try {
      const deployment = await companionCreate2(deploymentId, {
        from: deployer.address,
        contract: 'Ghost',
        log: true,
        salt: hre.salt(deploymentId),
        proxy: {
          owner: deployer.address,
          proxyContract: 'OptimizedTransparentProxy',
        },
      });
      results[network] = {
        proxy: deployment.address,
        implementation: deployment.implementationAddress,
      };
    } catch (e) {
      log(`Error while determining addresses in ${network}: ` + e);
    }
  });
  await Promise.all(promises);
  log(`Determined addresses:`);
  log(`${JSON.stringify(results, null, 2)}`);
};

deploy.tags = ['create2'];

deploy.skip = async (hre) => {
  const duplicate = Object.keys(hre.companionNetworks).find(
    (network) => hre.network.name === network
  );

  if (duplicate) {
    throw new Error(`companion: ${hre.network.name}`);
  }

  return false;
};

export default deploy;
