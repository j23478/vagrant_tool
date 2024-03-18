# vagrant_tool

## Prerequisite
- Install virtualbox
- Install vagrant
- Download VBoxGuestAdditions_6.1.38.iso (optional)
- Install vagrant-vbguest (guest additions) (optional)
```shell
	$ vagrant plugin install vagrant-vbguest 
```
- Add NAT Network
-- Create a NAT Network
-- Disable DHCP

## Steps
- Vagrant
```shell
    $ vagrant up
    $ vagrant ssh ansible-manager
    ansible-manager$ cd /Desktop/ansible_tool
    ansible-manager$ ansible-playbook playbook_install_m8s.yml
    ansible-manager$ ansible-playbook playbook_join_cluster_m8s.yml
```

## Add nodes
- add a new netplan yml
- add metadata to Vagrantfile
- add node to inventory.yml