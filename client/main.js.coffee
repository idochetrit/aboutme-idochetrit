Meteor.methods
  'sendMessage': (email, name, body) ->
    if Meteor.isSimulation then return true