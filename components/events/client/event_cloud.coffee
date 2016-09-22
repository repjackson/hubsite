@selected_event_tags = new ReactiveArray []

Template.event_cloud.onCreated ->
    @autorun -> Meteor.subscribe('event_tags', selected_event_tags.array())

Template.event_cloud.helpers
    event_tags: ->
        # event_count = Events.find().count()
        # if 0 < event_count < 3 then Event_tags.find { count: $lt: event_count } else Event_tags.find()
        Event_tags.find()


    tag_cloud_class: ->
        button_class = switch
            when @index <= 3 then 'big'
            when @index <= 7 then 'large'
            when @index <= 10 then ''
            when @index <= 14 then 'small'
            when @index <= 20 then 'tiny'
        return button_class

    # settings: -> {
    #     position: 'bottom'
    #     limit: 10
    #     rules: [
    #         {
    #             collection: Tags
    #             field: 'name'
    #             matchAll: true
    #             template: Template.tag_result
    #         }
    #         ]
    # }
    

    selected_event_tags: -> selected_event_tags.list()


Template.event_cloud.events
    'click .select_tag': -> selected_event_tags.push @name
    'click .unselect_tag': -> selected_event_tags.remove @valueOf()
    'click #clear_tags': -> selected_event_tags.clear()
    
    # 'keyup #search': (e,t)->
    #     e.preventDefault()
    #     val = $('#search').val().toLowerCase().trim()
    #     switch e.which
    #         when 13 #enter
    #             switch val
    #                 when 'clear'
    #                     selected_event_tags.clear()
    #                     $('#search').val ''
    #                 else
    #                     unless val.length is 0
    #                         selected_event_tags.push val.toString()
    #                         $('#search').val ''
    #         when 8
    #             if val.length is 0
    #                 selected_event_tags.pop()
                    
    # 'autocompleteselect #search': (event, template, doc) ->
    #     # console.log 'selected ', doc
    #     selected_event_tags.push doc.name
    #     $('#search').val ''
