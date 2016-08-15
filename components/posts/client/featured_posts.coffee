Template.featured_posts.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'featured_posts'


Template.featured_posts.helpers
    featured_posts: -> Docs.find {}, limit: 4
            
            
Template.featured_posts.events
    'click .featured_post_title': ->
        selected_post_tags.clear()
        for tag in @tags
            selected_post_tags.push tag
        FlowRouter.go '/posts'

