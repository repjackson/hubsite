FlowRouter.route '/admin', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'admin'
        
        
Meteor.users.helpers
    profile_doc: -> Docs.findOne connected_user: @_id

