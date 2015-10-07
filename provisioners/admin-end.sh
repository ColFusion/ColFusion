#!/usr/bin/env bash
set -o errexit

echo "Running admin-end.sh script as user: " $(whoami)

apt-get -y autoremove

echo "Done running admin-end.sh"
