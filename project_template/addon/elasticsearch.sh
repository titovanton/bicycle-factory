#!/bin/bash

aptitude update
aptitude upgrade -y
aptitude install openjdk-7-jre-headless -y
mkdir -p $HOME/src
cd $HOME/src
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb
dpkg -i elasticsearch-1.2.1.deb
update-rc.d elasticsearch defaults 95 10
/etc/init.d/elasticsearch start
