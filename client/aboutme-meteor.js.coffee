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
  
  showPage: (page_name, aTag) ->
    $("section.mainArticles article").css 'display', 'none'
    $('article#' + page_name).fadeIn('fast')
    @placeGlowBar($(aTag))

  placeGlowBar: (linkTag) ->
    linkTag.closest('ul').find('li').removeClass('glowbar-active')
    linkTag.closest('li').addClass('glowbar-active')


Meteor.startup ->
  app = new App()  
    #'-46.875%'

if Meteor.isClient
  Template.sendEmail.events
    'submit': ->
      event.preventDefault()
      $form = $("form.contact").get(0)
      spin = new Spinner().spin($form)
      body = $form.contact_saying.value
      name = $form.contact_name.value
      email = $form.contact_email.value
      Meteor.call 'sendMessage', email, name, body, (data)->
        $("form.contact").find("input, textarea").val("")
        spin.stop()
        alert("email sent...")
        