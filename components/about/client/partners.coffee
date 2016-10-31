Template.partners.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'partners'

Template.partners.helpers
    partners: ->
        Docs.find {
            tags: $in: ['partner']
        }
        
Template.partners.events
