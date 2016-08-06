Template.featured_events.helpers
    featured_events: Docs.find()



Template.featured_events.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'featured_events'
