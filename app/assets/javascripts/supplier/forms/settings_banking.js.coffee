$(document).ready ->
  $('.settings_banking').first().validate
    submitHandler: (form) ->
      $.fancybox.showLoading()
      form.submit()
    rules:
      'seller[bank_name]':
        required: true
        lettersandspacesandpunctuation: true
      'seller[bank_branch]':
        required: true
        lettersandspacesandpunctuation: true
      'seller[bank_account_name]':
        required: true
        lettersandspacesandpunctuationandhyphen: true
      'seller[bank_account_number]':
        required: true
        digits: true
        rangelength: [10, 18]
      'seller[bank_ifsc]':
        required: true
        lettersandnumbers: true
        exactlength: 11
      'seller[bank_micr]':
        digits: true
        exactlength: 9
      'seller[bank_pan]':
        required: true
        lettersandnumbers: true
        exactlength: 10
      'seller[bank_tin]':
        required: true
        digits: true
        exactlength: 11
      'seller[bank_vat]':
        required: true
        lettersandnumbers: true
        rangelength: [11, 12]
