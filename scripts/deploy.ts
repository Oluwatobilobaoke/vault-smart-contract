import { ethers } from "hardhat";

async function main() {
  const vault = await ethers.deployContract("GrantVault");

  await vault.waitForDeployment();

  console.log(`GRANT VAULT contract deployed to ${vault.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


// npx hardhat run scripts/deploy.ts --network sepolia
// GRANT VAULT contract deployed to 0x69eD36D0d9cF3cC6cb9A33a282406aa84F94E996

//  npx hardhat verify --network sepolia 0x69eD36D0d9cF3cC6cb9A33a282406aa84F94E996

// npx hardhat test


// Successfully verified contract GrantVault on the block explorer.
// https://sepolia.etherscan.io/address/0x69eD36D0d9cF3cC6cb9A33a282406aa84F94E996#code