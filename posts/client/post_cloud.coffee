@selected_post_tags = new ReactiveArray []

Template.post_cloud.onCreated ->
    @autorun -> Meteor.subscribe('post_tags', selected_post_tags.array())

Template.post_cloud.helpers
    all_post_tags: ->
        # userCount = Meteor.users.find().count()
        # if 0 < userCount < 3 then tags.find { count: $lt: userCount } else tags.find()
        Post_tags.find()

    post_tag_cloud_class: ->
        buttonClass = switch
            when @index <= 10 then 'big'
            when @index <= 20 then 'large'
            when @index <= 30 then ''
            when @index <= 40 then 'small'
            when @index <= 50 then 'tiny'
        return buttonClass

    selected_post_tags: -> selected_post_tags.list()

    can_add_post: -> Meteor.userId()


Template.post_cloud.events
    'click .select_tag': -> selected_post_tags.push @name
    'click .unselect_tag': -> selected_post_tags.remove @valueOf()
    'click #clear_tags': -> selected_post_tags.clear()
    
    
    'click #add_post': ->
        Meteor.call 'add_post', (err, id)->
            if err then console.error err
            else FlowRouter.go "/posts/edit/#{id}"
