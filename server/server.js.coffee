Meteor.startup ->
  # sets smtp conf
  process.env.MAIL_URL = 'smtp://postmaster%40idochetrit.me:idomuse6@smtp.mailgun.org:587';

Meteor.methods
  # method that send mail with the details...
  'sendMessage': (email, name, body)->
    Email.send
      from: email
      to: "idochetrit.dev@gmail.com"
      replyTo: email || undefined
      subject: "idochetrit.me: #{name} sent you this with email (#{email})!"
      text: body
