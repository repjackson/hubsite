Template.edit_organization.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'organization', FlowRouter.getParam('doc_id')


Template.edit_organization.helpers
    organization: ->
        Docs.findOne FlowRouter.getParam('doc_id')
    

        
        
Template.edit_organization.events
    'click #delete_organization': ->
        swal {
            title: 'Delete organization?'
            text: 'Confirm delete?'
            type: 'error'
            showCancelButton: true
            closeOnConfirm: true
            cancelButtonText: 'No'
            confirmButtonText: 'Delete'
            confirmButtonColor: '#da5347'
        }, ->
            Meteor.call 'delete_organization', FlowRouter.getParam('doc_id'), (error, result) ->
                if error
                    console.error error.reason
                else
                    FlowRouter.go '/organizations'




    'click #save_organization': ->
        title = $('#title').val()
        link = $('#link').val()
        description = $('#description').val()
        Docs.update FlowRouter.getParam('doc_id'),
            $set:
                title: title
                link: link
                description: description
                # tagCount: @tags.length
        selected_organization_tags.clear()
        for tag in @tags
            selected_organization_tags.push tag
        FlowRouter.go '/organizations'





