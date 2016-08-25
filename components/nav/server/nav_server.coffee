Meteor.publish 'me', ->
    Meteor.users.find @userId,
        fields:
            profile: 1
            username: 1
            image_id: 1
            tags: 1
            