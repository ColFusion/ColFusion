#!/usr/bin/env bash
set -o errexit

echo "Running colfusion.sh script as user: " $(whoami)

echo "Installing ColfusionServer"
 
/etc/rc6.d/K99_stop_tomcat
/opt/Colfusion/assets/scripts/cfserver.sh
/etc/init.d/start_tomcat

echo "Done Installing ColfusionServer"

echo "Installing Open Refine"

/opt/Colfusion/assets/scripts/cfopenrefine.sh
ln -s /opt/Colfusion/assets/scripts/cfopenrefine.sh /etc/init.d/
update-rc.d cfopenrefine.sh defaults

echo "Done Installing Open Refine"
