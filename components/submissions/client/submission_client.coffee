Template.submissions.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'submissions'


Template.submissions.helpers
    submissions: -> 
        Docs.find {}