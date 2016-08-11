@Organizations = new Meteor.Collection 'organizations'
@Organization_tags = new Meteor.Collection 'organization_tags'


# organizations

FlowRouter.route '/organizations', action: ->
    BlazeLayout.render 'layout', 
        cloud: 'organization_cloud'
        main: 'organizations'

FlowRouter.route '/organizations/edit/:organization_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_organization'

FlowRouter.route '/organizations/view/:organization_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'organization_page'



Organizations.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.officer_ids = [Meteor.userId()]
    return



Meteor.methods
    add_organization: ()->
        Organizations.insert
            tags: []

    delete_organization: (id)->
        Organizations.remove id

    remove_organization_tag: (tag, doc_id)->
        Organizations.update doc_id,
            $pull: tag

    add_organization_tag: (tag, doc_id)->
        Organizations.update doc_id,
            $addToSet: tags: tag
            
            
