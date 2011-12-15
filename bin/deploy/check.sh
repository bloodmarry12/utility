#!/bin/bash 

#for use judge the fileis user:group,this if from nginx

NGINX_CONF=/opt/work/conf/nginx.conf

CACHE_FILE=/opt/sohumc/client_body_temp

DEFAULT_USER=postfix
DEFAULT_GROUP=postfix


if [ -f $NGINX_CONF ];then
    user=`cat $NGINX_CONF|grep ^user|cut -d";" -f 1|awk '{print $2}'`
    group=`cat $NGINX_CONF|grep ^user|cut -d";" -f 1|awk '{print $3}'`
    #group=`cat /opt/work/conf/nginx.conf |grep ^user|cut -d";" -f 1|awk '{print $3}'`
fi

if [ -d $CACHE_FILE ];then
    if [ -n $user ] && [ -n $gruop ];then
        chown -R $user:$group $CACHE_FILE
    else
        chown -R $DEFAULT_USER:$DEFAULT_GROUP $CACHE_FILE
    fi
fi

