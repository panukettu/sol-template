# To load the variables in the .env file
source .env

# To deploy and verify our contract
forge script sol/scripts/Deploy.s.sol:Deploy --fork-url $RPC_GOERLI --broadcast -vvvv
