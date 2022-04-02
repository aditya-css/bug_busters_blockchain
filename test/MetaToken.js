const { expect } = require("chai");
const { Signer } = require("ethers");
const { ethers, waffle } = require("hardhat");

describe("MetaToken", function () {
  it("Testing MetaToken is on", async function () {
    const MetaToken = await ethers.getContractFactory("MetaToken");
    const metaToken = await MetaToken.deploy();
    await metaToken.deployed();
    const provider = waffle.provider;
    const [owner, addr1] = await ethers.getSigners();
    // await metaToken.mint(owner.address, 100);
    // expect(await metaToken.balanceOf(owner.address)).to.equal(100);

    // await metaToken.mint(owner.address, 50);
    // expect(await metaToken.balanceOf(owner.address)).to.equal(150);

    // sending ethers to get metatoken
    await metaToken.swapToToken({
      value: ethers.utils.parseEther("0.00000000000025"),
    });
    expect(await metaToken.balanceOf(owner.address)).to.equal(250000);
    expect(await provider.getBalance(metaToken.address)).to.equal(250000);

    //sending token to get ethers
    await metaToken.transfer(metaToken.address, 100);
    await metaToken.swapToEth(100);
    expect(await provider.getBalance(metaToken.address)).to.equal(249900);
    expect(await metaToken.balanceOf(owner.address)).to.equal(249900);
    expect(await metaToken.balanceOf(metaToken.address)).to.equal(100);
  });
});