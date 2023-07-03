const hre = require("hardhat");

async function main() {
  // This is used to deploy the contract into the chain
  const Create = await hre.ethers.getContractFactory("Create");
  const create = await Create.deploy();

  await create.deployed();

  console.log("Lock with 1ETH deployed to:", create.address);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
