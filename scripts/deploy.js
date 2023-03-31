const hre = require("hardhat");

async function main() {
  
  await lock.deployed();

  console.log(
    
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
