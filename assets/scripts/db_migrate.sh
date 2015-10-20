#!/bin/bash
set -o errexit

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/../../.. && pwd )

# This didn't work on windows host
#cd $COLFUSION_DIR/ColfusionServer/ColFusionServerDAL

cd /opt/build/ColfusionServer/ColFusionServerDAL

mvn -Dflyway.configFile=$COLFUSION_DIR/ColfusionServer/ColFusionServerUtils/src/main/resources/config_default.properties flyway:migrate
