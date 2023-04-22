import { config } from 'dotenv';
config();

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
  polygon: {
    lzChainId: 109,
    endpoint: '0x3c2269811836af69497E5F486A85D7316753cf62',
  },
  avax: {
    lzChainId: 106,
    endpoint: '0x3c2269811836af69497E5F486A85D7316753cf62',
  },
  fantom: {
    lzChainId: 112,
    endpoint: '0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7',
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
  zkSyncEra: {
    lzChainId: 165,
    endpoint: '0x9b896c0e23220469C7AE69cb4BbAE391eAa4C8da',
  },
  optimism: {
    lzChainId: 111,
    endpoint: '0x3c2269811836af69497E5F486A85D7316753cf62',
    confirmations: 6,
  },
  polygonZkEvm: {
    lzChainId: 158,
    endpoint: '0x9740FF91F1985D8d2B71494aE1A2f723bb3Ed9E4',
  },
  goerli: {
    lzChainId: 10121,
    endpoint: '0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23',
  },
  optimismGoerli: {
    lzChainId: 10132,
    endpoint: '0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1',
  },
  hardhat: {
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
  [layerZero.moonbeam.lzChainId]: 10,
  [layerZero.gnosis.lzChainId]: 5,
  [layerZero.polygonMumbai.lzChainId]: 10,
  [layerZero.goerli.lzChainId]: 3,
  [layerZero.arbitrumGoerli.lzChainId]: 3,
  [layerZero.optimismGoerli.lzChainId]: 3,
  [layerZero.zkSyncTestnet.lzChainId]: 10,
};
