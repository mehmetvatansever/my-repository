# Install CentOS 7 PHP 7.1.33
#
sudo yum update -y
#
#
sudo yum install -y httpd
#
#
sudo systemctl enable httpd
#
#
sudo systemctl restart httpd
#
#
sudo yum install -y epel-release yum-utils
#
#
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
#
#
yum info php71w-common
#
#
sudo yum install -y mod_php71w php71w-cli php71w-common php71w-gd php71w-mbstring php71w-mcrypt php71w-mysqlnd php71w-xml php71w-soap php71w-ldap php71w-zip php71w-fileinfo php71w-intl php71w-json php71w-opcache php71w-bcmath php71w-imap php71w-ldap php71w-opcache php71w-curl php71w-xmlrpc php71w-json php71w-pdo php71w-gd php71w-common php71w-snmp php71w-mbstring graphviz
#
#
sudo yum install -y php71w-fpm
#
#
systemctl enable php-fpm
#
#
systemctl start php-fpm
#
#
php -v
#
#
systemctl restart httpd
#
#php -v
#
#end
#---------------------------------
#if you want to check php
#sudo nano /var/www/html/info.php
#<?php
#phpinfo();
#?>
#---------------------------------
