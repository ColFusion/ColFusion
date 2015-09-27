#!/usr/bin/env bash
set -o errexit

# make sure colfusionserver hostname points to ColfusionServer running on VM
# instead of host machine. This should be run from within the VM.

sed -i '/$ID_COLFUSION_SERVER/d' /etc/hosts
echo -e '127.0.0.1\tcolfusionserver # $ID_COLFUSION_SERVER' >> /etc/hosts

