Events.allow
    insert: (userId, doc) -> doc.author_id is userId
    update: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')
    remove: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')



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
    manual_event_add: (event_id)->
        # event id
        HTTP.get "https://www.eventbriteapi.com/v3/events/#{event_id}", {
                params:
                    token: 'QLL5EULOADTSJDS74HH7'
                    expand: 'organizer, venue, logo, format, category, subcategory, ticket_classes, bookmark_info'
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
                        image_id = event.logo.id
                        image_object = HTTP.get "https://www.eventbriteapi.com/v3/media/#{image_id}", {
                            params:
                                token: 'QLL5EULOADTSJDS74HH7'
                        }
                        # console.log image_object
                        new_image_url = image_object.data.url
                        event.big_image_url = new_image_url
                        event_id = Events.insert event
                
                
                
