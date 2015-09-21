#!/bin/bash

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

cd $COLFUSION_DIR/ColfusionServer/ColFusionServerDAL

mvn -Dflyway.configFile=$COLFUSION_DIR/ColfusionServer/ColFusionServerUtils/src/main/resources/config_default.properties flyway:migrate
