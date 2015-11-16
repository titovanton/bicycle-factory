#! /bin/sh

cd /webapps/django/{{ project_name }}

./manage.py thumbnail clear_delete_all
./manage.py clear_cache
./manage.py clean_pyc -p ./
./manage.py clean_pyc -p /webapps/envs/{{ project_name }}/
