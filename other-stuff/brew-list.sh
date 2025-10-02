#!/bin/bash

# Get only things installed from "brew install X"
echo '# brew installed packages'
brew list --installed-on-request -1

echo '' # Newline

# Casks aren't included in the above list, so print all casks
echo '# brew installed casks'
brew list --casks -1
