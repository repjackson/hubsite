




            
Template.rockstar_members.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'rockstar_members'


Template.rockstar_members.helpers
    rockstar_members: -> 
        Meteor.users.find {}, 
            limit: 4

