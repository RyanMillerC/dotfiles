#!/bin/bash

# Set key repeat rate
defaults write -g InitialKeyRepeat -int 15  # 225 ms
defaults write -g KeyRepeat -int 2  # 30 ms
defaults write com.apple.Finder AppleShowAllFiles true
