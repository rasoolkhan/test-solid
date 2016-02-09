Number::formatMoney = ->
  n = @
  c = 2
  d = '.'
  t = ','
  s = if n < 0 then '-' else ''
  i = parseInt(n = Math.abs(+n or 0).toFixed(c)) + ''
  j = if (j = i.length) > 3 then j % 3 else 0
  s + (if j then i.substr(0, j) + t else '') + i.substr(j).replace(/(\d{3})(?=\d)/g, '$1' + t) + (if c then d + Math.abs(n - i).toFixed(c).slice(2) else '')

updateTotal = (context) ->
  lineItem = $(context).closest '.line-item'
  unitPrice = parseFloat lineItem.find('.cart-line-amount').data('amount')
  quantity = parseInt $(context).val()
  quantity = 0 if isNaN quantity
  lineTotalField = lineItem.find '.cart-line-total'
  lineTotalPrev = parseFloat lineTotalField.data('amount')
  lineTotalNew = unitPrice * quantity
  cartTotalField = $ '.cart-total-amount'
  cartTotalPrev = parseFloat cartTotalField.data('amount')
  cartTotalNew = cartTotalPrev + lineTotalNew - lineTotalPrev
  lineTotalField.data 'amount', lineTotalNew
  lineTotalField.text "₹#{lineTotalNew.formatMoney()}"
  cartTotalField.data 'amount', cartTotalNew
  cartTotalField.find('p').text "₹#{cartTotalNew.formatMoney()}"

$(document).ready ->
  $('.line_item_quantity_change').click (event) ->
    event.preventDefault()
    quantityField = $(@).closest('.line-item').find('.line_item_quantity')
    quantity = parseInt quantityField.val()
    quantity = 0 if isNaN quantity
    if $(@).hasClass 'line_item_quantity_decrement' then quantity and quantity-- else quantity++
    quantityField.val quantity
    updateTotal quantityField

  $('.line_item_quantity').change ->
    updateTotal @
