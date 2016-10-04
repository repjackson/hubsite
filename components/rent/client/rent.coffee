Template.rent.onCreated ->
    @autorun -> Meteor.subscribe('rentals')


Template.rent.onRendered ->
    $('#rent_slider').layerSlider
        autoStart: true
        # firstLayer: 2
        # skin: 'borderlesslight'
        # skinsPath: '/static/layerslider/skins/'
    
Template.rent.helpers
    rentals: -> 
        Docs.find {
            type: 'rental'
            }
            
Template.rent.events
    'click #add_rental': ->
        id = Docs.insert
            type: 'rental'
        FlowRouter.go "/rental/edit/#{id}"

    'click .launch-modal': ->
        $('.ui.modal').modal('show')

