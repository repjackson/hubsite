Meteor.publish 'ecosystem', (selected_tags)->

    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags
    # match.tags = $all: selected_tags
    if not @userId or not Roles.userIsInRole(@userId, ['admin'])
        match.published = true
 
    # match.type = 'ecosystem'
 
    profile_doc = Docs.findOne 
        author_id: @userId
        type: 'member_profile'
 
    profile_doc_id = profile_doc._id
        
    match._id = $nin: [profile_doc_id]
 
    # console.log match
 
    Docs.find match,
        limit: 10