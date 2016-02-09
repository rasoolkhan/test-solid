$(document).ready ->
  $('#new_spree_user[action="/signup"]').validate
    rules:
      'spree_user[first_name]':
        required: true
        lettersonly: true
      'spree_user[last_name]':
        required: true
        lettersonly: true
      'spree_user[email]':
        required: true
        email: true
      'spree_user[password]':
        required: true
        minlength: 6
      'spree_user[password_confirmation]':
        equalTo: '#spree_user_password'
    messages:
      'spree_user[first_name]':
        required: 'Please enter your First Name.'
        lettersonly: 'Please enter a valid First Name with letters only.'
      'spree_user[last_name]':
        required: 'Please enter your Last Name.'
        lettersonly: 'Please enter a valid Last Name with letters only.'
      'spree_user[email]':
        required: 'Please enter your email address.'
        email: 'Please enter a valid email address.'
      'spree_user[password]':
        required: 'Please enter a password.'
        minlength: 'Password must be atleast 6 characters long.'
      'spree_user[password_confirmation]':
        equalTo: 'Password confirmation does not match.'
