
Template.content.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'all_docs', selected_content_tags.array()


Template.content.helpers
    docs: -> Docs.find()



Template.content.events
    'click #add_page': ->
        id = Docs.insert 
            type: 'page'
            tags: ['page']
        FlowRouter.go "/page/edit/#{id}"
    
    'click #add_slide': ->
        id = Docs.insert 
            type: 'slide'
            tags: ['slide']
        FlowRouter.go "/edit/#{id}"
