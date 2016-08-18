FlowRouter.route '/profile/edit/', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_profile'

FlowRouter.route '/profile/view/:user_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'view_profile'

