
Template.header.rendered = ->
  Deps.autorun ->
    current_template = Router.current() && Router.current().route.name
    app.route(current_template || 'about')
