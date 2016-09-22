
    
Template.events.onRendered ->
    $('#event_slider').layerSlider
        autoStart: true

    
Template.events.events
    'keydown #add_event': (e,t)->
        e.preventDefault
        if e.which is 13
            event_id = t.find('#add_event').value.trim()
            if event_id.length > 0
                # console.log 'attemping to add event with id ', event_id
                Meteor.call 'add_event', event_id, (err,res)->
                    t.find('#add_event').value = ''


Template.events.onCreated -> @autorun -> Meteor.subscribe('selected_events', selected_event_tags.array())
# Template.upcoming_events.onCreated -> @autorun -> Meteor.subscribe('upcoming_events', selected_event_tags.array())
# Template.past_events.onCreated -> @autorun -> Meteor.subscribe('past_events', selected_event_tags.array())

Template.upcoming_events.helpers
    upcoming_events: -> 
        today = new Date()
        Events.find {"start.local": $gte: today.toISOString()}, sort: "start.local": 1

Template.past_events.helpers
    past_events: -> 
        today = new Date()
        Events.find {"start.local": $lte: today.toISOString()}, sort: "start.local": 1
            

Template.events.helpers
    options: ->
        # defaultView: 'basicWeek'
        defaultView: 'month'



Template.event_card.helpers
    event_tag_class: -> if @valueOf() in selected_event_tags.array() then 'red' else 'basic'

    day: -> moment(@start.local).format("dddd, MMMM Do");
    start_time: -> moment(@start.local).format("h:mm a")
    end_time: -> moment(@end.local).format("h:mm a")

    snippet: -> @description.text.substr(0, 200).concat('...')
        

Template.event_card.events
    # 'click .event_tag': ->
    #     if @valueOf() in selected_event_tags.array() then selected_event_tags.remove @valueOf() else selected_event_tags.push @valueOf()