@Service_tags = new Meteor.Collection 'service_tags'



FlowRouter.route '/services', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        cloud: 'service_cloud'
        main: 'services'

FlowRouter.route '/account/services', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'my_services'

FlowRouter.route '/services/edit/:service_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_service'

FlowRouter.route '/services/view/:service_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'service_page'





Meteor.methods
    add_service: ()->
        Docs.insert
            type: 'service'
            tags: []

    delete_service: (id)->
        Docs.remove id

    remove_service_tag: (tag, doc_id)->
        Docs.update doc_id,
            $pull: tag

    add_service_tag: (tag, doc_id)->
        Docs.update doc_id,
            $addToSet: tags: tag