Meteor.publish 'ecosystem', (selected_tags, limit)->

    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags

    if limit
        Docs.find match,
            limit: limit
    else 
        Docs.find match
 