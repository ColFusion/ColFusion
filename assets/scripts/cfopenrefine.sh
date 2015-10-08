#!/usr/bin/env bash
set -o errexit

# Builds openrefine and configures it to start automatically 

# Kill existing processes first (this init script may not exist yet, i.e., for first run)
if [ -e /etc/init.d/cfopenrefine ]; then
    /etc/init.d/cfopenrefine stop || true
fi

mkdir -p /opt/build
cd /opt/build
rm -rf ColfusionOpenRefine

cp -r /opt/Colfusion/ColfusionOpenRefine .
cd ColfusionOpenRefine/
mvn clean
mvn initialize
mvn package -DskipTests

echo "Setting openrefine to start automatically"

cp /opt/Colfusion/ColFusion/etc/init.d/cfopenrefine /etc/init.d

# Note: configuring openrefine to start automatically the conventional way has problems.
#       There is a NPE until a new table is created.
#       Delaying startup fixes this issue (20 seconds didn't work, 60 did)
#update-rc.d cfopenrefine defaults
cp /opt/Colfusion/ColFusion/etc/cron.d/cfopenrefine /etc/cron.d

echo "Starting openrefine"

/etc/init.d/cfopenrefine start

echo "Done with openrefine"
