
doSetHost(){
    ip=$2
    hostname=$3
    echo $ip  $hostname #>> /etc/hosts
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

read  -n 1 -p "Input Selection:" mainmenuinput