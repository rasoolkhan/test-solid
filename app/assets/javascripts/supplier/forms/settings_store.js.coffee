$(document).ready ->
  $('.settings_store').first().validate
    submitHandler: (form) ->
      $.fancybox.showLoading()
      form.submit()
    rules:
      'store[description]':
        required: true
      'store[logo_attributes][attachment]':
        accept: 'image/*'
        filesize: 2 * 1024 * 1024
      'store[image_attributes][attachment]':
        accept: 'image/*'
        filesize: 2 * 1024 * 1024
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
    messages:
      'store[description]':
        required: 'Please enter a Store Description.'
      'store[logo_attributes][attachment]':
        accept: 'Please attach a valid Logo Image.'
        filesize: 'Maximum Logo Image size allowed is 2MB.'
      'store[image_attributes][attachment]':
        accept: 'Please attach a valid Banner Image.'
        filesize: 'Maximum Banner Image size allowed is 2MB.'
      'store[office_address_attributes][address_attributes][address1]':
        required: 'Please enter Address Line 1.'
      'store[office_address_attributes][address_attributes][city]':
        required: 'Please enter your city.'
        lettersandspaces: 'Please enter a valid city.'
      'store[office_address_attributes][address_attributes][zipcode]':
        required: 'Please enter a Pincode.'
        digits: 'Please enter a pincode with digits only.'
      'store[office_address_attributes][address_attributes][phone]':
        required: 'Please enter a Phone number'
        digits: 'Please enter a phone number with digits only.'
