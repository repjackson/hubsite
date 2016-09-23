Template.edit_description.events
    'click #save_description': (e,t)->
        html = t.$('div.froala-reactive-meteorized-override').froalaEditor('html.get', true)
        doc_id = FlowRouter.getParam('doc_id')

        Docs.update doc_id,
            $set: description: html

# Template.edit_description.onRendered ->
#     tmpl = this
#     html = tmpl.$('div.froala-reactive-meteorized').froalaEditor('html.get', true)
#     console.log @
#     console.log html
#     return

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
            toolbarInline: false
            initOnClick: false
            tabSpaces: false
            height: 300
            '_onsave.before': (e, editor) ->
                # Get edited HTML from Froala-Editor
                newHTML = editor.html.get(true)
                # Do something to update the edited value provided by the Froala-Editor plugin, if it has changed:
                if !_.isEqual(newHTML, self.current_doc.description)
                    console.log 'onSave HTML is :' + newHTML
                    Docs.update { _id: self.current_doc._id }, $set: description: newHTML
                false
                # Stop Froala Editor from POSTing to the Save URL
        }
