#!/bin/bash -x 
#filename:operate_router.sh
#autuor:	gavingeng
#date:		2013-04-06 10:51:00

USER=admin
PASSWORD=admin
HOST=192.168.1.1

#重启路由器
restart(){
    curl --user $USER:$PASSWORD http://$HOST/userRpm/SysRebootRpm.htm\?Reboot\=%D6%D8%C6%F4%C2%B7%D3%C9%C6%F7
}

#获取目前正在上网的客户端mac
getMac(){
    echo "ID 客户端  MAC地址  IP地址  有效时间"
    curl --user $USER:$PASSWORD http://$HOST/userRpm/AssignedIpAddrListRpm.htm | grep "^\"" | awk -F"," '{if(NR%4==0){printf "%s\n",$1}else{printf "%s,",$1}}' | awk '{print NR,$0}'
}

usage(){
    echo "$0 [restart|getMac]"
}

if test -z $1;then
	usage
	exit 0
fi

case $1 in 
	restart)
		restart;;
	getMac)
		getMac;;
	default)
		usage;;
	*)
		usage;;
esac
