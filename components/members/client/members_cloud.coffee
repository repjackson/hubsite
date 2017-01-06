
Template.members_cloud.onCreated ->
    # @autorun -> Meteor.subscribe('member_tags', selected_member_tags.array(), Session.get('published_mode'), Session.get('checkedin_mode'))
    @autorun -> Meteor.subscribe('member_tags', selected_member_tags.array())

Template.members_cloud.helpers
    all_member_tags: ->
        # doc_count = Docs.find().count()
        # if 0 < doc_count < 5 then Member_tags.find { count: $lt: doc_count } else Member_tags.find({}, limit:20)

        Member_tags.find()

    tag_cloud_class: ->
        button_class = switch
            when @index <= 10 then 'big'
            when @index <= 20 then 'large'
            when @index <= 30 then ''
            when @index <= 40 then 'small'
            when @index <= 50 then 'tiny'
        return button_class

    selected_member_tags: -> 
        # type = 'event'
        # console.log "selected_#{type}_tags"
        selected_member_tags.list()

    settings: -> {
        position: 'bottom'
        limit: 10
        rules: [
            {
                collection: Member_tags
                field: 'name'
                matchAll: true
                template: Template.tag_result
            }
            ]
    }



Template.members_cloud.events
    'click .select_member_tag': -> selected_member_tags.push @name
    'click .unselect_member_tag': -> selected_member_tags.remove @valueOf()
    'click #clear_member_tags': -> selected_member_tags.clear()
    
    'click #turn_off_checkedin_mode': -> Session.set 'checkedin_mode', false
    'click #turn_on_checkedin_mode': -> Session.set 'checkedin_mode', true
    
    'keyup #search': (e,t)->
        e.preventDefault()
        val = $('#search').val().toLowerCase().trim()
        switch e.which
            when 13 #enter
                switch val
                    when 'clear'
                        selected_member_tags.clear()
                        $('#search').val ''
                    else
                        unless val.length is 0
                            selected_member_tags.push val.toString()
                            $('#search').val ''
            when 8
                if val.length is 0
                    selected_member_tags.pop()
                    
    'autocompleteselect #search': (event, template, doc) ->
        # console.log 'selected ', doc
        selected_member_tags.push doc.name
        $('#search').val ''
