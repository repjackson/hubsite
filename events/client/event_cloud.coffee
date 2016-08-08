@selected_event_tags = new ReactiveArray []

Template.event_cloud.onCreated ->
    @autorun -> Meteor.subscribe('event_tags', selected_event_tags.array())

Template.event_cloud.helpers
    globaltags: ->
        # userCount = Meteor.users.find().count()
        # if 0 < userCount < 3 then tags.find { count: $lt: userCount } else tags.find()
        Event_tags.find()

    globaltagClass: ->
        buttonClass = switch
            when @index <= 10 then 'big'
            when @index <= 20 then 'large'
            when @index <= 30 then ''
            when @index <= 40 then 'small'
            when @index <= 50 then 'tiny'
        return buttonClass

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
