
Template.edit_service.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'service', FlowRouter.getParam('doc_id')

Template.edit_service.helpers
    service: ->
        Docs.findOne FlowRouter.getParam('doc_id')
    
        
Template.edit_service.events
    'click #delete_service': ->
        swal {
            title: 'Delete service?'
            # text: 'Confirm delete?'
            type: 'error'
            showCancelButton: true
            closeOnConfirm: true
            cancelButtonText: 'No'
            confirmButtonText: 'Delete'
            confirmButtonColor: '#da5347'
        }, ->
            Meteor.call 'delete_service', FlowRouter.getParam('doc_id'), (error, result) ->
                if error
                    console.error error.reason
                else
                    FlowRouter.go '/services'


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
        selected_service_tags.clear()
        for tag in @tags
            selected_service_tags.push tag
        FlowRouter.go '/services'
