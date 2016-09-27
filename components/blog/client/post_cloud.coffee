@selected_post_tags = new ReactiveArray []

Template.post_cloud.onCreated ->
    @autorun -> Meteor.subscribe('tags', selected_post_tags.array(), 'post')

Template.post_cloud.helpers
    post_tags: ->
        post_count = Docs.find().count()
        if 0 < post_count < 3 then Tags.find { count: $lt: post_count } else Tags.find()
        # Tags.find()


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
    

    selected_post_tags: -> selected_post_tags.list()


Template.post_cloud.events
    'click .select_tag': -> selected_post_tags.push @name
    'click .unselect_tag': -> selected_post_tags.remove @valueOf()
    'click #clear_tags': -> selected_post_tags.clear()
    
    # 'keyup #search': (e,t)->
    #     e.preventDefault()
    #     val = $('#search').val().toLowerCase().trim()
    #     switch e.which
    #         when 13 #enter
    #             switch val
    #                 when 'clear'
    #                     selected_post_tags.clear()
    #                     $('#search').val ''
    #                 else
    #                     unless val.length is 0
    #                         selected_post_tags.push val.toString()
    #                         $('#search').val ''
    #         when 8
    #             if val.length is 0
    #                 selected_post_tags.pop()
                    
    # 'autocompleteselect #search': (event, template, doc) ->
    #     # console.log 'selected ', doc
    #     selected_post_tags.push doc.name
    #     $('#search').val ''
