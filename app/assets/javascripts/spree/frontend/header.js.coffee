$(document).ready ->
  # Initialization
  navStuck = false
  navSubHover = false
  innerNavHover = false
  header = $ 'header'
  search_form_unstuck = $ '.search-form-unstuck'
  search_form_stuck = $ '.search-form-stuck'

  # Disable clicks if there is no link
  $('a[href="#"]').click (event) ->
    event.preventDefault()

  $(document).click (e) ->
    if e.target.className == 'user-account-menu' or e.target.className == 'user-control-menu' or $(e.target).hasClass 'logged-in'
      return
    else
      if $('.user-control-menu').is(':visible')
        $('.user-control-menu').hide()
    return
    
  # nav-categories show
  $('.menu').click ->
    if isMobileView()
      $('.nav-categories').show()
      $('.header-foot').show()
      $('.header-content').slideDown()
      $('.menu').hide()
      $('.sub-level-options').show()
      $('.logo-stuck').toggleClass 'hideElement'
      $('.logo-unstuck').toggleClass 'hideElement'
      $('.search-form-stuck').toggleClass 'hideElement'
      # $('.nav-user-stuck').toggleClass 'hideElement'
      $('.nav-user-stuck ul li:nth-last-child(2)').hide()
      $('.nav-user-stuck ul li:last-child').hide()
    else
      $('.bars-menu').slideToggle()
      $('.menu').toggleClass 'fa-times'
      $('.menu').toggleClass 'fa-bars'

  # nav-categories hide
  $('.menu-close').click ->
    $('.header-content').slideUp()
    $('.nav-categories').slideUp()
    $('.header-foot').slideUp()
    $('.menu').show()
    $('.sub-level-options').hide()
    $('.logo-stuck').toggleClass 'hideElement'
    $('.logo-unstuck').toggleClass 'hideElement'
    $('.search-form-stuck').toggleClass 'hideElement'
    # $('.nav-user-stuck').toggleClass 'hideElement'
    $('.nav-user-stuck ul li:last-child').show()
    $('.nav-user-stuck ul li:nth-last-child(2)').show()
    $('.level-two-ul').hide()
    $('.level-three-ul').hide()
    $('.level-two-li').hide()
    $('.level-three-li').hide()
    $('.level-one-li').show()

  #Check if mobile view
  isMobileView = ->
    if window.matchMedia('(max-width: 999px)').matches
      true
    else
      false

   # $(window).resize ->
     # if isMobileView()
       # alert 'Mobile'
     # else
       # alert 'Desktop'

  if window.matchMedia('(max-width: 1279px)').matches
    if $('.nav-user-stuck ul li:last-child a i').hasClass('logged-in')
      $('.nav-user-stuck ul li:last-child a').html '<i class="fa fa-user image-login logged-in"></i>'
    else
      $('.nav-user-stuck ul li:last-child a').html '<i class="fa fa-user image-login"></i>'
    

  # Stick header based on scroll position
  $(window).scroll ->
    if isMobileView()
      # header = $ '.header-controls'
      if $(window).scrollTop() > 5
        unless navStuck
          navStuck = true
          header.sticky
            topSpacing: -10
      else
        if navStuck
          header.unstick()
          navStuck = false
    if window.matchMedia('screen and (min-width:1000px) and (max-width:1279px)').matches
      if $(window).scrollTop() > 71
        unless navStuck
          navStuck = true
          header.sticky
            topSpacing: 0
      else
        if navStuck
          header.unstick()
          navStuck = false
    else
      if $(window).scrollTop() > 71
        unless navStuck
          navStuck = true
          header.sticky
            topSpacing: -71
      else
        if navStuck
          header.unstick()
          navStuck = false

  # Show small header and hide big header on stick
  header.on 'sticky-start', ->
    unless isMobileView()
      unless window.matchMedia('(max-width: 1279px)').matches
        $('.logo-unstuck').hide 0
        $('.search-form-unstuck').hide 0
        $('.search-unstuck').hide 0
        $('.logo-stuck').css('display', 'inline-block').show 0
        $('.nav-categories').css 'margin-top', '-23px'
        $('.nav-categories').css 'left', '185px'
        $('.search-form-stuck').show 0
        $('.nav-user-stuck').show 0
    else
      # $('.menu').css 'left', '-112px'
      $('header').css 'padding-bottom', '5px'
      $('.header-content').css 'top', '44px'


  # Show big header and hide small header on unstick
  header.on 'sticky-end', ->
    unless isMobileView()
      unless window.matchMedia('(max-width: 1279px)').matches
        $('.logo-unstuck').show 0
        $('.search-form-unstuck').show 0
        $('.search-unstuck').show 0
        $('.logo-stuck').hide 0
        $('.nav-categories').css 'margin-top', '-23px'
        $('.nav-categories').css 'left', '210px'
        $('.search-form-stuck').hide 0
        $('.nav-user-stuck').hide 0
    else
      $('.logo-unstuck').show 0
      $('.logo-stuck').hide 0
      # $('.menu').css 'left', '-112px'
      $('.search-form-stuck').css 'right', '15px'
      $('.nav-user-stuck').css 'right', '15px'
      $('header').css 'padding-bottom', '10px'
      $('.header-content').css 'top', '55px'
      $('.nav-user-stuck').show 0
      $('.search-form-stuck').show 0

  # Hide search icon when input box is clicked (unstuck view)
  search_form_unstuck.find('input[type="search"]').focusin ->
    search_form_unstuck.find('.icon-search').hide 0
  search_form_unstuck.find('input[type="search"]').focusout ->
    search_form_unstuck.find('.icon-search').show 0

  # Toggle input box when search icon is clicked (stuck view)
  search_form_stuck.find('.icon-search').click ->
    search_form_stuck.find('input[type="search"]').toggle 'slide', {direction: 'right'}, 200

  # Code for display sub navigation on hover.
  $(".nav-main-0").hoverIntent
    over: ->
      $(".nav-subs-women").show 0
    out: ->
      unless navSubHover
        $(".nav-subs-women").hide 0
    timeout: 500
  $(".nav-main-1").hoverIntent
    over: ->
      $(".nav-subs-men").show 0
    out: ->
      $(".nav-subs-men").hide 0 unless navSubHover
    timeout: 500
  $(".nav-main-2").hoverIntent
    over: ->
      $(".nav-subs-kids").show 0
    out: ->
      $(".nav-subs-kids").hide 0 unless navSubHover
    timeout: 500
  $(".nav-main-3").hoverIntent
    over: ->
      $(".nav-main-3").css 'color', '#262626'
      $(".nav-subs-home").show 0
    out: ->
      unless navSubHover
        $(".nav-subs-home").hide 0
        $(".nav-main-3").css 'color', '#666'
    timeout: 500
  $(".nav-main-4").hoverIntent
    over: ->
      $(".nav-main-4").css 'color', '#262626'
      $(".nav-subs-lifestyle").show 0
    out: ->
      unless navSubHover
        $(".nav-subs-lifestyle").hide 0
        $(".nav-main-4").css 'color', '#666'
    timeout: 500
  $(".nav-main-5").hoverIntent
    over: ->
      $(".nav-main-5").css 'color', '#262626'
      $(".nav-subs-food").show 0
    out: ->
      $(".nav-subs-food").hide 0 unless navSubHover
      $(".nav-main-5").css 'color', '#666'
    timeout: 500
  $(".nav-main-6").hoverIntent
    over: ->
      $(".nav-main-6").css 'color', '#262626'
      $(".nav-subs-gifts").show 0
    out: ->
      $(".nav-subs-gifts").hide 0 unless navSubHover
      $(".nav-main-6").css 'color', '#666'
    timeout: 500
  $('.nav-subs').hover ( ->
    navSubHover = true
    return
  ), ->
    $('.nav-subs').hide 0
    navSubHover = false
    return


  $('.third-level-menu').hover ( ->
    innerNavHover = true
    return
  ), ->
    innerNavHover = false
    return

  $(".nav-sub").hoverIntent
    over: (e) ->
      e.stopPropagation()
      $(".nav-sub").css 'color', '#262626'
      x = $($(this)).position()
      ele = $($(this)).find('.third-level-menu')
      left = x.left + 175
      top = x.top
      $(ele).css 'left', left
      $(ele).css 'top', top
      # $(".third-level-menu-test").css 'top', '0px'
      $(".third-level-menu").hide 0
      count = $(ele).find('.third-level-menu-ul').children().length
      if count > 0
        $(ele).show 0
    out:  (e) ->
      e.stopPropagation()
      $(".third-level-menu").hide 0 unless innerNavHover
      $(".third-level-menu").css 'color', '#666'
    # timeout: 500

  # user-account-menu
  $('.user-account-menu').click ->
      x = $($(this)).position()
      top = x.top + 20
      if isMobileView()
        top = 54
      $(".user-control-menu").css 'top', top + 5
      $('.user-control-menu').slideToggle()    


  $('.accordian .level-one-li-div').click (e) ->
    if isMobileView()
      $ $(this).find('.dropdown').toggleClass 'fa-angle-up'
      $ $(this).find('.dropdown').toggleClass 'fa-angle-down'
      $('.accordian ul .level-two-ul').slideUp 'fast'
      $('.level-one-ul').find('.level-one-li').not($(this).parent()).slideToggle()
      if $(this).parent().find('.level-two-ul').is(':hidden')
        $(this).parent().find('.level-two-ul').slideDown()
        $('.level-two-ul').find('.level-two-li').not($(this)).show()
      return
    else
      e.preventDefault()



  $('.accordian .level-two-ul .level-two-li').click (e) ->
    if isMobileView()
      $ $(this).find('.dropdown-level-two').toggleClass 'fa-angle-up'
      $ $(this).find('.dropdown-level-two').toggleClass 'fa-angle-down'
      $('.accordian ul .level-three-ul').slideUp 'fast'
      $('.level-two-ul').find('.level-two-li').not($(this)).slideToggle()
      if $(this).find('.level-three-ul').is(':hidden')
        $(this).find('.level-three-ul').slideDown()
        $('.level-three-ul').find('.level-three-li').not($(this)).show()
      return
    else
      e.preventDefault()
    return


