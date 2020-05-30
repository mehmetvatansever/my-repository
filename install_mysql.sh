# Install CentOS 7 MySQL DB
#
sudo yum install -y wget
#
#
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
#
#
sudo chmod +x mysql57-community-release-el7-9.noarch.rpm
#
#
sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm
#
#
sudo yum install -y mysql-server
#
#
sudo systemctl enable mysqld
#
#
sudo systemctl start mysqld
#
#
sudo grep 'temporary password' /var/log/mysqld.log
#
#
rm -rf mysql57-community-release-el7-9.noarch.rpm
#
#
# sudo mysql_secure_installation
# mysqladmin -u root -p version
#
#end
