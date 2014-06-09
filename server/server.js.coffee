Meteor.startup ->
  # sets new relic
  require('newrelic');


Meteor.methods
  # method that send mail with the details...
  'sendMessage': (email, name, body)->
    Email.send
      from: email
      to: "idochetrit.dev@gmail.com"
      replyTo: email || undefined
      subject: "idochetrit.me: #{name} sent you this with email (#{email})!"
      text: body
