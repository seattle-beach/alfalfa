# alfalfa

This is an experimental project for provisioning new development machines.

Alfalfa seeks a middle ground between [sprout-wrap][sprout-wrap], which relies
on Chef, and [workstation-setup][workstation-setup], which uses shell
scripting.

[sprout-wrap]: https://github.com/pivotal-sprout/sprout-wrap
[workstation-setup]: https://github.com/pivotal/workstation-setup

## Usage

### Local Provisioning

```
bash <(curl -s https://raw.githubusercontent.com/seattle-beach/alfalfa/master/bootstrap.sh)
cd ~/workspace/alfalfa/ansible
ansible-playbook main.yml --ask-pass --ask-become-pass
```

You will need to type `yes` a couple of times due to SSH `known_hosts`
schenanigans until our playbook gets around to fixing it.

### Post-Install

Sierra does not allow modifying `TCC.db` without jumping through significant
hoops, so you'll need to manually enable apps that require accessibility access
(e.g., ShiftIt).

### Remote Provisioning

```
sudo -v && sudo -k
```

On the control machine:

```
brew install ansible

git clone https://github.com/seattle-beach/alfalfa
cd alfalfa/ansible
echo HOST > hosts
ansible-playbook main.yml --ask-pass --ask-become-pass
```

Since this sets up SSH keys, subsequent runs should not require `ask-pass`.

Depending on how you feel about cows, you might find it useful to `export ANSIBLE_NOCOWS=1` first.
