FlowRouter.route '/person/:user_id/account', action: (params) ->
    BlazeLayout.render 'layout',
        sub_nav: 'account_nav'
        main: 'edit_account'