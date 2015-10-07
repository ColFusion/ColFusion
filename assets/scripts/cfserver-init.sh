#!/usr/bin/env bash
set -o errexit

# Sends a request to ColfusionServer

# first request is slow, so do it before a user
STATUS=1
while [ "${STATUS}" -ne 0 ]; do
    set +e
    curl 'http://localhost:8080/ColFusionServer/rest/Story/metadata/license' &>/dev/null
    STATUS="$?"
    set -e
    if [ "${STATUS}" -ne 0 ]; then
        echo "waiting for server to startup $(date)"
        sleep 1
    fi
done


