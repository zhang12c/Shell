#!/bin/bash -
#版本1.1
#安装mysql社区版本5.5-8.0
info=`rpm -qa | grep "yum-utils"`
if [ -z $info ];then
	echo "正在安装脚本依赖"
	yum -y install yum-utils >/etc/null 2>&1
else
	echo "脚本依赖已经完成,脚本开始进行"
fi
 echo "=============================="
 echo "安装的版本："
 echo "(0) mysql55-community"
 echo "(1) mysql56-community"
 echo "(2) mysql57-community"
 echo "(3) mysql80-community"
 echo "Crt + c  退出脚本"
 echo "=============================="
 read -p "请选择您要安装的版本(0-3)" input
case $input in 
	0)
		yum-config-manager —disable mysql80-community --save
		yum-config-manager --enable mysql55-community --save
		yum install mysql-community-server -y;;
	1)
		yum-config-manager —disable mysql80-community --save
		yum-config-manager --enable mysql56-community --save
		yum install mysql-community-server -y;;
	2)
		yum-config-manager —disable mysql80-community --save
		yum-config-manager --enable mysql57-community --save
		yum install mysql-community-server -y;;
	3)
		yum install mysql-community-server -y;;
esac


