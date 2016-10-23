#!/usr/bin/env bash

sudo apt-get install -y git ansible sshpass python-apt
hash foo 2>/dev/null         || brew install ansible
[[ -d ~/workspace ]]         || mkdir ~/workspace
[[ -d ~/workspace/alfalfa ]] || git clone https://github.com/seattle-beach/alfalfa.git ~/workspace/alfalfa
ansible-playbook ~/workspace/alfalfa/ansible/main.yml -i "localhost" -c local --ask-pass --ask-become-pass
