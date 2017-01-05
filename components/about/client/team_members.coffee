Template.team_members.onCreated ->
    @autorun -> Meteor.subscribe('team_members')




Template.team_members.helpers
    team_members: ->
        Docs.find {
            tags: $all: ['team']
        },
        sort: order: 1