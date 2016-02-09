# alfalfa

This is an experimental project for provisioning new development machines.

Alfalfa seeks a middle ground between [sprout-wrap][sprout-wrap], which relies
on Chef, and [workstation-setup][workstation-setup], which uses shell
scripting.

[sprout-wrap]: https://github.com/pivotal-sprout/sprout-wrap
[workstation-setup]: https://github.com/pivotal/workstation-setup

## Usage

Adding a new config file: `rake add_config[PATH_TO_FILE]`

Updating submodules: `rake update_submodules`

## Installation

On the remote machine:

```
sudo -v && sudo -k # Get past the first-run sudo disclaimer.
```

On the control machine:

```
brew install ansible

git clone https://github.com/seattle-beach/alfalfa
cd alfalfa/ansible
ansible-playbook main.yml --ask-pass --ask-become-pass
```
