$(document).ready ->
  $('.option_type_form').first().validate
    submitHandler: (form) ->
      $.fancybox.showLoading()
      form.submit()
    rules:
      'option_type[name]':
        required: true
        alphanumeric: true
      'option_type[presentation]':
        required: true
        alphanumeric: true
    messages:
      'option_type[name]':
        required: 'Please enter a name.'
      'option_type[presentation]':
        required: 'Please enter a presentation. This is what is displayed on the store. Can be the same as the name field.'
