#!/usr/bin/env python
#coding:utf-8
#filename:tcp.py

'''
author:	gavingeng
date:	2011-12-14 09:35:59 
'''
import socket
import sys,os,traceback
import subprocess

NORMAL=0
ERROR=1
TIMEOUT=5.0#settimeout(None|float)

def ping(host,port,timeout=TIMEOUT):
	try:
		cs=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
		address=(str(host),int(port))
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

def nc(host,port,timeout):
	command = "nc -v -w %s %s %s" %(timeout,host,port)
	#print command
	status = os.popen(command)
	print status

def usage():
	print ur'usage: ./tcp.py host port [timeout]'
	print ur'eg.. ./tcp.py 127.0.0.1 3306 3'
	
if __name__=='__main__':
	if len(sys.argv) < 3 :
		usage()
		sys.exit(1)
	
	host = sys.argv[1]
	port = sys.argv[2]
	try:
		timeout = sys.argv[3]
		#timeout=TIMEOUT
		#ping(host,port,timeout)
		nc(host,port,timeout)
	except IndexError ,e:
		traceback.print_exc()

