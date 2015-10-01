#!/usr/bin/env bash
set -o errexit

# Packages a WAR for ColfusionServer

# Using the war from /opt/ColfusionServer doesn't work. Needs a clean build (and maven deps?)

# Don't remove files after building. Needed for building openrefine.

CF_DIR="/opt/Colfusion"

WEBAPPS="/opt/apache-tomcat-8.0.26/webapps"

mkdir -p /opt/build
cd /opt/build
rm -rf ColfusionServer

cp -r /opt/Colfusion/ColfusionServer .
cd ColfusionServer/

PROPS="ColFusionServerUtils/src/main/resources/config.properties"
: > "${PROPS}" # creates zero-length file (or wipes existing file to zero-length)
echo "colfusion.properties.source = custom in main" >> "${PROPS}"
[ -e "${CF_DIR}/ColFusion" ] && echo "colfusion.static_files.root_location = ${CF_DIR}/ColFusion/assets/www" >> "${PROPS}"
[ -e "${CF_DIR}/ColfusionOpenRefine" ] && echo "colfusion.openrefine.folder = ${CF_DIR}/ColfusionOpenRefine/workspace" >> "${PROPS}"
[ -e "${CF_DIR}/ColfusionOpenRefine" ] && echo "colfusion.openrefine.csv_file_dir = ${CF_DIR}/ColfusionOpenRefine/workspace" >> "${PROPS}"

mvn clean
mvn install -DskipTests
TARGET="$(ls -t ColFusionServerWAR/target/*.war | head -1)"

find "${WEBAPPS}" -maxdepth 1 -name "ColFusionServer*" -exec rm -r {} \;

# was having problems without changing name to ColFusionServer.war, although I thought that's supposed
# to work. e.g., "ColFusionServer##2015-09-27T18:34:00Z.war"
cp "${TARGET}" "${WEBAPPS}/ColFusionServer.war"

