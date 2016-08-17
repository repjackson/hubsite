Meteor.publish 'event_tags', (selected_tags)->
    check(arguments, [Match.Any])

    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags
    match.type = 'event'
    check(arguments, [Match.Any])


    cloud = Docs.aggregate [
        { $match: match }
        { $project: "tags": 1 }
        { $unwind: "$tags" }
        { $group: _id: "$tags", count: $sum: 1 }
        { $match: _id: $nin: selected_tags }
        { $sort: count: -1, _id: 1 }
        { $limit: 20 }
        { $project: _id: 0, name: '$_id', count: 1 }
        ]

    cloud.forEach (tag, i) ->
        self.added 'event_tags', Random.id(),
            name: tag.name
            count: tag.count
            index: i

    self.ready()


Meteor.publish 'events', (selected_tags)->
    check(arguments, [Match.Any])

    
    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags
    match.type = 'event'
    check(arguments, [Match.Any])

    Docs.find match


Meteor.publish 'event', (id)->
    check(arguments, [Match.Any])

    Docs.find id
    
    
    
Meteor.publish 'featured_events', ->
    check(arguments, [Match.Any])

    check(arguments, [Match.Any])
    match = {}
    match.featured = true
    match.type = 'event'

    Docs.find match, limit: 3