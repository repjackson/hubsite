
Template.edit_post.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'post', FlowRouter.getParam('post_id')

Template.edit_post.helpers
    post: ->
        Posts.findOne FlowRouter.getParam('post_id')
    
        
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
            Meteor.call 'delete_post', FlowRouter.getParam('post_id'), (error, result) ->
                if error
                    console.error error.reason
                else
                    FlowRouter.go '/posts'


    'change [name="upload_picture"]': (event, template) ->
        post_id = FlowRouter.getParam('post_id')
        # template.uploading.set true
        console.log event.target.files
        uploader = new (Slingshot.Upload)('myFileUploads')
        uploader.send event.target.files[0], (error, download_url) ->
            if error
                # Log service detailed response.
                console.error 'Error uploading', uploader.xhr.response
                console.error 'Error uploading', error
                alert error
            else
                Meteor.users.update Meteor.userId(), $push: 'profile.files': download_url
                Posts.update post_id, $set: featured_image_url: download_url
            return
            
            
    'click #remove_photo': ->
        Posts.update FlowRouter.getParam('post_id'), 
            $unset: featured_image_url: 1
            

    'keydown #add_post_tag': (e,t)->
        if e.which is 13
            post_id = FlowRouter.getParam('post_id')
            tag = $('#add_post_tag').val().toLowerCase().trim()
            if tag.length > 0
                Posts.update post_id,
                    $addToSet: tags: tag
                $('#add_post_tag').val('')

    'click .post_tag': (e,t)->
        tag = @valueOf()
        Posts.update FlowRouter.getParam('post_id'),
            $pull: tags: tag
        $('#add_post_tag').val(tag)



    'click #save_post': ->
        title = $('#title').val()
        description = $('#description').val()
        Posts.update FlowRouter.getParam('post_id'),
            $set:
                description: description
                title: title
                # tagCount: @tags.length
        selected_post_tags.clear()
        for tag in @tags
            selected_post_tags.push tag
        FlowRouter.go '/posts'




Template.edit_post.onRendered ->
    Meteor.setTimeout (->
        $('#description').froalaEditor
            heightMin: 200
            # toolbarInline: true
            # toolbarButtonsMD: ['bold', 'italic', 'fontSize', 'undo', 'redo', '|', 'insertImage', 'insertVideo','insertFile']
            # toolbarButtonsSM: ['bold', 'italic', 'fontSize', 'undo', 'redo', '|', 'insertImage', 'insertVideo','insertFile']
            # toolbarButtonsXS: ['bold', 'italic', 'fontSize', 'undo', 'redo', '|', 'insertImage', 'insertVideo','insertFile']
            toolbarButtons: 
                [
                  'fullscreen'
                  'bold'
                  'italic'
                  'underline'
                  'strikeThrough'
                  'subscript'
                  'superscript'
                #   'fontFamily'
                #   'fontSize'
                  '|'
                  'color'
                  'emoticons'
                #   'inlineStyle'
                #   'paragraphStyle'
                  '|'
                  'paragraphFormat'
                  'align'
                  'formatOL'
                  'formatUL'
                  'outdent'
                  'indent'
                  'quote'
                  'insertHR'
                  '-'
                  'insertLink'
                  'insertImage'
                  'insertVideo'
                  'insertFile'
                  'insertTable'
                  'undo'
                  'redo'
                  'clearFormatting'
                  'selectAll'
                  'html'
                ]
        ), 500

