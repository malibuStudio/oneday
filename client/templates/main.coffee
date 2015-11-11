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

#Template.body.events
#  'touchend .quote': (e)->
#    e.preventDefault
#
#  'touchend .menu': (e)->
#    e.preventDefault()
#
#    pageFromBottom('#page-settings')
#
#  'touchend #page-settings .close': (e)->
#    e.preventDefault()
#
#    pageSlideDown('#page-main')
#
#  'touchend #page-settings .theme-item': (e)->
#    e.preventDefault()
#
#    themeName = $(e.target).parent().attr('data-theme')
#
#    bgColor = theme[themeName].bg
#    txtColor = theme[themeName].txt
#
#    $(e.target).css('border-radius', '50%')
#
#    TweenMax.to $(e.target), 0.4,
#      borderRadius: '50%'
#      scaleX: 15
#      scaleY: 15
#      clearProps: "all"
#      onComplete: ->
#        $('.current-page').removeClass('current-page')
#        $('#page-main').addClass('current-page')
#
#
#    pageMain = document.getElementById('page-main')
#    quotes = document.querySelectorAll('.txt')
#
#
#    pageMain.style.backgroundColor = bgColor
#    for quote in quotes
#      quote.style.opacity = 0
#      quote.style.color = txtColor
#      TweenMax.to '.quote, .menu', 0.5,
#        delay: 0.4
#        opacity: 1
#      TweenMax.to '.author', 0.5,
#        delay: 0.9
#        opacity: 1

@mcom=
  onMenuDown: (e)->
    e.preventDefault()
    pageFromBottom '#page-settings'
  onMenuHandler:
    onmouseup: (e)-> mcom.onMenuDown(e)
    ontouchend: (e)-> mcom.onMenuDown(e)
  onCloseDown: (e)->
    e.preventDefault()
    pageSlideDown '#page-main'
  onCloseHandler:
    onmouseup: (e)-> mcom.onCloseDown(e)
    ontouchend: (e)-> mcom.onCloseDown(e)
  onThemeItemDown: (e)->
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
  onThemeItemHandler:
    onmouseup: (e)-> mcom.onThemeItemDown(e)
    ontouchend: (e)-> mcom.onThemeItemDown(e)

  Main:
    view: ->
      m '[id=\'viewport\']',
        m '.page.current-page[id=\'page-main\']',
          m '.menu.txt', mcom.onMenuHandler,
            m '.wrapper',
              m 'i.ion-ios-gear-outline'
          m '.quote-wrapper',
            m '.quote.txt', m.trust "서두르지 말라. <br/> 그러나 쉬지도 말라."
            m '.author.txt', '- 누군가가'
        m '.page[id=\'page-settings\']',
          m '.close', mcom.onCloseHandler,
            m 'i.ion-ios-close-empty'
          m '.settings-container',
            m '.theme-container',
              m '.settings-title', '테마선택'
              m '.theme-list',
                m '.theme-item[data-theme=\'default\']',
                  m '.theme-thumb.default'
                m '.theme-item[data-theme=\'red\']',
                  m '.theme-thumb.red'
                m '.theme-item[data-theme=\'blue\']',
                  m '.theme-thumb.blue'

Meteor.startup ->
  m.mount document.body, mcom.Main
  pageMain = document.getElementById('page-main')
  quotes = document.querySelectorAll('.txt')
  pageMain.style.backgroundColor = theme.default.bg
  for quote in quotes
    quote.style.color = theme.default.txt
