Template.nav.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'me'


Template.nav.helpers
    tagsettings: -> {
        position: 'bottom'
        limit: 10
        rules: [
            {
                collection: Tags
                field: 'name'
                template: Template.tagresult
            }
        ]
    }

    usertag_class: ->
        if @name in selected_tags.array() then 'primary' else 'basic'




Template.nav.events
    'click .toggleSidebar': ->
        $('.ui.sidebar').sidebar 'toggle'


    'autocompleteselect #tagDrilldown': (event, template, doc)->
        selected_tags.push doc.name.toString()
        $('#tagDrilldown').val('')

    'keyup #tagDrilldown': (event, template)->
        event.preventDefault()
        if event.which is 13
            val = $('#tagDrilldown').val()
            switch val
                when 'clear'
                    selected_tags.clear()
                    $('#tagDrilldown').val ''
                    $('#globalsearch').val ''

    'click #homeLink': ->
        selected_tags.clear()

    'keyup #search': (e)->
        e.preventDefault()
        searchTerm = e.target.value.toLowerCase().trim()
        switch e.which
            when 13
                if searchTerm is 'clear'
                    selected_tags.clear()
                    $('#search').val('')
                else
                    selected_tags.push searchTerm
                    $('#search').val('')
            when 8
                if searchTerm is ''
                    selected_tags.pop()

Template.top_nav.events
    'click #logout': -> AccountsTemplates.logout()
    
    'click #add_event': ->
        id = Docs.insert 
            type: 'event'
        FlowRouter.go "/event/edit/#{id}"

    