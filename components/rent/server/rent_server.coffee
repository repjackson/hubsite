Meteor.publish 'rentals', ->
    Docs.find {
        type: 'rental'
        }
        
