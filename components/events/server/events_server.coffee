Meteor.publish 'events', (selected_tags)->
    check(arguments, [Match.Any])

    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags
    match.type = 'event'
    

    Docs.find match,
        sort: 
            start_date: 1


Meteor.publish 'featured_events', ->
    check(arguments, [Match.Any])

    self = @
    match = {}
    match.type = 'event'
    match.featured = true    

    Docs.find match,
        sort: 
            start_date: 1

Meteor.publish 'attendees', (doc_id)->
    check(arguments, [Match.Any])
    ids = Docs.findOne(doc_id).attendee_ids
    if ids
        Meteor.users.find
            _id: $in: ids
    else return