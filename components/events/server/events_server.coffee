Meteor.publish 'events', (selected_tags)->
    check(arguments, [Match.Any])

    self = @
    match = {}
    # if selected_tags.length > 0 then match.tags = $all: selected_tags
    # match.type = 'event'
    

    Events.find match,
        limit: 10
        # sort: 
        #     start_date: 1


Meteor.publish 'event', (event_id)->
    Events.find event_id

Meteor.publish 'attendees', (doc_id)->
    check(arguments, [Match.Any])
    ids = Events.findOne(doc_id).attendee_ids
    if ids
        Meteor.users.find
            _id: $in: ids
    else return
    
    
Meteor.methods
    sync_events: ->
        HTTP.get 'https://www.eventbriteapi.com/v3/users/me/owned_events/', {
                params:
                    token: 'QLL5EULOADTSJDS74HH7'
                    expand: 'organizer,venue'
            }, 
            (err, res)->
                if err
                    console.error err
                else
                    console.log res
                    # for event in res.data.events
                    #     existing_event = Events.findOne { id: event.id} 
                    #     if existing_event
                    #         console.log 'found duplicate', event.id
                    #         continue
                    #     else
                    #         id = Events.insert event
                    #         console.log 'created event', event.id


        
    manual_event_add: (event_id)->
        # event id
        HTTP.get "https://www.eventbriteapi.com/v3/events/#{event_id}", {
                params:
                    token: 'QLL5EULOADTSJDS74HH7'
            #         'organizer.id': '10751261682'
            }, 
            (err, res)->
                if err
                    console.error err
                else
                    event = res.data
                    existing_event = Events.findOne { id: event.id} 
                    if existing_event
                        console.log 'found duplicate', event.id
                        return
                    else
                        id = Events.insert event
                        console.log 'created event', event.id
                