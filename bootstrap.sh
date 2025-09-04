#!/usr/bin/env bash
set -euo pipefail

# Ir para a pasta do repositório (diretório deste script)
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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

if [[ "${1:-}" == "--force" || "${1:-}" == "-f" ]]; then
  doIt
else
  read -rp "This may overwrite existing files in your home directory. Are you sure? (y/n) " REPLY
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi