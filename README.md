# alfalfa

This is an experimental project for provisioning new development machines.

Alfalfa seeks a middle ground between [sprout-wrap][sprout-wrap], which relies
on Chef, and [workstation-setup][workstation-setup], which uses shell
scripting.

[sprout-wrap]: https://github.com/pivotal-sprout/sprout-wrap
[workstation-setup]: https://github.com/pivotal/workstation-setup

## Usage



## Provisioning

On the machine to be provisioned:

```
sudo -v && sudo -k # Get past the first-run sudo disclaimer.
```

On the control machine:

```
brew install ansible

git clone https://github.com/seattle-beach/alfalfa
cd alfalfa/ansible
echo HOST > hosts
ansible-playbook main.yml --ask-pass --ask-become-pass
```

### Local provisioning

Although it is less convenient than installing from an already-provisioned
computer, Alfalfa can also be provisioned locally:

```
# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Ansible
brew install ansible

# Clone the Alfalfa repo
git clone https://github.com/seattle-beach/alfalfa.git ~/workspace/alfalfa
cd ~/workspace/alfalfa/ansible

# Provision the local machine
echo localhost > hosts
ansible-playbook main.yml --ask-pass --ask-become-pass
```
