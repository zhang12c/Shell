#!/bin/bash -
ip=$1
ping -c 2 -w 2 $ip > /dev/null 2>&1 
[ $? -eq 0 ] && echo "$ip is on" || echo "$ip is down"
