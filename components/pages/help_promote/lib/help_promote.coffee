FlowRouter.route '/help_promote', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'help_promote'
