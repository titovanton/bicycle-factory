# -*- coding: utf-8 -*-

import os


tmp = os.path.abspath(os.path.dirname(__file__))
APP_ROOT = os.path.join(os.path.split(tmp)[0], 'apps', 'mainapp')
PROJECT_ROOT = os.path.split(tmp)[0]
BASE_DIR = APP_ROOT


def rel_project(*x):
    return os.path.join(PROJECT_ROOT, *x)


def rel_mainapp(*x):
    return os.path.join(APP_ROOT, *x)


MEDIA_ROOT = '/webapps/django/media/spitekrepko3/'
MEDIA_URL = '/media/'
STATIC_ROOT = '/webapps/django/static/spitekrepko3/'
STATIC_URL = '/static/'
INTERNAL_ROOT = '/webapps/django/internal/spitekrepko3/'
INTERNAL_URL = '/internal/'


def rel_static_root(*x):
    return os.path.join(STATIC_ROOT, *x)


def rel_static_url(*x):
    path = os.path.join(STATIC_URL, *x)
    if not path.endswith('/'):
        path += '/'
    return path
