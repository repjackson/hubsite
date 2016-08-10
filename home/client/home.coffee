




Template.featured_posts.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'featured_posts'


Template.featured_posts.helpers
    featured_posts: -> 
        Docs.find type:'post', 
            limit: 3
            
            
            
Template.rockstar_members.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'rockstar_members'


Template.rockstar_members.helpers
    rockstar_members: -> 
        Meteor.users.find {}, 
            limit: 3

