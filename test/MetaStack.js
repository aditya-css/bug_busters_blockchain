const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MetaStack", function () {
  // Signers
  let alice, bob;

  // Signer addresses
  let aliceAddr, bobAddr;

  // Contract
  let metaStack;

  before(async () => {
    // Get signers
    [alice, bob] = await ethers.getSigners();

    // Get addresses
    aliceAddr = await alice.getAddress();
    bobAddr = await bob.getAddress();

    // Deploy contract
    const MetaStack = await ethers.getContractFactory("MetaStack");
    metaStack = await MetaStack.deploy();
  });

  it("Should revert if Amount is 0", async () => {
    await expect(
      metaStack.sendEth(bobAddr, { value: ethers.utils.parseEther("0") })
    ).to.be.revertedWith("Amount must be greater than 0");
  });

  it("Should transfer ethers from one account to another", async function () {
    await metaStack.sendEth(bobAddr, { value: ethers.utils.parseEther("10") });
    expect(await bob.getBalance()).to.equal(ethers.utils.parseEther("10010"));
  });
});
