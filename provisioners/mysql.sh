#!/usr/bin/env bash

echo "Running mysql.sh script as user: " $(whoami)

MYSQL_PASSWORD=thisShouldBeSafeEnough

echo "Installing mysql"

echo mysql-server mysql-server/root_password password $MYSQL_PASSWORD | debconf-set-selections
echo mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD | debconf-set-selections

apt-get install -y mysql-server

echo "Setting mysql to listen to 0.0.0.0"

sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

echo "Restarting MySQL"

service mysql restart

echo "Running sql script to create database"

mysql -uroot -p$MYSQL_PASSWORD < /opt/Colfusion/assets/ColfusionDB.sql

echo "Done installing MySQL and Setup Colfusion database"