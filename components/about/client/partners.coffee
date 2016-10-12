Template.office_holders.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'office_holders'

Template.office_holders.helpers
    office_holders: ->
        Docs.find {
            tags: $in: ['office holder']
        }
        
Template.office_holders.events
