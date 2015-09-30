#!/usr/bin/env bash
set -o errexit

# Starts/Restarts Colfusion's Open Refine

PIDFILE="/var/run/cfopenrefine.pid"

# Kill existing processes first
if [ -e "${PIDFILE}" ]; then
    OLDPID="$(cat "${PIDFILE}")"
    kill "${OLDPID}" || true
fi

mkdir -p /opt/build
cd /opt/build
rm -rf ColfusionOpenRefine

cp -r /opt/ColfusionOpenRefine .
cd ColfusionOpenRefine/
mvn clean initialize package -DskipTests
TARGET="$(ls -t server/target/openrefine-server-*.jar | head -1)"

# TODO: output to log and logrotate...
nohup java -jar "${TARGET}" &>/dev/null &
PID="$!"
echo "${PID}" > "${PIDFILE}"


