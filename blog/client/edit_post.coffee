
Template.edit_post.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'post', FlowRouter.getParam('post_id')
        # self.subscribe 'tags', selected_type_of_post_tags.array(),"post"


# Template.edit_post.onRendered ->

Template.edit_post.helpers
    post: ->
        Docs.findOne FlowRouter.getParam('post_id')
    

        
Template.edit_post.events
    'click #delete_post': ->
        swal {
            title: 'Delete post?'
            text: 'Confirm delete?'
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


    'keydown #add_post_tag': (e,t)->
        switch e.which
            when 13
                post_id = FlowRouter.getParam('post_id')
                tag = $('#add_post_tag').val().toLowerCase().trim()
                if tag.length > 0
                    Docs.update post_id,
                        $addToSet: tags: tag
                    $('#add_post_tag').val('')

    'click .post_tag': (e,t)->
        tag = @valueOf()
        Docs.update FlowRouter.getParam('post_id'),
            $pull: tags: tag
        $('#add_post_tag').val(tag)



    'click #save_post': ->
        title = $('#title').val()
        description = $('#description').val()
        Docs.update FlowRouter.getParam('post_id'),
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

