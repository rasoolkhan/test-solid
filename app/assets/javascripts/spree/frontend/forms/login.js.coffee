$(document).ready ->
  $('#new_spree_user[action="/login"]').validate
    rules:
      'spree_user[email]':
        required: true
        email: true
      'spree_user[password]':
        required: true
    messages:
      'spree_user[email]':
        required: 'Please enter your email address.'
        email: 'Please enter a valid email address.'
      'spree_user[password]':
        required: 'Please enter your password.'
