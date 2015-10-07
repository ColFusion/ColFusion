#!/usr/bin/env bash
set -o errexit

# Uses currently checked out code, and re-deploys from within VM

# TODO: if code hasn't changed, don't redeploy (that is, only re-deploy if there are updates)

CF_DIR="/opt/Colfusion"

"${CF_DIR}/ColFusion/assets/scripts/cfserver.sh"
"${CF_DIR}/ColFusion/assets/scripts/cfserver-init.sh"

"${CF_DIR}/ColFusion/assets/scripts/carte.sh"

"${CF_DIR}/ColFusion/assets/scripts/cfopenrefine.sh"

