@Quotes = [
  {
    quote: '"서두르지 말라. <br/> 그러나 쉬지도 말라."'
    author: '- 누군가가'
  }
  {
    quote: '"밥먹자. 배고프다"'
    author: '- 누군가가'
  }
]


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

############################################
# HAMMER JS
############################################
# Template.body.swipe = (e, d)->
#   activeQuote = $(e.target)
#   console.log d
#   if d is 1
#     nextQuote = $(e.target).next()
#     nextQuote.css(
#       'left': '100%'
#       'z-index': 999
#     )
#     xdir = '-100%'
#     if nextQuote.length is 0
#       nextQuote = $('.quote-wrapper:first')
#   else
#     nextQuote = $(e.target).prev()
#     nextQuote.css(
#       'left': 0
#       'z-index': 999
#     )
#     xdir = '100%'
#     if nextQuote.length is 0
#       nextQuote = $('.quote-wrapper:last')

#   console.log 'activeQuote', activeQuote
#   console.log 'nextQuote', nextQuote




#   TweenMax.to activeQuote, 0.31,
#     x: xdir
#     opacity: 0
#     clearProps: 'all'
#     ease: Power4.easeOut
#     onComplete: ->
#       activeQuote.removeClass('active')

#   TweenMax.to nextQuote, 0.31,
#     left: '50%'
#     opacity: 1
#     clearProps: 'all'
#     ease: Power4.easeIn
#     onComplete: ->
#       nextQuote.addClass('active')

# Template.body.helpers
#   swipeH:
#     'swiperight .quote-wrapper.active': (e, tmpl)->
#       e.preventDefault()
#       console.log 'Swipe Right'
#       tmpl.view.template.swipe e, -1

#     'swipeleft .quote-wrapper.active': (e, tmpl)->
#       e.preventDefault()
#       console.log 'Swipe Left'
#       tmpl.view.template.swipe e, 1
#       console.log e
############################################
# END HAMMER JS
############################################

@touchstart =
    x: 0
    y: 0

Template.body.events
  'touchstart .quote-wrapper.active': (e)->
    touchstart.x = e.originalEvent.touches[0].pageX
    touchstart.y = e.originalEvent.touches[0].pageY

  'touchmove .quote-wrapper.active': (e)->
    e.preventDefault
    touch = e.originalEvent.touches[0]

    activeQuote = $(e.target)
    # activeQuote.css('left', touch.clientX + 'px')
    TweenMax.to activeQuote, 0.05,
      left: touch.clientX + 'px'


  'touchend .quote-wrapper.active': (e)->
    e.preventDefault

    touchend =
      x: e.originalEvent.changedTouches[0].pageX
      y: e.originalEvent.changedTouches[0].pageY


    activeQuote = $(e.target)

    if touchstart.x >= $(window).width()/2.25 and touchstart.x > touchend.x
      # Swipe Left
      nextQuote = $(e.target).next()

      if nextQuote.length is 0
        nextQuote = $('.quote-wrapper:first')

      nextQuote.css(
        'left': '100%'
        'z-index': 999
      )

      TweenMax.to activeQuote, 0.31,
        x: '-100%'
        opacity: 0
        clearProps: 'all'
        ease: Power4.easeOut
        onComplete: ->
          activeQuote.removeClass('active')

      TweenMax.to nextQuote, 0.31,
        left: '50%'
        opacity: 1
        clearProps: 'all'
        ease: Power4.easeIn
        onComplete: ->
          nextQuote.addClass('active')

    else if touchstart.x <= $(window).width()/2.25 and touchstart.x < touchend.x
      # Swipe Right
      nextQuote = $(e.target).prev('.quote-wrapper')

      if nextQuote.length is 0
        console.log 'none'
        nextQuote = $('.quote-wrapper:last')

      nextQuote.css(
        'left': '0'
        'z-index': 999
      )

      TweenMax.to activeQuote, 0.31,
        x: '100%'
        opacity: 0
        clearProps: 'all'
        ease: Power4.easeOut
        onComplete: ->
          activeQuote.removeClass('active')

      TweenMax.to nextQuote, 0.31,
        left: '50%'
        opacity: 1
        clearProps: 'all'
        ease: Power4.easeIn
        onComplete: ->
          nextQuote.addClass('active')

    else
      console.log 'revert'
      TweenMax.to activeQuote, 0.05,
        left: '50%'



  'touchend .menu': (e)->
    e.preventDefault()

    pageFromBottom('#page-settings')

  'touchend #page-settings .close': (e)->
    e.preventDefault()

    pageSlideDown('#page-main')
  'touchstart #page-settings .theme-item': (e)->
    TweenMax.to $(e.target), 0.32,
      borderRadius: '50%'
      scaleX: 0.8
      scaleY: 0.8
      ease: Bounce.easeOut
      # clearProps: "all"

  'touchend #page-settings .theme-item': (e)->
    e.preventDefault()

    themeName = $(e.target).parent().attr('data-theme')

    bgColor = theme[themeName].bg
    txtColor = theme[themeName].txt

    $(e.target).css('border-radius', '50%')

    TweenMax.to $(e.target), 0.4,
      borderRadius: '50%'
      scaleX: 15
      scaleY: 15
      clearProps: "all"
      onComplete: ->
        $('.current-page').removeClass('current-page')
        $('#page-main').addClass('current-page')


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

Template.body.onRendered ->
  pageMain = document.getElementById('page-main')
  quotes = document.querySelectorAll('.txt')

  pageMain.style.backgroundColor = theme.default.bg
  for quote in quotes
    quote.style.color = theme.default.txt
