#!/usr/bin/env bash
set -o errexit

# Packages a WAR for ColfusionServer

# Using the war from /opt/ColfusionServer doesn't work. Needs a clean build (and maven deps?)

# Don't remove files after building. Needed for building openrefine.

WEBAPPS="/opt/apache-tomcat-8.0.26/webapps"

mkdir -p /opt/build
cd /opt/build
rm -rf ColfusionServer

cp -r /opt/ColfusionServer .
cd ColfusionServer/
mvn clean install -DskipTests
TARGET="$(ls -t ColFusionServerWAR/target/*.war | head -1)"

find "${WEBAPPS}" -maxdepth 1 -name "ColFusionServer*" -exec rm -r {} \;

# was having problems without changing name to ColFusionServer.war, although I thought that's supposed
# to work. e.g., "ColFusionServer##2015-09-27T18:34:00Z.war"
cp "${TARGET}" "${WEBAPPS}/ColFusionServer.war"
