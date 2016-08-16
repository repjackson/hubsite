Template.edit_organization.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'organization', FlowRouter.getParam('doc_id')
        # self.subscribe 'tags', selected_type_of_organization_tags.array(),"organization"


# Template.edit_organization.onRendered ->

Template.edit_organization.helpers
    organization: ->
        # docId = FlowRouter.getParam('doc_id')
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

    'keydown #add_organization_tag': (e,t)->
        if e.which is 13
            doc_id = FlowRouter.getParam('doc_id')
            tag = $('#add_organization_tag').val().toLowerCase().trim()
            if tag.length > 0
                Docs.update doc_id,
                    $addToSet: tags: tag
                $('#add_organization_tag').val('')

    'click .organization_tag': (e,t)->
        organization = Docs.findOne FlowRouter.getParam('doc_id')
        tag = @valueOf()
        if tag is organization.type
            Docs.update FlowRouter.getParam('doc_id'),
                $set: type: ''
        Docs.update FlowRouter.getParam('doc_id'),
            $pull: tags: tag
        $('#add_organization_tag').val(tag)



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

