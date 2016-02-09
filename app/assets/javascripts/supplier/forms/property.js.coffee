$(document).ready ->
  $('.property_form').first().validate
    submitHandler: (form) ->
      $.fancybox.showLoading()
      form.submit()
    rules:
      'property[name]':
        required: true
        alphanumeric: true
      'property[presentation]':
        required: true
        alphanumeric: true
    messages:
      'property[name]':
        required: 'Please enter a name.'
      'property[presentation]':
        required: 'Please enter a presentation. This is what is displayed on the store. Can be the same as the name field.'
