#!/bin/bash -x 
#filename:bashrc.sh
#autuor:	gavingeng
#date:		2011-12-18 12:14:31

#history相关设置
#让系统记录每条历史命令的执行时间
export HISTTIMEFORMAT='%F %T '
#忽略历史中的特定命令
export HISTIGNORE="pwd:ll:ls:ll -ltr:"
#控制历史命令记录的总行数
export HISTSIZE=100000

#创建目录，并进入该目录
mkcd(){
    mkdir $1
    cd $1
}

#创建.sh的时候，加入固定的信息，目前有：使用的shell信息、文件名、作者、创建日期
touchsh(){
	if test ! -e $1
	then
    	touch $1
		chmod 755 $1
    	title="#!/bin/bash -x \n#filename:$1\n#autuor:\tgavingeng\n#date:\t\t`date +"%Y-%m-%d %T"`\n"
    	echo -e $title >>$1
	fi

	vi $1
}

#创建.py文件时，写入固定信息
touchpy(){
	if test ! -e $1
	then
		touch $1
		chmod 755 $1
		title="#!/usr/bin/env python\n#coding:utf-8\n#filename:$1\n\n'''\nauthor:\tgavingeng\ndate:\t`date +"%Y-%m-%d %T"` \n'''"

		generate_main=0 #default  0

		if test $# = 2;
		then
			generate_main=$2
		fi

		if test $generate_main = 0 ;then
			title=${title}"\n\n\ndef main():\n\tpass\n\nif __name__=='__main__':\n\tmain()"
		fi

		echo -e $title >>$1
	fi

	vi $1
}

#自动补齐
#link:http://blog.longwin.com.tw/2012/02/bash-autocomplete-ssh-2012/
complete -W "$(echo $(grep '^ssh ' ~/.bash_history | sort -u | sed 's/^ssh //'))" ssh 

rmpyc(){
    #默认是删除5层结构内的pyc文件
    level=3
    #echo $((RANDOM%10+1)) 10以内的随机数
    if test -n $1;then
        #采用此方式来处理所传参数是否为数字，并将expr值重定向到/dev/null中
        expr $1 - $level >/dev/null 2>&1
        #使用$?来判断上步是否出错，这样来设置level
        if test $? -eq 0;then 
            level=$1
        fi  

    #   echo $level
        #可做交互式的删除操作
        for f in `find . -maxdepth $level -name "*.pyc"`;
        do  
            echo $f
            rm -rf $f
        done
    fi  
}

SimpleHTTPServer(){
    port=8000
    if test -n $1;then
        expr $1 - $port >/dev/null 2>&1
        if test $? -eq 0 ;then
            port=$1
        fi  
    fi  
    echo $port
    echo 'usage: python -m SimpleHTTPServer $port'
    #python -m SimpleHTTPServer $port >>/tmp/simpleHTTPServer.log 2>&1
    python -m SimpleHTTPServer $port 
}

receiveFileServere(){
    port=8000
    if test -n $1;then
        expr $1 - $port >/dev/null 2>&1
        if test $? -eq 0 ;then
            port=$1
        fi
    fi
    echo $port
    echo 'python ~/bin/droocp.py $port -d ~/uploads -p ~/Pictures/iphone_cmd.png -m"please send your file to me!"'
    #python ~/bin/droocp.py $port -d ~/uploads -p ~/Pictures/iphone_cmd.png -m"please send your file to me!"
    python ~/bin/droocp.py -d ~/uploads -p ~/Pictures/iphone_cmd.png -m"please send your file to me!"
}

#translate
#use youdao translate
ts_youdao(){
words=""
for word in $@; 
do
    words="$words$word "
done
echo $words
curl -s \
        "http://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule&smartresult=ugc&sessionFrom=dict.top" \
     -d \
    "type=AUTO&i=$words&doctype=json&xmlVersion=1.4&keyfrom=fanyi.web&ue=UTF-8&typoResult=true&flag=false" \
        | sed -E -n 's/.*tgt":"([^"]+)".*/\1/p' ;

return 0;
}

#use google translate
translate(){
words=""
for word in $@; 
do
    words="$words$word "
done
#echo $words
curl -e "http://translate.google.cn/?hl=en" -H 'User-Agent':'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -d "tsel=0&ssel=0&tl=zh_CN&client=t&hl=en&sl=en&sc=1&text=$words&multires=1&otf=2" -s "http://translate.google.cn/translate_a/t" | awk -F"," '{printf "%s\n%s\n%s\n", $2,$3,$1}' | awk -F"\"" '{print $2}'
    
    #return 0;
}
