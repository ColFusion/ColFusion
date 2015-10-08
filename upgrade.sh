#!/usr/bin/env bash
set -o errexit

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

# Pulls latest code, and upgrade Services from Host Machine

# TODO: This script currently 1) pulls latest code, and 2) restarts Colfusion services
#       Switch to 1) shutdown Colfusion services, 2) pull latest code, 3) restart services

"${COLFUSION_DIR}/ColFusion/pullall.sh"

# Restart Services
cd "${COLFUSION_DIR}/ColFusion/"
vagrant ssh -c "nohup sudo /opt/Colfusion/ColFusion/assets/scripts/deploy.sh 2>&1 </dev/null | cat"

