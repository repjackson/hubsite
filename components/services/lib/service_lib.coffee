@Service_tags = new Meteor.Collection 'service_tags'
@Services = new Meteor.Collection 'services'

Services.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.author_id = Meteor.userId()
    return



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
        Services.insert
            tags: []
            author_id: Meteor.userId()

    delete_service: (id)->
        Services.remove id

    remove_service_tag: (tag, doc_id)->
        Services.update doc_id,
            $pull: tag

    add_service_tag: (tag, doc_id)->
        Services.update doc_id,
            $addToSet: tags: tag