import { ethers } from "hardhat";

async function main() {
  const vault = await ethers.deployContract("GrantVaultAdvance");

  await vault.waitForDeployment();

  console.log(`GRANT VAULT contract deployed to ${vault.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


// npx hardhat run scripts/deploy-advance.ts --network sepolia
// GRANT VAULT contract deployed to 0x330B012670DcA1FA3246F9691E22b366Ce32a51c

//  npx hardhat verify --network sepolia 0x330B012670DcA1FA3246F9691E22b366Ce32a51c

// npx hardhat test


// Successfully verified contract GrantVault on the block explorer.
// https://sepolia.etherscan.io/address/0x330B012670DcA1FA3246F9691E22b366Ce32a51c#code