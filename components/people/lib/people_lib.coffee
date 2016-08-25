@People_tags = new Meteor.Collection 'people_tags'


FlowRouter.route '/people', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'people'


FlowRouter.route '/profile/view/:user_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'person_page'

