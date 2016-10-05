
Template.content.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'hub_users'


Template.content.helpers
    hub_users: -> 
        Meteor.users.find {}
        
    user_is_admin: -> 
        # console.log @
        Roles.userIsInRole(@_id, 'admin')





Template.content.events
    'click #add_organization': ->
        id = Docs.insert 
            type: 'organization'
        FlowRouter.go "/organization/edit/#{id}"
