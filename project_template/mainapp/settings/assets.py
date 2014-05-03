# -*- coding: utf-8 -*-

from secret import DEBUG
from _settings import STATIC_SRC
from _settings import STATIC_ROOT
from _settings import STATIC_URL


ASSETS_AUTO_BUILD = DEBUG

ASSETS_LOAD_PATH = [STATIC_ROOT, STATIC_SRC, ]

ASSETS_URL_MAPPING = {
    STATIC_ROOT: STATIC_URL,
    STATIC_SRC: STATIC_URL,
}
