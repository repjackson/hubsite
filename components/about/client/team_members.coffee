Template.team_members.onCreated ->
    @autorun -> Meteor.subscribe('team_members', selected_eco_tags.array())




Template.team_members.helpers
    team_members: ->
        Docs.find {
            tags: $all: ['person', 'team']
        },
        sort: order: 1