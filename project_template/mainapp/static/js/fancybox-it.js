/**
  * @file fancybox-it.js
  *
  * Get all DOM objects with class fancybox-it,
  * group them by attribute rel to separate fancybox galleries.
  * 
  * @required class="fancybox-it" rel="galleryX"
**/

jQuery(document).ready(function($) {
    var options = {
        openEffect: 'elastic',
        closeEffect: 'elastic',
        nextBtn: false,
        prevBtn: false,
        closeBtn: false,
        helpers: {
            buttons: {
                position: 'bottom'
            },
            thumbs: {
                position: 'top',
                width: 50,
                height: 50
            }
        }
    }
    $('.fancybox-it').fancybox(options)
});