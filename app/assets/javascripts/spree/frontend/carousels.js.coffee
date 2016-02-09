$(document).ready ->
  $('.form-howitworks-carousel').slick
    autoplay: true
    autoplaySpeed: 50000
    customPaging: (slider, event) ->
      '<div class="carousel-dot"></div>'
    dots: true
    nextArrow: '<i class="fa fa-chevron-right carousel-arrow carousel-arrow-right"></i>'
    prevArrow: '<i class="fa fa-chevron-left carousel-arrow carousel-arrow-left"></i>'

  $('.products-show-images').slick
    customPaging: (slider, i) ->
      thumb = $(slider.$slides[i]).data 'thumb'
      "<a><img src='#{thumb}'></a>"
    dots: true
    nextArrow: '<i class="fa fa-chevron-right product-show-arrow product-show-arrow-right"></i>'
    prevArrow: '<i class="fa fa-chevron-left product-show-arrow product-show-arrow-left"></i>'

  $('.testimonial-carousel').slick
    autoplay: true
    autoplaySpeed: 50000
    customPaging: (slider, event) ->
      '<div class="carousel-dot"></div>'
    dots: true
    nextArrow: '<i class="fa fa-chevron-right carousel-arrow carousel-arrow-right"></i>'
    prevArrow: '<i class="fa fa-chevron-left carousel-arrow carousel-arrow-left"></i>'
    
  $('.featured-store-carousel').slick
    autoplay: true
    autoplaySpeed: 500000
    infinite: false
    customPaging: (slider, event) ->
      '<div class="carousel-dot"></div>'
    dots: true
    nextArrow: '<i class="fa fa-chevron-right carousel-arrow carousel-arrow-right"></i>'
    prevArrow: '<i class="fa fa-chevron-left carousel-arrow carousel-arrow-left"></i>'
