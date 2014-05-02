Router.configure
  layoutTemplate: 'layout'
Router.map ->
  @route 'about', path: '/'
  @route 'projectsList', path: '/projects'
  @route 'contactMe', path: '/contact_me'
