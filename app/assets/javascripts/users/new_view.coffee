window.Loftly or= {}
window.Loftly.Users or= {}

class Loftly.Users.NewView extends Backbone.View
  el: '#preferences'

  events:
    'click .option': 'selectBedroom'

  selectBedroom: (event) ->
    @$el.find('.option').removeClass 'selected'
    $(event.currentTarget).addClass 'selected'

