FlowRouter.route '/rental/edit/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_rental'

FlowRouter.route '/rental/view/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'rental_page'


FlowRouter.route '/rent', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'rent'
