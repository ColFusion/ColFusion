#!/usr/bin/env bash
set -o errexit

echo "Running apahce-cfweb.sh script as user: " $(whoami)

echo "Installing apache2 and ColfusionWeb"

# TODO: if elegantly possible, decouple apache installation from setting up ColfusionServer

NEW_HOSTNAME=colfusionweb
sed -i 's/127.0.0.1.*/127.0.0.1\t'"localhost localhost.localdomain $NEW_HOSTNAME"'/g' /etc/hosts
echo $NEW_HOSTNAME > /etc/hostname
service hostname start

apt-get install -y apache2 sendmail php5 libapache2-mod-php5 php5-mcrypt php5-mysql php5-curl php-pear

# change server name, particularly for HELO/EHLO 
echo 'define(`confDOMAIN_NAME'"'"', `colfusion.exp.sis.pitt.edu'"'"')dnl' >> /etc/mail/sendmail.mc
m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf
service sendmail restart

cp /opt/Colfusion/ColFusion/etc/ApacheVirtualHostConfig.conf /etc/apache2/sites-available/

# by default we use the local machine's ColfusionServer
# change to 192.168.33.1 to use host
echo -e '127.0.0.1\tcolfusionserver # $ID_COLFUSION_SERVER' >> /etc/hosts

# by default we use the local machine's openrefine
# change to 192.168.33.1 to use host
echo -e '127.0.0.1\topenrefineserver # $ID_OPENREFINE_SERVER' >> /etc/hosts

cd /etc/apache2/mods-available

a2enmod proxy
a2enmod proxy_http

cd /etc/apache2/sites-available
a2dissite 000-default
a2ensite ApacheVirtualHostConfig.conf

sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=vagrant/' /etc/apache2/envvars
sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=vagrant/' /etc/apache2/envvars
chown -R vagrant:www-data /var/lock/apache2

#echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf
#a2enconf fqdn

service apache2 restart

if ! [ -L /var/www ]; then
  rm -rf /var/www
  mkdir /var/www
  ln -fs /opt/Colfusion/ColfusionWeb /var/www/colfusion
  ln -fs /opt/www /var/www/html
fi

pear install Mail-1.2.0
pear install Net_SMTP

sudo service apache2 restart

rm -R /opt/www/temp/* || true
rm -R /opt/www/upload_raw_data/* || true

echo "Done installing apache 2 and ColfusionWeb"
