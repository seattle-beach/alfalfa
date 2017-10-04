# alfalfa

This is an experimental project for provisioning new development machines.

Alfalfa seeks a middle ground between [sprout-wrap][sprout-wrap], which relies
on Chef, and [workstation-setup][workstation-setup], which uses shell
scripting.

[sprout-wrap]: https://github.com/pivotal-sprout/sprout-wrap
[workstation-setup]: https://github.com/pivotal/workstation-setup

## Usage

Depending on how you feel about cows, you might find it useful to `export
ANSIBLE_NOCOWS=1` first.

### Local Provisioning

```
bash <(curl -s https://raw.githubusercontent.com/seattle-beach/alfalfa/master/bootstrap.sh)
cd ~/workspace/alfalfa/ansible
ansible-playbook main.yml --ask-pass --ask-become-pass
```

You will need to type `yes` a couple of times due to SSH `known_hosts`
schenanigans until our playbook gets around to fixing it.

### Notes

The base Alfalfa playbook (`main.yml`) balances having a base set of tools for
a workstation with the amount of time required to run. As such, there are some
other playbooks included with Alfalfa that can be installed to finish
customizing a new install:

- `java.yml`
- `ruby.yml`
- `postgres.yml`
- `xcode.yml`
- `arkit.yml`

#### Running a single playbook
To run an individual playbook, go into the ansible directory and run the ansible command like this:

```
pushd ~/workspace/alfalfa/ansible
ansible-playbook arkit.yml --ask-become-pass
popd
```

Sierra does not allow modifying `TCC.db` without jumping through significant
hoops, so you'll need to manually enable apps that require accessibility access
(e.g., ShiftIt).

### Remote Provisioning

First, the remote machine needs to agree to the `sudo` disclaimer:

```
sudo -v && sudo -k
```

Then, on the control machine:

```
brew install ansible

git clone https://github.com/seattle-beach/alfalfa
cd alfalfa/ansible
echo HOST > hosts
ansible-playbook main.yml --ask-pass --ask-become-pass
```
