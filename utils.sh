
doSetHost(){
    ip=$2
    hostname=$3
    echo $ip  $hostname >> /etc/hosts
}

doSetSSH(){
    keyPath="/home/vagrant/.ssh/id_rsa"
    targetHostName=$2

    if [ ! -e $keyPath ];then
        ssh-keygen -b 2048 -t rsa -f $keyPath -q -N ""
    fi
    sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no "vagrant@${targetHostName}"
}

doinitMaster(){
    sudo apt update -y
    sudo apt-get install software-properties-common -y
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt-get install ansible -y
    sudo apt-get install sshpass -y
}

command=$1
case $command in
	setHost)
		doSetHost "$@"
		;;
	setSSH)
		doSetSSH "$@"
		;;
    initMaster)
        doinitMaster "$@"
        ;;
esac
