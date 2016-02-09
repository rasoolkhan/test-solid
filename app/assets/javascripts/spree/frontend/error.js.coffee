$(document).ready ->
  if $('#error-dialog').find('p').text() != ""
    $('#error-dialog').fancybox()
    $.fancybox $('#error-dialog')

  $(document).ajaxStart( ->
    $.fancybox.showLoading()
  )

  $('form').find('input[type="submit"]').click ->
    $.fancybox.showLoading()
