#!bin/bash
#version=1.0
#执行一个计划任务的脚本
read -p "周几执行：" week
read -p "24小时中的哪一个小时：" time
read -p " 执行脚本的命令：" command
user=`whoami`
cat << EOF >> /ect/crontab 
0 $time * * $week $user $command
