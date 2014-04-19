window.Loftly or= {}
window.Loftly.Users or= {}

class Loftly.Users.NewView extends Backbone.View
  template: JST['users/preferences']

  initialize: ->
    @listenTo @model, 'change', @render

  el: '#preferences'

  events:
    'click .option': 'selectBedroom'
    'change input.price': 'setPrice'

  selectBedroom: (event) ->
    @model.set 'bedrooms', $(event.currentTarget).data('bedrooms')

  setPrice: (event) ->
    $field = $(event.currentTarget)
    minOrMax = $field.data 'price'
    @model.set minOrMax + 'Price', $field.val()

  highlightSelectedBedroom: ->
    beds = @model.get('bedrooms')
    @$el.find('.option[data-bedrooms=' + beds + ']').addClass 'selected'

  render: ->
    @$el.html @template(@model.attributes)
    @hightlightSelectedBedroom()
    @
