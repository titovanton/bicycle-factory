#!/bin/bash

virtualenv --no-site-packages --prompt="($1-env)" $1
cd $1
source ./bin/activate

sudo apt-get install nginx
pip install uwsgi
pip install Django
# django-admin.py startproject $1

which nginx
which uwsgi
