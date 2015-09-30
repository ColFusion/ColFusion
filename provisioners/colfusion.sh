#!/usr/bin/env bash
set -o errexit

echo "Running colfusion.sh script as user: " $(whoami)

echo "Installing ColfusionServer"
 
/etc/init.d/tomcat stop
/opt/Colfusion/assets/scripts/cfserver.sh
/etc/init.d/tomcat start

echo "Done Installing ColfusionServer"

echo "Installing Open Refine"

/opt/Colfusion/assets/scripts/cfopenrefine.sh
ln -s /opt/Colfusion/assets/scripts/cfopenrefine.sh /etc/init.d/
update-rc.d cfopenrefine.sh defaults

echo "Done Installing Open Refine"
