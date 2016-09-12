Template.event_page.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'event', FlowRouter.getParam('event_id')

Template.event_page.helpers
    event: -> Events.findOne FlowRouter.getParam('event_id')

    event_tag_class: -> if @valueOf() in selected_tags.array() then 'red' else 'basic'

    attending: -> if @attendee_ids and Meteor.userId() in @attendee_ids then true else false

    can_edit: -> Meteor.userId()

    day: -> moment(@start.local).format("dddd, MMMM Do");
    start_time: -> moment(@start.local).format("h:mm a")
    end_time: -> moment(@end.local).format("h:mm a")

    
Template.event_page.events
    'click .event_tag': ->
        if @valueOf() in selected_tags.array() then selected_tags.remove @valueOf() else selected_tags.push @valueOf()

    'click .edit_event': ->
        FlowRouter.go "/event/edit/#{@_id}"
