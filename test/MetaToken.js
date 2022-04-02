const { expect } = require("chai");
const { Signer } = require("ethers");
const { ethers } = require("hardhat");

describe("MetaToken", function () {
  it("Testing MetaToken is on", async function () {
    const MetaToken = await ethers.getContractFactory("MetaToken");
    const metaToken = await MetaToken.deploy();
    await metaToken.deployed();

    const [owner, addr1] = await ethers.getSigners();
    // await metaToken.mint(owner.address, 100);
    // expect(await metaToken.balanceOf(owner.address)).to.equal(100);

    // await metaToken.mint(owner.address, 50);
    // expect(await metaToken.balanceOf(owner.address)).to.equal(150);
    console.log(await owner.getBalance());

    await metaToken.swapToToken({
      value: ethers.utils.parseEther("0.00000000000025"),
    });
    console.log(await metaToken.balanceOf(owner.address));
    // expect(await metaToken.balanceOf(owner.address)).to.equal(150);
    // wait until the transaction is mined
  });
});
