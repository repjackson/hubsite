@selected_event_tags = new ReactiveArray []

Template.event_cloud.onCreated ->
    @autorun -> Meteor.subscribe('tags', selected_event_tags.array(), 'event')

Template.event_cloud.helpers
    all_event_tags: ->
        event_count = Docs.find().count()
        if 0 < event_count < 3 then Tags.find { count: $lt: event_count } else Tags.find()

    event_tag_cloud_class: ->
        button_class = switch
            when @index <= 10 then 'big'
            when @index <= 20 then 'large'
            when @index <= 30 then ''
            when @index <= 40 then 'small'
            when @index <= 50 then 'tiny'
        return button_class

    selected_event_tags: -> selected_event_tags.list()

    can_add_event: -> Meteor.userId()


Template.event_cloud.events
    'click .select_tag': -> selected_event_tags.push @name
    'click .unselect_tag': -> selected_event_tags.remove @valueOf()
    'click #clear_tags': -> selected_event_tags.clear()
    
    
    'click #add_event': ->
        Meteor.call 'add_event', (err, id)->
            if err then console.error err
            else FlowRouter.go "/events/edit/#{id}"
