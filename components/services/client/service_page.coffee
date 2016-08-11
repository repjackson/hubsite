Template.service_page.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'service', FlowRouter.getParam('service_id')
        # self.subscribe 'tags', selected_type_of_service_tags.array(),"service"


# Template.service_page.onRendered ->

Template.service_page.helpers
    service: ->
        # docId = FlowRouter.getParam('service_id')
        Docs.findOne FlowRouter.getParam('service_id')
