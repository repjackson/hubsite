
FlowRouter.route '/people', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'people'

FlowRouter.route '/person/edit/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_person'

FlowRouter.route '/person/view/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'person_page'

