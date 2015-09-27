#!/usr/bin/env bash

echo "Running maven.sh script as user: " $(whoami)

echo "Copying and extracting maven"

cp /opt/Colfusion/assets/software/apache-maven-3.3.3-bin.tar.gz /opt

cd /opt
tar -xzf apache-maven-3.3.3-bin.tar.gz

# TODO: modify PATH as opposed to this
ln -s /opt/apache-maven-3.3.3/bin/mvn /usr/bin
ln -s /opt/apache-maven-3.3.3/bin/mvnDebug /usr/bin
ln -s /opt/apache-maven-3.3.3/bin/mvnyjp /usr/bin

echo "Done with maven"
