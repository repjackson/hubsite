Template.edit_title.events
    'blur #title': ->
        console.log 'hi'
        title = $('#title').val()
        Docs.update FlowRouter.getParam('doc_id'),
            $set: title: title