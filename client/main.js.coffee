Meteor.startup ->
  $ ->
    app = new App()

Template.about.rendered = () ->
  app = new App("about");
Template.projectsList.rendered = () ->
  app = new App("projectsList");
Template.contactMe.rendered = () ->
  app = new App("contactMe");