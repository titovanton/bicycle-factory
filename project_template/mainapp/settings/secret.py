# -*- coding: utf-8 -*-
'''
U must add it to .gitignore file
'''

DEBUG = True

TEMPLATE_DEBUG = DEBUG

SECRET_KEY = '{{ secret_key }}'

DATABASES_PASSWORD = '%DB_PWD%'

DATABASES_HOST = 'localhost'

ALLOWED_HOSTS = ['{{ project_name }}.com', '{{ project_name }}.ru']
