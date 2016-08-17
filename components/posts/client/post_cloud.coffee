@selected_tags = new ReactiveArray []

Template.post_cloud.onCreated ->
    @autorun -> Meteor.subscribe('post_tags', selected_tags.array())

Template.post_cloud.helpers
    all_post_tags: ->
        post_count = Docs.find().count()
        if 0 < post_count < 3 then Post_tags.find { count: $lt: post_count } else Post_tags.find()
        # Post_tags.find()

    post_tag_cloud_class: ->
        button_class = switch
            when @index <= 10 then 'big'
            when @index <= 20 then 'large'
            when @index <= 30 then ''
            when @index <= 40 then 'small'
            when @index <= 50 then 'tiny'
        return button_class

    selected_tags: -> selected_tags.list()

    can_add_post: -> Meteor.userId()


Template.post_cloud.events
    'click .select_tag': -> selected_tags.push @name
    'click .unselect_tag': -> selected_tags.remove @valueOf()
    'click #clear_tags': -> selected_tags.clear()
    
    
    'click #add_post': ->
        Meteor.call 'add_post', (err, id)->
            if err then console.error err
            else FlowRouter.go "/posts/edit/#{id}"
