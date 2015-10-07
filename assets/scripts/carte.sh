#!/usr/bin/env bash
set -o errexit

echo "Running carte.sh script as user: " $(whoami)

# Starts carte and configures it to start automatically 

# Kill existing processes first (this init script may not exist yet, i.e., for first run)
if [ -e /etc/init.d/carte ]; then
    /etc/init.d/carte stop || true
fi

# PentahoKettle/kettle-data-integration

# create a copy of PentahoKettle. We could launch directly from /opt/Colfusion/PentahoKettle,
# but it takes a long time to start that way...
mkdir -p /opt/build
cd /opt/build
echo "Removing existing copy of PentahoKettle..."
time rm -rf PentahoKettle

echo "Creating a copy of PentahoKettle (this could take a few minutes)"
time cp -r /opt/Colfusion/PentahoKettle .

echo "Setting carte to start automatically"

cp /opt/Colfusion/ColFusion/etc/init.d/carte /etc/init.d
update-rc.d carte defaults

echo "Starting carte"

/etc/init.d/carte start

echo "Done with Carte"
