changeMenus = (selects) ->
  selects.change ->
    selects.off 'change'
    selections = "id=#{product}&"
    selects.each ->
      selections = selections.concat "#{$(this).data('type')}=#{$(this).val()}&"
    $.ajax
      url: '/variant'
      data: selections
      dataType: 'json'
      success: (data) ->
        # Change images
        htmlMain = ''
        index = 0
        for url in data.images.product
          htmlMain = htmlMain.concat "<div data-thumb='#{data.images.mini[index]}'><img src='#{url}'></div>"
          index++
        $('.products-show-images').slick 'unslick'
        $('.products-show-images').html htmlMain
        $('.products-show-images').slick
          customPaging: (slider, i) ->
            thumb = $(slider.$slides[i]).data 'thumb'
            "<a><img src='#{thumb}'></a>"
          dots: true
          nextArrow: '<i class="fa fa-chevron-right product-show-arrow product-show-arrow-right"></i>'
          prevArrow: '<i class="fa fa-chevron-left product-show-arrow product-show-arrow-left"></i>'

        # Change variant title
        text = data.menus[0].value.name
        text = text.concat " + #{data.menus[1].value.name}" if data.menus[1]
        $('.products-show-interaction').find('h3').text text

        #Change price
        $('.products-show-interaction-price').find('span').text data.price

        # Change availability
        $('.products-show-interaction-stock').replaceWith(if data.available then '<p class="products-show-interaction-stock stock-active">In Stock</p>' else '<p class="products-show-interaction-stock stock-inactive">Out of Stock</p>')

        # Change SKU
        $('.products-show-interaction-sku').replaceWith "<p class='products-show-interaction-sku'>SKU #{data.sku}</p>"

        # Change selects
        $('.products-show-interaction').find('input[name="variant_id"]').replaceWith "<input type='hidden' name='variant_id' id='variant_id' value='#{data.variant}'>"
        $('.products-show-interaction-options').find('li:not(:last-child)').remove()
        html = ''
        for menu in data.menus
          html = html.concat "<li><label for='#{menu.type.name}'>#{menu.type.name}</label><select name='#{menu.type.name}' id='#{menu.type.name}' data-type='#{menu.type.id}'>"
          for value in menu.values
            html = html.concat "<option value='#{value.id}' #{'selected="selected"' if value.id is menu.value.id}>#{value.name}</option>"
          html = html.concat '</select></li>'
        $('.products-show-interaction-options').find('ul').prepend html
        changeMenus $('.products-show-interaction-options').find('select')

$(document).ready ->
  changeMenus $('.products-show-interaction-options').find('select')
