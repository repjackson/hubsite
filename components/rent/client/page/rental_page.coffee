Template.rental_page.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'doc', FlowRouter.getParam('doc_id')



Template.rental_page.helpers
    rental: ->
        Docs.findOne FlowRouter.getParam('doc_id')


Template.rental_page.events
    'click .edit_rental': ->
        FlowRouter.go "/rental/edit/#{@_id}"
