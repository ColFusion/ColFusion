#!/usr/bin/env bash

# This script pulls the latest code for the checked-out branch of colfusion repos
# (conflicts may prevent pulling. Running pullall.sh is useful to see if all repos updated)

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

REPOS=(ColFusion ColfusionOpenRefine ColfusionServer ColfusionWeb PentahoKettle)

for repo in "${REPOS[@]}"
do
    cd "$COLFUSION_DIR/$repo"
    git pull
done
