
# vagrant_tool

  

## Prerequisite

- Install virtualbox

- Install vagrant

- Add NAT Network
	- Create a NAT Network
	- Disable DHCP

- Download VBoxGuestAdditions_6.1.38.iso (optional)

- Install vagrant-vbguest (guest additions) (optional)

  

```shell

$ vagrant  plugin  install  vagrant-vbguest

```

  

## Steps

- Vagrant

```shell

$ vagrant  up

$ vagrant  ssh  ansible-manager

$ cd  ~/Desktop/ansible_tool

$ ansible-playbook  playbook_install_m8s.yml

$ ansible-playbook  playbook_join_cluster_m8s.yml

$ ansible-playbook  playbook_add_on_m8s.yml (optional)

```

  

## Add nodes

- add a new netplan yml

- add metadata to Vagrantfile

- add node to inventory.yml