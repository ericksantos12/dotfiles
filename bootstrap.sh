#!/usr/bin/env zsh
set -euo pipefail

# Ir para a pasta do repositório (diretório deste script)
script_dir=${0:A:h}
cd "$script_dir"

git pull origin main

doIt() {
  rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude ".osx" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" \
        --exclude "LICENSE-MIT.txt" \
        -avh --no-perms . ~
}

if [[ ${1:-} == "--force" || ${1:-} == "-f" ]]; then
  doIt
else
  print -n "This may overwrite existing files in your home directory. Are you sure? (y/n) "
  read -k 1 REPLY
  echo
  if [[ $REPLY == [Yy] ]]; then
    doIt
  fi
fi

unfunction doIt
