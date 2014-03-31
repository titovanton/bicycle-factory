# coding: UTF-8

import django_settings


def meta_tags(request):
    yandex_verification = u'<meta content="%s" name="yandex-verification">' % \
                          django_settings.get('yandex_verification', default='')
    google_site_verification = u'<meta content="%s" name="google-site-verification">' % \
                               django_settings.get('google_site_verification', default='')
    return {
        'GOOGLE_ANALYTICS': django_settings.get('google_analytics', default=''),
        'LIVEINTERNET': django_settings.get('liveinternet', default=''),
        'PAGERANK': django_settings.get('pagerank', default=''),
        'YANDEX_METRICA': django_settings.get('yandex_metrica', default=''),
        'YANDEX_VERIFICATION': yandex_verification,
        'GOOGLE_SITE_VERIFICATION': google_site_verification,
    }
