$(document).ready ->
    
  #Check if mobile view
  isMobileView = ->
    if window.matchMedia('(max-width: 999px)').matches
      true
    else
      false
        
  $('.filter-invoke').click ->
    unless isMobileView()
      if $('.stores-show-products-filter').is(':visible')
        $('.stores-show-products-filter').css 'display', 'none'
        $('.stores-show-products-list').css 'width', '100%'
        $('.stores-show-products-list').removeClass 'filter-on'
      else
        $('.stores-show-products-filter').css 'display', 'inline-block'
        $('.stores-show-products-list').css 'width', '69%'
        $('.stores-show-products-list').addClass 'filter-on'
      return
    return

  $('.stores-filter').appendTo $('.stores-index-stores-filter')
    
  $('.stores-filter-invoke').click ->
    unless isMobileView()
      if $('.stores-index-stores-filter').is(':visible')
        $('.stores-index-stores-filter').css 'display', 'none'
        $('.stores-index-stores-list').css 'width', '100%'
      else
        $('.stores-index-stores-filter').css 'display', 'inline-block'
        $('.stores-index-stores-list').css 'width', '69%'
      return
    else
      if $('.stores-index-stores-filter').is(':visible')
        $('.stores-index-stores-filter').slideUp()
      else
        $('.stores-index-stores-filter').slideDown()
      return
    return


  $('.stores-index-stores-filter .filter-close span').click ->
    if $('.stores-index-stores-filter').is(':visible')
      $('.stores-index-stores-filter').slideUp()
    return

   
  $(window).scroll ->
    if isMobileView() and $('.stores-index-stores-filter').is(':visible')
      if $(window).scrollTop() > 71
        $('.stores-index-stores-filter').css 'top', '44px'
      else
        $('.stores-index-stores-filter').css 'top', '54px'