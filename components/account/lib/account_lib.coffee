FlowRouter.route '/account', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'account'