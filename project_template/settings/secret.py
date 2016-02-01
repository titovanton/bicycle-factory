# -*- coding: utf-8 -*-
'''
U must add it to .gitignore file
and set Unix file change mode and owner
'''

DEBUG = True
SECRET_KEY = '{{ secret_key }}'

# DOMAIN
DOMAIN_NAME = '{{ project_name }}.ru'
TRANSPORT = 'http'
URL = '%s://%s' % (TRANSPORT, DOMAIN_NAME)

# ALLOWED_HOSTS
ALLOWED_HOSTS = [DOMAIN_NAME, ]

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
        'BACKEND': 'django_redis.cache.RedisCache',
        'LOCATION': 'redis://:%s@%s:%d/%d' % (
            REDIS_CONNECTION['password'],
            REDIS_CONNECTION['host'],
            REDIS_CONNECTION['port'],
            REDIS_CONNECTION['db'],
        ),
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
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

# EMAIL
EMAIL_HOST = 'localhost'
EMAIL_HOST_USER = ''
EMAIL_HOST_PASSWORD = ''
DEFAULT_FROM_EMAIL = u'{{ project_name }} <no-reply@{{ project_name }}>'
EMAIL_USE_TLS = False
EMAIL_PORT = 25
