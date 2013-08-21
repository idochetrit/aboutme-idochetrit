if Meteor.isServer
  Meteor.startup ->
    process.env.MAIL_URL = 'smtp://postmaster%40app17641980.mailgun.org:60whspzn8j44@smtp.mailgun.org:587';
  Meteor.methods
    'sendMessage': (email, name, body)->
        Email.send
          from: email
          to: "idochetrit.dev@gmail.com"
          replyTo: email || undefined
          subject: "idochetrit.me: #{name} sent you this email !"
          text: body + "\n" + Meteor.absoluteUrl() 
