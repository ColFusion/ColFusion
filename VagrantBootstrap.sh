#!/usr/bin/env bash

echo "installing apache2"

apt-get update
apt-get install -y apache2

#sudo service apache2 restart

#if ! [ -L /var/www ]; then
#  rm -rf /var/www
#  ln -fs /vagrant /var/www
#fi


MYSQL_PASSWORD=thisShouldBeSafeEnough

echo "installing mysql"

echo mysql-server mysql-server/root_password password $MYSQL_PASSWORD | debconf-set-selections
echo mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD | debconf-set-selections

apt-get install -y mysql-server

sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
service mysql restart

echo "running sql script"

mysql -uroot -p$MYSQL_PASSWORD < /vagrant/ColfusionDb.sql

echo "installing java"

apt-get install -y openjdk-7-jdk

export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"

echo "copying and extracting neo4j"

cp /vagrant/neo4j-community-1.9.2.tar.gz /opt

cd /opt
tar -xzf neo4j-community-1.9.2.tar.gz

chown -R root:root neo4j-community-1.9.2

echo "starting neo4j"

cd neo4j-community-1.9.2
mkdir data

sed -i 's/#org.neo4j.server.webserver.address=0.0.0.0/org.neo4j.server.webserver.address=0.0.0.0/g' /opt/neo4j-community-1.9.2/conf/neo4j-server.properties

./bin/neo4j start

echo "creating neo4j indexes"

curl -X POST -H "Content-Type: application/json" -d '{"name":"sources","config":{"provider":"lucene","type":"exact"}}' http://localhost:7474/db/data/index/node
curl -X POST -H "Content-Type: application/json" -d '{"name":"rels","config":{"provider":"lucene","type":"exact"}}' http://localhost:7474/db/data/index/relationship

echo "installing git"

apt-get install -y git

echo "downloading pentaho"

cd /opt
git clone https://github.com/ColFusion/PentahoKettle.git

echo "start Carte server on port 8081"

cd /opt/PentahoKettle/kettle-data-integration
nohup ./carte.sh 0.0.0.0 8081 > /opt/carteLog.out 2> /opt/carteError.log < /dev/null &
 
echo "done"

