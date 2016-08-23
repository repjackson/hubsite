@selected_people_tags = new ReactiveArray []

Template.people_cloud.onCreated ->
    @autorun -> Meteor.subscribe('people_tags', selected_people_tags.array())

Template.people_cloud.helpers
    all_people_tags: ->
        # user_count = Meteor.users.find().count()
        # if 0 < user_count < 3 then People_tags.find { count: $lt: user_count } else People_tags.find()
        People_tags.find()

    tag_cloud_class: ->
        button_class = switch
            when @index <= 10 then 'big'
            when @index <= 20 then 'large'
            when @index <= 30 then ''
            when @index <= 40 then 'small'
            when @index <= 50 then 'tiny'
        return button_class

    selected_people_tags: -> 
        # type = 'event'
        # console.log "selected_#{type}_tags"
        selected_people_tags.list()

Template.people_cloud.events
    'click .select_people_tag': -> selected_people_tags.push @name
    'click .unselect_people_tag': -> selected_people_tags.remove @valueOf()
    'click #clear_people_tags': -> selected_people_tags.clear()
    