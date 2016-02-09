$(document).ready ->
  $('#new_newsletter_signup').validate
    rules:
      'newsletter_signup[email]':
        required: true
        email: true
    messages:
      'newsletter_signup[email]':
        required: 'Please enter your email address.'
        email: 'Please enter a valid email address.'
