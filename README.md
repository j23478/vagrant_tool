
# Vagrant_tool
## Prerequisite

 - Install tools
	 - Install virtualbox
	 - Install vagrant
 - Create a NAT Network Named NatNetwork2 (virtualbox)
	 - 喜好設定 -> 網路 -> NAT 網路 -> Disable DHCP
 - Download VBoxGuestAdditions_6.1.38.iso
	 - https://download.virtualbox.org/virtualbox/6.1.38/
	 - Located in the same directory as the Vagrantfile
 - Install vagrant-vbguest
	`
	$  vagrant  plugin  install  vagrant-vbguest
`
## Steps
 - Create VM by Vagrant
	```shell
	$  git clone repo
	$  vagrant  up
	```
- Use ansible to install Microk8s
	```shell
	$  vagrant ssh ansible-manager
	$  cd  ~/Desktop/ansible_tool
	$  ansible-playbook  playbook_install_m8s.yml
	$  ansible-playbook  playbook_join_cluster_m8s.yml
	$  ansible-playbook  playbook_add_on_m8s.yml
	```
- Install Docker to build image locally and set hosts.toml to push to build-in registry
	```shell
	$  ansible-playbook  playbook_install_docker.yml
	$  ansible-playbook  playbook_set_registry_host.yml
	```
## Use build-in registry
- IP of the master node : default is 10.0.3.3
	```shell
	//  push  to  register
	$  docker  build  -t  <IP of the master node>:32000/<imagename>  .
	$  docker  push  <IP of the master node>:32000/<imagename>
	```
- Container template yaml example
	```yml
	template:
	  metadata:
	    labels:
	      app: test-backend
	  spec:
	    containers:
	      - name: test-backend
	        image: <IP of the master node>:32000/<imagename>
	```
## Add nodes
 - add a new netplan yml
 - add metadata to Vagrantfile
 - add node to inventory.yml