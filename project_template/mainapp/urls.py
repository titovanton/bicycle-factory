# -*- coding: utf-8 -*-

from django.conf.urls import patterns
from django.conf.urls import include
from django.conf.urls import url
from django.contrib import admin


admin.autodiscover()

urlpatterns = patterns('',
    url(r'^grappelli/', include('grappelli.urls')),
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
    url(r'^admin/', include(admin.site.urls)),

    # home
    url(r'^home/$', 'mainapp.views.home'),
    url(r'^$', 'mainapp.views.home'),
)
