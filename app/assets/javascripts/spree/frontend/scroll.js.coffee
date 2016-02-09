(($) ->

  jump = (e) ->
    target
    if e
      e.preventDefault()
      target = $(this).attr('href')
    else
      target = location.hash
    # console.log 'Target: '+ target
    if target != "#" and target != "#_=_"
      $('html,body').animate { scrollTop: $(target).offset().top - 150 }, 2000, ->
        location.hash = target
        return
    return

  $('html, body').hide()
  $(document).ready ->
    # console.log 'hash: '+location.hash
    $('a[href^=#]').bind 'click', jump
    if location.hash
      # setTimeout (->
        $('html, body').scrollTop(0).show()
        jump()
        return
      # ), 0
    else
      $('html, body').show()
    return
  return
) jQuery