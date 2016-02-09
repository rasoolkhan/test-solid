validatePolicies = ->
  $('.policy_heading').each  ->
    $(@).rules 'add',
      required:
        depends: (element) ->
          $(element).closest('fieldset').find('.policy_description').first().val().length > 0
  $('.policy_description').each  ->
    $(@).rules 'add',
    required:
      depends: (element) ->
        $(element).closest('fieldset').find('.policy_heading').first().val().length > 0

$(document).ready ->
  $('.settings_policies').first().validate
    submitHandler: (form) ->
      $.fancybox.showLoading()
      form.submit()

  if $('.settings_policies')[0]
    validatePolicies()

  $('.settings_policies').on 'click', '.form-policies-add', (event) ->
    event.preventDefault()
    fields = $('.store-policy-fields')
    rows = fields.find('fieldset').length
    fields.append ->
      "<fieldset><div class='form-group'><label class='col-sm-2 control-label' for='store_policies_attributes_#{rows}_heading'>Heading</label><div class='col-sm-10'><input class='form-control policy_heading' type='text' name='store[policies_attributes][#{rows}][heading]' id='store_policies_attributes_#{rows}_heading'></div></div><div class='form-group'><label class='col-sm-2 control-label' for='store_policies_attributes_#{rows}_description'>Description</label><div class='col-sm-10'><textarea class='form-control policy_description' name='store[policies_attributes][#{rows}][description]' id='store_policies_attributes_#{rows}_description'></textarea></div></div><div class='hr-line-dashed'></div></fieldset>"
    validatePolicies()
