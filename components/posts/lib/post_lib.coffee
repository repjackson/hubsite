
FlowRouter.route '/posts', action: ->
    BlazeLayout.render 'layout', 
        cloud: 'post_cloud'
        main: 'posts'

FlowRouter.route '/post/edit/:post_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_post'

FlowRouter.route '/post/view/:post_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'post_page'


