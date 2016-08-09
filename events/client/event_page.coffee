Template.event_page.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'event', FlowRouter.getParam('event_id')
        # self.subscribe 'tags', selected_type_of_event_tags.array(),"event"


# Template.event_page.onRendered ->

Template.event_page.helpers
    event: ->
        # docId = FlowRouter.getParam('event_id')
        Docs.findOne FlowRouter.getParam('event_id')
