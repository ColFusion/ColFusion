#!/bin/bash

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

pwd

vagrant up

echo "Clearing cache"
rm -r "${COLFUSION_DIR}/ColfusionWeb/cache/templates_c"

echo "Running maven to install all dependencies (skipping running tests)"

cd $COLFUSION_DIR/ColfusionServer

mvn install -DskipTests

echo "Run flyway migrations to setup database tables"

cd $COLFUSION_DIR/ColFusion

bash ./db_migrate.sh

