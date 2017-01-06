Meteor.users.allow
    insert: (userId, doc) ->
        # only admin can insert 
        u = Meteor.users.findOne(_id: userId)
        u and u.isAdmin
    update: (userId, doc, fields, modifier) ->
        # console.log 'user ' + userId + 'wants to modify doc' + doc._id
        if userId and doc._id == userId
            # console.log 'user allowed to modify own account!'
            # user can modify own 
            return true
        # admin can modify any
        u = Meteor.users.findOne(_id: userId)
        u and 'admin' in u.roles
    remove: (userId, doc) ->
        # only admin can remove
        u = Meteor.users.findOne(_id: userId)
        u and 'admin' in u.roles



Meteor.publish 'member_tags', (selected_member_tags, published_mode, checkedin_mode)->
    self = @
    match = {}
    if selected_member_tags.length > 0 then match.tags = $all: selected_member_tags
    # match.published = published_mode 
    # match.checked_in = checkedin_mode 
    # match.roles = $in: ['member']
    
    # match.type = 'member_profile'
    # match.author_id = $ne: @userId
    # match.tags = $in: ['profile']
    

    cloud = Meteor.users.aggregate [
        { $match: match }
        { $project: "tags": 1 }
        { $unwind: "$tags" }
        { $group: _id: "$tags", count: $sum: 1 }
        { $match: _id: $nin: selected_member_tags }
        { $sort: count: -1, _id: 1 }
        { $limit: 20 }
        { $project: _id: 0, name: '$_id', count: 1 }
        ]

    cloud.forEach (tag, i) ->
        self.added 'member_tags', Random.id(),
            name: tag.name
            count: tag.count
            index: i

    self.ready()


Meteor.publish 'members', (selected_people_tags=[])->
    self = @
    match = {}
    if selected_people_tags.length > 0 then match.tags = $all: selected_people_tags
    match._id = $ne: @userId
    # match.checked_in = checkedin_mode 
    match.roles = $in: ['member']


    Meteor.users.find match
            
