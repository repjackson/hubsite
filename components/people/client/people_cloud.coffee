
Template.people_cloud.onCreated ->
    # @autorun -> Meteor.subscribe('people_tags', selected_people_tags.array(), Session.get('published_mode'), Session.get('checkedin_mode'))
    @autorun -> Meteor.subscribe('people_tags', selected_people_tags.array())

Template.people_cloud.helpers
    all_people_tags: ->
        doc_count = Docs.find().count()
        if 0 < doc_count < 5 then People_tags.find { count: $lt: doc_count } else People_tags.find({}, limit:20)

        # People_tags.find()

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

    settings: -> {
        position: 'bottom'
        limit: 10
        rules: [
            {
                collection: People_tags
                field: 'name'
                matchAll: true
                template: Template.tag_result
            }
            ]
    }



Template.people_cloud.events
    'click .select_people_tag': -> selected_people_tags.push @name
    'click .unselect_people_tag': -> selected_people_tags.remove @valueOf()
    'click #clear_people_tags': -> selected_people_tags.clear()
    
    'click #turn_off_checkedin_mode': -> Session.set 'checkedin_mode', false
    'click #turn_on_checkedin_mode': -> Session.set 'checkedin_mode', true
    
    'keyup #search': (e,t)->
        e.preventDefault()
        val = $('#search').val().toLowerCase().trim()
        switch e.which
            when 13 #enter
                switch val
                    when 'clear'
                        selected_people_tags.clear()
                        $('#search').val ''
                    else
                        unless val.length is 0
                            selected_people_tags.push val.toString()
                            $('#search').val ''
            when 8
                if val.length is 0
                    selected_people_tags.pop()
                    
    'autocompleteselect #search': (event, template, doc) ->
        # console.log 'selected ', doc
        selected_people_tags.push doc.name
        $('#search').val ''
