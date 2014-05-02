# startup, header and fx singleton
class App
  constructor: ->
    @firstTime = true
  route: (template)->
    app = @

    console.log "#{template}, first?: #{@firstTime}"

    # break each header letters to classes
    $("#top-logo").lettering()

    # if this not the first launch
    if template && not @firstTime then @placeGlowBar $("a##{template}"); return;

    console.log 'startoff slide'
    # first time entering site (make a slide to the nav bar)
    $("a.nav-links").on 'click',  -> @placeGlowBar $("a#{template}")
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

    @placeGlowBar $("a##{template}")
    @firstTime = false




  placeGlowBar: (linkTag) ->
    console.log "glowing at #{linkTag[0].id}"
    linkTag.closest('ul').find('li').removeClass('glowbar-active')
    linkTag.closest('li').addClass('glowbar-active')

  parallax: (e)->
    # Deprecated
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

@app = new App()
