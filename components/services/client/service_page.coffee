Template.service_page.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'doc', FlowRouter.getParam('doc_id')
        # self.subscribe 'tags', selected_type_of_service_tags.array(),"service"


# Template.service_page.onRendered ->

Template.service_page.helpers
    service: ->
        Docs.findOne FlowRouter.getParam('doc_id')
