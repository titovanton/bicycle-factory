#!/bin/bash

source $WORKON_HOME/_config.sh

# sudo required for settings up nginx and uwsgi
sudo echo 'Enter sudo passwrod please:'

# Create dirs
mkdir -p $PROJECT_DIR
mkdir -p $SERVER
mkdir -p $STATIC
mkdir -p $MEDIA
mkdir -p $INTERNAL
mkdir $VIRTUAL_ENV/src

# Create DataBase
psql -h localhost -U postgres -f $TEMPLATES/createdb.sql -v passwd=\'$DB_PWD\' -v user=$PROJECT_NAME
# sudo -u postgres createuser -D -A -R -P $PROJECT_NAME
# sudo -u postgres createdb -O $PROJECT_NAME $PROJECT_NAME

# Redis db number(name):
REDIS_DB=$(python $TEMPLATES/redis_db.py $WORKON_HOME/redis_index.json $PROJECT_NAME)
read -s -p "Enter Redis passwrod please: " REDIS_PWD

# git
git init
git config --global user.name $GIT_USER
git config --global user.email $GIT_EMAIL
git config --global color.ui true
cp $TEMPLATES/.gitignore ./

pip install Django
