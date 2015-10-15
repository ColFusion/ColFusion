#!/usr/bin/env bash
set -o errexit

echo "Running backup.sh script as user: " $(whoami)

COLFUSION="/opt/Colfusion"

BACKUPS="/opt/Colfusion/ColFusion/backups"
WORKINGDIR="$(mktemp -d)"
TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"

# default from provisioners/mysql.sh
MYSQL_PASSWORD=thisShouldBeSafeEnough

cd "${WORKINGDIR}"

mkdir -p "${WORKINGDIR}/${TIMESTAMP}"

cd "${WORKINGDIR}/${TIMESTAMP}"

# Shut down colfusion while backing up. This is necessary for neo4j.
# Backing up while running neo4j is possible for neo4j enterprise and
# also possibly v2 of neo4j community.
# Additionally, shutting down will ensure backed up data is consistent
# (that is, e.g., mysql data reflects same point of time as neo4j data)
/etc/init.d/apache2 stop
# does stop wait for completion of outstanding requests?
# in case not, let's wait a few seconds
sleep 10

##### Start transfers

## Colfusion

cp -r "${COLFUSION}/ColFusion/assets/www" ColFusionAssetsWww

## Open Refine

cp -r "${COLFUSION}/ColfusionOpenRefine/workspace" OpenRefineWorkspace

## MySQL

mysqldump --all-databases -uroot -p"${MYSQL_PASSWORD}" > mysql.sql

## Neo4J

/etc/rc6.d/K99_stop_neo4j
cp -r /opt/neo4j-community/data/graph.db Neo4jGraphDb
/etc/init.d/start_neo4j

##### End transfers

/etc/init.d/apache2 start

cd "${WORKINGDIR}"
# TODO: is it faster to make tarball in VM, and then transfer to shared folder?
tar cvzf "${BACKUPS}/${TIMESTAMP}.tar.gz" "${TIMESTAMP}"

cd /
rm -r "${WORKINGDIR}"

echo "Done with backup.sh"
