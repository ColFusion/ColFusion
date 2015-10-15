#!/usr/bin/env bash
set -o errexit

echo "Running neo4j.sh script as user: " $(whoami)

echo "Copying and extracting neo4j"

cp /opt/Colfusion/ColFusion/assets/software/neo4j-community-1.9.2.tar.gz /opt

cd /opt
tar -xzf neo4j-community-1.9.2.tar.gz

chown -R root:root neo4j-community-1.9.2

if [ -h neo4j-community ]; then
      rm neo4j-community
fi

ln -s neo4j-community-1.9.2 neo4j-community

echo "Starting neo4j"

cd neo4j-community
mkdir data

sed -i 's/#org.neo4j.server.webserver.address=0.0.0.0/org.neo4j.server.webserver.address=0.0.0.0/g' /opt/neo4j-community-1.9.2/conf/neo4j-server.properties

./bin/neo4j start

echo "Creating neo4j indexes"

curl -X POST -H "Content-Type: application/json" -d '{"name":"sources","config":{"provider":"lucene","type":"exact"}}' http://localhost:7474/db/data/index/node
curl -X POST -H "Content-Type: application/json" -d '{"name":"rels","config":{"provider":"lucene","type":"exact"}}' http://localhost:7474/db/data/index/relationship

echo "Setting neo4j to start automatically"


echo "
#!/bin/bash

/opt/neo4j-community/bin/neo4j stop
" > /etc/rc6.d/K99_stop_neo4j

chmod +x /etc/rc6.d/K99_stop_neo4j

echo "
#!/bin/bash

/opt/neo4j-community/bin/neo4j start
" > /etc/init.d/start_neo4j

chmod +x /etc/init.d/start_neo4j

ln -s /etc/init.d/start_neo4j /etc/rc2.d/S99start_neo4j

echo "Done with neo4j"