/**
  * @file rc-carousel-it.js
  *
  * Get all DOM objects with class rs-carousel,
  * get attribute data-items-per-transition and initial rsCarousel
  * 
  * @required class="rs-carousel" data-items-per-transition="int"
  * @required div.rs-carousel-my-action-prev, div.rs-carousel-my-action-next
**/

// monkey putching
$.fn.rsCarousel = $.fn.carousel;
delete $.fn.carousel;

jQuery(window).load(function() {
    $('.rs-carousel').each(function(){
        var $this = $(this),
            itemsPerTransition = $this.attr('data-items-per-transition')
        $this.rsCarousel({
            itemsPerTransition: itemsPerTransition,
            pagination: false,
            nextPrevActions: false
        })
        $this.find('.rs-carousel-my-action-prev').click(function(){
            $(this).parents('.rs-carousel').rsCarousel('prev')
        })
        $this.find('.rs-carousel-my-action-next').click(function(){
            $(this).parents('.rs-carousel').rsCarousel('next')
        })
    })
});