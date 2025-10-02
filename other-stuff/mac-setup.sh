#!/bin/bash

# Set key repeat rate
defaults write -g InitialKeyRepeat -int 15  # 225 ms
defaults write -g KeyRepeat -int 2  # 30 ms

# Show dotfiles in Finder
defaults write com.apple.Finder AppleShowAllFiles true

# "Install" Plug
curl -sfLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
