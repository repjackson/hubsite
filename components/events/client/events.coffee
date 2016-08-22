Template.events.onCreated ->
    @autorun -> Meteor.subscribe('docs', selected_tags.array(), 'event')
    selected_tags.clear()
    
    
Template.events.helpers
    events: -> 
        match = {}
        # if selected_tags.array and selected_tags.array().length > 0 then match.tags = $all: selected_tags.array()
        Docs.find match


Template.event_card.helpers
    event_tag_class: -> if @valueOf() in selected_tags.array() then 'red' else 'basic'

    attending: -> if @attendee_ids and Meteor.userId() in @attendee_ids then true else false

    can_edit: -> Meteor.userId()

    event_messages: -> Messages.find event_id: @_id

    day: -> moment(@start_date).format("dddd, MMMM Do");
    start_time: -> moment(@start_date).format("h:mm a")
    end_time: -> moment(@end_date).format("h:mm a")

    # snippet: -> @description?.substr(1, 100)

Template.event_card.events
    'click .event_tag': ->
        if @valueOf() in selected_tags.array() then selected_tags.remove @valueOf() else selected_tags.push @valueOf()

    'click .join_event': ->
        Meteor.call 'join_event', @_id

    'click .leave_event': ->
        Meteor.call 'leave_event', @_id


    'click .cancel_event': ->
        if confirm 'Cancel event?'
            Docs.remove @_id
            
    'click .edit_event': ->
        FlowRouter.go "/event/edit/#{@_id}"
