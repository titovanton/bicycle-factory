# coding: utf-8

from django.conf import settings
from django_assets import Bundle
from django_assets import register


src = settings.STATIC_SRC

js_all = Bundle(src+'/js/main.js', filters='jsmin', output='js/all.js')
css_all = Bundle(src+'/less/bootstrap.less', filters='cssrewrite,less,cssmin', 
                 output='css/all.css', depends=src+'less/*.less')
js_carousel = Bundle('rc-carousel/js/jquery.rs.carousel.js',
                     'rc-carousel/js/jquery.rs.carousel-autoscroll.js',
                     'rc-carousel/js/jquery.rs.carousel-continuous.js',
                     'rc-carousel/js/jquery.rs.carousel-touch.js',
                     src+'/js/rc-carousel-it.js',
                     filters='jsmin', 
                     output='js/carousel.js')
css_carousel = Bundle('rc-carousel/css/jquery.rs.carousel.css', 
                      filters='cssrewrite,cssmin', 
                      output='css/carousel.css')
js_fancybox = Bundle('fancybox/jquery.fancybox.pack.js',
                     'fancybox/helpers/jquery.fancybox-buttons.js',
                     'fancybox/helpers/jquery.fancybox-media.js',
                     'fancybox/helpers/jquery.fancybox-thumbs.js',
                     src+'/js/fancybox-it.js',
                     filters='jsmin', 
                     output='js/fancybox.js')
css_fancybox = Bundle('fancybox/jquery.fancybox.css', 
                      'fancybox/helpers/jquery.fancybox-buttons.css',
                      'fancybox/helpers/jquery.fancybox-thumbs.css',
                      filters='cssrewrite,less,cssmin', 
                      output='css/fancybox.css')
js_print = Bundle('print/jquery.printPage.js', 
                  filters='jsmin', 
                  output='js/print.js')


register('js_all', js_all)
register('css_all', css_all)
register('js_carousel', js_carousel)
register('css_carousel', css_carousel)
register('js_fancybox', js_fancybox)
register('css_fancybox', css_fancybox)
register('js_print', js_print)
