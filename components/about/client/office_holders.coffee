Template.partners.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'partners'

Template.partners.helpers
    partners: ->
        Docs.find {
            type: 'organization'
            tags: $in: ['partner']
        }
        
Template.partners.events
