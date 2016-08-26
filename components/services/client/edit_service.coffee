
Template.edit_service.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'doc', FlowRouter.getParam('doc_id')

Template.edit_service.helpers
    service: ->
        Docs.findOne FlowRouter.getParam('doc_id')
    
        
Template.edit_service.events
    'click #save_service': ->
        title = $('#title').val()
        description = $('#description').val()
        price = $('#price').val()
        Docs.update FlowRouter.getParam('doc_id'),
            $set:
                title: title
                description: description
                price: price
                # tagCount: @tags.length
        selected_tags.clear()
        for tag in @tags
            selected_tags.push tag
        FlowRouter.go '/services'
