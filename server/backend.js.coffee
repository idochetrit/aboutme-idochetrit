Meteor.startup ->
  # sets smtp conf
  process.env.MAIL_URL = 'smtp://postmaster%40app17641980.mailgun.org:60whspzn8j44@smtp.mailgun.org:587';
Meteor.methods
  # method that send mail with the details...
  'sendMessage': (email, name, body)->
    if Meteor.isServer
      Email.send
        # from: "postmaster@app17641980.mailgun.org"
        from: email
        to: "idochetrit.dev@gmail.com"
        replyTo: email || undefined
        subject: "idochetrit.me: #{name} sent you this with email (#{email})!"
        text: body