@Organization_tags = new Meteor.Collection 'organization_tags'


# organizations

FlowRouter.route '/organizations', action: ->
    BlazeLayout.render 'layout', 
        cloud: 'organization_cloud'
        main: 'organizations'

FlowRouter.route '/organizations/edit/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_organization'

FlowRouter.route '/organizations/view/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'organization_page'



Meteor.methods
    add_organization: ()->
        Docs.insert
            tags: []
            type: 'organization'

    delete_organization: (id)->
        Docs.remove id

    remove_organization_tag: (tag, doc_id)->
        Docs.update doc_id,
            $pull: tag

    add_organization_tag: (tag, doc_id)->
        Docs.update doc_id,
            $addToSet: tags: tag
            
            
