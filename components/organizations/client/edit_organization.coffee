Template.edit_organization.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'organization', FlowRouter.getParam('organization_id')
        # self.subscribe 'tags', selected_type_of_organization_tags.array(),"organization"


# Template.edit_organization.onRendered ->

Template.edit_organization.helpers
    organization: ->
        # docId = FlowRouter.getParam('organization_id')
        Organizations.findOne FlowRouter.getParam('organization_id')
    

        
        
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
            Meteor.call 'delete_organization', FlowRouter.getParam('organization_id'), (error, result) ->
                if error
                    console.error error.reason
                else
                    FlowRouter.go '/organizations'

    'change [name="upload_picture"]': (organization, template) ->
        organization_id = FlowRouter.getParam('organization_id')
        # template.uploading.set true
        console.log organization.target.files
        uploader = new (Slingshot.Upload)('myFileUploads')
        uploader.send organization.target.files[0], (error, download_url) ->
            if error
                # Log service detailed response.
                # console.error 'Error uploading', uploader.xhr.response
                console.error 'Error uploading', error
                alert error
            else
                Meteor.users.update Meteor.userId(), $push: 'profile.files': download_url
                Organizations.update organization_id, $set: featured_image_url: download_url
            return


    'click #remove_photo': ->
        Organizations.update FlowRouter.getParam('organization_id'), 
            $unset: featured_image_url: 1



    'keydown #add_organization_tag': (e,t)->
        if e.which is 13
            organization_id = FlowRouter.getParam('organization_id')
            tag = $('#add_organization_tag').val().toLowerCase().trim()
            if tag.length > 0
                Organizations.update organization_id,
                    $addToSet: tags: tag
                $('#add_organization_tag').val('')

    'click .organization_tag': (e,t)->
        organization = Organizations.findOne FlowRouter.getParam('organization_id')
        tag = @valueOf()
        if tag is organization.type
            Organizations.update FlowRouter.getParam('organization_id'),
                $set: type: ''
        Organizations.update FlowRouter.getParam('organization_id'),
            $pull: tags: tag
        $('#add_organization_tag').val(tag)



    'click #save_organization': ->
        title = $('#title').val()
        link = $('#link').val()
        description = $('#description').val()
        Organizations.update FlowRouter.getParam('organization_id'),
            $set:
                title: title
                link: link
                description: description
                # tagCount: @tags.length
        selected_organization_tags.clear()
        for tag in @tags
            selected_organization_tags.push tag
        FlowRouter.go '/organizations'





Template.edit_organization.onRendered ->
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

