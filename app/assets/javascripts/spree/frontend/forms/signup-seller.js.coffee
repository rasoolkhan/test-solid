$(document).ready ->
  $('#new_store').validate
    submitHandler: (form) ->
      $.get '/supplier/slug_availability', {slug: $('.stores-new-slug').find('input').val()}, (data) ->
        unless data.available
          $.fancybox 'The chosen URL is already taken. Please choose a different one.'
          $.fancybox.hideLoading()
        else
          form.submit()
    rules:
      'store[seller_attributes][name]':
        required: true
        lettersandspacesandpunctuation: true
      'store[office_address_attributes][address_attributes][address1]':
        required: true
      'store[office_address_attributes][address_attributes][city]':
        required: true
        lettersandspaces: true
      'store[office_address_attributes][address_attributes][zipcode]':
        required: true
        digits: true
        exactlength: 6
      'store[office_address_attributes][address_attributes][phone]':
        required: true
        digits: true
        rangelength: [5, 10]
      'store[name]':
        required: true
        lettersandspacesandpunctuationandhyphen: true
      'store[slug]':
        required: true
        alphanumericandhyphen: true
      'store[description]':
        required: true
        maxlength: 1024
      'store[logo_attributes][attachment]':
        required: true
        accept: 'image/*'
        filesize: 2 * 1024 * 1024
      'store[image_attributes][attachment]':
        required: true
        accept: 'image/*'
        filesize: 2 * 1024 * 1024
    messages:
      'store[seller_attributes][name]':
        required: 'Please enter your Company Name.'
        lettersandspacesandpunctuation: 'Please enter a valid Company Name with letters, spaces and punctuation only.'
      'store[office_address_attributes][address_attributes][address1]':
        required: 'Please enter Address Line 1.'
      'store[office_address_attributes][address_attributes][city]':
        required: 'Please enter your city.'
        lettersandspaces: 'Please enter a valid city.'
      'store[office_address_attributes][address_attributes][zipcode]':
        required: 'Please enter a Pincode.'
        digits: 'Please enter a pincode with digits only.'
        exactlength: 'Zipcode must be exactly 6 digits long.'
      'store[office_address_attributes][address_attributes][phone]':
        required: 'Please enter a Phone number'
        digits: 'Please enter a phone number with digits only.'
        rangelength: 'Phone number needs to be between 5-10 digits.'
      'store[name]':
        required: 'Please enter your Store Name.'
        lettersandspacesandpunctuationandhyphen: 'Please enter a valid Store Name with letters, spaces and punctuation only.'
      'store[slug]':
        required: 'Please enter your Store URL.'
        alphanumericandhyphen: 'Please enter a valid URL with only lowercase letters and hyphens.'
      'store[description]':
        required: 'Please enter a Store Description.'
        maxlength: 'Store Description cannot be more than 1024 characters.'
      'store[logo_attributes][attachment]':
        required: 'Please attach a Logo Image.'
        accept: 'Please attach a valid Logo Image.'
        filesize: 'Maximum Logo Image size allowed is 2MB.'
      'store[image_attributes][attachment]':
        required: 'Please attach a Banner Image.'
        accept: 'Please attach a valid Banner Image.'
        filesize: 'Maximum Banner Image size allowed is 2MB.'

  $('.signup-product-image').each (index) ->
    $(@).rules 'add',
      accept: 'image/*'
      filesize: 2 * 1024 * 1024
      messages:
        accept: "Please attach a valid Product Sample Image (#{index + 1})."
        filesize: "Maximum Product Sample Image (#{index + 1}) size allowed is 2MB."

  $('.signup-social-url').each (index) ->
    $(@).rules 'add',
      lettersandspacesandnocomma: true
      messages:
        lettersandspacesandnocomma: "Please enter a valid Social URL (#{index + 1}) with letters, spaces and '.' '&'"

  $('.stores-new-name').find('input').keyup ->
    $('.stores-new-slug').find('input').val $(@).val().replace(/[^a-z0-9_\-]/gi, '').toLowerCase()
