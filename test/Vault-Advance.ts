import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Vault Advance", function () {
  async function deployVaultAdvance() {
    const [owner, otherAccount, addr1] = await ethers.getSigners();
    const VaultAdvance = await ethers.getContractFactory("GrantVaultAdvance");
    const vaultAdvance = await VaultAdvance.deploy();
    return { owner, otherAccount, addr1, vaultAdvance };
  }

  describe("Deployment", function () {
    it("Should be able to deploy the contract", async function () {
      const { vaultAdvance } = await loadFixture(deployVaultAdvance);
      expect(vaultAdvance.target).to.not.equal(0);
    });
  });
});
