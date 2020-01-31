#!/bin/bash -

Nextcloud=nextcloud
Nextcloud_version=18.0.0
cd /tmp
sudo rm -rf ./${Nextcloud} && sudo unzip ./${Nextcloud}-${Nextcloud_version}.zip -d ./${Nextcloud}
cp ./$Nextcloud /var/www/$Nextcloud
echo '
<VirtualHost *:80>
  DocumentRoot /var/www/nextcloud/

  <Directory /var/www/nextcloud/>
    Require all granted
    AllowOverride All
    Options FollowSymLinks MultiViews

    <IfModule mod_dav.c>
      Dav off
    </IfModule>

  </Directory>
</VirtualHost>
' | tee /etc/httpd/conf.d/nextcloud.conf
sudo yum install httpd
sudo yum install mysqld

#sudo Passwd=`date +%s | sha256sum | base64 | head -c 11 ;echo`
#sudo User=`date +%s | sha256sum | base64 | head -c 6 ;echo`
echo "手动输入mysql
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
GRANT ALL PRIVILEGES on nextcloud.* to 'username'@'localhost';
FLUSH privileges;
"
sudo chown -R apache:apache /var/www/nextcloud/
yum install epel-release yum-utils
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --enable remi-php73
sudo yum install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd php-zip php-dom php-Xml php-libxml php-mbstring
sudo systemctl restart httpd
sudo systemctl restart mysqld
