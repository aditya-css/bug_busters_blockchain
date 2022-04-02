const { expect } = require("chai");
const { Signer } = require("ethers");
const { ethers, waffle } = require("hardhat");

describe("MetaToken", function () {
  it("Testing Swapping Ether to MetaToken", async function () {
    const MetaToken = await ethers.getContractFactory("MetaToken");
    const MetaStack = await ethers.getContractFactory("MetaStack");
    const metaToken = await MetaToken.deploy();
    const metaStack = await MetaStack.deploy();
    await metaToken.deployed();
    const provider = waffle.provider;
    const [owner, addr1] = await ethers.getSigners();

    // sending ethers to get metatoken
    await metaToken.swapToToken(metaStack.address, {
      value: ethers.utils.parseEther("0.00000000000025"),
    });
    expect(await metaToken.balanceOf(owner.address)).to.equal(250000);
    expect(await provider.getBalance(metaToken.address)).to.equal(250000);
  });

  it("Testing Swapping MetaToken to Ether", async function () {
    const MetaToken = await ethers.getContractFactory("MetaToken");
    const MetaStack = await ethers.getContractFactory("MetaStack");
    const metaToken = await MetaToken.deploy();
    const metaStack = await MetaStack.deploy();
    await metaToken.deployed();
    const provider = waffle.provider;
    const [owner, addr1] = await ethers.getSigners();

    // sending ethers to get metatoken
    await metaToken.swapToToken(metaStack.address, {
      value: ethers.utils.parseEther("0.00000000000025"),
    });
    expect(await metaToken.balanceOf(owner.address)).to.equal(250000);
    expect(await provider.getBalance(metaToken.address)).to.equal(250000);

    //sending token to get ethers
    await metaToken.transfer(metaToken.address, 100);
    await metaToken.swapToEth(100);
    expect(await provider.getBalance(metaToken.address)).to.equal(249900);
    expect(await metaToken.balanceOf(owner.address)).to.equal(249900);
    expect(await metaToken.balanceOf(metaToken.address)).to.equal(0);
  });
});
