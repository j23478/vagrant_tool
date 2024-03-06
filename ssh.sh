
doSetHost(){
    ip=$2
    hostname=$3
    echo $ip  $hostname >> /etc/hosts
}

doSetSSH(){
    ssh-keygen -f ~/.ssh/id_rsa -N ""
    ip=$2
    targetHostName=$3
    ssh-cpoy-id -i .ssh/id_rsa targetHostName

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