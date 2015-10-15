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

##### Start transfers

## Colfusion

cp -r "${COLFUSION}/ColFusion/assets/www" ColFusionAssetsWww

## Open Refine

cp -r "${COLFUSION}/ColfusionOpenRefine/workspace" OpenRefineWorkspace

## MySQL

mysqldump --all-databases -uroot -p"${MYSQL_PASSWORD}" > mysql.sql

## Neo4J

# ???

##### End transfers

cd "${WORKINGDIR}"
# TODO: is it faster to make tarball in VM, and then transfer to shared folder?
tar cvzf "${BACKUPS}/${TIMESTAMP}.tar.gz" "${TIMESTAMP}"

cd /
rm -r "${WORKINGDIR}"

echo "Done with backup.sh"
