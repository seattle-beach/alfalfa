#!/usr/bin/env bash
echo "[defaults]
host_key_checking = False" > ~/ansible.cfg
[[ -d /usr/local/Homebrew ]] || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

if hash ansible; then
  echo "Ansible already installed. Skipping."
  else
    brew install ansible
fi

[[ -d ~/workspace ]]         || mkdir ~/workspace
[[ -d ~/workspace/alfalfa ]] || git clone https://github.com/seattle-beach/alfalfa.git ~/workspace/alfalfa
