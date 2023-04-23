# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

init:
	@echo "installing blackbox"
	@brew install blackbox
	@echo "creating gpg key"
	@gpg --gen-key
	@echo "adding blackbox admin"
	@blackbox_addadmin ${GPG_EMAIL}
	@echo "adding blackbox file"
	@blackbox_register_new_file .env.example
	
# deps
update:; forge update

# Build & test
build  :; forge build --sizes
test   :; forge test -vvv

# Utilities
download :; cast etherscan-source --chain ${chain} -d sol/etherscan/${chain}_${address} ${address}
git-diff :
	@mkdir -p diffs
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md
