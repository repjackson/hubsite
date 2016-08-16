
Template.edit_service.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'service', FlowRouter.getParam('service_id')

Template.edit_service.helpers
    service: ->
        Services.findOne FlowRouter.getParam('service_id')
    
        
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
            Meteor.call 'delete_service', FlowRouter.getParam('service_id'), (error, result) ->
                if error
                    console.error error.reason
                else
                    FlowRouter.go '/services'


    'change [name="upload_picture"]': (event, template) ->
        service_id = FlowRouter.getParam('service_id')
        # template.uploading.set true
        ##console.log event.target.files
        uploader = new (Slingshot.Upload)('myFileUploads')
        uploader.send event.target.files[0], (error, download_url) ->
            if error
                # Log service detailed response.
                console.error 'Error uploading', uploader.xhr.response
                console.error 'Error uploading', error
                alert error
            else
                Meteor.users.update Meteor.userId(), $push: 'profile.files': download_url
                Services.update service_id, $set: featured_image_url: download_url
            return
            
            
    'click #remove_photo': ->
        Services.update FlowRouter.getParam('service_id'), 
            $unset: featured_image_url: 1
            

    'keydown #add_service_tag': (e,t)->
        if e.which is 13
            service_id = FlowRouter.getParam('service_id')
            tag = $('#add_service_tag').val().toLowerCase().trim()
            if tag.length > 0
                Services.update service_id,
                    $addToSet: tags: tag
                $('#add_service_tag').val('')

    'click .service_tag': (e,t)->
        tag = @valueOf()
        Services.update FlowRouter.getParam('service_id'),
            $pull: tags: tag
        $('#add_service_tag').val(tag)



    'click #save_service': ->
        title = $('#title').val()
        description = $('#description').val()
        price = $('#price').val()
        Services.update FlowRouter.getParam('service_id'),
            $set:
                title: title
                description: description
                price: price
                # tagCount: @tags.length
        selected_service_tags.clear()
        for tag in @tags
            selected_service_tags.push tag
        FlowRouter.go '/services'




Template.edit_service.onRendered ->
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
