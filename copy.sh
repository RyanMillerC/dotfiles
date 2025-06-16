#!/bin/bash

set -e

files=(
  .bash_profile
  .bashrc
  .config/karabiner.edn
  .config/nvim/
  .gitconfig
  .gitignore
  .inputrc
  .vim/spell/en.utf-8.add
  .vimrc
  .wezterm.lua
)

for file in ${files[@]} ; do
    echo cp -r "${HOME}/${file}" "./${file}"
    cp -r "${HOME}/${file}" "./${file}"
done
