#!/usr/bin/env bash

apt-get update
apt-get install -y apache2

sudo service apache2 restart

#if ! [ -L /var/www ]; then
#  rm -rf /var/www
#  ln -fs /vagrant /var/www
#fi


MYSQL_PASSWORD=thisShouldBeSafeEnough

echo "installing mysql"

echo mysql-server mysql-server/root_password password $MYSQL_PASSWORD | debconf-set-selections
echo mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD | debconf-set-selections

apt-get install -y mysql-server

service mysql start

echo "running sql script"

mysql -uroot -p$MYSQL_PASSWORD < /vagrant/ColfusionDb.sql