// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");
const {
  utils: { deployContract },
} = require('@axelar-network/axelar-local-dev');


async function main() {

  const registryChain = '';
  const registryId = '';

  const roundContract = await ethers.getContractAt("ChainBRound", registryId);

  console.log(`Updating registryChain and registryId.`);
  // set registry
  const tx = await roundContract.setRegistry(registryChain, registryId);
  await tx.wait();

  const tx2 = await roundContract.testCrossChain(
    1,
    "0xB8cEF765721A6da910f14Be93e7684e9a3714123"
  )
  console.log(tx2)
}


// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
