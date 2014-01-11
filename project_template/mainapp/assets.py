# coding: utf-8

from django_assets import Bundle
from django_assets import register


js_all = Bundle('js/main.js', filters='jsmin', output='js/packed.js')
css_all = Bundle('less/bootstrap.less', filters='less,cssmin', output='css/packed.css',
                 depends='less/*.less')
js_carousel = Bundle('libs/jquery-ui-carousel/dist/js/jquery.rs.carousel.js',
                     'libs/jquery-ui-carousel/dist/js/jquery.rs.carousel-autoscroll.js',
                     'libs/jquery-ui-carousel/dist/js/jquery.rs.carousel-continuous.js',
                     'libs/jquery-ui-carousel/dist/js/jquery.rs.carousel-touch.js',
                     'js/rc-carousel-it.js',
                     filters='jsmin', output='js/carousel_packed.js')
css_carousel = Bundle('libs/jquery-ui-carousel/dist/css/jquery.rs.carousel.css', 
                      filters='cssmin', output='css/carousel_packed.css')
js_fancybox = Bundle('libs/fancyapps-fancyBox/source/jquery.fancybox.pack.js',
                     'libs/fancyapps-fancyBox/source/helpers/jquery.fancybox-buttons.js',
                     'libs/fancyapps-fancyBox/source/helpers/jquery.fancybox-media.js',
                     'libs/fancyapps-fancyBox/source/helpers/jquery.fancybox-thumbs.js',
                     'js/fancybox-it.js',
                     filters='jsmin', output='js/fancybox_packed.js')
css_fancybox = Bundle('libs/fancyapps-fancyBox/source/jquery.fancybox.css', 
                      'libs/fancyapps-fancyBox/source/helpers/jquery.fancybox-buttons.css',
                      'libs/fancyapps-fancyBox/source/helpers/jquery.fancybox-thumbs.css',
                      filters='less,cssmin', output='css/fancybox_packed.css')
js_print = Bundle('libs/jQuery-printPage-plugin/jquery.printPage.js', 
                  filters='jsmin', output='js/print_packed.js')


register('js_all', js_all)
register('css_all', css_all)
register('js_carousel', js_carousel)
register('css_carousel', css_carousel)
register('js_fancybox', js_fancybox)
register('css_fancybox', css_fancybox)
register('js_print', js_print)
