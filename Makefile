# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

init-blackbox:
	@echo "installing blackbox"
	@brew install blackbox
	@echo "initializing blackbox"
	@blackbox_initialize
	@echo "creating gpg key"
	@gpg --gen-key
	@echo "adding blackbox admin"
	@blackbox_addadmin ${email}
	@echo "copying env example"
	@cp .env.example .env
	@echo "adding blackbox file"
	@blackbox_register_new_file .env
	@echo "decrypting env"
	@blackbox_decrypt_file .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes
test   :; forge test -vvv

# Utilities
download :; cast etherscan-source --chain ${chain} -d sol/contracts/etherscan/${chain}/${address} ${address}
git-diff :
	@mkdir -p diffs
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md
