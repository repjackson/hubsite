Template.event_page.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'event', FlowRouter.getParam('event_id')
        # self.subscribe 'tags', selected_type_of_event_tags.array(),"event"


# Template.event_page.onRendered ->

Template.event_page.helpers
    event: ->
        # docId = FlowRouter.getParam('event_id')
        Events.findOne FlowRouter.getParam('event_id')

    event_tag_class: -> if @valueOf() in selected_event_tags.array() then 'red' else 'basic'

    attending: -> if @attendee_ids and Meteor.userId() in @attendee_ids then true else false

    can_edit: -> @author_id is Meteor.userId()

    event_messages: -> Messages.find event_id: @_id

    day: -> moment(@start_date).format("dddd, MMMM Do");
    start_time: -> moment(@start_date).format("h:mm a")
    end_time: -> moment(@end_date).format("h:mm a")
