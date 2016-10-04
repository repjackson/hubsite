Template.edit_rental.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'doc', FlowRouter.getParam('doc_id')

Template.edit_rental.helpers
    rental: ->
        Docs.findOne FlowRouter.getParam('doc_id')
    
        
Template.edit_rental.events
    'click #save_rental': ->
        FlowRouter.go "/rental/view/#{@_id}"