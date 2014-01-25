# -*- coding: utf-8 -*-

import os

from django.conf.global_settings import TEMPLATE_CONTEXT_PROCESSORS as TCP
from django.conf.global_settings import MIDDLEWARE_CLASSES as MC

from secret import *
from _settings import *
from sorl import *
from mainapp import *


INSTALLED_APPS = (
    'grappelli',

    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    'mainapp',

    'django_extensions',
    'sorl.thumbnail',
    'south',
    'django_assets',

    'bicycle.futuremessage',
    'bicycle.djangomixins',
    'bicycle.feedback',
    'bicycle.variables',
    'bicycle.statistics',
)

MIDDLEWARE_CLASSES = MC + (
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'bicycle.futuremessage.middleware.FutureMessageMiddleware'
)

TEMPLATE_CONTEXT_PROCESSORS = TCP + (
    'django.core.context_processors.request',
    'bicycle.statistics.context_processors.tags',
)

TEMPLATE_DIRS = (
    rel_mainapp('templates'),
    rel_project('bicycle', 'djangomixins', 'templates'),
)

STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
    'django.contrib.staticfiles.finders.FileSystemFinder',
)

ROOT_URLCONF = 'mainapp.urls'

WSGI_APPLICATION = 'mainapp.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': '{{ project_name }}',
        'USER': '{{ project_name }}',
        'PASSWORD': DATABASES_PASSWORD,
        'HOST': 'localhost',
        'PORT': '',
    }
}

LANGUAGE_CODE = 'ru-RU'

TIME_ZONE = 'Europe/Moscow'

USE_I18N = True

USE_L10N = True

USE_TZ = True

MEDIA_ROOT = rel_mainapp('media')

MEDIA_URL = rel_url('media')

STATIC_ROOT = rel_mainapp('static')

STATIC_URL = rel_url('static')

INTERNAL_ROOT = rel_mainapp('internal')

INTERNAL_URL = rel_url('internal')
