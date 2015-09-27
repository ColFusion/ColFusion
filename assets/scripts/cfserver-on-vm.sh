#!/usr/bin/env bash
set -o errexit

echo "Running cfserver.sh script as user: " $(whoami)

echo "Installing ColfusionServer"

# Using the war from /opt/ColfusionServer doesn't work. Needs a clean build (and maven deps?)

WEBAPPS="/opt/apache-tomcat-8.0.26/webapps"

TMP_BUILD_DIR="$(mktemp -d)"
cd "${TMP_BUILD_DIR}"

# alternatively, could git clone
cp -r /opt/ColfusionServer .
cd ColfusionServer/
mvn clean install -DskipTests
TARGET="$(ls -t ColFusionServerWAR/target/*.war | head -1)"

find "${WEBAPPS}" -maxdepth 1 -name "ColFusionServer*" -exec rm -r {} \;

# was having problems without changing name to ColFusionServer.war, although I thought that's supposed
# to work. e.g., "ColFusionServer##2015-09-27T18:34:00Z.war"
cp "${TARGET}" "${WEBAPPS}/ColFusionServer.war"

rm -r "${TMP_BUILD_DIR}"

# make sure colfusionserver hostname points here instead of to host machine
sed -i '/$ID_COLFUSION_SERVER/d' /etc/hosts
echo -e '127.0.0.1\tcolfusionserver # $ID_COLFUSION_SERVER' >> /etc/hosts

echo "Done Installing ColfusionServer"

