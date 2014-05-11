#!/bin/bash

source $WORKON_HOME/_config.sh
source $WORKON_HOME/_prepare.sh

cd $PROJECT_DIR

read -p "Enter git repo please: " GIT_REMOTE
git remote add origin $GIT_REMOTE

# Pull Django project
git pull origin master
git submodule init
git submodule update
cp $PROJECT_TEMPLATE/manage.py ./
cp $PROJECT_TEMPLATE/$MAINAPP/wsgi.py $MAINAPP/
SECRET_KEY=$(cat /dev/urandom | tr -cd 'a-f0-9~!@#$%^&*()_+<>?:,.\|-' | head -c 50)
sed -e "s;%DB_PWD%;$DB_PWD;g" \
    -e "s;%REDIS_DB%;$REDIS_DB;g" \
    -e "s;%REDIS_PWD%;$REDIS_PWD;g" \
    -e "s;{{ secret_key }};$SECRET_KEY;g" \
    -e "s;{{ project_name }};$PROJECT_NAME;g" \
    $PROJECT_TEMPLATE/$SETTINGS/secret.py > $PROJECT_DIR/$SETTINGS/secret.py

$WORKON_HOME/_finish.sh
