$(document).ready ->
  $('.variant_form').first().validate
    submitHandler: (form) ->
      $.fancybox.showLoading()
      form.submit()
    rules:
      'variant[sku]':
        required: true
      'variant[price]':
        required: true
        price: true
      'variant[stock]':
        required: true
        digits: true
      'variant[processing_days]':
        required: true
        numberpositive: true
        rangelength: [1, 2]
    messages:
      'variant[sku]':
        required: 'Please enter a SKU.'

  $('.variant-image').each ->
    $(@).rules 'add',
      accept: 'image/*'
      filesize: 2 * 1024 * 1024
      messages:
        accept: 'Please attach valid variant images only.'
        filesize: 'Maximum image size allowed is 2MB.'

  if $('.variant-image').length > 0
    $('.variant-image').first().rules 'add',
      required:
        depends: ->
          retVal = true
          $('.variant-image').each ->
            retVal = false if $(@).val().length > 0
          if retVal
            file_count = $('.variant_images_delete').length
            $('.variant_images_delete').each ->
              file_count-- if $(@).is(':checked')
            retVal = false if file_count > 0
          retVal
