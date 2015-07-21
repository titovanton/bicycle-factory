# -*- coding: utf-8 -*-

from secret import DEBUG
from secret import REDIS_CONNECTION


THUMBNAIL_DEBUG = DEBUG
# THUMBNAIL_ENGINE = 'sorl.thumbnail.engines.wand_engine.Engine'
THUMBNAIL_KVSTORE = 'sorl.thumbnail.kvstores.redis_kvstore.KVStore'
THUMBNAIL_REDIS_DB = REDIS_CONNECTION['db']
THUMBNAIL_REDIS_PASSWORD = REDIS_CONNECTION['password']
THUMBNAIL_REDIS_HOST = REDIS_CONNECTION['host']
THUMBNAIL_REDIS_PORT = REDIS_CONNECTION['port']
THUMBNAIL_PRESERVE_FORMAT = True
