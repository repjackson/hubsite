Meteor.publish 'me', ->
    Meteor.users.find @userId