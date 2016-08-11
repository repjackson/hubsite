Organizations.allow
    insert: (userId, doc) -> doc.author_id is userId
    update: (userId, doc) -> userId in doc.officer_ids
    remove: (userId, doc) -> doc.author_id is userId



Meteor.publish 'organization_tags', (selected_tags)->
    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags

    tagCloud = Organizations.aggregate [
        { $match: match }
        { $project: "tags": 1 }
        { $unwind: "$tags" }
        { $group: _id: "$tags", count: $sum: 1 }
        { $match: _id: $nin: selected_tags }
        { $sort: count: -1, _id: 1 }
        { $limit: 20 }
        { $project: _id: 0, name: '$_id', count: 1 }
        ]

    tagCloud.forEach (tag, i) ->
        self.added 'organization_tags', Random.id(),
            name: tag.name
            count: tag.count
            index: i

    self.ready()


Meteor.publish 'organizations', (selected_tags=[])->
    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags

    Organizations.find match
    # Organizations.find match,
    #     fields:
    #         tags: 1
    #         attendee_ids: 1
    #         host_id: 1
    #         date_array: 1
    #         date: 1


Meteor.publish 'organization', (id)->
    Organizations.find id
    
    
    
Meteor.publish 'featured_organizations', ->
    match = {}

    Organizations.find match, limit: 3
    # Docs.find match,
    #     fields:
    #         tags: 1
    #         attendee_ids: 1
    #         host_id: 1
    #         date_array: 1
    #         date: 1
