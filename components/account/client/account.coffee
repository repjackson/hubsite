Template.user_management.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'hub_users'


Template.user_management.helpers
    hub_users: -> 
        Meteor.users.find {}
