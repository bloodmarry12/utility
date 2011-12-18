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
        #title="#!/bin/bash -x \n#autuor `whoami` \n#date:`date +"%Y-%m-%d %T"` \n"
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
        title=${title}"\n\n\ndef main():\n\tpass\n\nif __name__=='__main__':\n\tmain()"
        #title="#coding:utf-8\n\n#author:\tgavingeng\n#date:\t\t`date +"%Y-%m-%d %T"` \n"
        echo -e $title >>$1
    fi  

    vi $1
}
