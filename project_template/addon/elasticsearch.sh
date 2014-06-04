#!/bin/bash

aptitude update
aptitude upgrade -y
aptitude install openjdk-7-jre-headless -y
mkdir -p $HOME/src
cd $HOME/src
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.deb
dpkg -i elasticsearch-1.1.1.deb
URL=http://dl.bintray.com/content/imotov/elasticsearch-plugins/org/elasticsearch/elasticsearch-analysis-morphology/1.2.0/elasticsearch-analysis-morphology-1.2.0.zip
/usr/share/elasticsearch/bin/plugin -install analysis-morphology -url $URL
update-rc.d elasticsearch defaults 95 10
/etc/init.d/elasticsearch start
