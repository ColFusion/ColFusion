#!/usr/bin/env bash
set -o errexit

echo "Running docker.sh script as user: " $(whoami)

echo "Setting up docker"

apt-key add /opt/Colfusion/ColFusion/assets/keys/docker.key

apt-get update
apt-get -y install linux-image-extra-$(uname -r)
sh -c "echo deb http://get.docker.io/ubuntu docker main\ > /etc/apt/sources.list.d/docker.list"
apt-get update

apt-get -y install lxc-docker


echo "
#!/bin/bash

service docker stop

nohup docker -d -H 0.0.0.0:2376  > /opt/docker.out 2> /opt/dockerError.log < /dev/null &
" > /etc/init.d/start_docker

chmod +x /etc/init.d/start_docker

ln -s /etc/init.d/start_docker /etc/rc2.d/S99start_docker

echo "Start Docker server on port 2376"

bash /etc/init.d/start_docker

echo "done"