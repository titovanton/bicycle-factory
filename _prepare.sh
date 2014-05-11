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
if [ ! -f $HOME/.pgpass ]; then
    printf '\nYou can touch .pgpass file with chmode 0600 in your home dir\n'
    printf "insted prompt password for user $PG_SU every time.\n"
    printf 'Read the man: http://www.postgresql.org/docs/9.0/static/libpq-pgpass.html\n\n'
fi
psql -h $PG_HOST -U $PG_SU -f $TEMPLATES/createdb.sql -v passwd=\'$DB_PWD\' -v user=$PROJECT_NAME
# sudo -u postgres createuser -D -A -R -P $PROJECT_NAME
# sudo -u postgres createdb -O $PROJECT_NAME $PROJECT_NAME

# Redis db number(name):
REDIS_DB=$(python $TEMPLATES/redis_db.py $WORKON_HOME/redis_index.json $PROJECT_NAME)
read -s -p "Enter Redis passwrod please: " REDIS_PWD
echo

# git
cd $PROJECT_DIR
git init
git config --global user.name $GIT_USER
git config --global user.email $GIT_EMAIL
git config --global color.ui true

pip install Django
