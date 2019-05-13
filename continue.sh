#!/bin/bash -
#用来输出1到10


i=`ls`
#echo $i
for i in $i
do 
	[ $i = "*.sh" ] && continue #continue跳出当前的循环执行下一个循环
	echo $i
done
