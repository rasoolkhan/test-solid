$(document).ready ->
  $('.form-field-file').find('input').on 'change', (event) ->
    preview = $(@).parent().find('.form-field-file-preview')
    if event.target.value
      if preview
        reader = new FileReader()
        reader.onload = (event) ->
          preview.find('.form-field-file-preview-blank').hide 0
          preview.css('background-image', 'url(' + event.target.result + ')')
        reader.readAsDataURL @.files[0]
      $(@).parent().find('.form-field-file-text').text(event.target.value.split( '\\' ).pop())
    else
      if preview
        preview.css('background-image', 'none')
        preview.find('.form-field-file-preview-blank').show 0
      $(@).parent().find('.form-field-file-text').text('No Image Uploaded.')
