FlowRouter.route '/ecosystem', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        # cloud: 'event_cloud'
        main: 'ecosystem'

FlowRouter.route '/edit/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit'

FlowRouter.route '/view/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'page_view'

