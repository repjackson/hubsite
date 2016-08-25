Meteor.publish 'sent_messages', ->
    check(arguments, [Match.Any])
    Messages.find
        author_id: @userId


Meteor.publish 'event_messages', (event_id) ->
    check(arguments, [Match.Any])
    Messages.find
        event_id: event_id

Meteor.publish 'received_messages', ->
    check(arguments, [Match.Any])
    Messages.find
        recipient_id: @userId

