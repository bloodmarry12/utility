#!/bin/bash 

#hosts="99"
#DEPLOY_FILE=/root/gavin/deploy/check.sh

source ./const_check.sh

for host in $hosts;
do
    host=mx$host.mail.sohu.net
    echo $host $DEPLOY_FILE
    scp $DEPLOY_FILE root@$host:/root
done
