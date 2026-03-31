.PHONY: help
help:
	@echo 'Makefile Help'
	@echo ''
	@echo 'make brew-personal - Install general + personal packages'
	@echo 'make brew-work     - Install general + work packages'
	@echo 'make stow          - Set up dotfile symlinks'

.PHONY: brew-personal
brew-personal:
	brew bundle --file=./other-stuff/Brewfile
	brew bundle --file=./other-stuff/Brewfile.personal

.PHONY: brew-work
brew-work:
	brew bundle --file=./other-stuff/Brewfile
	brew bundle --file=./other-stuff/Brewfile.work

.PHONY: stow
stow:
	stow -t "${HOME}" -vv .
