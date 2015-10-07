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
update-rc.d cfopenrefine defaults

echo "Starting openrefine"

/etc/init.d/cfopenrefine start

echo "Done with openrefine"
