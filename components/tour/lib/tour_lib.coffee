FlowRouter.route '/tour', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'tour'
        
