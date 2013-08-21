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
    # $("form").submit (e)->
    #   $form = $(@)
    #   e.preventDefault()
    #   app.sendContact($form)
  
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
    
if Meteor.isServer 
  Meteor.startup ->
    process.env.MAIL_URL = 'smtp://postmaster%40idochetrit.me:idomuse6@smtp.mailgun.org:587';
sendMessage = (email, name, body)->
  Email.send
    from: email
    to: "idochetrit.dev@gmail.com"
    replyTo: email || undefined
    subject: "idochetrit.me: #{name} sent you this email !"
    text: body + "\n" + Meteor.absoluteUrl()

Meteor.methods
  'sendMessage': (e, n, b)->
    if (Meteor.isServer)
      sendMessage(e, n, b) 

if Meteor.isClient 
  Meteor.startup ->
    app = new App()  
    #'-46.875%'

if Meteor.isClient
  Template.sendEmail.events
    'submit': ->
      event.preventDefault()
      alert("Mail sent !")
      body = $("#contact_saying").val()
      name = $("#contact_name").val()
      email = $("#contact_email").val()
      Meteor.call('sendMessage', email, name, body)



