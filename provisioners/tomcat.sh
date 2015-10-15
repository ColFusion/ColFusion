#!/usr/bin/env bash
set -o errexit

echo "Running tomcat.sh script as user: " $(whoami)

echo "Copying and extracting tomcat"

cp /opt/Colfusion/ColFusion/assets/software/apache-tomcat-8.0.26.tar.gz /opt

cd /opt
tar -xzf apache-tomcat-8.0.26.tar.gz

if [ -h apache-tomcat ]; then
      rm apache-tomcat
fi

ln -s apache-tomcat-8.0.26 apache-tomcat

cd apache-tomcat-8.0.26

echo "Setting tomcat to start automatically"

cp /opt/Colfusion/ColFusion/etc/init.d/tomcat /etc/init.d
update-rc.d tomcat defaults

echo "Starting tomcat"

/etc/init.d/tomcat start

echo "Done with tomcat"
