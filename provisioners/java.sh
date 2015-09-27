#!/usr/bin/env bash

echo "Running java.sh script as user: " $(whoami)

echo "Installing java 8"

echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository -y ppa:webupd8team/java && \
apt-get update && \
apt-get install -y oracle-java8-installer \
oracle-java8-set-default

echo "Setting JAVA_HOME"

echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /etc/environment
source /etc/environment

echo "JAVA_HOME is set to: " $JAVA_HOME

echo "Done installing java 8"
