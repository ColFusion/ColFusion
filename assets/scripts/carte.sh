#!/usr/bin/env bash
set -o errexit

echo "Running carte.sh script as user: " $(whoami)

# Starts carte and configures it to start automatically 

# Kill existing processes first (this init script may not exist yet, i.e., for first run)
if [ -e /etc/init.d/carte ]; then
    /etc/init.d/carte stop
fi

echo "Setting carte to start automatically"

cp /opt/Colfusion/ColFusion/etc/init.d/carte /etc/init.d
update-rc.d carte defaults

echo "Starting carte"

/etc/init.d/carte start

echo "Done with Carte"
