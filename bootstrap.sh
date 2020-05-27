#!/usr/bin/env bash
echo "[defaults]
host_key_checking = False" > ~/ansible.cfg

if hash brew; then
  echo "Homebrew already installed. Skipping."
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if hash ansible; then
  echo "Ansible already installed. Skipping."
else
  brew install ansible
fi

if hash sshpass; then
  echo "sshpass already installed. Skipping."
else
  brew install http://git.io/sshpass.rb
fi

[[ -d ~/workspace ]]         || mkdir ~/workspace
[[ -d ~/workspace/alfalfa ]] || git clone https://github.com/seattle-beach/alfalfa.git ~/workspace/alfalfa
