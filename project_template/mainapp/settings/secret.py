# -*- coding: utf-8 -*-
'''
U must add it to .gitignore file
'''

DEBUG = True

TEMPLATE_DEBUG = True

SECRET_KEY = '{{ secret_key }}'

DATABASES_PASSWORD = '1'

PROJECT_URL = '{{ project_name }}.localsite.com'

ALLOWED_HOSTS = ['{{ project_name }}.com', '{{ project_name }}.ru',
                 '{{ project_name }}.localsite.com', ]
