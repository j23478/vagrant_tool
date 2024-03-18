host_list = [
    {
        :name => "ansible-worker1",
        :networkFile => "00-installer-2-config.yaml",
        :ip => "10.0.3.4"
    },
    {
        :name => "ansible-manager",
        :networkFile => "00-installer-1-config.yaml",
        :ip => "10.0.3.3"
    }
]


Vagrant.configure("2") do |config|
  # 全局
  	config.vm.box = "tranphuquy19/ubuntu-22.04-desktop"
  	config.vm.box_version = "1.1.0"
  	config.ssh.insert_key = false # can use the same private key to ssh
  	config.vbguest.iso_path = "./VBoxGuestAdditions_6.1.38.iso"
  	config.vbguest.auto_update = false
    
    # ansible tool dir
    config.vm.synced_folder "./ansible_tool", "/home/vagrant/Desktop/ansible_tool", automount: true, mount_options: ["dmode=770", "fmode=770"]
	
	host_list.each do |item|
        config.vm.define item[:name] do |host|
        	# 設置 host 屬性
            host.vm.hostname = item[:name]
            host.vm.provider "virtualbox" do |vb, override|
              #   override.vm.synced_folder ".", "/vagrant", type: "virtualbox"
              vb.customize ["modifyvm", :id, "--nic2", "natnetwork"]
              vb.customize ["modifyvm", :id, "--nictype2", "82540EM"]
              vb.customize ["modifyvm", :id, "--nat-network2", "NatNetwork2"]
            end
            # copy network setting to guest
            host.vm.provision "file", source: "./#{item[:networkFile]}", destination: "/tmp/#{item[:networkFile]}"
            host.vm.provision "shell", inline: "mv /tmp/#{item[:networkFile]} /etc/netplan/#{item[:networkFile]}"
            host.vm.provision "shell", inline: "netplan apply"
			# copy utils.sh to guest
			host.vm.provision "file", source: "./utils.sh", destination: "/home/vagrant/utils.sh"
			host.vm.provision "shell", inline: "chmod 777 /home/vagrant/utils.sh"

            if item[:name] == "ansible-manager"
                host.vm.provision "shell", inline: ". /home/vagrant/utils.sh initMaster"
                host_list.each do |elem|
                    if elem[:name] != "ansible-manager"
						# set /etc/hosts to ansible-manager
						host.vm.provision "shell", inline: ". /home/vagrant/utils.sh setHost #{elem[:ip]} #{elem[:name]}"
						# set ssh in ansible-manager
						host.vm.provision "shell", inline: ". /home/vagrant/utils.sh setSSH #{elem[:name]}", privileged: false
                    end
                end
            end
        end
    end
end
