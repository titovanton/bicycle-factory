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

    # home
    (r'^home/$', 'mainapp.views.home'),
    (r'^$', 'mainapp.views.home'),
)


if settings.DEBUG:
    import debug_toolbar
    urlpatterns += patterns('',
        (r'^__debug__/', include(debug_toolbar.urls)),
    )
