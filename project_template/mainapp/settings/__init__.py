# -*- coding: utf-8 -*-

import os

from django.conf.global_settings import TEMPLATE_CONTEXT_PROCESSORS as TCP
from django.conf.global_settings import MIDDLEWARE_CLASSES as MC

from _settings import *
from dj_settings import *
from grappelli import *
from mainapp import *
from secret import *
from sorl import *


INSTALLED_APPS = (
    # 'grappelli.dashboard',
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
    'django_settings',

    'bicycle.futuremessage',
    'bicycle.djangomixins',
    'bicycle.feedback',
    'bicycle.news',
    'bicycle.carousel',
)

MIDDLEWARE_CLASSES = MC + (
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'bicycle.futuremessage.middleware.FutureMessageMiddleware'
)

TEMPLATE_CONTEXT_PROCESSORS = TCP + (
    'django.core.context_processors.request',
    'mainapp.context_processors.meta_tags',
)

TEMPLATE_DIRS = (
    rel_mainapp('templates'),
    rel_project('bicycle', 'djangomixins', 'templates'),
)

STATICFILES_DIRS = (
    ('bootstrap', rel_project('libs', 'bootstrap', 'dist')),
    ('fancybox', rel_project('libs', 'fancyapps-fancyBox', 'source')),
    ('print', rel_project('libs', 'jQuery-printPage-plugin')),
    ('rc-carousel', rel_project('libs', 'jquery-ui-carousel', 'dist')),
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
        'HOST': DATABASES_HOST,
        'PORT': '',
    }
}

LANGUAGE_CODE = 'ru-RU'

TIME_ZONE = 'Europe/Moscow'

USE_I18N = True

USE_L10N = True

USE_TZ = True
