class App
  constructor: ->
    app = @
    ## adds the glow bar effect to menu
    $("#navBar ul").css({ 'top': '-15px', "opacity": "0" })
    $("#top_logo").lettering()
    $("#navBar ul").delay(500).animate({
        "opacity": "1",
        'top': '0'}, {duration: 500, easing:"swing"})
    $('section.mainArticles article[id!="homePage"]').css 'display', 'none'
    setTimeout (-> app.placeGlowBar($("a#homeLink"))), 500

    $("a#homeLink").on('click',  -> app.showPage('homePage', @))
    $("a#stuffLink").on('click',  -> app.showPage('stuffPage', @))
    $("a#contactLink").on('click', -> app.showPage('contactPage', @))
    $('body').flowtype
      minimum   : 200
      maximum   : 700
      minFont   : 14
      maxFont   : 18
      fontRatio : 30
      lineRatio : 1.5
  
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

      # pre-send effect conf
      $(".control-group.error").removeClass "error"
      $form = $("form.contact")
      spin = new Spinner().spin($("section.mainArticles").get(0))
      $form.closest("article").css("opacity", 0.3)

      # gather form info for sending to server
      body = $form.get(0).contact_saying.value
      name = $form.get(0).contact_name.value
      email = $form.get(0).contact_email.value

      ## validations for iOS and non-html5 browsers
      unless body && name && email 
        $form.closest("article").css("opacity", 1.0)
        $("input[value=], textarea[value=]")
          .closest(".control-group").addClass('error')
        alert("All fields are required!")
        spin.stop()
        return

      # CALL: meteor server `sendMessage` method with the form info
      Meteor.call 'sendMessage', email, name, body, (data)->
        #restor to normal state (clear form, add indication and stop spin)
        $form.closest("article").css("opacity", 1.0)
        spin.stop()
        
        # if error occurred...
        if data 
          alert("error occurred \n Please check your details maybe it's not an email there...")
          return  
        send = $form.find("#send")
        $form.find("input, textarea").val("")
        send.html('Sent! ').append('<i class="icon-ok" />')
        # indication of sent mail stays untill next press...
        $form.on 'keypress', 'input, textarea', ->
          send.html("Send").find('i').remove()
          $form.off 'keypress'
        # alert("email sent...")
        