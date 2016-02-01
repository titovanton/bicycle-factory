# coding: utf-8

from django_assets import Bundle
from django_assets import register


home_css = Bundle('less/base/base.less',
                  'less/home/home.less',
                  filters='cssrewrite,less,cssmin',
                  output='css/home.css',
                  depends='less/*.less')

home_js = Bundle('coffee/base/base.coffee',
                 'coffee/home/home.coffee',
                 filters='coffeescript,jsmin',
                 # filters='coffeescript',
                 output='js/home.js')

register('home_css', home_css)
register('home_js', home_js)
