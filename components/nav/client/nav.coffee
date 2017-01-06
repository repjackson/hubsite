Template.nav.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'me'
        # self.subscribe 'user_profile'


Template.nav.helpers
    # tagsettings: -> {
    #     position: 'bottom'
    #     limit: 10
    #     rules: [
    #         {
    #             collection: Tags
    #             field: 'name'
    #             template: Template.tagresult
    #         }
    #     ]
    # }

    # usertag_class: ->
    #     if @name in selected_tags.array() then 'primary' else 'basic'




Template.top_nav.events
    'click #logout': -> AccountsTemplates.logout()
    
    
Template.top_nav.helpers
    profile_doc: ->
        Docs.findOne
            type: 'member_profile'
            author_id: Meteor.userId()
