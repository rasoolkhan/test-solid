buildFilter = ->
  data =
    filter:
      categories: []
      price: {}
  data.filter.sort = $('.stores-sort-type').find('input:checked').val()
  data.filter.keyword = $('input[name="stores-filter-keyword"]').val()
  $('.stores-filter-categories').find('input:checked').each ->
    filter.categories.push $(@).val()
  data.filter.price.min = $("#filter-price")
  data

$(document).ready ->
  $('.stores-sort-type').find('input').change ->
    $.get '/filter/stores', buildFilter()
