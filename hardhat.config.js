require("@nomiclabs/hardhat-waffle");
const INFURA_API_KEY = "aaf79fe8754e469caff2e1e484f89d0c";
const RINKEBY_PRIVATE_KEY =
  "604479196f566546d0734ed4967e37a8fabfff8b0e142f4fb6fef5bf67ae8c25";

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
    hardhat: {
      chainId: 1337,
    },
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [`${RINKEBY_PRIVATE_KEY}`],
    },
  },
};
