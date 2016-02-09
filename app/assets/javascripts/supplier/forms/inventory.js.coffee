$(document).ready ->
  $('.inventory_form').first().validate
    submitHandler: (form) ->
      $.fancybox.showLoading()
      form.submit()
    rules:
      'stock_item[count_on_hand]':
        required: true
        numberpositive: true
