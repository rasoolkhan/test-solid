verifyProductCategories = ->
  $('.form-category-level1').change ->
    $.fancybox.showLoading()
    level1 = $ @
    $.ajax(
      url: '/categories'
      data:
        c: 'l1'
        l1: level1.val()
    ).done( (data) ->
      line = level1.closest('.form-category-line')
      level2 = line.find('.form-category-level2')
      level3 = line.find('.form-category-level3')
      l2s = '<option value=""></option>'
      for l2 in data.l2s
        l2s += "<option value='#{l2[0]}'>#{l2[1]}</option>"
      level2.html(l2s)
      level2.trigger 'chosen:updated'
      level3.html('<option value=""></option>')
      level3.trigger 'chosen:updated'
    ).always ->
      $.fancybox.hideLoading()

  $('.form-category-level2').change ->
    $.fancybox.showLoading()
    level2 = $ @
    line = level2.closest('.form-category-line')
    level1 = line.find('.form-category-level1')
    $.ajax(
      url: '/categories'
      data:
        c: 'l2'
        l1: level1.val()
        l2: level2.val()
    ).done( (data) ->
      level3 = line.find('.form-category-level3')
      l3s = '<option value=""></option>'
      for l3 in data.l3s
        l3s += "<option value='#{l3[0]}'>#{l3[1]}</option>"
      level3.html(l3s)
      level3.trigger 'chosen:updated'
    ).always ->
      $.fancybox.hideLoading()


verifyProductOptions = ->
  $('.product_option_new_name').each (index) ->
    $(@).rules 'add',
      required: "#product_option_new_values_#{index}:filled"
      notInList: ".option_type_name"

  $('.product_option_new_values').each (index) ->
    $(@).rules 'add',
      required: "#product_option_new_name_#{index}:filled"


verifyProductProperties = ->
  $('#product_properties_label').each (index) ->
    $(@).rules 'add',
      required:
        depends: ->
          retVal = false
          $('.product_property_name').each ->
            retVal = true if $(@).is(":filled")
          $('.product_property_value').each ->
            retVal = true if $(@).is(":filled")
          retVal

  $('.product_property_name').each (index) ->
    $(@).rules 'add',
      required: "#product_property_values_#{index}:filled"
      notInList: ".product_property_name"
      messages:
        notInList: "This is a duplicate name"

  $('.product_property_value').each (index) ->
    $(@).rules 'add',
      required: "#product_property_names_#{index}:filled"


$(document).ready ->
  $.validator.setDefaults
    ignore: ':hidden:not(.chosen-select):not(.chosen-select-deselect)'

  $('.product_form').first().validate
    submitHandler: (form) ->
      $.fancybox.showLoading()
      form.submit()
    rules:
      'product[name]':
        required: true
        maxlength: 128
      'product[description]':
        required: true
        maxlength: 2048
      'product[meta_keywords]':
        maxarraycommasep: [10, 20]
      'product[taxon_ids][]':
        required: true
      'product[taxon_ids_1][0]':
        required: ->
          retVal = true
          $('.form-category-level1').each ->
            retVal = false if $(@).val().length > 0
          retVal
      'product[guide]':
        accept: 'image/*,application/pdf'
        filesize: 2 * 1024 * 1024
      'product[master_images][]':
        required: true
        accept: 'image/*'
        filesize: 2 * 1024 * 1024
        filecountmax: 4
    messages:
      'product[taxon_ids][]':
        required: 'Please select atleast one category.'
      'product[guide]':
        accept: 'Please attach valid size guide images or PDF files only.'
        filesize: 'Maximum image size allowed is 2MB.'

  # Categories add
  verifyProductCategories()
  $('.form-categories-list').on 'click', '.form-category-add', (event) ->
    return if $(event.target).is('button') # Some bug with jquery -- this function is called when enter is pressed.
    event.preventDefault()
    lines = $('.form-category-lines')
    rows = lines.find('.form-category-line').length
    lines.append ->
      '<div class="form-category-line"><div class="col-sm-3 col-sm-offset-2"><div class="input-group"><select name="product[taxon_ids_1][' + rows + ']" id="product_taxon_ids_1_' + rows + '" class="chosen-select-deselect form-category-level1" data-placeholder="Choose Level 1"><option value=""></option><option value="5">women</option><option value="6">men</option><option value="7">kids</option><option value="8">home</option><option value="9">lifestyle</option><option value="10">food &amp; drink</option><option value="11">gifts</option></select></div></div><div class="col-sm-3"><div class="input-group"><select name="product[taxon_ids_2][' + rows + ']" id="product_taxon_ids_2_' + rows + '" class="chosen-select-deselect form-category-level2" data-placeholder="Choose Level 2"><option value=""></option></select></div></div><div class="col-sm-3"><div class="input-group"><select name="product[taxon_ids_3][' + rows + ']" id="product_taxon_ids_3_' + rows + '" class="chosen-select-deselect form-category-level3" data-placeholder="Choose Level 3"><option value=""></option></select></div></div></div>'
    lines.find('.form-category-line:last-child').find('.chosen-select-deselect').chosen
      allow_single_deselect: true
      width: '100%'
    verifyProductCategories()

  # Properties add
  verifyProductProperties()
  $('.form-properties-list').on 'click', '.form-property-add', (event) ->
    event.preventDefault()
    tbody = $(@).parent().find('tbody')
    rows = tbody.find('tr').length
    tbody.append ->
      '<tr><td><input type="text" name="product[property_names][' + rows + ']" id="product_property_names_' + rows + '" class="form-control product_property_name"></td><td><input type="text" name="product[property_values][' + rows + ']" id="product_property_values_' + rows + '" class="form-control product_property_value"></td></tr>'
    verifyProductProperties()

  # Options add
  verifyProductOptions()
  $('.form-options-list').on 'click', '.form-option-add', (event) ->
    event.preventDefault()
    tbody = $(@).parent().find('tbody')
    rows = tbody.find('tr').length
    tbody.append ->
      '<tr><td><input type="text" name="product[option_new_name][' + rows + ']" id="product_option_new_name_' + rows + '" class="form-control product_option_new_name"></td><td><input type="text" name="product[option_new_values][' + rows + ']" id="product_option_new_values_' + rows + '" class="form-control product_option_new_values"></td></tr>'
    verifyProductOptions()
