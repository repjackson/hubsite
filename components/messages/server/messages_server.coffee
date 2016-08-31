Messages.allow
    insert: (userId, doc) -> doc.author_id is userId
    update: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')
    remove: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')



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

