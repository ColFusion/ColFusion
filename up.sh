#!/bin/bash

echo $(pwd)

vagrant up

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

cd $COLFUSION_DIR/ColfusionWeb

echo $(pwd)

vagrant up