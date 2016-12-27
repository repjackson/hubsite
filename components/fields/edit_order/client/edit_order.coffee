Template.edit_order.events
    'change #order': ->
        doc_id = FlowRouter.getParam('doc_id')
        order = parseInt($('#order').val())

        Docs.update doc_id,
            $set: order: order