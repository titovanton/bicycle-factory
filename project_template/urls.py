# -*- coding: utf-8 -*-

# from django.conf import settings
from django.conf.urls import include
from django.conf.urls import url
from bicycle.core.views import Redirect301View

from apps.admin.admin_site import admin_site
# from views import page_not_found


# handler404 = page_not_found

urlpatterns = [
    url(r'^admin/', admin_site.urls),
    url(r'^admin', Redirect301View.as_view(url='/admin/')),

    # errors
    # url(r'^404/$', page_not_found),

    # home
    url(r'^$', 'apps.mainapp.views.home'),
]

# if settings.DEBUG:
#     import debug_toolbar
#     urlpatterns += [
#         url(r'^__debug__/', include(debug_toolbar.urls)),
#     ]
