host_list = [
    {
        :name => "ansible-worker",
        :networkFile => "00-installer-2-config.yaml",
        :ip => "10.0.3.3"
    },
    {
        :name => "ansible-manager",
        :networkFile => "00-installer-1-config.yaml",
        :ip => "10.0.3.2"
    }
]


Vagrant.configure("2") do |config|
  # 全局
  config.vm.box = "tranphuquy19/ubuntu-22.04-desktop"
  config.vm.box_version = "1.1.0"
  config.ssh.insert_key = false # can use the same private key to ssh
  config.vbguest.iso_path = "./VBoxGuestAdditions_6.1.38.iso"
  config.vbguest.auto_update = false
  # 區域
  # 多台 vm
    #   config.vm.define "ansible-manager" do |ansible_manager|
    #     ansible_manager.vm.hostname = "ansible-manager"

    #   end

    #   config.vm.define "ansible_worker" do |ansible_worker|
    #     ansible_worker.vm.hostname = "ansible-worker"

    #   end
  
    
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

            # set /etc/hosts to ansible-manager
            if item[:name] == "ansible-manager"
                host_list.each do |elem|
                    if elem[:name] != "ansible-manager"
                        host.vm.provision "shell" do |s|
                            s.args = ["setHost", elem[:ip], elem[:name]]
                            s.path = "utils.sh"
                        end
                        host.vm.provision "shell" do |s|
                            s.privileged=false
                            s.args = ["setSSH", elem[:name]]
                            s.path = "utils.sh"
                        end
                    end
                end
            end
        end
    end
end
