class App
  constructor: (template)->
    app = @
    ## adds the glow bar effect to menu
    $("#top-logo").lettering() 

    if template
      app.placeGlowBar $("a##{template}")
      return
    
    $("a.nav-links").on 'click',  -> app.placeGlowBar $(@)
    $(".nav-bar ul").css 'top': '-15px', 'opacity': 0.0
    $(".nav-bar ul").delay(500).animate(
        {"opacity": "1",'top': '0'},
        {duration: 500, easing:"swing"})
    
    # if window.DeviceOrientationEvent
    #   window.addEventListener('deviceorientation', app.parallax ,false)
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

  parallax: (e)->
    background = $("body").get 0
    beta = e.beta;
    gamma = e.gamma;
    pad = 80;
    
    if gamma > 90 then gamma = 180 - gamma;
    if gamma < -90 then gamma = -180 - gamma;
    
    yTilt = Math.round(-beta/180 * pad);
    xTilt = Math.round(-gamma/180 * pad);

    position = 'translate3d(' + xTilt + 'px, ' + yTilt + 'px, ' + pad + 'px)';
    background.style.transform = position;
    background.style.webkitTransform = position;

@App = App