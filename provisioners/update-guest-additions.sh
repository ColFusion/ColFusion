#!/usr/bin/env bash
set -o errexit

echo "Running update-guest-additions.sh script as user: " $(whoami)

mkdir -p /media/cdrom
sudo mount /dev/cdrom /media/cdrom || true

if [ -e /media/cdrom/VBoxLinuxAdditions.run ]; then
    yes | /media/cdrom/VBoxLinuxAdditions.run
fi

echo "Done with updating guest additions"
