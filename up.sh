#!/bin/bash

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

pwd

vagrant up

cd $COLFUSION_DIR/ColfusionWeb

pwd

vagrant up

echo "Running maven to install all dependencies (skipping running tests)"

cd $COLFUSION_DIR/ColfusionServer

mvn install -DskipTests

echo "Run flyway migrations to setup database tables"

cd $COLFUSION_DIR/ColFusion

bash ./db_migrate.sh
