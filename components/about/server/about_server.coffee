Meteor.publish 'office_holders', ->
    Docs.find {
        type: 'ecosystem'
        tags: $in: ['office holder']
    }


Meteor.publish 'partners', ->
    Docs.find {
        type: 'ecosystem'
        tags: $in: ['partner']
    }
