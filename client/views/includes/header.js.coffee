Meteor.startup () ->
  app = new App()

Template.header.rendered = () ->
  app = new App(Meteor.Router._page)