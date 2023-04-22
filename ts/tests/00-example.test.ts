import { expect } from 'chai';
import hre from 'hardhat';

describe('Test', () => {
  it('testBoo', async () => {
    const { deployer } = await hre.getNamedAccounts();
    const Deployment = await hre.deployments.deploy('Ghost', {
      from: deployer,
    });
    const Ghost = await hre.ethers.getContractAt('Ghost', Deployment.address);
    expect(await Ghost.boo()).to.equal('Boo!');
  });
});
