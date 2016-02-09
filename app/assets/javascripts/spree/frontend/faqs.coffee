$(document).ready ->
    
  #Check if mobile view
  isMobileView = ->
    if window.matchMedia('(max-width: 750px)').matches
      true
    else
      false
        
  
  $('.question-for-buyer').appendTo $('.buyer-question-desktop')
  $('.question-for-seller').appendTo $('.seller-question-desktop')
  $('.question-for-buyer').clone().appendTo $('.buyer-question-mobile')
  $('.question-for-seller').clone().appendTo $('.seller-question-mobile')
        
  $('.buyer').click ->
    $('.overlay').hide()
    if isMobileView()
      $('.seller-question-mobile').slideUp 'slow'
      $('.buyer-question-mobile').slideToggle()
      $('.buyer .select-border').toggle()
      $('.seller .select-border').hide()
    else
      $('.seller-question-desktop').slideUp 'slow'
      $('.buyer-question-desktop').slideDown 'slow'
      $('.buyer .overlay').show()
    return

  $('.seller').click ->
    $('.overlay').hide()
    if isMobileView()
      $('.buyer-question-mobile').slideUp 'slow'
      $('.seller-question-mobile').slideToggle()
      $('.seller .select-border').toggle()
      $('.buyer .select-border').hide()
    else
       $('.buyer-question-desktop').slideUp 'slow'
       $('.seller-question-desktop').slideDown 'slow'
       $('.seller .overlay').show()
    return

  return