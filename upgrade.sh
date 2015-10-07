#!/usr/bin/env bash
set -o errexit

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

# Upgrade Services

# TODO: This script currently 1) pulls latest code, and 2) restarts Colfusion services
#       Switch to 1) shutdown Colfusion services, 2) pull latest code, 3) restart services

"${COLFUSION_DIR}/ColFusion/pullall.sh"

# Restart Services
cd "${COLFUSION_DIR}/ColFusion/"
vagrant ssh -c "sudo /opt/Colfusion/ColFusion/assets/scripts/restart.sh"

