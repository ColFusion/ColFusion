#!/usr/bin/env bash

# This script pulls the latest code for the checked-out branch of colfusion repos

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

cd $COLFUSION_DIR

REPOS=(ColFusion ColfusionOpenRefine ColfusionServer ColfusionWeb PentahoKettle)

for repo in "${REPOS[@]}"
do
    cd "$repo"
    git pull
    cd ..
done
