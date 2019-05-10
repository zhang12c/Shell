#!/bin/bash -

#i=0
#[ $i -eq 0 ] && echo "=" || echo "!="

i=$1
if [ $i -eq 0 ];then
	echo "=0"
elif [ $i -eq 1 ];then
	echo "=1"
else 

	echo "!="
fi 

