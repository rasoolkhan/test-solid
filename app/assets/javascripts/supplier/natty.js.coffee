$(document).ready ->
  # Sortable & serachable tables
  $('.table-dynamic').dataTable()

  # Chosen select boxes
  chosen_config =
    '.chosen-select':
      width: "100%"
    '.chosen-select-deselect':
      allow_single_deselect: true
      width: "100%"
    '.chosen-select-no-single':
      disable_search_threshold: 10
    '.chosen-select-no-results':
      no_results_text: 'Oops, nothing found!'
    '.chosen-select-width':
      width: "95%"
  for selector of chosen_config
    $(selector).chosen chosen_config[selector]

  # Date pickers
  $('.form-date').datepicker
    todayBtn: 'linked'
    keyboardNavigation: false
    forceParse: false
    calendarWeeks: true
    autoclose: true

  # Check boxes
  $('.i-checks').iCheck
    checkboxClass: 'icheckbox_square-green'
    radioClass: 'iradio_square-green'

  # Feature add
  $('.form-features-list').on 'click', '.form-feature-add', (event) ->
    event.preventDefault()
    $(@).parent().find('tbody').append ->
      '<tr><td><input type="text" name="product[features][]" id="product_features_" class="form-control"></td></tr>'

  # Color picker
  currentColor = $('#variant_colour').val()
  $('#variant_colour').simplecolorpicker(
    theme: 'fontawesome'
  ).on 'change', ->
    newColor = $('.simplecolorpicker').find('span[data-selected]').data 'color'
    if currentColor == newColor
      $('#variant_colour').simplecolorpicker('selectColor', '');
      currentColor = ''
    else
      currentColor = newColor
