@selected_service_tags = new ReactiveArray []

Template.service_cloud.onCreated ->
    @autorun -> Meteor.subscribe('service_tags', selected_service_tags.array())

Template.service_cloud.helpers
    all_service_tags: ->
        # userCount = Meteor.users.find().count()
        # if 0 < userCount < 3 then tags.find { count: $lt: userCount } else tags.find()
        Service_tags.find()

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
