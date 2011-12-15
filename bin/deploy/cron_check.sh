#!/bin/bash -x

source ./const_check.sh
DATE=`date +"%Y-%m-%d %T"`
echo "u will add crontab to $hosts,are you sure:y/n"

read key

if [ $key = "y" ] || [ $key = "Y" ];then
    for host in $hosts;
    do
        host=mx$host.mail.sohu.net
		comment="\#add by gavin $DATE"
        #content="*/10 * * * * /root/check.sh"
		content="\*\/10 \* \* \* \* /root/check.sh" #zhuanyi chuli
		ssh root@$host "crontab -l |cat >/root/crontab.ori" #bak
        ssh root@$host "crontab -l |cat >/root/tmp.log"
		ssh root@$host "echo $comment >>/root/tmp.log"
        ssh root@$host "echo $content >>/root/tmp.log"
        ssh root@$host "crontab /root/tmp.log"
        #ssh root@$host "rm -rf /root/tmp.log"
    done
fi
