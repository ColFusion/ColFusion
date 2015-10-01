#!/usr/bin/env bash
set -o errexit

echo "Running carte.sh script as user: " $(whoami)

echo "Setting neo4j to start automatically"


echo "
#!/bin/bash

cd /opt/Colfusion/PentahoKettle/kettle-data-integration && nohup ./carte.sh 0.0.0.0 8081 > /opt/carteLog.out 2> /opt/carteError.log < /dev/null &
" > /etc/init.d/start_carte

chmod +x /etc/init.d/start_carte

ln -s /etc/init.d/start_carte /etc/rc2.d/S99start_carte

echo "Start Carte server on port 8081"

bash /etc/init.d/start_carte

echo "Done with Carte"
