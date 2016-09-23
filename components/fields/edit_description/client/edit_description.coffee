# Template.edit_description.events
#     "blur #description": (e) ->
#         doc_id = FlowRouter.getParam('doc_id')
#         description = $('#description').val()

#         Docs.update doc_id,
#             description: description



# Template.edit_description.onRendered ->
#     Meteor.setTimeout (->
#         $('#description').froalaEditor
#             heightMin: 200
#             # toolbarInline: true
#             # toolbarButtonsMD: ['bold', 'italic', 'fontSize', 'undo', 'redo', '|', 'insertImage', 'insertVideo','insertFile']
#             # toolbarButtonsSM: ['bold', 'italic', 'fontSize', 'undo', 'redo', '|', 'insertImage', 'insertVideo','insertFile']
#             # toolbarButtonsXS: ['bold', 'italic', 'fontSize', 'undo', 'redo', '|', 'insertImage', 'insertVideo','insertFile']
#             toolbarButtons: 
#                 [
#                   'fullscreen'
#                   'bold'
#                   'italic'
#                   'underline'
#                   'strikeThrough'
#                   'subscript'
#                   'superscript'
#                 #   'fontFamily'
#                 #   'fontSize'
#                   '|'
#                   'color'
#                   'emoticons'
#                 #   'inlineStyle'
#                 #   'paragraphStyle'
#                   '|'
#                   'paragraphFormat'
#                   'align'
#                   'formatOL'
#                   'formatUL'
#                   'outdent'
#                   'indent'
#                   'quote'
#                   'insertHR'
#                   '-'
#                   'insertLink'
#                   'insertImage'
#                   'insertVideo'
#                   'insertFile'
#                   'insertTable'
#                   'undo'
#                   'redo'
#                   'clearFormatting'
#                   'selectAll'
#                   'html'
#                 ]
#         ), 5000


Template.edit_description.helpers
    getFEContext: ->
        @current_doc = Docs.findOne FlowRouter.getParam('doc_id')
        self = @
        {
            _value: self.current_doc.description
            _keepMarkers: true
            _className: 'froala-reactive-meteorized-override'
            toolbarInline: true
            initOnClick: false
            tabSpaces: false
            '_onsave.before': (e, editor) ->
                # Get edited HTML from Froala-Editor
                newHTML = editor.html.get(true)
                # Do something to update the edited value provided by the Froala-Editor plugin, if it has changed:
                if !_.isEqual(newHTML, self.current_doc.description)
                    console.log 'onSave HTML is :' + newHTML
                    myCollection.update { _id: self.current_doc._id }, $set: description: newHTML
                false
                # Stop Froala Editor from POSTing to the Save URL
        }
