Meteor.publish 'favorites', ->
    check(arguments, [Match.Any])
    Docs.find
        favoriters: $in: [@userId]