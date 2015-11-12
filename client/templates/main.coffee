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

Template.body.events
  'touchend .quote-wrapper.active': (e)->
    e.preventDefault

    activeQuote = $(e.target)
    nextQuote = $(e.target).next()

    console.log 'activeQuote', activeQuote
    console.log 'nextQuote', nextQuote

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
