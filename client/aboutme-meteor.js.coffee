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
    'submit form.contact': ->
      event.preventDefault()
      $form = $("form.contact")
      spin = new Spinner().spin($("section.mainArticles").get(0))
      $form.closest("article").css("opacity", 0.3)
      body = $form.get(0).contact_saying.value
      name = $form.get(0).contact_name.value
      email = $form.get(0).contact_email.value
      unless body || name || email then return
      Meteor.call 'sendMessage', email, name, body, (data)->
        send = $form.find("#send")
        $form.find("input, textarea").val("")
        send.html('Sent! ').append('<i class="icon-ok" />')
        $form.closest("article").css("opacity", 1.0)
        $form.on 'keypress', 'input, textarea', ->
          send.html("Send").find('i').remove()
          $form.off 'keypress'

        spin.stop()
        # alert("email sent...")
        