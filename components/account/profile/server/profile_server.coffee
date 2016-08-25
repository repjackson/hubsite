Meteor.publish 'my_profile', ->
    Meteor.users.find @userId,
        fields:
            tags: 1
            profile: 1
            username: 1
            published: 1
            name: 1
            bio: 1
            website: 1
            linkedin: 1
            twitter: 1
            facebook: 1
            position: 1
            company: 1
            image_id: 1


Meteor.publish 'user_profile', (id)->
    check(arguments, [Match.Any])
    Meteor.users.find id,
        fields:
            tags: 1
            profile: 1
            username: 1
            published: 1
            name: 1
            bio: 1
            website: 1
            linkedin: 1
            twitter: 1
            facebook: 1
            position: 1
            company: 1
            image_id: 1