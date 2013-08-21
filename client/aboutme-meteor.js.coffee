class App
  constructor: ->
    app = @
    $("#navBar ul").css({ 'top': '-15px', "opacity": "0" })
    $("#top_logo").lettering()
    $("#navBar ul").delay(250).animate({
        "opacity": "1",
        'top': '0'}, {duration: 350, easing:"swing"})
    $('section.mainArticles article[id!="homePage"]').css 'display', 'none'
    setTimeout (-> app.placeGlowBar($("a#homeLink"))), 500

    $("a#homeLink").on('click',  -> app.showPage('homePage', @))
    $("a#stuffLink").on('click',  -> app.showPage('stuffPage', @))
    $("a#contactLink").on('click', -> app.showPage('contactPage', @))
    $("form").submit (e)->
      $form = $(@)
      e.preventDefault()
      app.sendContact($form)
  
  showPage: (page_name, aTag) ->
    $("section.mainArticles article").css 'display', 'none'
    $('article#' + page_name).fadeIn('fast')
    @placeGlowBar($(aTag))

  placeGlowBar: (linkTag) ->
    linkTag.closest('ul').find('li').removeClass('glowbar-active')
    linkTag.closest('li').addClass('glowbar-active')

  sendContact: (form)->
    # alert(form.serialize())
    alert("Your request sent")


Meteor.startup ->
  app = new App()
  #'-46.875%'