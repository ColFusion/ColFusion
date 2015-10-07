#!/usr/bin/env bash
set -o errexit

# Restarts Colfusion Services

CF_DIR="/opt/Colfusion"

"${CF_DIR}/ColFusion/assets/scripts/carte.sh"
"${CF_DIR}/ColFusion/assets/scripts/cfserver.sh"
"${CF_DIR}/ColFusion/assets/scripts/cfopenrefine.sh"

