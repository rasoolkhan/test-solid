$(document).ready ->
  $('#search-form').validate
    rules:
      'search':
        required: true
    messages:
      'search':
        required: 'Please enter a search criteria.'
