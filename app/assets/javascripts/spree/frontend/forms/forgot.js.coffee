$(document).ready ->
  $('#new_spree_user[action="/password/recover"]').validate
    rules:
      'spree_user[email]':
        required: true
        email: true
    messages:
      'spree_user[email]':
        required: 'Please enter your email address.'
        email: 'Please enter a valid email address.'
