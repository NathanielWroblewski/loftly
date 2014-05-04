window.Loftly or= {}

class Loftly.UserModel extends Backbone.Model
  defaults:
    bedrooms: '1'

  urlRoot: '/users'
