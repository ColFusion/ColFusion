#!/bin/bash

echo $(pwd)

vagrant suspend

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

cd $COLFUSION_DIR/ColfusionWeb

echo $(pwd)

vagrant suspend