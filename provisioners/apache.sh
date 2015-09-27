#!/usr/bin/env bash

echo "Running apahce.sh script as user: " $(whoami)

echo "Installing apache2"

NEW_HOSTNAME=colfusionweb
sed -i 's/127.0.0.1.*/127.0.0.1\t'"localhost localhost.localdomain $NEW_HOSTNAME"'/g' /etc/hosts
echo $NEW_HOSTNAME > /etc/hostname
service hostname start

apt-get install -y apache2 sendmail php5 libapache2-mod-php5 php5-mcrypt php5-mysql php5-curl php-pear

cp /opt/Colfusion/etc/ApacheVirtualHostConfig.conf /etc/apache2/sites-available/

cd /etc/apache2/mods-available

a2enmod proxy
a2enmod proxy_http

cd /etc/apache2/sites-available
a2dissite 000-default
a2ensite ApacheVirtualHostConfig

sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=vagrant/' /etc/apache2/envvars
sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=vagrant/' /etc/apache2/envvars
chown -R vagrant:www-data /var/lock/apache2

echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf
a2enconf fqdn

service apache2 restart

if ! [ -L /var/www ]; then
  rm -rf /var/www
  mkdir /var/www
  ln -fs /opt/ColfusionWeb /var/www/colfusion
  ln -fs /opt/www /var/www/html
fi

pear install Mail-1.2.0
pear install Net_SMTP

sudo service apache2 restart

rm -R /opt/www/temp/*
rm -R /opt/www/upload_raw_data/*

echo "Done installing apache 2"
