
Meteor.methods
    add_post: ()->
        Docs.insert
            tags: []


            
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


