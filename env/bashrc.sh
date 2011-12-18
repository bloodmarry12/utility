#!/bin/bash -x 
#filename:bashrc.sh
#autuor:	gavingeng
#date:		2011-12-18 12:14:31

mkcd(){
    mkdir $1
    cd $1
}

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
