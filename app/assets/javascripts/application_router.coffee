window.Loftly or= {}
window.Loftly.Users or= {}

class Loftly.ApplicationRouter extends Backbone.Router

  routes:
    'users/new(/)': 'newUser'

  newUser: ->
    new Loftly.Users.NewView
      model: new Loftly.UserModel
