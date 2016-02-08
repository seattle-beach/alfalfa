# alfalfa

## Installation

On the remote machine:

```
sudo -v && sudo -k # Get past the first-run sudo disclaimer.
```

```
brew install ansible

git clone https://github.com/seattle-beach/alfalfa
cd alfalfa/ansible
ansible-playbook main.yml --ask-pass --ask-become-pass
```
