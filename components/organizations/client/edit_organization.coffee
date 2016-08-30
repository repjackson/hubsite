Template.edit_organization.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'doc', FlowRouter.getParam('doc_id')


Template.edit_organization.helpers
    organization: ->
        Docs.findOne FlowRouter.getParam('doc_id')
    

        
        
Template.edit_organization.events
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
        # selected_tags.clear()
        # for tag in @tags
        #     selected_tags.push tag
        FlowRouter.go "/organization/view/#{@_id}"





