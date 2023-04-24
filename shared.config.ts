import { config } from 'dotenv';
import type {
  HttpNetworkAccountsUserConfig,
  NetworksUserConfig,
} from 'hardhat/types/config.ts';
import * as chains from '@wagmi/chains';
config();

export const mainnets = (
  accounts: HttpNetworkAccountsUserConfig
): NetworksUserConfig => ({
  mainnet: {
    accounts,
    url: rpc('mainnet'),
    chainId: chains.mainnet.id,
    verify: {
      etherscan: etherscan('mainnet'),
    },
    companionNetworks: {
      arbitrum: 'arbitrum',
      polygon: 'polygon',
      optimism: 'optimism',
      polygonZkEvm: 'polygonZkEvm',
    },
  },
  arbitrum: {
    accounts,
    url: rpc('arbitrum'),
    chainId: chains.arbitrum.id,
    verify: {
      etherscan: etherscan('arbitrum'),
    },
    companionNetworks: {
      mainnet: 'mainnet',
      polygon: 'polygon',
      optimism: 'optimism',
      polygonZkEvm: 'polygonZkEvm',
    },
  },
  arbitrumNova: {
    accounts,
    url: rpc('arbitrumNova'),
    chainId: chains.arbitrumNova.id,
    verify: {
      etherscan: etherscan('arbitrumNova'),
    },
  },
  bsc: {
    accounts,
    url: rpc('bsc'),
    chainId: chains.bsc.id,
    verify: {
      etherscan: etherscan('bsc'),
    },
    companionNetworks: {
      polygon: 'polygon',
    },
  },
  gnosis: {
    accounts,
    url: rpc('gnosis'),
    chainId: chains.gnosis.id,
    verify: {
      etherscan: etherscan('gnosis'),
    },
  },
  moonbeam: {
    accounts,
    url: rpc('moonbeam'),
    chainId: chains.moonbeam.id,
    verify: {
      etherscan: etherscan('moonbeam'),
    },
  },
  moonriver: {
    accounts,
    url: rpc('moonriver'),
    chainId: chains.moonriver.id,
    verify: {
      etherscan: etherscan('moonriver'),
    },
  },
  polygon: {
    accounts,
    url: rpc('polygon'),
    chainId: chains.polygon.id,
    verify: {
      etherscan: etherscan('polygon'),
    },
    companionNetworks: {
      arbitrum: 'arbitrum',
      polygon: 'polygon',
      optimism: 'optimism',
      polygonZkEvm: 'polygonZkEvm',
    },
  },
  optimism: {
    accounts,
    url: rpc('optimism'),
    chainId: chains.optimism.id,
    verify: {
      etherscan: etherscan('optimism'),
    },
    companionNetworks: {
      mainnet: 'mainnet',
      arbitrum: 'arbitrum',
      polygon: 'polygon',
      polygonZkEvm: 'polygonZkEvm',
    },
  },
  polygonZkEvm: {
    accounts,
    url: rpc('polygonZkEvm'),
    chainId: chains.polygonZkEvm.id,
    verify: {
      etherscan: etherscan('polygonZkEvm'),
    },
    companionNetworks: {
      mainnet: 'mainnet',
      arbitrum: 'arbitrum',
      polygon: 'polygon',
      optimism: 'optimism',
    },
  },
  fantom: {
    accounts,
    url: rpc('fantom'),
    chainId: chains.fantom.id,
    verify: {
      etherscan: etherscan('fantom'),
    },
  },
  harmony: {
    accounts,
    url: rpc('harmony'),
    chainId: chains.harmonyOne.id,
  },
  celo: {
    accounts,
    url: rpc('celo'),
    chainId: chains.celo.id,
    verify: {
      etherscan: etherscan('celo'),
    },
  },
  aurora: {
    accounts,
    url: rpc('aurora'),
    chainId: chains.aurora.id,
    verify: {
      etherscan: etherscan('aurora'),
    },
  },
  avax: {
    accounts,
    url: rpc('avax'),
    chainId: chains.avalanche.id,
    verify: {
      etherscan: etherscan('avax'),
    },
  },
  metis: {
    accounts,
    url: rpc('metis'),
    chainId: chains.metis.id,
  },
  zkSync: {
    accounts,
    url: rpc('zkSync'),
    chainId: chains.zkSync.id,
    zksync: true,
  },
});
export const testnets = (
  accounts: HttpNetworkAccountsUserConfig
): NetworksUserConfig => ({
  goerli: {
    accounts,
    url: rpc('goerli'),
    chainId: chains.goerli.id,
    verify: {
      etherscan: etherscan('goerli'),
    },
    companionNetworks: {
      optimismGoerli: 'optimismGoerli',
      sepolia: 'sepolia',
      arbitrumGoerli: 'arbitrumGoerli',
      polygonMumbai: 'polygonMumbai',
      polygonZkEvmTestnet: 'polygonZkEvmTestnet',
    },
  },
  sepolia: {
    accounts,
    url: rpc('sepolia'),
    chainId: chains.sepolia.id,
    verify: {
      etherscan: etherscan('sepolia'),
    },
    companionNetworks: {
      optimismGoerli: 'optimismGoerli',
      goerli: 'goerli',
      arbitrumGoerli: 'arbitrumGoerli',
      polygonMumbai: 'polygonMumbai',
      polygonZkEvmTestnet: 'polygonZkEvmTestnet',
    },
  },
  arbitrumGoerli: {
    accounts,
    url: rpc('arbitrumGoerli'),
    chainId: chains.arbitrumGoerli.id,
    verify: {
      etherscan: etherscan('arbitrumGoerli'),
    },
    companionNetworks: {
      optimismGoerli: 'optimismGoerli',
      goerli: 'goerli',
      sepolia: 'sepolia',
      polygonMumbai: 'polygonMumbai',
      polygonZkEvmTestnet: 'polygonZkEvmTestnet',
    },
  },
  polygonMumbai: {
    accounts,
    url: rpc('polygonMumbai'),
    chainId: chains.polygonMumbai.id,
    verify: {
      etherscan: etherscan('polygonMumbai'),
    },
    companionNetworks: {
      optimismGoerli: 'optimismGoerli',
      goerli: 'goerli',
      sepolia: 'sepolia',
      arbitrumGoerli: 'arbitrumGoerli',
      polygonZkEvmTestnet: 'polygonZkEvmTestnet',
    },
  },
  optimismGoerli: {
    accounts,
    url: rpc('optimismGoerli'),
    chainId: chains.optimismGoerli.id,
    verify: {
      etherscan: etherscan('optimismGoerli'),
    },
    companionNetworks: {
      goerli: 'goerli',
      sepolia: 'sepolia',
      arbitrumGoerli: 'arbitrumGoerli',
      polygonMumbai: 'polygonMumbai',
      polygonZkEvmTestnet: 'polygonZkEvmTestnet',
    },
  },
  polygonZkEvmTestnet: {
    accounts,
    url: rpc('polygonZkEvmTestnet'),
    chainId: chains.polygonZkEvmTestnet.id,
    verify: {
      etherscan: etherscan('polygonZkEvmTestnet'),
    },
    companionNetworks: {
      optimismGoerli: 'optimismGoerli',
      goerli: 'goerli',
      sepolia: 'sepolia',
      arbitrumGoerli: 'arbitrumGoerli',
      polygonMumbai: 'polygonMumbai',
    },
  },
  zkSyncTestnet: {
    accounts,
    url: rpc('zkSyncTestnet'),
    chainId: chains.zkSyncTestnet.id,
    zksync: true,
  },
});

export const rpc = (network: Networks, provider: RPCProvider = 'pokt') => {
  try {
    switch (provider) {
      case 'pokt':
        return pokt(network);
      case 'alchemy':
        return alchemy(network);
      case 'infura':
        return infura(network);
      case 'omnia':
        return omnia(network);
      default:
        return pokt(network);
    }
  } catch {
    return publicRPC(network);
  }
};

export const etherscan = (network: Networks) => {
  return {
    mainnet: {
      url: 'https://etherscan.io',
      apiUrl: process.env.ETHERSCAN_API_URL_MAINNET,
      apiKey: process.env.ETHERSCAN_API_KEY_MAINNET,
    },
    bsc: {
      url: 'https://bscscan.com',
      apiUrl: process.env.ETHERSCAN_API_URL_BSC,
      apiKey: process.env.ETHERSCAN_API_KEY_BSC,
    },
    optimism: {
      url: 'https://optimistic.etherscan.io',
      apiUrl: process.env.ETHERSCAN_API_URL_OPTIMISM,
      apiKey: process.env.ETHERSCAN_API_KEY_OPTIMISM,
    },
    arbitrum: {
      url: 'https://arbiscan.io',
      apiUrl: process.env.ETHERSCAN_API_URL_ARBITRUM,
      apiKey: process.env.ETHERSCAN_API_KEY_ARBITRUM,
    },
    arbitrumNova: {
      url: 'https://nova.arbiscan.io',
      apiUrl: process.env.ETHERSCAN_API_URL_ARBITRUM_NOVA,
      apiKey: process.env.ETHERSCAN_API_KEY_ARBITRUM_NOVA,
    },
    gnosis: {
      url: 'https://gnosisscan.io',
      apiUrl: process.env.ETHERSCAN_API_URL_GNOSIS,
      apiKey: process.env.ETHERSCAN_API_KEY_GNOSIS,
    },
    moonbeam: {
      url: 'https://moonbeam.moonscan.io',
      apiUrl: process.env.ETHERSCAN_API_URL_MOONBEAM,
      apiKey: process.env.ETHERSCAN_API_KEY_MOONBEAM,
    },
    moonriver: {
      url: 'https://moonriver.moonscan.io',
      apiUrl: process.env.ETHERSCAN_API_URL_MOONRIVER,
      apiKey: process.env.ETHERSCAN_API_KEY_MOONRIVER,
    },
    polygonZkEvm: {
      url: 'https://zkevm.polygonscan.com',
      apiUrl: process.env.ETHERSCAN_API_URL_POLYGON_ZKEVM,
      apiKey: process.env.ETHERSCAN_API_KEY_POLYGON_ZKEVM,
    },
    celo: {
      url: 'https://celoscan.io',
      apiUrl: process.env.ETHERSCAN_API_URL_CELO,
      apiKey: process.env.ETHERSCAN_API_KEY_CELO,
    },
    avax: {
      url: 'https://snowtrace.io',
      apiUrl: process.env.ETHERSCAN_API_URL_AVAX,
      apiKey: process.env.ETHERSCAN_API_KEY_AVAX,
    },
    fantom: {
      url: 'https://ftmscan.com',
      apiUrl: process.env.ETHERSCAN_API_URL_FANTOM,
      apiKey: process.env.ETHERSCAN_API_KEY_FANTOM,
    },
    polygon: {
      url: 'https://polygonscan.com',
      apiUrl: process.env.ETHERSCAN_API_URL_POLYGON,
      apiKey: process.env.ETHERSCAN_API_KEY_POLYGON,
    },
    polygonMumbai: {
      url: 'https://mumbai.polygonscan.com',
      apiUrl: process.env.ETHERSCAN_API_URL_POLYGON_MUMBAI,
      apiKey: process.env.ETHERSCAN_API_KEY_POLYGON_MUMBAI,
    },
    arbitrumGoerli: {
      url: 'https://goerli.arbiscan.io',
      apiUrl: process.env.ETHERSCAN_API_URL_ARBITRUM_GOERLI,
      apiKey: process.env.ETHERSCAN_API_KEY_ARBITRUM_GOERLI,
    },
    optimismGoerli: {
      url: 'https://goerli-optimism.etherscan.io',
      apiUrl: process.env.ETHERSCAN_API_URL_OPTIMISM_GOERLI,
      apiKey: process.env.ETHERSCAN_API_KEY_OPTIMISM_GOERLI,
    },
    goerli: {
      url: 'https://goerli.etherscan.io',
      apiUrl: process.env.ETHERSCAN_API_URL_GOERLI,
      apiKey: process.env.ETHERSCAN_API_KEY_GOERLI,
    },
    sepolia: {
      url: 'https://sepolia.etherscan.io',
      apiUrl: process.env.ETHERSCAN_API_URL_SEPOLIA,
      apiKey: process.env.ETHERSCAN_API_KEY_SEPOLIA,
    },
    polygonZkEvmTestnet: {
      url: 'https://testnet-zkevm.polygonscan.com',
      apiUrl: process.env.ETHERSCAN_API_URL_POLYGON_ZKEVM_TESTNET,
      apiKey: process.env.ETHERSCAN_API_KEY_POLYGON_ZKEVM_TESTNET,
    },
  }[network];
};

export const pokt = (network: Networks) => {
  const POKT_API_KEY = process.env.POKT_API_KEY;

  if (!POKT_API_KEY) throw new Error('POKT_API_KEY is not defined in .env');

  let poktId = '';

  if (network === 'mainnet') poktId = 'eth-trace';
  if (network === 'goerli') poktId = 'goerli-archival';
  if (network === 'optimism') poktId = 'optimism-mainnet';
  if (network === 'bsc') poktId = 'bsc-archival';
  if (network === 'arbitrum') poktId = 'arbitrum-one';
  if (network === 'polygon') poktId = 'poly-archival';
  if (network === 'polygonZkEvm') poktId = 'polygon-zkevm-mainnet';
  if (network === 'polygonMumbai') poktId = 'polygon-mumbai';
  if (network === 'moonbeam') poktId = 'moonbeam-mainnet';
  if (network === 'moonriver') poktId = 'moonriver-mainnet';
  if (network === 'gnosis') poktId = 'poa-xdai-archival';
  if (network === 'celo') poktId = 'celo-mainnet';
  if (network === 'fantom') poktId = 'fantom-mainnet';
  if (network === 'avax') poktId = 'avax-archival';
  if (network === 'harmony') poktId = 'harmony-0';
  if (network === 'metis') poktId = 'metis-mainnet';

  if (poktId === '') throw new Error('No pokt found for network: ' + network);

  return `https://${poktId}.gateway.pokt.network/v1/lb/${POKT_API_KEY}`;
};

export const publicRPC = (network: Networks) => {
  return {
    mainnet: process.env.RPC_MAINNET,
    goerli: process.env.RPC_GOERLI,
    bsc: process.env.RPC_BSC,
    gnosis: process.env.RPC_GNOSIS,
    moonbeam: process.env.RPC_MOONBEAM,
    moonriver: process.env.RPC_MOONRIVER,
    sepolia: process.env.RPC_SEPOLIA,
    optimism: process.env.RPC_OPTIMISM,
    optimismGoerli: process.env.RPC_OPTIMISM_GOERLI,
    arbitrum: process.env.RPC_ARBITRUM,
    arbitrumNova: process.env.RPC_ARBITRUM_NOVA,
    arbitrumGoerli: process.env.RPC_ARBITRUM_GOERLI,
    polygon: process.env.RPC_POLYGON,
    polygonMumbai: process.env.RPC_POLYGON_MUMBAI,
    polygonZkEvm: process.env.RPC_POLYGON_ZKEVM,
    polygonZkEvmTestnet: process.env.RPC_POLYGON_ZKEVM_TESTNET,
    fantom: process.env.RPC_FANTOM,
    metis: process.env.RPC_METIS,
    celo: process.env.RPC_CELO,
    zkSync: process.env.RPC_ZKSYNC,
    harmony: process.env.RPC_HARMONY,
    avax: process.env.RPC_AVAX,
    aurora: process.env.RPC_AURORA,
    zkSyncTestnet: process.env.RPC_ZKSYNC_TESTNET,
  }[network];
};

export const infura = (network: Networks) => {
  const infuraKey = process.env.INFURA_API_KEY;
  if (!infuraKey) {
    throw new Error('No INFURA_API_KEY found in .env file');
  }
  let infuraId = '';
  if (network === 'mainnet') infuraId = 'mainnet';
  if (network === 'goerli') infuraId = 'goerli';
  if (network === 'sepolia') infuraId = 'sepolia';
  if (network === 'optimism') infuraId = 'optimism-mainnet';
  if (network === 'optimismGoerli') infuraId = 'optimism-goerli';
  if (network === 'arbitrum') infuraId = 'arbitrum-mainnet';
  if (network === 'arbitrumGoerli') infuraId = 'arbitrum-goerli';
  if (network === 'polygon') infuraId = 'polygon-mainnet';
  if (network === 'polygonMumbai') infuraId = 'polygon-mumbai';
  if (network === 'polygonZkEvm') infuraId = 'polygonzkevm-mainnet';
  if (network === 'polygonZkEvmTestnet') infuraId = 'polygonzkevm-testnet';
  return `https://${infuraId}.infura.io/v3/${infuraKey}`;
};

export const alchemy = (network: Networks) => {
  const alchemyKey = process.env.ALCHEMY_API_KEY;
  if (!alchemyKey) {
    throw new Error('No ALCHEMY_API_KEY found in .env file');
  }
  let alchemyId = '';

  if (network === 'mainnet') alchemyId = 'eth-mainnet';
  if (network === 'goerli') alchemyId = 'eth-goerli';
  if (network === 'sepolia') alchemyId = 'eth-sepolia';
  if (network === 'optimism') alchemyId = 'opt-mainnet';
  if (network === 'optimismGoerli') alchemyId = 'opt-goerli';
  if (network === 'arbitrum') alchemyId = 'arb-mainnet';
  if (network === 'arbitrumGoerli') alchemyId = 'arb-goerli';
  if (network === 'polygon') alchemyId = 'polygon-mainnet';
  if (network === 'polygonMumbai') alchemyId = 'polygon-mumbai';
  if (network === 'polygonZkEvm') alchemyId = 'polygonzkevm-mainnet';
  if (network === 'polygonZkEvmTestnet') alchemyId = 'polygonzkevm-testnet';

  if (!alchemyId) throw new Error(`No alchemyId found in for ${network}`);
  return `https://${alchemyId}.g.alchemy.com/v2/${alchemyKey}`;
};

export const omnia = (network: Networks) => {
  const omniaKey = process.env.OMNIATECH_API_KEY;
  if (!omniaKey) {
    throw new Error('No OMNIA_API_KEY found in .env file');
  }
  let omniaId = '';
  if (network === 'mainnet') omniaId = 'eth/mainnet';
  if (network === 'goerli') omniaId = 'eth/goerli';
  if (network === 'sepolia') omniaId = 'eth/sepolia';
  if (network === 'optimism') omniaId = 'op/mainnet';
  if (network === 'optimismGoerli') omniaId = 'op/goerli';
  if (network === 'arbitrum') omniaId = 'arbitrum/one';
  if (network === 'arbitrumGoerli') omniaId = 'arbitrum/goerli';
  if (network === 'polygon') omniaId = 'polygon/mainnet';
  if (network === 'polygonMumbai') omniaId = 'matic/mumbai';
  if (network === 'bsc') omniaId = 'bsc/mainnet';
  if (network === 'avax') omniaId = 'avax/mainnet';
  if (network === 'fantom') omniaId = 'fantom/mainnet';

  if (!omniaId) throw new Error(`No omniaId found in for ${network}`);
  return `https://endpoints.omniatech.io/v1/${omniaId}/${omniaKey}`;
};

export const layerZero = {
  mainnet: {
    lzChainId: 101,
    endpoint: '0x66A71Dcef29A0fFBDBE3c6a460a3B5BC225Cd675',
  },
  arbitrum: {
    lzChainId: 110,
    endpoint: '0x3c2269811836af69497E5F486A85D7316753cf62',
  },
  bsc: {
    lzChainId: 102,
    endpoint: '0x3c2269811836af69497E5F486A85D7316753cf62',
  },
  optimism: {
    lzChainId: 111,
    endpoint: '0x3c2269811836af69497E5F486A85D7316753cf62',
    confirmations: 6,
  },
  polygon: {
    lzChainId: 109,
    endpoint: '0x3c2269811836af69497E5F486A85D7316753cf62',
  },
  moonbeam: {
    lzChainId: 126,
    endpoint: '0x9740FF91F1985D8d2B71494aE1A2f723bb3Ed9E4',
  },
  moonriver: {
    lzChainId: 167,
    endpoint: '0x7004396C99D5690da76A7C59057C5f3A53e01704',
  },
  gnosis: {
    lzChainId: 145,
    endpoint: '0x9740FF91F1985D8d2B71494aE1A2f723bb3Ed9E4',
  },
  polygonZkEvm: {
    lzChainId: 158,
    endpoint: '0x9740FF91F1985D8d2B71494aE1A2f723bb3Ed9E4',
  },
  zkSync: {
    lzChainId: 165,
    endpoint: '0x9b896c0e23220469C7AE69cb4BbAE391eAa4C8da',
  },
  celo: {
    lzChainId: 125,
    endpoint: '0x3A73033C0b1407574C76BdBAc67f126f6b4a9AA9',
  },
  avax: {
    lzChainId: 106,
    endpoint: '0x3c2269811836af69497E5F486A85D7316753cf62',
  },
  fantom: {
    lzChainId: 112,
    endpoint: '0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7',
  },
  harmony: {
    lzChainId: 116,
    endpoint: '0x9740FF91F1985D8d2B71494aE1A2f723bb3Ed9E4',
  },
  metis: {
    lzChainId: 151,
    endpoint: '0x9740FF91F1985D8d2B71494aE1A2f723bb3Ed9E4',
  },
  /* -------------------------------------------------------------------------- */
  /*                                  TESTNETS                                  */
  /* -------------------------------------------------------------------------- */
  goerli: {
    lzChainId: 10121,
    endpoint: '0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23',
  },
  optimismGoerli: {
    lzChainId: 10132,
    endpoint: '0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1',
  },
  polygonMumbai: {
    lzChainId: 10109,
    endpoint: '0xf69186dfBa60DdB133E91E9A4B5673624293d8F8',
  },
  arbitrumGoerli: {
    lzChainId: 10143,
    endpoint: '0x6aB5Ae6822647046626e83ee6dB8187151E1d5ab',
  },
  polygonZkEvmTestnet: {
    lzChainId: 10158,
    endpoint: '0x6aB5Ae6822647046626e83ee6dB8187151E1d5ab',
  },
  sepolia: {
    lzChainId: 10161,
    endpoint: '0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1',
  },
  zkSyncTestnet: {
    lzChainId: 10165,
    endpoint: '0x093D2CF57f764f09C3c2Ac58a42A2601B8C79281',
  },
};

export const layerZeroBlockConfig = {
  [layerZero.mainnet.lzChainId]: 15,
  [layerZero.bsc.lzChainId]: 20,
  [layerZero.avax.lzChainId]: 12,
  [layerZero.polygon.lzChainId]: 512, // https://polygonscan.com/block/39599624/f?hash=0x0b7e6c5e9fbae3e2dbd114e4836b52ffb1211820bf62bbbd3ddf859dd07c0fe1
  [layerZero.arbitrum.lzChainId]: 20,
  [layerZero.optimism.lzChainId]: 20,
  [layerZero.fantom.lzChainId]: 5,
  [layerZero.harmony.lzChainId]: 5,
  [layerZero.metis.lzChainId]: 5,
  [layerZero.moonbeam.lzChainId]: 10,
  [layerZero.gnosis.lzChainId]: 5,
  [layerZero.celo.lzChainId]: 5,
  /* -------------------------------------------------------------------------- */
  /*                                  Testnets                                  */
  /* -------------------------------------------------------------------------- */
  [layerZero.polygonMumbai.lzChainId]: 10,
  [layerZero.goerli.lzChainId]: 3,
  [layerZero.arbitrumGoerli.lzChainId]: 3,
  [layerZero.optimismGoerli.lzChainId]: 3,
  [layerZero.zkSyncTestnet.lzChainId]: 10,
};
