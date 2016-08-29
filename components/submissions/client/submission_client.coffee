Template.submissions.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'docs', 'submission'


Template.submissions.helpers
    submissions: -> 
        Docs.find {}