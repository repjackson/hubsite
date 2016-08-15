Meteor.publish 'service_tags', (selected_tags)->
    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags
    match.type = 'service'


    cloud = Docs.aggregate [
        { $match: match }
        { $project: "tags": 1 }
        { $unwind: "$tags" }
        { $group: _id: "$tags", count: $sum: 1 }
        { $match: _id: $nin: selected_tags }
        { $sort: count: -1, _id: 1 }
        { $limit: 50 }
        { $project: _id: 0, name: '$_id', count: 1 }
        ]

    cloud.forEach (tag, i) ->
        self.added 'service_tags', Random.id(),
            name: tag.name
            count: tag.count
            index: i

    self.ready()


Meteor.publish 'services', (selected_tags)->
    self = @
    match = {}
    if selected_tags and selected_tags.length > 0 then match.tags = $all: selected_tags
    match.type = 'service'

    Docs.find match


Meteor.publish 'service', (id)->
    Docs.find id
    
    
    
Meteor.publish 'featured_services', ->
    match = {}
    match.type = 'service'

    Docs.find match, limit: 3
