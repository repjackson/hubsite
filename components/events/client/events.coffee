Template.events.onCreated ->
    @autorun -> Meteor.subscribe('events', selected_event_tags.array())
    # selected_event_tags.clear()
    
Template.events.events
    'keydown #add_event': (e,t)->
        e.preventDefault
        if e.which is 13
            event_id = t.find('#add_event').value.trim()
            if event_id.length > 0
                # console.log 'attemping to add event with id ', event_id
                Meteor.call 'add_event', event_id, (err,res)->
                    t.find('#add_event').value = ''

Template.events.helpers
    events: -> 
        match = {}
        # if selected_event_tags.array and selected_event_tags.array().length > 0 then match.tags = $all: selected_event_tags.array()
        Events.find match

    options: ->
        # defaultView: 'basicWeek'
        defaultView: 'month'



Template.event_card.helpers
    event_tag_class: -> if @valueOf() in selected_event_tags.array() then 'red' else 'basic'

    attending: -> if @attendee_ids and Meteor.userId() in @attendee_ids then true else false

    can_edit: -> Meteor.userId()

    event_messages: -> Messages.find event_id: @_id

    day: -> moment(@start.local).format("dddd, MMMM Do");
    start_time: -> moment(@start.local).format("h:mm a")
    end_time: -> moment(@end.local).format("h:mm a")

    snippet: -> @description.text.substr(0, 200).concat('...')
        

Template.event_card.events
    'click .event_tag': ->
        if @valueOf() in selected_event_tags.array() then selected_event_tags.remove @valueOf() else selected_event_tags.push @valueOf()