# @MAIN=
#   # it is fired when the initial HTML document has been completely loaded and parsed.
#   didLoaded: ->
#     console.log 'MAIN didLoaded'

#   Main:
#     view: ->

@theme =
  default:
    bg: 'RGBA(255, 242, 211, 1)'
    txt: 'RGBA(0, 0, 0, 0.8)'
  red:
    bg: 'RGBA(255, 72, 65, 1)'
    txt: 'RGBA(255, 255, 255, 0.95)'
  blue:
    bg: 'RGBA(0, 91, 177, 1)'
    txt: 'RGBA(255, 255, 255, 0.95)'

Template.body.events
  'touchend .quote': (e)->
    e.preventDefault

    # $('.quote').text('Hello')
    # $('.author').text('h??')

  'touchend .menu': (e)->
    e.preventDefault()

    pageFromBottom('#page-settings')

  'touchend #page-settings .close': (e)->
    e.preventDefault()

    pageSlideDown('#page-main')

  'touchend #page-settings .theme-item': (e)->
    e.preventDefault()

    themeName = $(e.target).parent().attr('data-theme')

    bgColor = theme[themeName].bg
    txtColor = theme[themeName].txt

    $(e.target).css('border-radius', '50%')

    TweenMax.to $(e.target), 0.4,
      # position: 'absolute'
      borderRadius: '50%'
      # ease: Power4.easeOut
      scaleX: 15
      scaleY: 15
      clearProps: "all"
      onComplete: ->
        $('.current-page').removeClass('current-page')
        $('#page-main').addClass('current-page')


    # pageSlideDown('#page-main')

    pageMain = document.getElementById('page-main')
    quotes = document.querySelectorAll('.txt')


    pageMain.style.backgroundColor = bgColor
    for quote in quotes
      quote.style.opacity = 0
      quote.style.color = txtColor
      TweenMax.to '.quote, .menu', 0.5,
        delay: 0.4
        opacity: 1
      TweenMax.to '.author', 0.5,
        delay: 0.9
        opacity: 1
        # onComplete: ->


    # TweenMax.to pageMain, 0.5,
    #   # delay: 0.2
    #   background: bgColor

    # for quote in quotes
    #   TweenMax.to quote, 0.5,
    #     # delay: 0.2
    #     color: txtColor

Template.body.onRendered ->
  pageMain = document.getElementById('page-main')
  quotes = document.querySelectorAll('.txt')

  pageMain.style.backgroundColor = theme.default.bg
  for quote in quotes
    quote.style.color = theme.default.txt
