Conversations.allow
    update: (userId, doc, fieldNames, modifier) -> doc.author_id is Meteor.userId()
    remove: (userId, doc)-> doc.author_id is userId


Meteor.publish 'conversations', (selected_tags)->
    check(arguments, [Match.Any])
    self = @
    match = {}
    if selected_tags and selected_tags.length > 0 then match.tags = $all: selected_tags

    Conversations.find match,
        fields:
            tags: 1
            author_id: 1
            participant_ids: 1


Meteor.publish 'conversation_messages', (conversation_id) ->
    check(arguments, [Match.Any])
    Messages.find
        conversation_id: conversation_id
