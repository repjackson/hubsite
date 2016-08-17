
FlowRouter.route '/organizations', action: ->
    BlazeLayout.render 'layout', 
        main: 'organizations'

FlowRouter.route '/organizations/edit/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_organization'

FlowRouter.route '/organizations/view/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'organization_page'


