Meteor.publish 'events', (selected_tags)->
    check(arguments, [Match.Any])

    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags
    match.type = 'event'
    

    Docs.find match,
        sort: 
            start_date: 1
