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

Meteor.publish 'team_members', ->
        Docs.find
            tags: $in: ['member_profile', 'team']
            