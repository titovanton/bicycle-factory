# -*- coding: utf-8 -*-

from django.conf import settings
from django.conf.urls import patterns
from django.conf.urls import include
from django.contrib import admin


admin.autodiscover()

urlpatterns = patterns('',
    (r'^grappelli/', include('grappelli.urls')),
    (r'^admin/doc/', include('django.contrib.admindocs.urls')),
    (r'^admin/', include(admin.site.urls)),

    # errors
    (r'^404/$', page_not_found),

    # home
    (r'^$', 'mainapp.views.home'),
)


if settings.DEBUG:
    import debug_toolbar
    urlpatterns += patterns('',
        (r'^__debug__/', include(debug_toolbar.urls)),
    )
