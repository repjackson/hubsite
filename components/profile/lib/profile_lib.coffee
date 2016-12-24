FlowRouter.route '/profile/edit/', action: (params) ->
    BlazeLayout.render 'layout',
        # sub_nav: 'account_nav'
        main: 'edit_profile'

FlowRouter.route '/profile/view/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'view_profile'

