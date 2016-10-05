Template.office_holders.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'docs', null, 'organization'

Template.office_holders.helpers
    office_holders: ->
        Docs.find {
            type: 'organization'
            tags: $in: ['office holder']
        }
        
Template.office_holders.events
