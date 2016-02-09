$(document).ready ->
  $('#new_spree_user[action="/password/change"]').validate
    rules:
      'spree_user[password]':
        required: true
        minlength: 6
      'spree_user[password_confirmation]':
        equalTo: '#spree_user_password'
    messages:
      'spree_user[password]':
        required: 'Please enter your password.'
        minlength: 'Password must be atleast 6 characters long.'
      'spree_user[password_confirmation]':
        equalTo: 'Password confirmation does not match.'
