#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: ./get_up_ubuntu.sh <user>"
    exit 1
else
    USER_NAME=$1
fi

read -p "Is it production (yes/no, default: yes)? " PRODUCTION
if [[ $PRODUCTION == 'no' || $PRODUCTION == 'n' ]]; then
    PRODUCTION=false
fi
if [[ $PRODUCTION == 'yes' || $PRODUCTION == 'y' || $PRODUCTION == '' ]]; then
    PRODUCTION=true
fi

read -p "Enter PostgreSQL version (default: 9.3): " vPSQL
if [[ $vPSQL == '' ]]; then
    vPSQL=9.3
fi

read -p "Would you like to install Redis (yes/no, default: yes)?" REDIS
if [[ $REDIS == 'no' || $REDIS == 'n' ]]; then
    REDIS=false
fi
if [[ $REDIS == 'yes' || $REDIS == 'y' || $REDIS == '' ]]; then
    REDIS=true
    REDIS_PASSWORD=''
    while [[ $REDIS_PASSWORD == '' ]]; do
        read -s -p "Enter redis password: " REDIS_PASSWORD
        echo
    done
fi

read -p "Would you like to install ElasticSearch (yes/no, default: yes)?" ELASTICSEARCH
if [[ $ELASTICSEARCH == 'no' || $ELASTICSEARCH == 'n' ]]; then
    ELASTICSEARCH=false
fi
if [[ $ELASTICSEARCH == 'yes' || $ELASTICSEARCH == 'y' || $ELASTICSEARCH == '' ]]; then
    ELASTICSEARCH=true
fi

read -p "Would you like to install imagemagick (yes/no, default: no)?" IMAGEMAGICK
if [[ $IMAGEMAGICK == 'no' || $IMAGEMAGICK == 'n' || $IMAGEMAGICK == '' ]]; then
    IMAGEMAGICK=false
fi
if [[ $IMAGEMAGICK == 'yes' || $IMAGEMAGICK == 'y' ]]; then
    IMAGEMAGICK=true
fi

read -p "Would you like to install Less (yes/no, default: yes)?" LESS
if [[ $LESS == 'no' || $LESS == 'n' ]]; then
    LESS=false
fi
if [[ $LESS == 'yes' || $LESS == 'y' || $LESS == '' ]]; then
    LESS=true
fi

read -p "Would you like to install Memcached (yes/no, default: yes)?" MEMCACHED
if [[ $MEMCACHED == 'no' || $MEMCACHED == 'n' ]]; then
    MEMCACHED=false
fi
if [[ $MEMCACHED == 'yes' || $MEMCACHED == 'y' || $MEMCACHED == '' ]]; then
    MEMCACHED=true
fi


# postgresql
apt-get install -y curl build-essential openssl libssl-dev \
    python-psycopg2 postgresql postgresql-client postgresql-server-dev-$vPSQL
echo "Launch the command: \"\password postgres\" and enter password"
sed -e "s/local *all *all *password//g" \
    -i /etc/postgresql/$vPSQL/main/pg_hba.conf
sudo -u postgres psql
sed -e "s/command line switches\./command line switches.\n\nlocal all all password/" \
    -i /etc/postgresql/$vPSQL/main/pg_hba.conf
PG_PASSWORD=''
read -s -p "If you want to save postgres password to /home/$USER_NAME/.pgpass,\
    then enter password, else leave blank: " PG_PASSWORD
if [[ $PG_PASSWORD != '' ]]; then
    echo "*:*:*:postgres:$PG_PASSWORD" >> /home/$USER_NAME/.pgpass
    chmod 600 /home/$USER_NAME/.pgpass
fi

# venv continue
apt-get install -y python2.7-dev python-pip libjpeg-dev
pip install --upgrade pip
pip install virtualenv
pip install virtualenvwrapper
chown -R $USER_NAME:www-data /webapps
chown -R $USER_NAME:www-data $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh
echo "export WORKON_HOME=$WORKON_HOME" >> /home/$USER_NAME/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> /home/$USER_NAME/.bashrc

# iptables
if [ ! -f /etc/network/if-up.d/iptables-rules ]; then
    if $PRODUCTION; then
        $WORKON_HOME/templates/iptables_production.sh
    else
        $WORKON_HOME/templates/iptables_local.sh
    fi
    echo '#!/sbin/iptables-restore' > /etc/network/if-up.d/iptables-rules
    iptables-save >> /etc/network/if-up.d/iptables-rules
    chmod +x /etc/network/if-up.d/iptables-rules
fi

# nginx uwsgi
apt-get install libpcre3 libpcre3-dev nginx -y
pip install uwsgi
sed -e "s/# server_names_hash_bucket_size 64/server_names_hash_bucket_size 64/g" -i /etc/nginx/nginx.conf

# emperor
mkdir -p /var/log/uwsgi
mkdir -p /etc/uwsgi/vassals
chown -R $USER_NAME:www-data /var/log/uwsgi
chmod -R 774 /var/log/uwsgi
cp $WORKON_HOME/templates/uwsgi_params /webapps/server/
PTRN="s;exit 0;/usr/local/bin/uwsgi --emperor /etc/uwsgi/vassals --uid www-data --gid www-data --daemonize /var/log/uwsgi/mylog.log\n\nexit 0;g"
sed -e "$PTRN" -i /etc/rc.local

# redis
if $REDIS; then
    apt-get install redis-server -y
    cp /etc/redis/redis.conf /etc/redis/redis.conf.default
    sed -e "s/# requirepass foobared/requirepass $REDIS_PASSWORD/g" -i /etc/redis/redis.conf
fi

# ES
if $ELASTICSEARCH; then
    apt-get install openjdk-7-jre-headless -y
    mkdir -p /home/$USER_NAME/src
    cd /home/$USER_NAME/src
    wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.deb
    dpkg -i elasticsearch-1.1.1.deb
    /usr/share/elasticsearch/bin/plugin \
                -install analysis-morphology \
                -url http://dl.bintray.com/content/imotov/elasticsearch-plugins/org/elasticsearch/elasticsearch-analysis-morphology/1.2.0/elasticsearch-analysis-morphology-1.2.0.zip
    update-rc.d elasticsearch defaults 95 10
    sed -e "s/^# network\.host: .*$/network.host: 127.0.0.1/g" -i /etc/elasticsearch/elasticsearch.yml
fi

# node-less
if $LESS; then
    apt-get install node-less -y
fi

# memcached
if $MEMCACHED; then
    apt-get install memcached -y
fi

# imagemagick
if $IMAGEMAGICK; then
    apt-get install imagemagick -y
fi

reboot
