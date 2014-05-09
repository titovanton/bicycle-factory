# -*- coding: utf-8 -*-
'''
U must add it to .gitignore file
and set Unix file change mode and owner
'''

DEBUG = True

TEMPLATE_DEBUG = DEBUG

SECRET_KEY = '{{ secret_key }}'

ALLOWED_HOSTS = ['{{ project_name }}.com', 'www.{{ project_name }}.com',
                 '{{ project_name }}.ru', 'www.{{ project_name }}.ru',]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': '{{ project_name }}',
        'USER': '{{ project_name }}',
        'PASSWORD': '%DB_PWD%',
        'HOST': 'localhost',
        'PORT': '',
    }
}

REDIS_CONNECTION = {
    'host': 'localhost',
    'port': 6379,
    'db': %REDIS_DB%,
    'password': '%REDIS_PWD%',
}
