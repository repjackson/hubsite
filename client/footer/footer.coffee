Template.footer.helpers
    footer: Docs.find()



Template.footer.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'featured_events'
