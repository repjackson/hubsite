FlowRouter.route '/profile/edit/:doc_id?', action: (params) ->
    if not params.doc_id 
        found_profile = Docs.findOne
            type: 'member_profile'
            author_id: Meteor.userId()
        
        if found_profile then FlowRouter.setParams(doc_id: found_profile)
        else
            profile_id = Meteor.call 'create_profile' 
            FlowRouter.setParams(doc_id: profile_id)
    BlazeLayout.render 'layout',
        # sub_nav: 'account_nav'
        main: 'edit_profile'

FlowRouter.route '/profile/view/:doc_id?', action: (params) ->
    if not params.doc_id then params.doc_id = Meteor.userId()
    BlazeLayout.render 'layout',
        main: 'view_profile'

