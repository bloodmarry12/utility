#!/bin/bash 
#filename:check_bucket.sh
#author:	gavingeng
#date:		2012-03-09 11:06:05

SECONDS=3

#用于检测桶服务是否正常，将正常的桶号记录下来，后续在做免费部署时做调用
#相当于动态检查免费桶
if test -f host;then
	rm -rf host
fi

for((i=1;i<150;i++));
do
	nc -v -w $SECONDS mx$i.mail.sohu.com -z 6504 >tmp 2>&1
	host=`cat tmp |grep "succeeded!" |awk '{print $3}'`
	if test $host;then
		echo $i >>host
		#echo $host
	fi
done	

#使用awk将多行转换为一行，格式化
awk '{{printf "%s ",$0}}' host >hosts

rm -rf tmp
