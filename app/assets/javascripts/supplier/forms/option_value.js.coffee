verifyOptionValues = ->
  $('.option_value_name').each (index) ->
    $(@).rules 'add',
      required: "#option_values_presentation_#{index}:filled"
      alphanumeric: true

  $('.option_value_presentation').each (index) ->
    $(@).rules 'add',
      required: "#option_values_names_#{index}:filled"
      alphanumeric: true

$(document).ready ->
  $('.option_value_form').first().validate
    submitHandler: (form) ->
      $.fancybox.showLoading()
      form.submit()

  verifyOptionValues()

  # Option Value add
  $('.form-option-value-button').click (event) ->
    event.preventDefault()
    tbody = $(@).parent().find('tbody')
    rows = tbody.find('tr').length
    tbody.append ->
      '<tr><td><input type="text" name="option_values[names][' + rows + ']" id="option_values_names_' + rows + '" class="form-control option_value_name"></td><td><input type="text" name="option_values[presentation][' + rows + ']" id="option_values_presentation_' + rows + '" class="form-control option_value_presentation"></td></tr>'
    verifyOptionValues()
