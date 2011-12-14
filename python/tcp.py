#!/usr/bin/env python
#coding:utf-8
#filename:tcp.py

'''
author:	gavingeng
date:	2011-12-14 09:35:59 
'''
import socket
import sys

NORMAL=0
ERROR=1
TIMEOUT=5

def ping(ip,port,timeout=TIMEOUT):
	try:
		cs=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
		address=(str(ip),int(port))
		status = cs.connect_ex((address))
		cs.settimeout(timeout)
		#this status is returnback from tcpserver
		if status != NORMAL :
			print ERROR
		else:
			print NORMAL	
	except Exception ,e:
		print ERROR
		print "error:%s" %e
		return ERROR
	
	return NORMAL

def usage():
	print ur'usage: ./tcp.py ip port [timeout]'
	print ur'eg.. ./tcp.py 127.0.0.1 3306'
	
if __name__=='__main__':
	if len(sys.argv) < 3 :
		usage()
		sys.exit(1)
	
	ip = sys.argv[1]
	port = sys.argv[2]
	try:
		timeout = sys.argv[3]
	except IndexError ,e:
		timeout=TIMEOUT
	ping(ip,port,timeout)

