Services.allow
    insert: (userId, doc) -> doc.author_id is userId
    update: (userId, doc) -> doc.author_id is userId
    remove: (userId, doc) -> doc.author_id is userId





Meteor.publish 'service_tags', (selected_tags)->
    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags

    cloud = Services.aggregate [
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

    Services.find match


Meteor.publish 'service', (id)->
    Services.find id
    
    
    
Meteor.publish 'featured_services', ->
    match = {}

    Services.find match, limit: 3
    # Docs.find match,
    #     fields:
    #         tags: 1
    #         attendee_ids: 1
    #         host_id: 1
    #         date_array: 1
    #         date: 1
