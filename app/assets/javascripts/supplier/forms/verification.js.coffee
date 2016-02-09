verifyProductImages = ->
  $('.verification-product-image').each (index) ->
    $(@).rules 'add',
      accept: 'image/*'
      filesize: 2 * 1024 * 1024
      messages:
        accept: "Please attach a valid Product Sample Image (#{index + 1})."
        filesize: "Maximum Product Sample Image (#{index + 1}) size allowed is 2MB."

$(document).ready ->
  $('.edit_store').first().validate
    submitHandler: (form) ->
      $.fancybox.showLoading()
      slugInput = $('.stores-edit-slug').find('input')
      newSlug = slugInput.val()
      $.get '/supplier/slug_availability', {slug: newSlug}, (data) ->
        unless data.available or (slugInput.data('orig') == newSlug)
          $.fancybox 'The chosen URL is already taken. Please choose a different one.'
          $.fancybox.hideLoading()
        else
          form.submit()
    rules:
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
        accept: 'image/*'
        filesize: 2 * 1024 * 1024
      'store[image_attributes][attachment]':
        accept: 'image/*'
        filesize: 2 * 1024 * 1024
    messages:
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
      'store[name]':
        required: 'Please enter your Store Name.'
        lettersandspacesandpunctuationandhyphen: 'Please enter a valid Store Name with letters, spaces and punctuation only.'
      'store[slug]':
        required: 'Please enter your Store URL.'
        alphanumericandhyphen: 'Please enter a valid URL with only lowercase letters and hyphens.'
      'store[description]':
        required: 'Please enter a Store Description.'
      'store[logo_attributes][attachment]':
        accept: 'Please attach a valid Logo Image.'
        filesize: 'Maximum Logo Image size allowed is 2MB.'
      'store[image_attributes][attachment]':
        accept: 'Please attach a valid Banner Image.'
        filesize: 'Maximum Banner Image size allowed is 2MB.'

  verifyProductImages()

  $('.verification-social-url').each (index) ->
    $(@).rules 'add',
      lettersandspacesandnocomma: true
      messages:
        lettersandspacesandnocomma: "Please enter a valid Social URL (#{index + 1}) with letters, spaces and '.' '&'"

  # Samples add
  $('.form-samples-list').on 'click', '.form-samples-add', (event) ->
    event.preventDefault()
    tbody = $(@).parent().find('tbody')
    rows = tbody.find('tr').length
    tbody.append ->
      '<tr><td><input class="verification-product-image" type="file" name="store[product_samples_attributes][' + rows + '][image_attributes][attachment]" id="store_product_samples_attributes_' + rows + '_image_attributes_attachment"></td><td><input type="text" name="store[product_samples_attributes][' + rows + '][name]" id="store_product_samples_attributes_' + rows + '_name"></td><td><input type="text" name="store[product_samples_attributes][' + rows + '][description]" id="store_product_samples_attributes_' + rows + '_description"></td><td><input type="text" name="store[product_samples_attributes][' + rows + '][price]" id="store_product_samples_attributes_' + rows + '_price"></td></tr>'
    verifyProductImages()

  $('.stores-edit-name').find('input').keyup ->
    $('.stores-edit-slug').find('input').val $(@).val().replace(/[^a-z0-9_\-]/gi, '').toLowerCase()
