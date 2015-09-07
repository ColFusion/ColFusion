#!/usr/bin/env bash

echo "Running apahce.sh script as user: " $(whoami)

echo "Installing apache2"

apt-get install -y apache2

if ! [ -L /var/www ]; then
  rm -rf /var/www/html
  ln -fs /opt/www /var/www/html
fi

sudo service apache2 restart

rm -R /opt/www/temp/*
rm -R /opt/www/upload_raw_data/*

echo "Done installing apache 2"