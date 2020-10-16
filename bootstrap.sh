#!/usr/bin/env bash

set -e -o pipefail

echo "[defaults]
host_key_checking = False" > ~/ansible.cfg

if hash brew 2> /dev/null; then
  echo "Homebrew already installed. Skipping."
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if hash ansible; then
  echo "Ansible already installed. Skipping."
else
  brew install ansible
fi

[[ -d ~/workspace ]]         || mkdir ~/workspace
[[ -d ~/workspace/alfalfa ]] || git clone https://github.com/seattle-beach/alfalfa.git ~/workspace/alfalfa
