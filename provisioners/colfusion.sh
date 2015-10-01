#!/usr/bin/env bash
set -o errexit

echo "Running colfusion.sh script as user: " $(whoami)

echo "Installing ColfusionServer"
 
# TODO: stop/start tomcat didn't seem to be working.
# The reason to stop/start is to finish processing existing requests, although
# I'm not sure that will be the case
#/etc/rc6.d/K99_stop_tomcat
/opt/Colfusion/ColFusion/assets/scripts/cfserver.sh
#/etc/init.d/start_tomcat

echo "Done Installing ColfusionServer"

echo "Installing Open Refine"

/opt/Colfusion/ColFusion/assets/scripts/cfopenrefine.sh
ln -s /opt/Colfusion/ColFusion/assets/scripts/cfopenrefine.sh /etc/init.d/
update-rc.d cfopenrefine.sh defaults

echo "Done Installing Open Refine"
