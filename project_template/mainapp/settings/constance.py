# -*- coding: utf-8 -*-

from secret import REDIS_CONNECTION


CONSTANCE_REDIS_CONNECTION = REDIS_CONNECTION

CONSTANCE_REDIS_PREFIX = 'constance:{{ project_name }}:'

CONSTANCE_CONFIG = {
    'GOOGLE_ANALYTICS': (u'''
        ''', u'Код Google Аналитик'),
    'YANDEX_METRICA': (u'''
        ''', u'Код Yandex Метрика'),
    'YANDEX_VERIFICATION': ('''
        ''', u'Метатег Yandex проверка'),
    'GOOGLE_SITE_VERIFICATION': ('''
        ''', u'Метатег Google проверка'),
}
