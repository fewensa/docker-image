#!/bin/sh
#


nohup /usr/bin/dockerd > /dev/null &

/usr/sbin/sshd -D
