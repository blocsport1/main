const dotenv = require('dotenv')
const HDWalletProvider = require('truffle-hdwallet-provider')
const { MNEMONIC, INFURA_KEY } = dotenv.load().parsed

const rinkebyProvider =
  new HDWalletProvider(MNEMONIC, 'https://rinkeby.infura.io/v3/' + INFURA_KEY, 0, 10)

const ropstenProvider =
    new HDWalletProvider(MNEMONIC, 'https://ropsten.infura.io/v3/' + INFURA_KEY, 0, 10)

const mainnetProvider =
        new HDWalletProvider(MNEMONIC, 'https://mainnet.infura.io/v3/' + INFURA_KEY, 0, 10)

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: '127.0.0.1',
      port: 7545,
      network_id: '*'
    },
    mainnet: {
        provider: () => mainnetProvider,
        gas: 6.9e6,
        gasPrice: 15000000001,
        network_id: '1'
      },
    ropsten: {
      provider: () => ropstenProvider,
      gas: 6.9e6,//6.9e6
      gasPrice: 15000000001,//15000000001
      network_id: '3'
    },
    rinkeby: {
      provider: () => rinkebyProvider,
      gas: 6.9e6,
      gasPrice: 15000000001,
      network_id: '4'
    }

  },
  compilers: {
    solc: {
      version: "^0.4.24"
    }
  }
}
