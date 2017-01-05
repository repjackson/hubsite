@Member_tags = new Meteor.Collection 'member_tags'


FlowRouter.route '/members', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'members'
