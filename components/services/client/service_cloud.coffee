@selected_service_tags = new ReactiveArray []

Template.service_cloud.onCreated ->
    @autorun -> Meteor.subscribe('tags', selected_service_tags.array(), 'service')

Template.service_cloud.helpers
    all_service_tags: ->
        service_count = Docs.find().count()
        if 0 < service_count < 3 then Tags.find { count: $lt: service_count } else Tags.find()

    service_tag_cloud_class: ->
        buttonClass = switch
            when @index <= 10 then 'big'
            when @index <= 20 then 'large'
            when @index <= 30 then ''
            when @index <= 40 then 'small'
            when @index <= 50 then 'tiny'
        return buttonClass

    selected_service_tags: -> selected_service_tags.list()

    can_add_service: -> Meteor.userId()


Template.service_cloud.events
    'click .select_tag': -> selected_service_tags.push @name
    'click .unselect_tag': -> selected_service_tags.remove @valueOf()
    'click #clear_tags': -> selected_service_tags.clear()
    
    
    'click #add_service': ->
        Meteor.call 'add_service', (err, id)->
            if err then console.error err
            else FlowRouter.go "/services/edit/#{id}"
