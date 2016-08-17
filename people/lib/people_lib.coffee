
Meteor.methods
    add_person: ()->
        Docs.insert {}

    
            
            
            
FlowRouter.route '/people', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        cloud: 'people_cloud'
        main: 'people'

FlowRouter.route '/person/edit/:person_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_person'

FlowRouter.route '/person/view/:person_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'person_page'

