Meteor.publish 'conversation_messages', (conversation_id) ->
    check(arguments, [Match.Any])
    Messages.find
        conversation_id: conversation_id
