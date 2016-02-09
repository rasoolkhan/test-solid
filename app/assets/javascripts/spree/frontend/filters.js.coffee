$(document).ready ->
  priceSlider = $('#filter-price')
  priceInputBox = $('input.sliderValue')
    
  priceSlider.slider
    range: true
    min: parseInt priceSlider.attr('min')
    max: parseInt priceSlider.attr('max')
    values: [parseInt(priceSlider.attr('min')), parseInt(priceSlider.attr('max'))]
    slide: (event, ui) ->
      i = 0
      while i < ui.values.length
        $('input.sliderValue[data-index=' + i + ']').val ui.values[i]
        ++i
      return
  priceInputBox.change ->
    $this = $(this)
    priceSlider.slider 'values', $this.data('index'), $this.val()
    return
