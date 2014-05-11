#!/bin/bash

# init
PG_HOST=localhost
PG_SU=postgres
WEBAPPS=/webapps
TEMPLATES=$WORKON_HOME/templates
PROJECT_TEMPLATE=$WORKON_HOME/project_template
MAINAPP=mainapp
if [ -f $WORKON_HOME/name ]; then
    PROJECT_NAME=$(cat $WORKON_HOME/name)
else
    PROJECT_NAME=$@
fi
PROJECT_DIR=$WEBAPPS/django/$PROJECT_NAME
SERVER=$WEBAPPS/server/$PROJECT_NAME
STATIC=$WEBAPPS/django/static/$PROJECT_NAME
STATIC_SRC=$PROJECT_DIR/$MAINAPP/static_src
MEDIA=$WEBAPPS/django/media/$PROJECT_NAME
INTERNAL=$WEBAPPS/django/internal/$PROJECT_NAME
SETTINGS=$MAINAPP/settings
BOOTSTRAP_SED=$PROJECT_DIR/libs/bootstrap/less/
UWSGI_PARAMS=$WEBAPPS/server/uwsgi_params
DB_PWD=$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32)
DUMMY_ROOT=$WEBAPPS/dummy/$PROJECT_NAME
LIBS=libs
UNIX_USER=$USER
GIT_USER=$USER
# GIT_USER=titovanton-com
GIT_EMAIL=mail@titovanton.com
