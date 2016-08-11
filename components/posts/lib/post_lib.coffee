@Post_tags = new Meteor.Collection 'post_tags'
@Posts = new Meteor.Collection 'posts'

Posts.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.author_id = Meteor.userId()
    return



Meteor.methods
    add_post: ()->
        Posts.insert
            tags: []

    delete_post: (id)->
        Posts.remove id

    remove_post_tag: (tag, doc_id)->
        Posts.update doc_id,
            $pull: tag

    add_post_tag: (tag, doc_id)->
        Posts.update doc_id,
            $addToSet: tags: tag
            
            
            
# Posts

FlowRouter.route '/posts', action: ->
    BlazeLayout.render 'layout', 
        cloud: 'post_cloud'
        main: 'posts'

FlowRouter.route '/posts/edit/:post_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_post'

FlowRouter.route '/posts/view/:post_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'post_page'

