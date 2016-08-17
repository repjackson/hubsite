
FlowRouter.route '/services', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'services'

FlowRouter.route '/account/services', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'my_services'

FlowRouter.route '/services/edit/:service_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_service'

FlowRouter.route '/services/view/:service_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'service_page'





Meteor.methods
    add_service: ()->
        Docs.insert
            type: 'service'
            tags: []
