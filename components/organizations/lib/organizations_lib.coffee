
FlowRouter.route '/organizations', action: ->
    BlazeLayout.render 'layout', 
        main: 'organizations'

FlowRouter.route '/organization/edit/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_organization'

FlowRouter.route '/organization/view/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'organization_page'


