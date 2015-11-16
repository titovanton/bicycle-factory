# -*- coding: utf-8 -*-

import os
import sys

from django.conf.global_settings import TEMPLATE_CONTEXT_PROCESSORS as TCP

from assets import *
from debug_toolbar import *
from glue import *
from grappelli import *
from mainapp import *
from path import *
from secret import *
from sessions import *
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

    'django_assets',
    'django_extensions',
    # 'django_rq',
    'sorl.thumbnail',

    # 'bicycle.carousel',
    'bicycle.core',
    'bicycle.glue',
    # 'bicycle.news',
)

if DEBUG:
    INSTALLED_APPS += (
        'debug_toolbar',
        'template_timings_panel',
    )

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    # 'django.middleware.locale.LocaleMiddleware',
)

if DEBUG:
    MIDDLEWARE_CLASSES += ('debug_toolbar.middleware.DebugToolbarMiddleware',)

TEMPLATE_CONTEXT_PROCESSORS = TCP + (
    'django.core.context_processors.request',
    'bicycle.core.context_processors.cache_timeout',
)

TEMPLATE_DIRS = (
    rel_project('mainapp', 'templates'),
    #     rel_project('bicycle', 'core', 'templates'),
)

STATICFILES_DIRS = (
    ('', rel_project('mainapp', 'static_src', 'static')),
#     ('bootstrap', rel_project('libs', 'bootstrap', 'dist')),
#     ('fancybox', rel_project('libs', 'fancyapps-fancyBox', 'source')),
#     ('print', rel_project('libs', 'jQuery-printPage-plugin')),
#     ('rc-carousel', rel_project('libs', 'jquery-ui-carousel', 'dist')),
)

LOCALE_PATHS = (
    rel_project('mainapp', 'locale'),
    rel_project('bicycle', 'locale'),
)

STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
    'django.contrib.staticfiles.finders.FileSystemFinder',
)

# should we link StaticSrcStorageFinder:
sss_finder = ASSETS_AUTO_BUILD

try:
    # when user runs ./manage.py assets build
    if sys.argv[1] == 'assets' and sys.argv[2] == 'build':
        sss_finder = True
except IndexError:
    pass

try:
    # when user runs ./manage.py collectstatic
    if sys.argv[1] == 'collectstatic':
        sss_finder = False
except IndexError:
    pass

if sss_finder:
    STATICFILES_FINDERS += (
        'mainapp.finders.MainappFinder',
        'mainapp.finders.LibsFinder',
        'mainapp.finders.BicycleFinder',
    )

ROOT_URLCONF = 'mainapp.urls'
WSGI_APPLICATION = 'wsgi.application'
LANGUAGE_CODE = 'ru-RU'
TIME_ZONE = 'Europe/Moscow'
USE_I18N = True
USE_L10N = True
USE_TZ = True
