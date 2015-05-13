# -*- coding: utf-8 -*-

from path import rel_mainapp
from path import rel_static_root
from path import rel_static_url


GLUE_CONFIG = {
    'source': rel_mainapp('static_src', 'sprites_src'),
    'output': rel_static_root('sprites'),
    'move_styles_to': rel_mainapp('static_src', 'less', 'sprites'),
    'less': True,
    'css_url': rel_static_url('sprites'),
    'csscomb': True,
    'crop': True,
    'margin': 5,
}
