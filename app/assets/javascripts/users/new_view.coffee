window.Loftly or= {}
window.Loftly.Users or= {}

class Loftly.Users.NewView extends Backbone.View
  el: '#preferences'

  events:
    'click .option': 'selectBedroom'
    'change input.price': 'setPrice'
    'change #send-intro-input': 'toggleIntro'
    'click .continue': 'continue'

  selectBedroom: (event) ->
    @model.set 'bedrooms', $(event.currentTarget).data('bedrooms')
    @highlightSelectedBedroom()

  setPrice: (event) ->
    $field = $(event.currentTarget)
    minOrMax = $field.data 'price'
    @model.set minOrMax + '_price', $field.val()

  highlightSelectedBedroom: ->
    @$el.find('.option').removeClass 'selected'
    beds = @model.get('bedrooms')
    @$el.find('.option[data-bedrooms=' + beds + ']').addClass 'selected'

  toggleIntro: ->
    @$('textarea').prop 'disabled', !@$('textarea').prop('disabled')

  continue: ->
    if @onLastSlide() then @submit() else @$('.orbit-next').click()

  onLastSlide: ->
    @$('ul[data-orbit] li').last().hasClass 'active'

  submit: ->
    @model.set
      email: @$('#email').val()
      intro: @$('textarea').val()
    @emailInvalid() unless @model.save(@model.attributes,
      success: (model, response) =>
        @model.set 'slug', response.user.slug
        @complete()
      error: =>
        @emailInvalid()
    )

  emailInvalid: ->
    @$('.errors').show()
    @$('.email-label').css
      'background-color': 'red'
      'color': 'white'

  complete: ->
    if slug = @model.get 'slug'
      $complete = @$('#complete')
      url = $complete.prop('href').replace 'users', 'users/' + slug + '/edit'
      $complete.prop 'href', url
      $complete[0].click()
