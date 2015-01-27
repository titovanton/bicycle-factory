# -*- coding: utf-8 -*-
'''
U must add it to .gitignore file
and set Unix file change mode and owner
'''

DEBUG = True

TEMPLATE_DEBUG = DEBUG

SECRET_KEY = '{{ secret_key }}'

ALLOWED_HOSTS = ['.{{ project_name }}.com', '.{{ project_name }}.ru', ]

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

# django-redis
CACHES = {
    'default': {
        'BACKEND': 'redis_cache.cache.RedisCache',
        'LOCATION': 'redis://:%s@%s:%d/%d' % (
            REDIS_CONNECTION['password'],
            REDIS_CONNECTION['host'],
            REDIS_CONNECTION['port'],
            REDIS_CONNECTION['db'],
        ),
        'OPTIONS': {
            'CLIENT_CLASS': 'redis_cache.client.DefaultClient',
        }
    }
}

# django-rq
RQ_QUEUES = {
    'default': {
        'USE_REDIS_CACHE': 'default',
    },
}

# one year
CACHE_TIMEOUT = 60 * 60 * 24 * 30 * 12

# cache key prefix
KEY_PREFIX = 'cache:{{ project_name }}:'
