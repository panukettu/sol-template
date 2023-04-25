# To load the variables in the .env file
source .env

# To deploy and verify our contract
forge script sol/scripts/Bridge.s.sol:BridgeAll --fork-url $RPC_GOERLI -vvvv
