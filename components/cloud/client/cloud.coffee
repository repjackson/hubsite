@selected_tags = new ReactiveArray []

Template.cloud.onCreated ->
    @autorun -> Meteor.subscribe('tags', selected_tags.array(), Template.currentData().filter)

Template.cloud.helpers
    all_tags: ->
        doc_count = Docs.find().count()
        if 0 < doc_count < 3 then Tags.find { count: $lt: doc_count } else Tags.find()

    tag_cloud_class: ->
        button_class = switch
            when @index <= 10 then 'big'
            when @index <= 20 then 'large'
            when @index <= 30 then ''
            when @index <= 40 then 'small'
            when @index <= 50 then 'tiny'
        return button_class

    selected_tags: -> 
        # type = 'event'
        # console.log "selected_#{type}_tags"
        selected_tags.list()

    can_add: -> Meteor.userId()

Template.cloud.events
    'click .select_tag': -> selected_tags.push @name
    'click .unselect_tag': -> selected_tags.remove @valueOf()
    'click #clear_tags': -> selected_tags.clear()
    
    'click #add': ->
        id = Docs.insert 
            type: @filter
            tags: [@filter]
        FlowRouter.go "/#{@filter}/edit/#{id}"
