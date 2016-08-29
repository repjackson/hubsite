Template.organization_page.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'doc', FlowRouter.getParam('doc_id')



Template.organization_page.helpers
    organization: ->
        Docs.findOne FlowRouter.getParam('doc_id')


Template.organization_page.events
    'click .edit_organization': ->
        doc_id = FlowRouter.getParam('doc_id')
        FlowRouter.go "/organization/edit/#{doc_id}"
