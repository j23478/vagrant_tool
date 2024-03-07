
doSetHost(){
    ip=$2
    hostname=$3
    echo $ip  $hostname >> /etc/hosts
}

doSetSSH(){
    keyFileName=ansible_manager
    keyPath="/home/vagrant/.ssh/id_rsa"
    targetHostName=$2

    if [ ! -e $keyPath ];then
        ssh-keygen -b 2048 -t rsa -f $keyPath -q -N ""
    fi

    sudo apt-get install sshpass -y
    sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no "vagrant@${targetHostName}"
}

command=$1
case $command in
	setHost)
		doSetHost "$@"
		;;
	setSSH)
		doSetSSH "$@"
		;;
esac