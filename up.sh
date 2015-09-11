#!/bin/bash

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

echo $(pwd)

vagrant up

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

cd $COLFUSION_DIR/ColfusionWeb

echo $(pwd)

vagrant up

echo "Running maven to install all dependencies (skipping running tests)"

cd $COLFUSION_DIR/ColfusionServer

mvn install -DskipTests

echo "Run flyway migrations to setup database tables"

cd $COLFUSION_DIR/Colfusion

sh ./db_migrate.sh