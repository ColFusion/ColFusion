#!/usr/bin/env bash

echo "Running tomcat.sh script as user: " $(whoami)

echo "Copying and extracting tomcat"

cp /opt/Colfusion/assets/apache-tomcat-8.0.26.tar.gz /opt

cd /opt
tar -xzf apache-tomcat-8.0.26.tar.gz

cd apache-tomcat-8.0.26

echo "Starting tomcat"

bin/catalina.sh start

echo "Setting tomcat to start automatically"

echo "
#!/bin/bash

/opt/apache-tomcat-8.0.26/bin/catalina.sh stop
" > /etc/rc6.d/K99_stop_tomcat

chmod +x /etc/rc6.d/K99_stop_tomcat

echo "
#!/bin/bash

/opt/apache-tomcat-8.0.26/bin/catalina.sh start
" > /etc/init.d/start_tomcat

chmod +x /etc/init.d/start_tomcat

ln -s /etc/init.d/start_tomcat /etc/rc2.d/S99start_tomcat

echo "Done with tomcat"
