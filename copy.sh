#!/bin/bash

set -e

files=(
  .bash_profile
  .bashrc
  .config/karabiner.edn
  .config/nvim
  .gitconfig
  .gitignore
  .inputrc
  .vimrc
  .wezterm.lua
)

for file in ${files[@]} ; do
    echo cp "${HOME}/${file}" "./${file}"
    cp "${HOME}/${file}" "./${file}"
done
