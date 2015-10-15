#!/usr/bin/env bash
set -o errexit

echo "Running admin-start.sh script as user: " $(whoami)

# run initial sysadmin tasks

echo "Change clock to Eastern timezone"

echo 'America/New_York' > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

apt-get update
apt-get -y upgrade
apt-get -y dist-upgrade

# TODO: WARNING: Max 1024 open files allowed, minimum of 40 000 recommended. See the Neo4j manual.

echo "Done running admin-start.sh"
