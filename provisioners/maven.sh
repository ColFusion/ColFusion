#!/usr/bin/env bash
set -o errexit

echo "Running maven.sh script as user: " $(whoami)

echo "Copying and extracting maven"

cp /opt/Colfusion/ColFusion/assets/software/apache-maven-3.3.3-bin.tar.gz /opt

cd /opt
tar -xzf apache-maven-3.3.3-bin.tar.gz

if [ -h apache-maven ]; then
      rm apache-maven
fi

ln -s apache-maven-3.3.3 apache-maven

# TODO: modify PATH as opposed to this
ln -s /opt/apache-maven/bin/mvn /usr/bin
ln -s /opt/apache-maven/bin/mvnDebug /usr/bin
ln -s /opt/apache-maven/bin/mvnyjp /usr/bin

echo "Done with maven"
