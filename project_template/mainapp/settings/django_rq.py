# -*- coding: utf-8 -*-

from secret import REDIS_CONNECTION


RQ_QUEUES = {
    'default': {
        'HOST': REDIS_CONNECTION['host'],
        'PORT': REDIS_CONNECTION['port'],
        'DB': REDIS_CONNECTION['db'],
        'PASSWORD': REDIS_CONNECTION['password'],
    }
}
