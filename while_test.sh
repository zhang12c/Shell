#!/bin/bash -

i=0
while [ 9 -ne 10 ]
do 
	i=$(($i+1))
	echo $i
	[ $i -eq 100 ] && break
done

