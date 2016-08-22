Template.user_management.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'hub_users'


Template.user_management.helpers
    hub_users: -> 
        Meteor.users.find {}


Template.admin.events
    'click #add_event': ->
        id = Docs.insert 
            type: 'event'
        FlowRouter.go "/event/edit/#{id}"

    'click #add_organization': ->
        id = Docs.insert 
            type: 'organization'
        FlowRouter.go "/organization/edit/#{id}"

    'click #add_post': ->
        id = Docs.insert 
            type: 'post'
        FlowRouter.go "/post/edit/#{id}"

