$.validator.setDefaults
  onfocusout: false
  onkeyup: false
  onclick: false
  errorContainer: '#error-form'
  errorLabelContainer: '#error-form ul'
  wrapper: 'li'
  invalidHandler: (event, validator) ->
    $.fancybox $('#error-form')

$(document).ready ->
  $('#error-form').fancybox()
