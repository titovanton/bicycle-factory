# -*- coding: utf-8 -*-

"""
This file was generated with the customdashboard management command and
contains the class for the main dashboard.

To activate your index dashboard add the following to your settings.py::
    GRAPPELLI_INDEX_DASHBOARD = 'rusrob.dashboard.CustomIndexDashboard'
"""

# from django.utils.translation import ugettext_lazy as _
from django.core.urlresolvers import reverse

from grappelli.dashboard import modules, Dashboard
from grappelli.dashboard.utils import get_admin_site_name


class CustomIndexDashboard(Dashboard):

    """
    Custom index dashboard for www.
    """

    def init_with_context(self, context):
        site_name = get_admin_site_name(context)

        self.children.append(modules.ModelList(
            u'Управление контентом',
            column=1,
            exclude=('django.contrib.*',),
        ))

        self.children.append(modules.ModelList(
            u'Администрирование',
            column=1,
            models=('django.contrib.*',),
        ))

        self.children.append(modules.LinkList(
            u'Обратная связь',
            column=2,
            children=[
                {
                    'title': u'Список',
                    'url': '/admin/feedback/feedback/',
                    'external': False,
                },
            ]
        ))

        self.children.append(modules.RecentActions(
            u'Последние действия',
            limit=5,
            collapsible=False,
            column=3,
        ))
