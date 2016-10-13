@selected_eco_tags = new ReactiveArray []

Template.eco_cloud.onCreated ->
    @autorun -> Meteor.subscribe('eco_tags', selected_eco_tags.array())

Template.eco_cloud.helpers
    eco_tags: ->
        doc_count = Docs.find().count()
        if 0 < doc_count < 3 then Tags.find { count: $lt: doc_count } else Tags.find()
        # Tags.find()

    tag_cloud_class: ->
        button_class = switch
            # when @index <= 10 then 'big'
            when @index <= 10 then 'large'
            when @index <= 20 then ''
            when @index <= 30 then 'small'
            when @index <= 40 then 'tiny'
        return button_class

    settings: -> {
        position: 'bottom'
        limit: 10
        rules: [
            {
                collection: Tags
                field: 'name'
                matchAll: true
                template: Template.tag_result
            }
            ]
    }
    

    selected_eco_tags: -> 
        # type = 'event'
        # console.log "selected_#{type}_tags"
        selected_eco_tags.list()


Template.eco_cloud.events
    'click .select_tag': -> selected_eco_tags.push @name
    'click .unselect_tag': -> selected_eco_tags.remove @valueOf()
    'click #clear_tags': -> selected_eco_tags.clear()
    
    'keyup #search': (e,t)->
        e.preventDefault()
        val = $('#search').val().toLowerCase().trim()
        switch e.which
            when 13 #enter
                switch val
                    when 'clear'
                        selected_eco_tags.clear()
                        $('#search').val ''
                    else
                        unless val.length is 0
                            selected_eco_tags.push val.toString()
                            $('#search').val ''
            when 8
                if val.length is 0
                    selected_eco_tags.pop()
                    
    'autocompleteselect #search': (event, template, doc) ->
        # console.log 'selected ', doc
        selected_eco_tags.push doc.name
        $('#search').val ''
   
    'click #add_ecosystem_item': ->
        id = Docs.insert 
            type: 'ecosystem'
        FlowRouter.go "/edit/#{id}"
