
Template.edit_post.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'doc', FlowRouter.getParam('doc_id')

Template.edit_post.helpers
    post: ->
        Docs.findOne FlowRouter.getParam('doc_id')
    
        
Template.edit_post.events
    'click #delete_post': ->
        swal {
            title: 'Delete post?'
            # text: 'Confirm delete?'
            type: 'error'
            showCancelButton: true
            closeOnConfirm: true
            cancelButtonText: 'No'
            confirmButtonText: 'Delete'
            confirmButtonColor: '#da5347'
        }, ->
            Meteor.call 'delete_post', FlowRouter.getParam('doc_id'), (error, result) ->
                if error
                    console.error error.reason
                else
                    FlowRouter.go '/posts'


    'click #save_post': ->
        title = $('#title').val()
        publish_date = $('#publish_date').val()
        description = $('#description').val()
        Docs.update FlowRouter.getParam('doc_id'),
            $set:
                title: title
                publish_date: publish_date
                description: description
                # tagCount: @tags.length
        selected_tags.clear()
        for tag in @tags
            selected_tags.push tag
        FlowRouter.go '/posts'
