# -*- coding: utf-8 -*-

import sys

from secret import DEBUG


# Debug Toolbar should works with runserver only:
try:
    if sys.argv[1] == 'runserver' or sys.argv[1] == 'runserver_plus':
        DEBUG_TOOLBAR_PATCH_SETTINGS = DEBUG
    else:
        DEBUG_TOOLBAR_PATCH_SETTINGS = False
except IndexError:
    DEBUG_TOOLBAR_PATCH_SETTINGS = False

DEBUG_TOOLBAR_PANELS = [
    # default
    'debug_toolbar.panels.versions.VersionsPanel',
    'debug_toolbar.panels.timer.TimerPanel',
    'debug_toolbar.panels.settings.SettingsPanel',
    'debug_toolbar.panels.headers.HeadersPanel',
    'debug_toolbar.panels.request.RequestPanel',
    'debug_toolbar.panels.sql.SQLPanel',
    'debug_toolbar.panels.staticfiles.StaticFilesPanel',
    'debug_toolbar.panels.templates.TemplatesPanel',
    'debug_toolbar.panels.cache.CachePanel',
    'debug_toolbar.panels.signals.SignalsPanel',
    'debug_toolbar.panels.logging.LoggingPanel',
    'debug_toolbar.panels.redirects.RedirectsPanel',

    # Profiling information for the view function.
    'debug_toolbar.panels.profiling.ProfilingPanel',

    # Displays template rendering times for your Django application.
    'template_timings_panel.panels.TemplateTimings.TemplateTimings',
]
