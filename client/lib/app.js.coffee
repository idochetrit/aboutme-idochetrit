class App
  constructor: (template)->
    app = @
    ## adds the glow bar effect to menu
    $("#top_logo").lettering()

    if template
      app.placeGlowBar $("a.#{template}")
      return
      
    $("a").on 'click',  -> app.placeGlowBar $(@)
    $("#navBar ul").css 'top': '-15px', 'opacity': 0.0
    $("#navBar ul").delay(500).animate(
        {"opacity": "1",'top': '0'},
        {duration: 500, easing:"swing"})

    
    $('body').flowtype
      minimum   : 200
      maximum   : 700
      minFont   : 14
      maxFont   : 18
      fontRatio : 30
      lineRatio : 1.5
  

  placeGlowBar: (linkTag) ->
    linkTag.closest('ul').find('li').removeClass('glowbar-active')
    linkTag.closest('li').addClass('glowbar-active')
@App = App