@selected_organization_tags = new ReactiveArray []

Template.organization_cloud.onCreated ->
    @autorun -> Meteor.subscribe('organization_tags', selected_organization_tags.array())

Template.organization_cloud.helpers
    organization_tags: ->
        organization_count = Organizations.find().count()
        if 0 < organization_count < 3 then Organization_tags.find { count: $lt: organization_count } else Organization_tags.find()
        # organization_tags.find()

    organization_tag_class: ->
        buttonClass = switch
            when @index <= 10 then 'big'
            when @index <= 20 then 'large'
            when @index <= 30 then ''
            when @index <= 40 then 'small'
            when @index <= 50 then 'tiny'
        return buttonClass

    selected_organization_tags: -> selected_organization_tags.list()

    can_add_organization: -> Meteor.userId()


Template.organization_cloud.events
    'click .select_tag': -> selected_organization_tags.push @name
    'click .unselect_tag': -> selected_organization_tags.remove @valueOf()
    'click #clear_tags': -> selected_organization_tags.clear()
    
    
    'click #add_organization': ->
        Meteor.call 'add_organization', (err, id)->
            if err then console.error err
            else FlowRouter.go "/organizations/edit/#{id}"
