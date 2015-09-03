#!/usr/bin/env bash

echo "installing apache2"

apt-get update
apt-get install -y apache2

if ! [ -L /var/www ]; then
  rm -rf /var/www/html
  ln -fs /www /var/www/html
fi

sudo service apache2 restart
chmod -R 777 /www/temp
chmod -R 777 /www/upload_raw_data

rm -R /www/temp/*
rm -R /www/upload_raw_data/*


MYSQL_PASSWORD=thisShouldBeSafeEnough

echo "installing mysql"

echo mysql-server mysql-server/root_password password $MYSQL_PASSWORD | debconf-set-selections
echo mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD | debconf-set-selections

apt-get install -y mysql-server

sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
service mysql restart

echo "running sql script"

mysql -uroot -p$MYSQL_PASSWORD < /vagrant/ColfusionDB.sql

echo "installing java"

echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository -y ppa:webupd8team/java && \
apt-get update && \
apt-get install -y oracle-java8-installer \
oracle-java8-set-default

export JAVA_HOME="/usr/lib/jvm/java-8-oracle"

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

echo "start Carte server on port 8081"

cd /opt/PentahoKettle/kettle-data-integration
nohup ./carte.sh 0.0.0.0 8081 > /opt/carteLog.out 2> /opt/carteError.log < /dev/null &
 
echo "done"

