Meteor.publish 'me', ->
    Meteor.users.find @userId,
        fields:
            profile_doc: 1
            username: 1
            