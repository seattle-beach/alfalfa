echo "Bootstrapping Alfalfa"
bash <(curl -s https://raw.githubusercontent.com/seattle-beach/alfalfa/master/bootstrap.sh)
pushd ~/workspace/alfalfa/ansible

echo "Running main playbook"
ansible-playbook main.yml --ask-pass --ask-become-pass
popd
