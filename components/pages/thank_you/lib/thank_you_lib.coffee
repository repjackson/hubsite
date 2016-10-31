FlowRouter.route '/thankyou', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'thank_you'
