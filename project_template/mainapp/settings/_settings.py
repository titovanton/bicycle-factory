# -*- coding: utf-8 -*-

import os


tmp = os.path.abspath(os.path.dirname(__file__))

APP_ROOT = os.path.split(tmp)[0]

PROJECT_ROOT = os.path.split(APP_ROOT)[0]

BASE_DIR = APP_ROOT


def rel_project(*x):
    return os.path.join(PROJECT_ROOT, *x)


def rel_mainapp(*x):
    return os.path.join(APP_ROOT, *x)
    

MEDIA_ROOT = '/webapps/django/media/rusrob/'

MEDIA_URL = '/media/'

STATIC_ROOT = '/webapps/django/static/rusrob/'

STATIC_SRC = rel_mainapp('static_src')

STATIC_URL = '/static/'

INTERNAL_ROOT = '/webapps/django/internal/rusrob/'

INTERNAL_URL = '/internal/'
