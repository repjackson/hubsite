Template.events.onCreated ->
    @autorun -> Meteor.subscribe('events', selected_event_tags.array())

Template.events.helpers
    events: -> 
        match = {}
        if selected_event_tags.array and selected_event_tags.array().length > 0 then match.tags = $all: selected_event_tags.array()
        match.type = 'event'
    
        Docs.find match




# Single
# Template.event.onCreated ->
#     @autorun -> Meteor.subscribe('eventMessages', Template.currentData()._id)
#     @autorun -> Meteor.subscribe('usernames')

Template.event.helpers
    event_tag_class: ->
        if @valueOf() in selected_event_tags.array() then 'red' else 'basic'

    attending: -> if @attendee_ids and Meteor.userId() in @attendee_ids then true else false

    can_edit: -> @author_id is Meteor.userId()

    eventMessages: -> Messages.find eventId: @_id

    day: -> moment(@start_date).format("dddd, MMMM Do");
    start_time: -> moment(@start_date).format("h:mm a")
    end_time: -> moment(@end_date).format("h:mm a")


Template.event.events
    'click .event_tag': ->
        if @valueOf() in selected_event_tags.array() then selected_event_tags.remove @valueOf() else selected_event_tags.push @valueOf()

    'click .join_event': ->
        Meteor.call 'join_event', @_id

    'click .leave_event': ->
        Meteor.call 'leave_event', @_id


    'keydown .addMessage': (e,t)->
        e.preventDefault
        switch e.which
            when 13
                text = t.find('.addMessage').value.trim()
                if text.length > 0
                    Meteor.call 'add_event_message', text, @_id, (err,res)->
                        t.find('.addMessage').value = ''

    'click .cancelEvent': ->
        if confirm 'Cancel event?'
            Events.remove @_id
            
    'click .edit_event': ->
        FlowRouter.go "/events/edit/#{@_id}"
