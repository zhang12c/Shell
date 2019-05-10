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
fun_echo(){
cat << EOF
==============================
安装的版本：
0) mysql55-community
1) mysql56-community
2) mysql57-community
3) mysql80-community
Crt + c  退出脚本
==============================
EOF
}
dis_mysql80(){

yum-config-manager —disable mysql80-community --save
}
en_mysql55(){

yum-config-manager --enable mysql55-community --save

}
en_mysql56(){

yum-config-manager --enable mysql56-community --save

}
en_mysql57(){

yum-config-manager --enable mysql57-community --save

}
in_mysql(){

yum install mysql-community-server -y

}
fun_read(){
 read -p "请选择您要安装的版本(0-3)" input
}

fun_install(){
case $input in 
	0)
		dis_mysql80#yum-config-manager —disable mysql80-community --save
		en_mysql55#yum-config-manager --enable mysql55-community --save
		in_mysql;;#yum install mysql-community-server -y;;
	1)
		dis_mysql80#yum-config-manager —disable mysql80-community --save
		en_mysql56#yum-config-manager --enable mysql56-community --save
		in_mysql#yum install mysql-community-server -y;;
	2)
		dis_mysql80#yum-config-manager —disable mysql80-community --save
		en_mysql57#yum-config-manager --enable mysql57-community --save
		in_mysql;;#yum install mysql-community-server -y;;
	3)
		in_mysql;;#yum install mysql-community-server -y;;
esac
}
fun_echo 
fun_read
if [ -z $input ]
then
	echo "输入有误，请重新输入"
	fun_read
else
	fun_install
fi
 

