window.Loftly or= {}

class Loftly.UserModel extends Backbone.Model
  defaults:
    bedrooms: '1'

  urlRoot: '/users'

  validate: ->
    'Invalid email.' if @get('email').length < 1
