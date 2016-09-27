@selected_post_tags = new ReactiveArray []


Template.posts.onCreated ->
    @autorun -> Meteor.subscribe('selected_posts', selected_post_tags.array())

Template.posts.onRendered ->
    $('#blog_slider').layerSlider
        autoStart: true


Template.posts.helpers
    posts: -> 
        Docs.find {},
            sort:
                publish_date: -1
            limit: 5
            
Template.posts.events
    'click #add_post': ->
        id = Docs.insert
            type: 'post'
        FlowRouter.go "/post/edit/#{id}"




Template.post.helpers
    post_tag_class: -> if @valueOf() in selected_post_tags.array() then 'red' else 'basic'

    can_edit: -> @author_id is Meteor.userId()

    publish_when: -> moment(@publish_date).fromNow()

Template.post.events
    'click .post_tag': ->
        if @valueOf() in selected_post_tags.array() then selected_post_tags.remove @valueOf() else selected_post_tags.push @valueOf()

    'click .edit_post': ->
        FlowRouter.go "/post/edit/#{@_id}"
