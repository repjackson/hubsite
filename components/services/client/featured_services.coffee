Template.featured_services.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'featured_services'


Template.featured_services.helpers
    featured_services: -> Services.find {}, limit: 4
            
            
Template.featured_services.events
    'click .featured_post_title': ->
        selected_tags.clear()
        for tag in @tags
            selected_tags.push tag
        FlowRouter.go '/services'

