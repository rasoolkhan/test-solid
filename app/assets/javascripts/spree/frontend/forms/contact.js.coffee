$(document).ready ->
  $('.contact_form').validate
    rules:
      'user[first_name]':
        required: true
        lettersandspacesandpunctuation: true
      'user[last_name]':
        required: true
        lettersandspacesandpunctuation: true
      'user[email]':
        required: true
        email: true
      'subject':
        required: true
      'message':
        required: true
    messages:
      'user[first_name]':
        required: 'Please enter your First Name.'
        lettersandspacesandpunctuation: "First Name: Only letters, spaces and ',' '.' '&' only please."
      'user[last_name]':
        required: 'Please enter your Last Name.'
        lettersandspacesandpunctuation: "Last Name: Only letters, spaces and ',' '.' '&' only please."
      'user[email]':
        required: 'Please enter your email address.'
        email: 'Please enter a valid email address.'
      'subject':
        required: 'Please enter a subject.'
      'message':
        required: 'Please enter a message.'
