Meteor.publish 'ecosystem', (selected_tags)->

    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags
    if not @userId or not Roles.userIsInRole(@userId, ['admin'])
        match.published = true
 
    # match.type = 'ecosystem'
 
    Docs.find match,
        limit: 5