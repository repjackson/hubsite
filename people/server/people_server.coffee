Meteor.publish 'people_tags', (selected_people_tags)->
    check(arguments, [Match.Any])
    self = @
    match = {}
    if selected_people_tags.length > 0 then match.profile.tags = $all: selected_people_tags

    cloud = Meteor.users.aggregate [
        { $match: match }
        { $project: "tags": 1 }
        { $unwind: "$tags" }
        { $group: _id: "$tags", count: $sum: 1 }
        { $match: _id: $nin: selected_people_tags }
        { $sort: count: -1, _id: 1 }
        { $limit: 20 }
        { $project: _id: 0, name: '$_id', count: 1 }
        ]

    cloud.forEach (tag, i) ->
        self.added 'people_tags', Random.id(),
            name: tag.name
            count: tag.count
            index: i

    self.ready()


Meteor.publish 'users', (selected_people_tags=[])->
    check(arguments, [Match.Any])
    self = @
    match = {}
    if selected_people_tags.length > 0 then match.tags = $all: selected_people_tags

    Meteor.users.find match,
        fields:
            tags: 1
            profile: 1
            username: 1
